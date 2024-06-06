PERK.PrintName = "Tinkerer"
PERK.Description = "{1} increased minion maximum health."
PERK.Icon = "materials/perks/tinkerer.png"
PERK.Params = {
    [1] = { value = 0.15, percent = true },
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_tinkerer" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() and (not ent.Horde_Has_Tinkerer) then
                ent:SetMaxHealth(ent:GetMaxHealth() * 1.15)
                ent:SetHealth(ent:GetMaxHealth())
                ent.Horde_Has_Tinkerer = true
            end
        end
    end
end

PERK.Hooks.Horde_OnUnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_tinkerer" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() and ent.Horde_Has_Tinkerer then
                ent:SetMaxHealth(ent:GetMaxHealth() / 1.15)
                ent:SetHealth(ent:GetMaxHealth())
                ent.Horde_Has_Tinkerer = nil
            end
        end
    end
end

PERK.Hooks.OnEntityCreated = function(ent)
    if CLIENT then return end
    if not ent:IsValid() then return end
    timer.Simple(0.1, function()
        if not ent:IsValid() then return end
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsPlayer() and ply:Horde_GetPerk("engineer_tinkerer") and ent:IsNPC() then
            ent:SetMaxHealth(ent:GetMaxHealth() * 1.15)
            ent:SetHealth(ent:GetMaxHealth())
            ent.Horde_Has_Tinkerer = true
        end
    end)
end
