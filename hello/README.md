## hello world in Rust
this a simple hello world in rust 
if a parameter was passed like
    
    hello toto 

it answers : hello toto  

### how to build statically (no dependencies)

    rustc -C target-feature=+crt-static -o hello  src/main.rs

    ldd ./hello 
	statically linked

    file ./hello
    ./hello: ELF 64-bit LSB pie executable, x86-64, version 1 (GNU/Linux), static-pie linked, BuildID[sha1]=d9fcf57c29b00d7f9783bdc9c7899d2714da7973, for GNU/Linux 3.2.0, with debug_info, not stripped


As explained in this [stackoverflow article](https://stackoverflow.com/questions/31770604/how-to-generate-statically-linked-executables)
you can also add the next line to .cargo/config

    [target.x86_64-unknown-linux-gnu]
    rustflags = ["-C", "target-feature=+crt-static"]
     


### strip debug info and symbols

As explained in the [Rust performance Book](https://nnethercote.github.io/perf-book/build-configuration.html#:~:text=Strip%20Debug%20Info%20and%20Symbols&text=Alternatively%2C%20use%20strip%20%3D%20%22symbols,when%20debug%20info%20is%20stripped.)
 
*"...Stripping debug info can greatly reduce binary size. On Linux, the binary size of a small Rust programs might shrink by 4x when debug info is stripped..."*

Before stripping here is the size of our binary 

    du -h hello 
    5.6M	hello

To strip the file  add the last two lines to .cargo/config

    [target.x86_64-unknown-linux-gnu]
    rustflags = ["-C", "target-feature=+crt-static"]
    [profile.release]
    strip = "symbols"

now proceed to build with cargo

    cargo clean
    cargo build  --release 

    ldd ../target/release/hello
	statically linked

    file ../target/release/hello
    ../target/release/hello: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), static-pie linked, BuildID[sha1]=414d8f5212c6307e94d41d6e0be3345ceb39ba6c, for GNU/Linux 3.2.0, stripped

    du -h ../target/release/hello
    1.4M	../target/release/hello


**That's a 75% smaller file, that's a huge size reduction !**
    


### security of the binary

If you check this binary with [checksec](https://github.com/lao-tseu-is-alive/checksec.sh) :
    
    checksec --file=../target/release/hello
    RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH	Symbols		FORTIFY	Fortified	Fortifiable	FILE
    Full RELRO      No canary found   NX enabled    PIE enabled     No RPATH   No RUNPATH   No Symbols	  No	0		0		../target/release/hello


you can find information on the history of this security tool in [Tobias Klein web](https://www.trapkit.de/tools/checksec/)
<br><br>

 + [Stack Canaries are very simple - at the beginning of the function, a random value is placed on the stack](https://ir0nstone.gitbook.io/notes/types/stack/canaries)

 + [NX bit, wich stands for No eXecute](https://ir0nstone.gitbook.io/notes/types/stack/no-execute)

 + [PIE stands for Position Independent Executable](https://ir0nstone.gitbook.io/notes/types/stack/pie)

 + [Information on flags RPATH and RUNPATH](https://security.stackexchange.com/questions/161799/why-does-checksec-sh-highlight-rpath-and-runpath-as-security-issues/165762#165762)

 + [checksec security properties explained](https://opensource.com/article/21/6/linux-checksec)


