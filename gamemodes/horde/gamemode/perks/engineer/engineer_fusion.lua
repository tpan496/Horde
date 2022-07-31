PERK.PrintName = "Fusion"
PERK.Description = [[
Minions regenerate {1} health per second.
{2} increased minion damage while minion is on full health.]]
PERK.Icon = "materials/perks/fusion.png"
PERK.Params = {
    [1] = {value = 0.02, percent = true},
    [2] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_fusion" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() then
                timer.Create("Horde_Fusion" .. id, 1, 0, function()
                    if not ent:IsValid() or not ply:IsValid() or not ply:Horde_GetPerk("engineer_fusion") then timer.Remove("Horde_Fusion" .. id) return end
                    if ent.Horde_Debuff_Active and ent.Horde_Debuff_Active[HORDE.Status_Decay] then return end
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
        if ply:IsValid() and ply:Horde_GetPerk("engineer_fusion") and ent:IsNPC() then
            local id = ent:GetCreationID()
            timer.Create("Horde_Fusion" .. id, 1, 0, function()
                if not ent:IsValid() or not ply:IsValid() or not ply:Horde_GetPerk("engineer_fusion") then timer.Remove("Horde_Fusion" .. id) return end
                if ent.Horde_Debuff_Active and ent.Horde_Debuff_Active[HORDE.Status_Decay] then return end
                ent:SetHealth(math.min(ent:Health() + ent:GetMaxHealth() * 0.02, ent:GetMaxHealth()))
            end)
        end
    end)
end

PERK.Hooks.Horde_OnPlayerMinionDamage = function (ply, npc, bonus, dmginfo)
    if ply:Horde_GetPerk("engineer_fusion") and dmginfo:GetInflictor():Health() >= dmginfo:GetInflictor():GetMaxHealth() then
        bonus.increase = bonus.increase + 0.15
    end
end