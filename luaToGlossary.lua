test = false
local save = { tformat = {}}
function section(str) end
function t(source, target, tag)
    if string.len(source) <= 30 and not string.find(source, "\n") then
        if tag ~= "nil" and tag ~= "_t" and tag ~= "tformat"  then
            save[tag] = save[tag] or {}
            if not save[tag][source] then 
                save[tag][source] = target
                if not test then
                    print(source, target, tag)
                end
            else
                if test and save[tag][source] ~= target then print(source, target, tag) end 
            end
        else 
            if not save.tformat[source] then
                save.tformat[source] = target
                if not test then
                    print(source, target)
                end
            else
                if test and save.tformat[source] ~= target then print(source, target, tag) end
            end
        end
    end
end
dofile("others/tome4-chinese-translation/engine.lua")
dofile("others/tome4-chinese-translation/mod-tome.lua")
dofile("others/tome4-chinese-translation/tome-ashes-urhrok.lua")
dofile("others/tome4-chinese-translation/tome-orcs.lua")
dofile("others/tome4-chinese-translation/tome-cults.lua")