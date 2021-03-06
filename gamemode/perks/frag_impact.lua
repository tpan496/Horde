PERK.PrintName = "Impact Detonation"
PERK.Description = "Grenades explode with {damage} damage on enemy impact.\nImpact blast radius is reduced to {radius}."

PERK.Parameters = {
    ["damage"] = {type = "i", default = 300, min = 0},
    ["radius"] = {type = "i", default = 150, min = 0},
}

PERK.Hooks = {}

PERK.Hooks.EntityTakeDamage = function(victim, dmginfo)
    local attacker = dmginfo:GetAttacker()
    local ent = dmginfo:GetInflictor()
    if (victim:IsNPC() or victim:IsNextBot()) and IsValid(ent)
            and ent:GetClass() == "npc_grenade_frag" and IsValid(attacker)
            and not dmginfo:IsExplosionDamage() and attacker:Horde_GetPerk("frag_impact") then
        local dmg = attacker:Horde_GetPerkParam("frag_impact", "damage")
        local rad = attacker:Horde_GetPerkParam("frag_impact", "radius")
        local e = EffectData()
        e:SetOrigin(ent:GetPos())
        util.Effect("Explosion", e)
        util.BlastDamage(ent, attacker, ent:GetPos(), rad, dmg)
        ent:Remove()
    end
end

--[[]
PERK.Hooks.OnEntityCreated = function(ent)
    timer.Simple(0, function()
        local owner = ent:GetOwner()
        if SERVER and ent:GetClass() == "npc_grenade_frag" and IsValid(owner)
            and owner:IsPlayer() and owner:Horde_GetPerk("frag_impact") then
            local dmg = owner:Horde_GetPerkParam("frag_impact", "damage")
            local rad = owner:Horde_GetPerkParam("frag_impact", "radius")
            ent:AddCallback("PhysicsCollide", function(ent2, data)
                local hit = data.HitEntity
                if not hit:IsWorld() then print(hit) end
                if hit:IsNPC() or hit:IsNextBot() then
                    -- Create a bigger explosion
                    local e = EffectData()
                    e:SetOrigin(ent2:GetPos())
                    util.Effect("Explosion", e)
                    util.BlastDamage(ent2, owner, ent2:GetPos(), rad, dmg)
                    ent2:Remove()
                end
            end)
        end
    end)
end
]]