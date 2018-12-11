use std::fs::File;
use std::collections::{HashMap, HashSet};
use std::io::{BufRead, BufReader};

fn l1(a: (i32, i32), b: (i32, i32)) -> i32 {
    (a.0 - b.0).abs() + (a.1 - b.1).abs()
}

fn main() {
    let f = File::open("day06").unwrap();

    let v: Vec<Vec<i32>> = BufReader::new(&f)
        .lines()
        .map(|l| {
            l.unwrap().split(", ").map(|x| x.parse().unwrap()).collect()
        })
        .collect();

    let mut c = HashMap::new();
    let mut b = HashSet::new();

    let mut s = 0;

    for x in 0..500 {
        for y in 0..500 {
            let next = v.iter()
                .min_by_key(|p| l1((x, y), (p[0], p[1]))).unwrap();
            *c.entry(next).or_insert(0) += 1;

            if x == 0 || x == 499 || y == 0 || y == 499 {
                b.insert(next);
            }

            if v.iter().map(|p| l1((x, y), (p[0], p[1]))).sum::<i32>() < 10000 {
                s += 1;
            }
        }
    }

    println!(
        "{}",
        c.iter()
            .filter(|(k, _)| !b.contains(*k))
            .max_by_key(|(_, v)| *v)
            .unwrap().1
    );
    println!("{}", s);
}
