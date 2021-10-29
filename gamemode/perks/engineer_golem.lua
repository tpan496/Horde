PERK.PrintName = "Golem"
PERK.Description = "Minions regenerate {1} health per second.\nMinion attacks have increased knockback."
PERK.Icon = "materials/perks/golem.png"
PERK.Params = {
    [1] = {value = 0.02, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_golem" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() then
                timer.Create("Horde_Golem" .. id, 1, 0, function()
                    if not ent:IsValid() or not ply:IsValid() or not ply:Horde_GetPerk("engineer_golem") then timer.Remove("Horde_Golem" .. id) return end
                    ent:SetHealth(math.min(ent:Health() + ent:GetMaxHealth() * 0.02, ent:GetMaxHealth()))
                end)
            end
        end
    end
end

PERK.Hooks.OnEntityCreated = function (ent)
    if not ent:IsValid() then return end
    if CLIENT then return end
    timer.Simple(0.1, function()
        if not ent:IsValid() then return end
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsValid() and ply:Horde_GetPerk("engineer_golem") and ent:IsNPC() then
            local id = ent:GetCreationID()
            timer.Create("Horde_Golem" .. id, 1, 0, function()
                if not ent:IsValid() or not ply:IsValid() or not ply:Horde_GetPerk("engineer_golem") then timer.Remove("Horde_Golem" .. id) return end
                ent:SetHealth(math.min(ent:Health() + ent:GetMaxHealth() * 0.02, ent:GetMaxHealth()))
            end)
        end
    end)
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
    elseif npc.Horde_Has_Parasite and npc.Horde_Has_Parasite:IsPlayer() and npc.Horde_Has_Parasite:Horde_GetPerk("engineer_golem") then
        local startpos = dmg:GetDamagePosition()
        local endpos = npc:GetPos()
        local dir = endpos - startpos
        npc:SetVelocity(dir:GetNormalized() * 500)
    end
end