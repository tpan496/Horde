local M = {}

--Taken from nodegraph
local SIZEOF_INT = 4
local SIZEOF_SHORT = 2
local AINET_VERSION_NUMBER = 37
local function toUShort(b)
    local i = {string.byte(b,1,SIZEOF_SHORT)}
    return i[1] +i[2] *256
end
local function toInt(b)
    local i = {string.byte(b,1,SIZEOF_INT)}
    i = i[1] +i[2] *256 +i[3] *65536 +i[4] *16777216
    if(i > 2147483647) then return i -4294967296 end
    return i
end
local function ReadInt(f) return toInt(f:Read(SIZEOF_INT)) end
local function ReadUShort(f) return toUShort(f:Read(SIZEOF_SHORT)) end

-- Taken from nodegraph
function ParseFile()
    if HORDE.found_ai_nodes then
        return
    end

    f = file.Open("maps/graphs/"..game.GetMap()..".ain","rb","GAME")
    if not f then
        return
    end

    HORDE.found_ai_nodes = true
    local ainet_ver = ReadInt(f)
    local map_ver = ReadInt(f)
    if ainet_ver ~= AINET_VERSION_NUMBER then
        MsgN("Unknown graph file")
        return
    end

    local numNodes = ReadInt(f)
    if numNodes < 0 then
        MsgN("Graph file has an unexpected amount of nodes")
        return
    end

    for i = 1,numNodes do
        local v = Vector(f:ReadFloat(),f:ReadFloat(),f:ReadFloat())
        local yaw = f:ReadFloat()
        local flOffsets = {}
        for i = 1,NUM_HULLS do
            flOffsets[i] = f:ReadFloat()
        end
        local nodetype = f:ReadByte()
        local nodeinfo = ReadUShort(f)
        local zone = f:ReadShort()

        if nodetype == 4 then
            goto cont
        end
        
        local node = {
            pos = v,
            yaw = yaw,
            offset = flOffsets,
            type = nodetype,
            info = nodeinfo,
            zone = zone,
            neighbor = {},
            numneighbors = 0,
            link = {},
            numlinks = 0
        }

        table.insert(HORDE.ai_nodes,node)

        ::cont::
    end
end
M.ParseFile = ParseFile

return M