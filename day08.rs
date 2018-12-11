use std::fs::File;
use std::io::{BufRead,BufReader};

fn part1(v: &mut Vec<i32>) -> i32 {
    let len = v[0];
    let mdl = v[1];

    let mut data = v.split_off(2);
    std::mem::swap(&mut data, v);
    
    let mut mds = (0..len).map(|_| part1(v)).sum::<i32>();
    
    let mut mdata = v.split_off(mdl as usize);
    std::mem::swap(&mut mdata, v);
    
    mds += mdata.iter().sum::<i32>();

    return mds;
}

fn part2(v: &mut Vec<i32>) -> i32 {
    let len = v[0];
    let mdl = v[1];
    let mut data = v.split_off(2);
    std::mem::swap(&mut data, v);
    
    let mds: Vec<i32> = (0..len).map(|_| part2(v)).collect();
    
    let mut mdata = v.split_off(mdl as usize);
    std::mem::swap(&mut mdata, v);

    if len == 0 {
        mdata.iter().sum::<i32>()
    } else {
        mdata.iter().map(|i| mds.get(*i as usize-1).unwrap_or(&0)).sum::<i32>()
    }
}

fn main() {
    let f = File::open("day08").unwrap();

    let v: Vec<i32> = BufReader::new(&f).lines()
        .next().unwrap()
        .unwrap().split(" ")
        .map(|n| n.parse().unwrap())
        .collect();

    println!("{}", part1(&mut v.clone()));
    println!("{}", part2(&mut v.clone()));
}
