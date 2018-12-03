use std::fs::File;
use std::collections::HashSet;
use std::io::{BufRead,BufReader};

fn main() {
    let f = File::open("day01").unwrap();

    let v: Vec<i32> = BufReader::new(&f).lines()
        .map(|l| l.unwrap().parse().unwrap())
        .collect();
    println!("{}", v.iter().sum::<i32>());  // 553

    let mut seen = HashSet::new();
    let s = v.iter()
        .cycle()
        .scan(0, |a,e| {
            *a += e;
            Some(*a)
        })
        .find(|n| !seen.insert(*n));
    println!("{}", s.unwrap_or(-1));  // 78724
}
