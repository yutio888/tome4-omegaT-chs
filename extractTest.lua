local cur_sec = ""

function section(str) 
    cur_sec = str
end

local function isShortString(str)
    local counts = 0
    for word in string.gmatch(str, "\n") do
        counts = counts + 1
        if counts >= 10 then return end
    end
    return true
end
function t(source, target, tag)
    if string.find(cur_sec, "/data/talents") and isShortString(source) then
        print(source)
        print("")
    end
end
dofile("others/tome4-chinese-translation/engine.lua")
dofile("others/tome4-chinese-translation/mod-tome.lua")
dofile("others/tome4-chinese-translation/tome-ashes-urhrok.lua")
dofile("others/tome4-chinese-translation/tome-orcs.lua")
dofile("others/tome4-chinese-translation/tome-cults.lua")