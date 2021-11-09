local xml2lua = require("xml2lua")
-- This works with xml2lua 1.5-1
local tmx = {
    header = {
        ["_attr"] = {
            creationtool="OmegaT",
            ["o-tmf"]="OmegaT TMX",
            adminlang="EN-US",
            datatype="plaintext",
            creationtoolversion="4.3.2_0_6a661c5e",
            segtype="paragraph",
            srclang="EN-US",
        },
    },
    body = {
        tu = {},
    },
}

    
local list =tmx.body.tu
function section(sec)
end
local function adjustString(str)
    str = string.gsub(str, "&", "&amp;")
    str = string.gsub(str, "<", "&lt;")
    return str
end

function t(source, target, tag) 
    if source ~= target then
        list[#list + 1] = {
            tuv = {
                {
                    ["_attr"] = {
                        lang = "EN-US",
                        tag = tag ~= "nil" and tag or nil,
                    },
                    seg = adjustString(source),
                },
                {
                    ["_attr"] = { lang = "ZH-CN", },
                    seg = adjustString(target),
                },
            }
        }
    end
end
dofile("others/tome4-chinese-translation/engine.lua")
dofile("others/tome4-chinese-translation/mod-tome.lua")
dofile("others/tome4-chinese-translation/tome-ashes-urhrok.lua")
dofile("others/tome4-chinese-translation/tome-orcs.lua")
dofile("others/tome4-chinese-translation/tome-cults.lua")
os.remove("tm/auto/tome.tmx.bak")
os.rename("tm/auto/tome.tmx", "tm/auto/tome.tmx.bak")
local file = io.open("tm/auto/tome.tmx", "w")
file:write(xml2lua.toXml(tmx, "tmx"))