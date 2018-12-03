use std::fs::File;
use std::io::{BufRead, BufReader};

fn appears(s: &str, n: usize) -> bool {
    s.chars().any(|c| s.matches(c).count() == n)
}

fn same_but_one(s: &str, t: &str) -> Option<String> {
    let mut x = s.chars().zip(t.chars()).enumerate().filter(|(_, (a,b))| a != b);
    match (x.next(), x.next()) {
        (Some(m), None) => Some(format!("{}{}", &s[..m.0], &s[m.0+1..])),
        _ => None
    }
}

fn main() {
    let f = File::open("day02").unwrap();

    let v: Vec<_> = BufReader::new(&f).lines().map(|l| l.unwrap()).collect();

    println!("{}",
             v.iter().filter(|s| appears(s, 2)).count() *
             v.iter().filter(|s| appears(s, 3)).count());

    'outer: for x in &v {
        for y in &v {
            if let Some(s) = same_but_one(&x, &y) {
                println!("{}", s);
                break 'outer;
            }
        }
    }
}
