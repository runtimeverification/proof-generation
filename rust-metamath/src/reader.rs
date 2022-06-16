use std::{
    collections::HashSet,
    fs::File,
    io::{BufRead, BufReader},
    rc::Rc,
};

#[derive(Debug)]
pub struct Tokens {
    lines_buffer: Vec<BufReader<File>>,
    token_buffer: Vec<String>,
    imported_files: HashSet<String>,
}

//since statement may be used multiple times when applying substitution
// use Rc
pub type Statement = Rc<[LanguageToken]>; //may be better to newtype this but I guess it works for now

pub type Proof = Vec<Label>; //I don't think a proof is used multiple times
pub type Label = Rc<str>;
pub type LanguageToken = Rc<str>;

impl Tokens {
    pub fn new(lines: BufReader<File>) -> Tokens {
        Tokens {
            lines_buffer: vec![lines],
            token_buffer: vec![],
            imported_files: HashSet::new(),
        }
    }
    pub fn read(&mut self) -> Option<String> {
        // println!("inside read function with state {:?}", self);
        while self.token_buffer.is_empty() {
            //println!("Buffer is empty, refilling");
            let mut line = String::new();
            // pretend this succeeeds
            let result = self.lines_buffer.last_mut().unwrap().read_line(&mut line);
            // println!("Read line: {}", line);

            match result {
                Ok(num) if num > 0 => {
                    // println!("Read {} lines ", num);
                    self.token_buffer = line.split_whitespace().map(|x| x.into()).collect();
                    self.token_buffer.reverse();
                }
                _ => {
                    // println!("Done with file");
                    self.lines_buffer.pop();
                    if self.lines_buffer.is_empty() {
                        return None;
                    }
                }
            }
            // println!("Created token buffer {:?}", self.token_buffer);
        }
        self.token_buffer.pop()
    }

    fn read_file(&mut self) -> Option<String> {
        // println!("reading file");

        let mut token = self.read();
        // println!("In read file found token {:?}", token);
        while let Some("$[") = token.as_deref() {
            let filename = self.read().expect("Couldn't find filename");
            let endbracket = self.read().expect("Coludn't find end bracket");

            // println!("In read file found filename: {:?}, endbracket: {:?}", filename, endbracket);
            if endbracket != "$]" {
                panic!("End bracket not found");
            }

            if !self.imported_files.contains(&filename) {
                // println!("Found new file {}", &filename);

                self.lines_buffer.push(BufReader::new(
                    File::open(filename.clone()).expect("Failed to open file"),
                ));
                self.imported_files.insert(filename);
            }
            token = self.read();
        }
        token
    }

    pub fn read_comment(&mut self) -> Option<String> {
        // println!("reading comment");

        loop {
            let mut token = self.read_file();
            // println!("In read comment: found token to be {:?}", token);
            match &token {
                None => return None,
                Some(x) if x == "$(" => loop {
                    match token.as_deref() {
                        Some("$)") => break,
                        _ => token = self.read(),
                    }
                },
                _ => return token,
            }
        }
    }

    pub fn readstat(&mut self) -> Statement {
        let mut stat: Vec<Rc<str>> = vec![];
        let mut token = self
            .read_comment()
            .expect("Failed to read token in read stat");

        // println!("In read stat, found token to be {:?}", token);
        while token != "$." {
            stat.push(token.into());
            token = self.read_comment().expect("EOF before $.");
        }
        stat.into()
    }
}
