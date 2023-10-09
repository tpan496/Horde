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
function ENT:CustomOnInitialize()
    self:SetColor(Color(255, 0, 0))
    self:SetAngles(Angle(0,0,180))
    self:DropToFloor()
    --self:SetCollisionBounds(Vector(0,0,0), Vector(0,0,0))
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

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsPhysicalDamage(dmginfo) then
        if HORDE:IsMeleeDamage(dmginfo) then
            dmginfo:ScaleDamage(1.25)
        end
    else
		dmginfo:ScaleDamage(0.75)
    end
end

VJ.AddNPC("Flesh Flower","npc_vj_horde_flesh_flower", "Zombies")