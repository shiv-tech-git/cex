# Command EXecutor
CEX (pronounced as "keks" ) is the bash framework designed to organize work with scripts.  
 

## Init
```
mkdir my_tool_dir
cd my_tool_dir
git clone [cex_repo]
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
Create  
`src/do_routine.sh`  

Append to _commands_:
```
#My everyday routine
    do_routine      ./src/do_routine.sh
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

## Multiple tools
You can create multiple tools with single CEX source code. To do that, run:
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

## Notice!
In _commands_ file: 
  - comments that starts with '##' visible only in _commands_ file
  - comments that starts with '#' visible in `my_tool --help`
  - commands that starts with '--' reserved as CEX internal commands  

In _preload_ dir:
  - all files contect will be exported before executing scripts from _src_ dir

Examine `hello-world` example for better understanding.