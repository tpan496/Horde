PERK.PrintName = "Natural Selection"
PERK.Description = "{1} increased minion maximum health."
PERK.Icon = "materials/perks/hatcher/natural_selection.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "hatcher_natural_selection" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if IsValid( ent ) and ent:IsNPC() and (not ent.Horde_Has_NaturalSelection) then
                ent:SetMaxHealth(ent:GetMaxHealth() * 1.2)
                ent:SetHealth(ent:GetMaxHealth())
                ent.Horde_Has_NaturalSelection = true
            end
        end
    end
end

PERK.Hooks.Horde_OnUnSetPerk = function(ply, perk)
    if SERVER and perk == "hatcher_natural_selection" then
        if not HORDE.player_drop_entities[ply:SteamID()] then return end
        for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
            if ent:IsNPC() and ent.Horde_Has_NaturalSelection then
                ent:SetMaxHealth(ent:GetMaxHealth() / 1.2)
                ent:SetHealth(ent:GetMaxHealth())
                ent.Horde_Has_NaturalSelection = nil
            end
        end
    end
end

PERK.Hooks.OnEntityCreated = function (ent)
    if not ent:IsValid() then return end
    if CLIENT then return end
    timer.Simple(0.2, function()
        if not ent:IsValid() then return end
        local ply = ent:GetNWEntity("HordeOwner")
        if ply:IsPlayer() and ply:Horde_GetPerk("hatcher_natural_selection") and ent:IsNPC() then
            ent:SetMaxHealth(ent:GetMaxHealth() * 1.2)
            ent:SetHealth(ent:GetMaxHealth())
            ent.Horde_Has_NaturalSelection = true
        end
    end)
end