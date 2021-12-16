local sleepTime = "0.05"
local inputString = "abababbaaaba"

local startingState = "q0"
local instructionSet = {
    [startingState] = {
        {
            charRead = "a",
            nextState = "q1",
            charWrite = "a",
            move = "R"
        },
        {
            charRead = "b",
            nextState = "q1",
            charWrite = "b",
            move = "R"
        },
        {
            charRead = "_",
            nextState = "q7",
            charWrite = "_",
            move = "R"
        },
    },
    ["q1"] = {
        {
            charRead = "a",
            nextState = "q1",
            charWrite = "a",
            move = "R"
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
    },
    ["q2"] = {
        {
            charRead = "a",
            nextState = "q3",
            charWrite = "x",
            move = "R"
        },
        {
            charRead = "b",
            nextState = "q4",
            charWrite = "x",
            move = "R"
        },
        {
            charRead = "x",
            nextState = "q2",
            charWrite = "x",
            move = "L"
        },
        {
            charRead = "_",
            nextState = "q6",
            charWrite = "_",
            move = "R"
        },
    },
    ["q3"] = {
        {
            charRead = "a",
            nextState = "q3",
            charWrite = "a",
            move = "R"
        },
        {
            charRead = "b",
            nextState = "q3",
            charWrite = "b",
            move = "R"
        },
        {
            charRead = "x",
            nextState = "q3",
            charWrite = "x",
            move = "R"
        },
        {
            charRead = "_",
            nextState = "q5",
            charWrite = "a",
            move = "L"
        },
    },
    ["q4"] = {
        {
            charRead = "a",
            nextState = "q4",
            charWrite = "a",
            move = "R",
        },
        {
            charRead = "b",
            nextState = "q4",
            charWrite = "b",
            move = "R",
        },
        {
            charRead = "x",
            nextState = "q4",
            charWrite = "x",
            move = "R",
        },
        {
            charRead = "_",
            nextState = "q5",
            charWrite = "b",
            move = "L",
        },
    },
    ["q5"] = {
        {
            charRead = "a",
            nextState = "q5",
            charWrite = "a",
            move = "L"
        },
        {
            charRead = "b",
            nextState = "q5",
            charWrite = "b",
            move = "L"
        },
        {
            charRead = "x",
            nextState = "q2",
            charWrite = "x",
            move = "L"
        }
    },
    ["q6"] = {
        {
            charRead = "a",
            nextState = "q7",
            charWrite = "a",
            move = "R"
        },
        {
            charRead = "b",
            nextState = "q7",
            charWrite = "b",
            move = "R"
        },
        {
            charRead = "x",
            nextState = "q6",
            charWrite = "_",
            move = "R"
        },
    },
    ["q7"] = {}
}

local currentState, currentInstruction = startingState, ""
local lowestIndex, currentHeadPosition = 1, 1

local tape = {}
setmetatable(tape, {
    __index = function(t, k)
        return rawget(t, k) or "_"
    end
})

for i = 1, #inputString do tape[i] = inputString:sub(i, i) end

function printTape()
    os.execute(("sleep %s"):format(sleepTime))
    os.execute("clear")
    for i = lowestIndex, #tape do
        io.write(" " .. tape[i] .. " ")  -- Doesn't cause a new line
    end
    print("") -- New line
    
    for i = lowestIndex, currentHeadPosition do
        if i == currentHeadPosition then 
            print(" ^ ") 
        else 
            io.write("   ") -- Doesn't cause a new line
        end
    end
    print("") -- New line
end

while currentInstruction ~= "-" do
    printTape()
    
    local currentInstructionSet, shouldHalt = instructionSet[currentState], true
    for i = 1, #currentInstructionSet do
        if tape[currentHeadPosition] == currentInstructionSet[i]["charRead"] then
            tape[currentHeadPosition], currentState = currentInstructionSet[i]["charWrite"], currentInstructionSet[i]["nextState"]
            
            shouldHalt = false
            if currentInstructionSet[i]["move"] == "-" then
                shouldHalt = true
            elseif currentInstructionSet[i]["move"] == "L" then
                currentHeadPosition = currentHeadPosition - 1
                if (currentHeadPosition < lowestIndex) then lowestIndex = currentHeadPosition end
            else 
                currentHeadPosition = currentHeadPosition + 1
            end
            
            
            printTape()
            break
        end
    end

    if shouldHalt then
        print("HALT")
        break
    end
end