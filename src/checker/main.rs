use std::rc::Rc;

#[derive(Debug, Eq, PartialEq)]
enum Instruction {
    List = 1,
    // Patterns
    EVar, SVar, Symbol, Implication, Application, Mu, Exists,
    // Meta Patterns,
    MetaVar, ESubst, SSubst,
    // Axiom Schemas,
    Prop1, Prop2, Prop3, Quantifier, PropagationOr, PropagationExists,
    PreFixpoint, Existance, Singleton,
    // Inference rules,
    ModusPonens, Generalization, Frame, Substitution, KnasterTarski,
    // Meta Incference rules,
    InstantiateNotation, InstantiateSchema,
    // Stack Manipulation,
    Pop,
    // Memory Manipulation,
    Save, Load,
    // Journal Manipulation,
    Publish,
}

impl Instruction {
    fn from(value: u32) -> Instruction {
        match value {
            1 => Instruction::List,
            2 => Instruction::EVar,
            3 => Instruction::SVar,
            4 => Instruction::Symbol,
            5 => Instruction::Implication,
            6 => Instruction::Application,
            7 => Instruction::Mu,
            8 => Instruction::Exists,
            9 => Instruction::MetaVar,
           10 => Instruction::ESubst,
           11 => Instruction::SSubst,
           12 => Instruction::Prop1,
           13 => Instruction::Prop2,
           14 => Instruction::Prop3,
           15 => Instruction::Quantifier,
           16 => Instruction::PropagationOr,
           17 => Instruction::PropagationExists,
           18 => Instruction::PreFixpoint,
           19 => Instruction::Existance,
           20 => Instruction::Singleton,
           21 => Instruction::ModusPonens,
           22 => Instruction::Generalization,
           23 => Instruction::Frame,
           24 => Instruction::Substitution,
           25 => Instruction::KnasterTarski,
           26 => Instruction::InstantiateNotation,
           27 => Instruction::InstantiateSchema,
           28 => Instruction::Pop,
           29 => Instruction::Save,
           30 => Instruction::Load,
           31 => Instruction::Publish,
            _ => panic!("Bad Instruction!")
        }
    }
}

#[derive(Debug, Eq, PartialEq, Clone)]
enum Pattern {
    EVar(u32),
    SVar(u32),
    Symbol(u32),
    Implication{left: Rc<Pattern>, right: Rc<Pattern>},
    Application{left: Rc<Pattern>, right: Rc<Pattern>},
    Exists  { var: u32, subpattern: Rc<Pattern>},
    Mu      { var: u32, subpattern: Rc<Pattern>},

    MetaVar{
        id: u32,
        e_fresh: Vec<u32>,
        s_fresh: Vec<u32>,
        positive: Vec<u32>,
        negative: Vec<u32>,
        application_context: Vec<u32>
    },
}
#[derive(Debug, Eq, PartialEq, Clone)]
enum Term        { Pattern(Rc<Pattern>), Proved(Rc<Pattern>), List(Vec<u32>) }
#[derive(Debug, Eq, PartialEq)]
enum Entry       { Pattern(Rc<Pattern>), Proved(Rc<Pattern>) }

type Stack = Vec<Term>;
type Journal = Vec<Entry>;
type Memory = Vec<Entry>;

fn pop_stack(stack: &mut Stack) -> Term {
    return stack.pop().expect("Insufficient stack items.");
}

fn pop_stack_list(stack: &mut Stack) -> Vec<u32> {
    match pop_stack(stack) {
        Term::List(l) => return l,
        _   => panic!("Expected list on stack.")
    }
}

fn pop_stack_pattern(stack: &mut Stack) -> Rc<Pattern> {
    match pop_stack(stack) {
        Term::Pattern(p) => return p,
        _ => panic!("Expected list on stack.")
    }
}


fn execute_instructions<'a>(
    mut proof: impl Iterator<Item = &'a u32>,
    stack: &mut Stack, memory: &mut Memory, journal: &mut Journal)
{
    while let Some(instr_u32) = proof.next() {
        match Instruction::from(*instr_u32) {
            Instruction::List => {
                let len = *proof.next().expect("Insufficient parameters for List instruction") as usize;
                assert_eq!(len, 0);
                let list = vec![];
                stack.push(Term::List(list));
            }
            Instruction::Implication => {
                let right = pop_stack_pattern(stack);
                let left = pop_stack_pattern(stack);
                stack.push(Term::Pattern(Rc::new(Pattern::Implication{left, right})))
            }
            Instruction::MetaVar => {
                let id = *proof.next().expect("Insufficient parameters for MetaVar instruction");
                let application_context = pop_stack_list(stack);
                let negative = pop_stack_list(stack);
                let positive = pop_stack_list(stack);
                let s_fresh = pop_stack_list(stack);
                let e_fresh = pop_stack_list(stack);
                stack.push(Term::Pattern(Rc::new(
                    Pattern::MetaVar{id, e_fresh, s_fresh, positive, negative, application_context})));
            }
            Instruction::Save => {
                match stack.last().expect("Save needs an entry on the stack") {
                    Term::Pattern(p) => memory.push(Entry::Pattern(p.clone())),
                    Term::Proved(p) => memory.push(Entry::Proved(p.clone())),
                    Term::List(_) => panic!("Cannot Save lists."),
                }
            }
            Instruction::Load => {
                let index = *proof.next().expect("Insufficient parameters for Load instruction");
                match &memory[index as usize] {
                    Entry::Pattern(p) => stack.push(Term::Pattern(p.clone())),
                    Entry::Proved(p) => stack.push(Term::Proved(p.clone())),
                }
            }
            _ => { unimplemented!("Instruction: {}", instr_u32) }
        }
    }
}
 
fn verify<'a>(proof: impl Iterator<Item = &'a u32>) -> (Stack, Journal, Memory) {
    let mut stack = vec![];
    let mut journal = vec![];
    let mut memory = vec![];
    execute_instructions(proof, &mut stack, &mut journal, &mut memory);
    return (stack, journal, memory);
}

fn test_construct_phi_implies_phi() {
    let proof : Vec<u32> = vec![
        Instruction::List as u32, 0, // E Fresh
        Instruction::List as u32, 0, // S Fresh
        Instruction::List as u32, 0, // Positive
        Instruction::List as u32, 0, // Negative
        Instruction::List as u32, 0, // Context
        Instruction::MetaVar as u32, 0, // Stack: Phi
        Instruction::Save as u32,    // @ 0
        Instruction::Load as u32, 0, // Phi ; Phi
        Instruction::Implication as u32, // Phi -> Phi
    ];
    let (stack, _journal, _memory) = verify(proof.iter());
    let phi0 = Rc::new(Pattern::MetaVar{id: 0, s_fresh: vec![], e_fresh: vec![], positive: vec![], negative: vec![], application_context: vec![]});
    assert_eq!(stack, vec![Term::Pattern(Rc::new(Pattern::Implication{left: phi0.clone(), right: phi0.clone()}))]);
}

fn main() {
    test_construct_phi_implies_phi()
}


