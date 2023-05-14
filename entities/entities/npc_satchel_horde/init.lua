AddCSLuaFile("cl_init.lua")
include("shared.lua")

local reuse = CreateConVar("horde_tripmine_reusable", 1, FCVAR_SERVER_CAN_EXECUTE, "Can tripwire mines(SLAM's) be picked up after being armed?")

ENT.SWEP = "horde_slam"
ENT.Damage = 500
ENT.Radius = 250

-- btw, incendiary deals 75 spherical burn damage 4 times per seconds for 15 seconds
function ENT:Detonate()
    if self.Detonated then return end
    self.Detonated = true
    local pos = self:GetPos()
    local eff = EffectData()
    eff:SetStart(pos)
    eff:SetOrigin(pos)
    util.Effect("Explosion", eff, true, true)

    util.BlastDamage(self, self:GetHordeOwner(), pos, self.Radius, self.Damage)
    local ply = self:GetHordeOwner()
    if IsValid(ply) and ply:Horde_GetPerk("demolition_frag_cluster") then
        local dmg = 300
        local rad = 150
        for i = 1, 3 do
            local prop = ents.Create("prop_physics")
            prop:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
            prop:SetModelScale(0.25, 0)
            prop:SetPos(self:GetPos() + VectorRand() * 4 + Vector(0, 0, 8))
            prop:SetAngles(AngleRand())
            prop:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            prop:Spawn()
            prop:Activate()
            timer.Simple(0, function() prop:GetPhysicsObject():AddVelocity(VectorRand() * 200 + Vector(0, 0, 150)) end)
            timer.Simple(0.5 + i * 0.1, function() if IsValid(prop) then
                local e = EffectData()
                e:SetOrigin(prop:GetPos())
                util.Effect("Explosion", e)
                util.BlastDamage(prop, ply, prop:GetPos(), rad, dmg)
                prop:Remove()
            end end)
        end
    end

    if IsValid(ply) and ply:Horde_GetPerk("demolition_frag_impact") then
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
            if HORDE:IsEnemy(ent) then
                ent:Horde_AddDebuffBuildup(HORDE.Status_Stun, 250, self.Owner, ent:GetPos())
            end
        end
    end

    for _, ent in pairs(ents.FindInSphere(self:GetPos(), 100)) do
        if ent ~= self and ent:GetClass() == "npc_tripmine_horde" or ent:GetClass() == "npc_satchel_horde" and ent:GetHordeOwner() == self:GetHordeOwner() then
            ent:PassiveDetonate()
        end
    end
    
    self:Remove()
end

function ENT:PassiveDetonate()
    if self.Detonated then return end
    self.Detonated = true
    local pos = self:GetPos()
    local eff = EffectData()
    eff:SetStart(pos)
    eff:SetOrigin(pos)
    util.Effect("Explosion", eff)

    util.BlastDamage(self, self:GetHordeOwner(), pos, self.Radius, self.Damage)
    local ply = self:GetHordeOwner()
    if IsValid(ply) and ply:Horde_GetPerk("demolition_frag_cluster") then
        local dmg = 300
        local rad = 150
        for i = 1, 3 do
            local prop = ents.Create("prop_physics")
            prop:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
            prop:SetModelScale(0.25, 0)
            prop:SetPos(self:GetPos() + VectorRand() * 4 + Vector(0, 0, 8))
            prop:SetAngles(AngleRand())
            prop:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            prop:Spawn()
            prop:Activate()
            timer.Simple(0, function() prop:GetPhysicsObject():AddVelocity(VectorRand() * 200 + Vector(0, 0, 150)) end)
            timer.Simple(0.5 + i * 0.1, function() if IsValid(prop) then
                local e = EffectData()
                e:SetOrigin(prop:GetPos())
                util.Effect("Explosion", e, true, true)
                util.BlastDamage(prop, ply, prop:GetPos(), rad, dmg)
                prop:Remove()
            end end)
        end
    end

    if IsValid(ply) and ply:Horde_GetPerk("demolition_frag_impact") then
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
            if HORDE:IsEnemy(ent) then
                ent:Horde_AddDebuffBuildup(HORDE.Status_Stun, 250, self.Owner, ent:GetPos())
            end
        end
    end
    self:Remove()
end

local defuse = Sound("ambient/machines/pneumatic_drill_3.wav")
function ENT:Use(ply)
    local owner = self:GetHordeOwner()
    if reuse:GetBool() == false then return end
    if IsValid(owner) and owner ~= ply then return end    -- feel free to steal disconnected player mines

    -- I don't want player to be able to difuse mines with wrong class >:c
    -- btw, saboteur class when?
    local item = HORDE.items[self.SWEP]
    if not item or ply:Horde_GetWeight() - item.weight < 0 or not item.whitelist[ply:Horde_GetClass().name] then return end

    self:EmitSound(defuse, 60)
    self:Remove()
    ply:GiveAmmo(1, "slam", true)
    if not IsValid(ply:GetWeapon(self.SWEP)) then
        ply:Give(self.SWEP, true)
    end
end