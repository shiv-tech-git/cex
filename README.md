# Command EXecutor
CEX (pronounced as "keks") is the bash framework designed to organize work with scripts.  
 

## Init
Run:
```
mkdir my_tool_dir
cd my_tool_dir
git clone https://github.com/shiv-tech-git/cex.git
./cex/bootstrap.sh
```
Set name:
```
App name: my_tool
```
Output:
```
App id: cex_my_tool
Append to /home/user/.bashrc:
        PATH=$PATH:/home/user/my_tool_dir #cex_my_tool

Create link: my_tool
Create hello_world example

run: . /home/user/.bashrc
run: my_tool --help
run: my_tool hello-world
```
Run:  
```
. ./$(basename $SHELL)rc
my_tool hello-world
```

## Create command
Create:   
`src/do_routine.sh`  

Append to _commands_:
```
#My everyday routine
    do_routine      "./src/do_routine.sh"
```
Run:
```
my_tool --help
```  
Output:
```
./src/help.sh  

Command executor
    --update        ./src/update.sh
    --help          ./src/help.sh

My everyday routine
    do_routine      ./src/do_routine.sh
```
Run:
```
my_tool do_routine
```  
Output:
```
Everyday routine has been started...
``` 

## Multitool
You can create multiple tools with single CEX source code.  
Run:
```
mkdir my_tool_1
cd my_tool_1
../cex/bootstrap.sh
cd ..

mkdir my_tool_2
cd my_tool_2
../cex/bootstrap.sh
cd ..
```

## Submodule
You can use CEX as submodule.  
Run:
```
git submodule add https://github.com/shiv-tech-git/cex.git
./cex/bootstrap.sh
```

## Global variables
In all scripts next variables available:
  - CEX_APP_ID
  - CEX_APP_NAME
  - CEX_APP_ROOT

## Commands file syntax
  - comments that starts with '##' visible only in _commands_ file
  - comments that starts with '#' visible in `my_tool --help`
  - commands that starts with '--' reserved for CEX commands  

## Preload
In _preload_ dir:
  - all files content will be exported before executing scripts
  - functions that starts with "cex_" reserved for CEX functions
  - variables that starts with "CEX_" reserved for CEX variables

## Hooks
Files in _hooks_ dir with special name fill be invoked on:  
`dbs --install`:
  - _./hooks/pre_install.sh_
  - _./hooks/post_install.sh_

`dbs --uninstall`:
  - _./hooks/pre_uninstall.sh_
  - _./hooks/post_uninstall.sh_

See /preload/hooks.sh `function cex_invoke_hook`

## Hello world
Examine `hello-world` example for better understanding.  
Run:  
```
./cex/bootstrap.sh
App name: my_tool
...
...
...
. ./$(basename $SHELL)rc
my_tool hello-world
```
