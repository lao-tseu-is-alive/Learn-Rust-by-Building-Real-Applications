use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    let num_args = args.len();
    if  num_args > 1 {
        println!("Hello {} !", args[1])
    } else {
        println!("Hello, world!");
    }

}
