## hello world in Rust
this a simple hello world in rust 
if a parameter was passed like
    
    hello toto 

it answers : hello toto  

### how to build statically (no dependencies)

    rustc -C target-feature=+crt-static -o hello  src/main.rs

As explained in this [stackoverflow article](https://stackoverflow.com/questions/31770604/how-to-generate-statically-linked-executables)
you can also add the next line to .cargo/config

    rustflags = ["-C", "target-feature=+crt-static"] 


