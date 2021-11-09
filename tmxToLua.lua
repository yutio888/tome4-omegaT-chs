function table.print(src, offset, line_feed)
	if not line_feed then line_feed = '\n' end
	if type(src) ~= "table" then print("table.print has no table:", src) print(line_feed) return end
	offset = offset or ""
	for k, e in pairs(src) do
		-- Deep copy subtables, but not objects!
		if type(e) == "table" and not e.__ATOMIC and not e.__CLASSNAME then
			print(("%s[%s] = {"):format(offset, tostring(k))) print(line_feed)
			table.print(e, offset.."  ", line_feed)
			print(("%s}"):format(offset)) print(line_feed)
		else
			print(("%s[%s] = %s"):format(offset, tostring(k), tostring(e))) print(line_feed)
		end
	end
end
local xml2lua = require("xml2lua")
--Uses a handler that converts the XML to a Lua table
local handler = require("xmlhandler.tree")
local file = io.open("TE4CHN-omegat.tmx", "r")
local content = file:read("*all")
file:close()
local parser = xml2lua.parser(handler)
parser:parse(content)

local res = handler.root.tmx.body.tu

table.print(handler.root)

function section() end
local list = {}
function t(src, tgt, tag) 
	if tag then
		if list[src] and list[src] ~= tag then
			print("WARNING, multi tag detected", src, tag, list[src]) 
		end
		list[src] = tag
	end
end

dofile("others/tome4-chinese-translation/engine.lua")
dofile("others/tome4-chinese-translation/mod-tome.lua")
dofile("others/tome4-chinese-translation/tome-ashes-urhrok.lua")
dofile("others/tome4-chinese-translation/tome-orcs.lua")
dofile("others/tome4-chinese-translation/tome-cults.lua")

local file = io.open("output.lua", "w")
for _, p in ipairs(res) do
	local source = p.tuv[1].seg
	local target = p.tuv[2].seg
	local tag = list[source]
	if not tag then
		file:write(([[t(%s%s%s, %s%s%s)]]):format("[[",source,"]]","[[", target,"]]"))
		file:write("\n")
	else
		file:write(([[t(%s%s%s, %s%s%s, %s%s%s)]]):format("[[",source,"]]","[[", target,"]]", [["]] , tag, [["]]))
		file:write("\n")
	end
end

