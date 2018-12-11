use std::fs::File;
use std::io::{BufRead,BufReader};

fn main() {
    let f = File::open("day10").unwrap();

    let v: Vec<(i32,i32,i32,i32)> = BufReader::new(&f).lines()
        .map(|l| {
            let l = l.unwrap();
            (l[10..16].trim().parse().unwrap(),
             l[18..24].trim().parse().unwrap(),
             l[36..38].trim().parse().unwrap(),
             l[40..42].trim().parse().unwrap())
        }).collect();

    let p2 = (0..20000).min_by_key(|i| {
        let a = v.iter().map(|l| l.0 + i*l.2).max().unwrap();
        let b = v.iter().map(|l| l.0 + i*l.2).min().unwrap();
        (a - b)
    }).unwrap();

    let mut m = [[' '; 30]; 80];
    for l in v {
        m[(l.0 + p2*l.2 - 100) as usize][(l.1 + p2*l.3 - 180) as usize] = '#';
    }

    for x in 0..30 {
        for y in 0..80 {
            print!("{}", m[y][x]);
        }
        println!("");
    }
    println!("{}", p2);
}
