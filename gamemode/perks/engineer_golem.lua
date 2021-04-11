PERK.PrintName = "Golem"
PERK.Description = "Minions regenerate {1} health per second.\nMinion attacks have increased knockback."
PERK.Icon = "materials/perks/golem.png"
PERK.Params = {
    [1] = {value = 0.02, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.OnEntityCreated = function (ent)
    if not ent:IsValid() then return end
    local ply = ent:GetNWEntity("HordeOwner")
    if ply:IsValid() and ply:Horde_GetPerk("engineer_golem") and ent:IsNPC() then
        timer.Simple(0.1, function()
            if not ent:IsValid() then return end
            local id = ent:GetCreationID()
            timer.Create("Horde_Golem" .. id, function()
                if not ent:IsValid() then timer.Remove("Horde_Golem" .. id) return end
                ent:SetHealth(math.min(ent:Health() + ent:GetMaxHealth() * 0.02, ent:GetMaxHealth()))
            end)
        end)
    end
end

PERK.Hooks.ScaleNPCDamage = function (npc, hitgroup, dmg)
    if not npc:IsValid() then return end
    local attacker = dmg:GetAttacker()
    if attacker:GetNWEntity("HordeOwner"):IsPlayer() then
        if attacker:GetNWEntity("HordeOwner"):Horde_GetPerk("engineer_golem") then
            local startpos = dmg:GetDamagePosition()
            local endpos = npc:GetPos()
            local dir = endpos - startpos
            npc:SetVelocity(dir:GetNormalized() * 500)
        end
    end
end