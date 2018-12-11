use std::collections::VecDeque;

const mp : usize = 466;
const mr : usize = 71436;

fn main() {
    let mut s = VecDeque::new();
    s.push_back(0);

    let mut scores = [0usize; mp + 1];

    for (n, p) in (1..mp+1).cycle().take(mr*100).enumerate() {
        let m = n + 1;
        if m % 23 == 0 {
            scores[p] += m;

            for _ in 0..7 {
                let x = s.pop_back().unwrap();
                s.push_front(x);
            }

            scores[p] += s.pop_back().unwrap();
            let x = s.pop_front().unwrap();
            s.push_back(x);
        } else {
            let x = s.pop_front().unwrap();
            s.push_back(x);
            s.push_back(m);
        }
    }

    println!("{}", scores.iter().max().unwrap());
}
