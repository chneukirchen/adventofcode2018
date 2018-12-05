use std::fs::File;
use std::collections::{HashSet, HashMap};
use std::io::{BufRead, BufReader};

fn main() {
    let f = File::open("day03").unwrap();

    let d: Vec<_> = BufReader::new(&f)
        .lines()
        .map(|line| {
            let line = line.unwrap();
            let v: Vec<&str> = line.split(
                |c| c == '#' || c == ',' || c == ' ' || c == 'x' || c == ':'
            ).collect();
            (
                v[1].parse::<i32>().unwrap(),
                v[3].parse::<i32>().unwrap(),
                v[4].parse::<i32>().unwrap(),
                v[6].parse::<i32>().unwrap(),
                v[7].parse::<i32>().unwrap(),
            )
        })
        .collect();

    let mut seen = HashMap::new();
    let mut seen_twice = HashSet::new();

    let mut claims: HashSet<_> = d.iter().map(|x| x.0).collect();

    for v in d {
        for x in v.1..v.1 + v.3 {
            for y in v.2..v.2 + v.4 {
                if let Some(id) = seen.insert((x, y), v.0) {
                    seen_twice.insert((x, y));
                    claims.remove(&id);
                    claims.remove(&v.0);
                }
            }
        }
    }

    println!("{}", seen_twice.len());
    for c in claims {
        println!("{}", c)
    }
}
