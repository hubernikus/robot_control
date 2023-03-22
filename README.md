# robot_control
Library use for Robot Control [in Rust]

Build the project:

``` bash
cargo build
```

Exectue the project:

``` bash
./target/debug/robot_avoider
```



## General Setup (standard for rust crates)
``` bash
cd libs && bindgen input.h -o bindings.rs 
```

Install bindgen
``` bash
cargo install bindgen-cli
```
