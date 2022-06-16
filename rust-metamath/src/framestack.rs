use std::cmp::max;
use std::cmp::min;
use std::collections::{HashMap, HashSet, VecDeque};

use crate::reader::Label;
use crate::reader::LanguageToken;
use crate::reader::Statement;

#[derive(Default, Debug)]
pub struct Frame {
    c: HashSet<LanguageToken>,
    v: HashSet<LanguageToken>,
    d: HashSet<(LanguageToken, LanguageToken)>, //maybe switch this give c and v different types
    f: Vec<(LanguageToken, LanguageToken)>,
    f_labels: HashMap<LanguageToken, Label>,
    e: Vec<Statement>,
    e_labels: HashMap<Statement, Label>,
}

#[derive(Default, Debug)]
pub struct FrameStack {
    pub list: Vec<Frame>,
}

#[derive(Debug)]
pub struct Assertion {
    pub dvs: HashSet<(LanguageToken, LanguageToken)>,
    pub f_hyps: VecDeque<(LanguageToken, LanguageToken)>,
    pub e_hyps: Vec<Statement>,
    pub stat: Statement,
}

impl FrameStack {
    pub fn push(&mut self) {
        self.list.push(Frame::default());
    }

    pub fn add_c(&mut self, token: LanguageToken) {
        let frame = &mut self.list.last_mut().unwrap();

        if frame.c.contains(&token) {
            panic!("Const already defined")
        }
        if frame.v.contains(&token) {
            panic!("consta elaryd defined as var in scope")
        }
        frame.c.insert(token);
    }

    pub fn add_v(&mut self, token: LanguageToken) {
        let frame = &mut self.list.last_mut().unwrap();

        if frame.c.contains(&token) {
            panic!("Variable already defined")
        }
        if frame.v.contains(&token) {
            panic!("Variable elaryd defined as var in scope")
        }
        frame.v.insert(token);
    }

    pub fn add_f(&mut self, var: LanguageToken, kind: LanguageToken, label: Label) {
        if !self.lookup_v(&var) {
            panic!("var not defined")
        }
        if !self.lookup_c(&kind) {
            panic!("const not defined")
        }

        let frame = self.list.last_mut().unwrap();
        if frame.f_labels.contains_key(&var) {
            panic!("f already defined in scope")
        }
        frame.f.push((var.clone(), kind));
        frame.f_labels.insert(var, label);
    }

    pub fn add_e(&mut self, stat: Statement, label: Label) {
        let frame = self.list.last_mut().unwrap();

        frame.e.push(stat.clone());
        frame.e_labels.insert(stat, label);
    }

    pub fn add_d(&mut self, stat: Statement) {
        let frame = self.list.last_mut().unwrap();
        //let mut product_vec = vec!();
        for x in stat.iter() {
            for y in stat.iter() {
                if x != y {
                    frame
                        .d
                        .insert((min(x.clone(), y.clone()), max(x.clone(), y.clone())));
                }
            }
        }
    }

    pub fn lookup_c(&self, token: &str) -> bool {
        self.list.iter().rev().any(|fr| fr.c.contains(token))
    }

    pub fn lookup_v(&self, token: &str) -> bool {
        self.list.iter().rev().any(|fr| fr.v.contains(token))
    }

    pub fn lookup_f(&self, var: LanguageToken) -> Label {
        // println!("lookup {}", var);
        let f = self
            .list
            .iter()
            .rev()
            .find(|frame| frame.f_labels.contains_key(&var))
            .unwrap();

        f.f_labels[&var].clone()
    }

    pub fn lookup_d(&self, x: LanguageToken, y: LanguageToken) -> bool {
        self.list.iter().rev().any(|fr| {
            fr.d.contains(&(min(x.clone(), y.clone()), max(x.clone(), y.clone())))
        })
    }

    pub fn lookup_e(&self, stmt: Statement) -> Label {
        let f = self
            .list
            .iter()
            .rev()
            .find(|frame| frame.e_labels.contains_key(&stmt))
            .expect("Bad e");

        f.e_labels[&stmt].clone()
    }

    pub fn make_assertion(&self, stat: Statement) -> Assertion {
        //let _frame = self.list.last_mut().unwrap();

        let e_hyps: Vec<Statement> = self.list.iter().flat_map(|fr| fr.e.clone()).collect();

        let chained = e_hyps.iter().chain(std::iter::once(&stat));

        let mut mand_vars: HashSet<LanguageToken> = chained
            .flat_map(|x| x.iter())
            .filter(|tok| self.lookup_v(tok))
            .cloned()
            .collect(); //cloned should do a shallow copy

        // println!("ma: \n mand_vars: {:?}, ", mand_vars);

        let mut cartesian: HashSet<(LanguageToken, LanguageToken)> = HashSet::new();

        for x in mand_vars.iter() {
            for y in mand_vars.iter() {
                cartesian.insert((x.clone(), y.clone()));
            }
        }

        let dvs: HashSet<(LanguageToken, LanguageToken)> = self
            .list
            .iter()
            .flat_map(|fr| fr.d.intersection(&cartesian))
            .cloned()
            .collect();

        let mut f_hyps = VecDeque::new();
        self.list.iter().rev().for_each(|fr| {
            fr.f.iter().rev().for_each(|(v, k)| {
                if mand_vars.contains(v) {
                    f_hyps.push_front((k.clone(), v.clone()));
                    mand_vars.remove(v);
                }
            });
        });
        // println!("ma: \n dvs: {:?}, f: {:?}, e_hyps: {:?}, stat: {:?}", dvs, f_hyps, e_hyps, stat);

        Assertion {
            dvs,
            f_hyps,
            e_hyps,
            stat,
        }
    }
}
