use std::fs::File;
use std::io::prelude::*;

fn react(s: &mut String) -> usize {
    while let Some(pos) = (0..s.len() - 1).find(|i| {
        (s.as_bytes()[*i] as i32 - s.as_bytes()[*i + 1] as i32).abs() == 32
    }) {
        s.replace_range(pos..pos + 2, "");
    }
    return s.len();
}

fn main() {
    let mut f = File::open("day05").unwrap();

    let mut s = String::new();
    f.read_to_string(&mut s).unwrap();
    s.pop();

    println!("{}", react(&mut s.clone()));

    println!("{}",
             (65u8..65u8 + 27)
             .map(|c| {
                 let mut t = s.clone();
                 t.retain(|b| b != (c as char) && b != (c + 32u8) as char);
                 react(&mut t)
             })
             .min()
             .unwrap());
}
