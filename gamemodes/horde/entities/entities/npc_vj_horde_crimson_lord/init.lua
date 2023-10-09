AddCSLuaFile("shared.lua")
include('shared.lua')
include('autorun/vj_controls.lua')

-- Core
ENT.Model = {"models/barnacle.mdl"}
ENT.StartHealth = 500
ENT.HullType = HULL_MEDIUM
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} 
ENT.MovementType = VJ_MOVETYPE_STATIONARY 
---------------------------------------------------------------------------------------------------------------------------------------------

local function shuffle(tbl)
for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
end
return tbl
end

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

local function ParseNodes()
    f = file.Open("maps/graphs/"..game.GetMap()..".ain","rb","GAME")
    if not f then
        return
    end

    local nodes = {}

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

        table.insert(nodes,node.pos)

        ::cont::
    end

    return nodes
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	dmginfo:SetDamage(0)
    return true
end

function ENT:CustomOnInitialize()
    self:SetColor(Color(255, 0, 0))
    self:SetAngles(Angle(0,0,180))
    --self:SetCollisionBounds(self:OBBMins(), self:OBBMaxs())

    local nodes = shuffle(ParseNodes())
    local i = 50
    for _, pos in pairs(nodes) do
        if i < 0 then return end
        local tr = util.TraceHull({
            start = pos,
            endpos = pos,
            filter = self,
            mins = self:OBBMins(),
            maxs = self:OBBMaxs(),
        })
        if tr.Hit then
            local ent = tr.Entity
            if ent:IsValid() and ent:IsPlayer() then
                goto cont
            end
        end

        local flower = ents.Create("npc_vj_horde_flesh_flower")
		flower:SetPos(pos)
		flower:Spawn()
		flower:SetOwner(self)
        i = i - 1
        ::cont::
    end
end

ENT.LastPuke = CurTime()
function ENT:Think()
    if self.LastPuke <= CurTime() then
        self.LastPuke = CurTime() + 5
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 250)) do
            if HORDE:IsPlayerOrMinion(ent) == true then
                ent:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, 20, self)
            end
        end
        local e = EffectData()
            e:SetOrigin(self:GetPos())
        util.Effect("horde_flesh_flower_effect", e, true, true)
    end
end

VJ.AddNPC("Crimson Lord","npc_vj_horde_crimson_lord", "Zombies")