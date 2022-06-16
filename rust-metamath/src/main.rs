mod framestack;
mod reader;
use std::ops::Deref;

use std::collections::HashMap;
use std::fs::File;
use std::io::BufReader;
use std::rc::Rc;

use framestack::FrameStack;

use crate::framestack::Assertion;
use crate::reader::Label;
use crate::reader::Statement;
use crate::reader::{LanguageToken, Proof, Tokens};

// first one is label type,

#[derive(Debug)]
enum LabelEntry {
    DollarA(Assertion),
    DollarP(Assertion),
    DollarE(Statement),
    DollarF(Statement),
}

struct MM {
    fs: FrameStack,
    labels: HashMap<Label, Rc<LabelEntry>>,
    begin_label: Option<String>,
    stop_label: Option<String>,
}

impl MM {
    fn new(begin_label: Option<String>, stop_label: Option<String>) -> MM {
        MM {
            fs: FrameStack::default(),
            labels: HashMap::new(),
            begin_label,
            stop_label,
        }
    }

    fn read(&mut self, toks: &mut Tokens) {
        // println!("Starting function read");
        self.fs.push();
        let mut label: Option<String> = None;
        let mut tok = toks.read_comment();
        // println!("In MM read, found token to be {:?}", tok);
        loop {
            match tok.as_deref() {
                Some("$}") => break,
                Some("$c") => {
                    for tok in toks.readstat().iter() {
                        self.fs.add_c(tok.clone());
                    }
                }
                Some("$v") => {
                    for tok in toks.readstat().iter() {
                        self.fs.add_v(tok.clone());
                    }
                }
                Some("$f") => {
                    let stat = toks.readstat();
                    let label_u: Label = label.expect("$f must have a label").into();
                    if stat.len() != 2 {
                        panic!("$f must have length 2");
                    }

                    // println!("{} $f {} {} $.", label_u, stat[0].clone(), stat[1].clone());
                    self.fs
                        .add_f(stat[1].clone(), stat[0].clone(), label_u.clone());
                    let data = LabelEntry::DollarF(Rc::new([stat[0].clone(), stat[1].clone()]));
                    self.labels.insert(label_u, Rc::new(data));
                    label = None;
                }
                Some("$a") => {
                    let label_u = label.expect("$a must have a label");
                    match &self.stop_label {
                        Some(a) if a == &label_u => std::process::exit(0),
                        _ => {}
                    }

                    let data = LabelEntry::DollarA(self.fs.make_assertion(toks.readstat()));
                    self.labels.insert(label_u.into(), Rc::new(data));
                    label = None;
                }

                Some("$e") => {
                    let label_u: Label = label.expect("e must have label").into();

                    let stat = toks.readstat();
                    self.fs.add_e(stat.clone(), label_u.clone());
                    let data = LabelEntry::DollarE(stat);
                    self.labels.insert(label_u.clone(), Rc::new(data));
                    label = None;
                }
                Some("$p") => {
                    let label_u = label.clone().expect("$p must have elabel");
                    if label == self.stop_label {
                        //could be rewritten better
                        std::process::exit(0);
                    }
                    let stat = toks.readstat();
                    let i = stat
                        .iter()
                        .position(|x| x.as_ref() == "$=")
                        .expect("Mmust have $=");
                    let proof = &stat[i + 1..].to_vec();
                    let stat = &stat[..i];

                    if self.begin_label.is_some() && &label_u == self.begin_label.as_ref().unwrap()
                    {
                        self.begin_label = None;
                    }
                    if self.begin_label.is_none() {
                        println!("verifying {}", label_u);
                        self.verify(label_u.clone(), stat.into(), proof.to_vec());
                    }
                    let data = LabelEntry::DollarP(self.fs.make_assertion(stat.into()));
                    self.labels.insert(label_u.into(), Rc::new(data));
                    label = None;
                }
                Some("$d") => {
                    self.fs.add_d(toks.readstat());
                }
                Some("${") => {
                    self.read(toks);
                }
                Some(x) if !x.starts_with('$') => {
                    label = tok;
                }
                Some(_) => {
                    // print!("tok {:?}", tok);
                }
                None => break,
            }
            tok = toks.read_comment();
        }
        self.fs.list.pop();
    }

    fn apply_subst(
        &self,
        stat: &Statement,
        subst: &HashMap<LanguageToken, Statement>,
    ) -> Statement {
        let mut result: Vec<LanguageToken> = vec![];

        for tok in stat.iter() {
            if subst.contains_key(tok.as_ref()) {
                result.extend(subst[tok.as_ref()].iter().cloned()); //the cloned shouldn't deep copy
            } else {
                result.push(tok.clone());
            }
        }
        result.into()
    }

    fn find_vars(&self, stat: Statement) -> Vec<LanguageToken> {
        let mut vars: Vec<LanguageToken> = vec![];
        for x in stat.iter() {
            if !vars.contains(x) && self.fs.lookup_v(x) {
                vars.push(x.to_owned());
            }
        }

        vars
    }

    fn decompress_and_verify(&mut self, stat: Statement, proof: Proof) {
        // yes I copy pasted this, I know it's bad
        // so please work
        //println!("complete proof {:?}", proof);
        //
        let ep = proof
            .iter()
            .position(|x| x.as_ref() == ")")
            .expect("Failed to find matching parthesis");

        let mut labels: Vec<Rc<str>> = self.get_labels(Rc::clone(&stat), ep);
        let hyp_end = labels.len(); //when the f and e end
        labels.extend((&proof[1..ep]).iter().cloned());

        let compressed_proof = proof[ep + 1..].join("");

        let label_end = labels.len();


        let proof_indeces = Self::get_proof_indeces(compressed_proof);
        if proof_indeces.is_empty() {
            // we didn't do the proof yet
            return;
        }

        let mut subproofs: Vec<Statement> = vec![]; //stuff tagged  with Zs
                                                    //let mut prev_proofs: Vec<CompressedProof> = vec![]; // when we contruct a subproof, we have to know the hyps
        let mut stack: Vec<Statement> = vec![];
        let mut previous_proof: Option<Statement> = None;

        for pf_int in &proof_indeces {
            match pf_int {
                None => {
                    let last_proof = previous_proof
                        .as_ref()
                        .expect("Error in decompressing proof, found unexpected Z");
                    subproofs.push(Rc::clone(last_proof));
                }
                Some(i) if *i < hyp_end => {
                    //mandatory hypothesis
                    let label = &labels[*i];
                    let data = Rc::clone(&self.labels[label]);

                    match data.deref() {
                        LabelEntry::DollarA(a) | LabelEntry::DollarP(a) => {
                            println!("Verifying hypothesis  {:?}", a);
                            let new_prev = self.verify_assertion(a, &mut stack);
                            previous_proof = Some(new_prev);
                        }
                        LabelEntry::DollarF(x) | LabelEntry::DollarE(x) => {
                            stack.push(x.clone());
                            previous_proof = Some(Rc::clone(x))
                        }
                    }
                }

                Some(i) if hyp_end <= *i && *i < label_end => {
                    //one of the given labels in the proof

                    let label_name = &labels[*i];

                    let step_data = Rc::clone(&self.labels[label_name]);

                    match step_data.deref() {
                        LabelEntry::DollarA(a) | LabelEntry::DollarP(a) => {
                            let prev_statement = self.verify_assertion(a, &mut stack);

                            previous_proof = Some(prev_statement);

                        }
                        LabelEntry::DollarE(x) | LabelEntry::DollarF(x) => {
                            previous_proof = Some(Rc::clone(x));
                            stack.push(Rc::clone(x));
                        }
                    }
                }

                Some(i) if label_end <= *i => {
                    // no need to verify something already proved
                    let pf = &subproofs[(*i as usize) - label_end];
                    stack.push(Rc::clone(pf));
                    previous_proof = Some(Rc::clone(pf));
                }
                _ => {
                    panic!("Bad compression")
                }
            }
        }

        if stack.len() > 1 {
            panic!("stack has anentry greater than >1 at end")
        }
        if stack[0] != stat {
            panic!(
                "assertion proved {:?} but does not match expected {:?} ",
                stack[0], stat
            );
        }
    }

    fn get_labels(&self, stat: Statement, _ep: usize) -> Vec<Label> {
        let Assertion {
            dvs: _dm,
            f_hyps: mand_hyp_stmnts,
            e_hyps: hype_stmnts,
            stat: _,
        } = self.fs.make_assertion(stat);
        // println!("mand_hyps_stmnts {:?}", mand_hyp_stmnts);

        let mand_hyps = mand_hyp_stmnts
            .iter()
            .map(|(_k, v)| self.fs.lookup_f(v.clone()));

        let hyps = hype_stmnts.iter().map(|s| self.fs.lookup_e(s.clone()));

        let labels: Vec<Label> = mand_hyps.chain(hyps).collect(); // contains both the mandatory hypotheses and the e println!("Labels {:?}", labels);

        labels
    }

    fn get_proof_indeces(compressed_proof: String) -> Vec<Option<usize>> {
        let mut proof_indeces: Vec<Option<usize>> = vec![];
        let mut cur_index: usize = 0;

        for ch in compressed_proof.chars() {
            if ch == 'Z' {
                proof_indeces.push(None);
            } else if ('A'..='T').contains(&ch) {
                cur_index = 20 * cur_index + (ch as i32 - 'A' as i32 + 1) as usize;
                if cur_index == 0 {
                    panic!("current index was tagged as 0, bad character {}", ch);
                }
                proof_indeces.push(Some(cur_index - 1));
                cur_index = 0;
            } else if ('U'..='Y').contains(&ch) {
                cur_index = 5 * cur_index + (ch as i32 - 'U' as i32 + 1) as usize;
            }
        }
        proof_indeces
    }

    fn print_stack(stack: &Vec<Statement>) {
        println!(
            "stack: {:?}",
            stack.iter().map(|x| x.join(" ")).collect::<Vec<String>>()
        );
    }

    fn verify_assertion(&mut self, assertion: &Assertion, stack: &mut Vec<Statement>) -> Statement {
        let Assertion {
            dvs: distinct,
            f_hyps: mand_var,
            e_hyps: hyp,
            stat: result,
        } = assertion;
        let npop = mand_var.len() + hyp.len();
        let sp = stack.len() - npop;
        if stack.len() < npop {
            panic!("stack underflow")
        }
        let mut sp = sp;
        let mut subst = HashMap::<LanguageToken, Statement>::new();

        for (k, v) in mand_var {
            let entry: Statement = stack[sp].clone();

            if &entry[0] != k {
                panic!(
                    "stack entry doesn't match mandatry var hypothess, found {} and {}",
                    &entry[0], k
                );
            }

            subst.insert(v.clone(), entry[1..].into());
            sp += 1;
        }

        for (x, y) in distinct {
            let x_vars = self.find_vars(Rc::clone(&subst[x]));
            let y_vars = self.find_vars(subst[y].clone());


            for x in &x_vars {
                for y in &y_vars {
                    if x == y || !self.fs.lookup_d(x.clone(), y.clone()) {
                        panic!("Disjoint violation");
                    }
                }
            }
        }
        for h in hyp {
            let entry = &stack[sp];
            let subst_h = self.apply_subst(h, &subst);
            if entry != &subst_h {
                panic!(
                    "Stack entry: {:?} doesn't match hypothesis {:?}",
                    entry, &subst_h
                );
            }
            sp += 1;
        }

        stack.drain(stack.len() - npop..);
        let substituted = self.apply_subst(result, &subst);
        stack.push(Rc::clone(&substituted));
        substituted
    }

    fn verify(&mut self, stat_label: String, stat: Statement, proof: Proof) {
        let mut stack: Vec<Statement> = vec![];
        let _stat_type = stat[0].clone();
        if proof[0].as_ref() == "(" {
            self.decompress_and_verify(stat, proof);
            return;
        }

        if proof.is_empty() {
            println!("Did not find proof for {}, skipping", stat_label);
            return;
        }

        for label in proof {
            let stepdat = Rc::clone(&self.labels[&label]);
            // println!("{:?} : {:?}", label, self.labels[&label]);

            match stepdat.deref() {
                LabelEntry::DollarA(a) | LabelEntry::DollarP(a) => {
                    self.verify_assertion(a, &mut stack);
                }
                LabelEntry::DollarF(x) | LabelEntry::DollarE(x) => {
                    stack.push(x.clone());
                }
            }
            // // // // println!("st: {:?}", stack);
        }
        if stack.len() != 1 {
            panic!("stack has anentry greater than >1 at end")
        }
        if stack[0] != stat {
            panic!("assertion proved doesn't match ")
        }
    }

    fn dump(&mut self) {
        // println!("{:?}", self.labels);
    }
}
fn main() {
    // println!("Starting proof verification");

    let args: Vec<String> = std::env::args().collect();

    // println!("Got cmd argumnets {:?}", args);

    let mut mm = MM::new(args.get(2).cloned(), args.get(3).cloned());

    let file = File::open(args[1].clone()).expect("Failed to find file");
    // println!("Found file name {:?}", args[1]);
    use std::time::Instant;
    let now = Instant::now();

    mm.read(&mut Tokens::new(BufReader::new(file)));
    mm.dump();
    let elapsed = now.elapsed();
    println!("Finished checking in {:.2?}", elapsed);
}
