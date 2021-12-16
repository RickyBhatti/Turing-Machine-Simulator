# Turing Machine Simulator

A Turing Machine Simulator written in Lua 5.3

# How to Use

## Instructions

startingState - The state in which to start in. Found on `Line 4`

charRead - Character to read  
nextState - Next state to transition to  
charWrite - Character to write to position  
move - Direction to move.
> 'L' - Left | 'R' - Right | '-' - Halt

```lua
["q1"] = { -- State
    {  -- Instruction 1
        charRead = "a", -- Character to read
        nextState = "q1", -- Next State
        charWrite = "a", -- Character to write
        move = "R" -- Direction to move "L"/"R"/"-"
    },
    {
        charRead = "b",
        nextState = "q1",
        charWrite = "b",
        move = "R"
    },
    {
        charRead = "_",
        nextState = "q2",
        charWrite = "_",
        move = "L"
    },
}
```

## How to run

You need lua5.3 installed to be able to run this script.

> To install lua5.3 on Ubuntu use: `sudo apt-get install lua5.3`  

> To install lua5.3 on Windows download: https://sourceforge.net/projects/luabinaries/files/5.3.5/

To run the script, just simply use the following command.

### Linux
```
lua turing.lua
```

### Windows **(Powershell only)**
```
path\to\lua.exe turing.lua
```


