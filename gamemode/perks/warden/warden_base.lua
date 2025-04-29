PERK.PrintName = "Warden Base"
PERK.Description = [[
The Warden is a support class that uses aura effects and structures to buff teammates.
Complexity: MEDIUM

{1} increased Warden Aura radius. ({2} per level, up to {3}).

Players near you are affected by Warden Aura.
Warden Aura blocks {4} damage.]]
PERK.Params = {
    [1] = {percent = true, level = 0.01, max = 0.25, classname = HORDE.Class_Warden},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
    [4] = {value = 2}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_base" then
        timer.Simple(0.1, function()
            ply:Horde_AddWardenAura()
        end)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_base" then
        ply:Horde_RemoveWardenAura()
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("warden_base", 1 + math.min(0.25, 0.01 * ply:Horde_GetLevel(HORDE.Class_Warden)))
    end
end

PERK.Hooks.DoPlayerDeath = function (ply)
    if not ply:Horde_GetPerk("warden_base") then return end
    if not HORDE.player_drop_entities[ply:SteamID()] then return end
    for _, ent in pairs(HORDE.player_drop_entities[ply:SteamID()])  do
        if HORDE:IsWatchTower(ent) then
            ent:Horde_RemoveWardenAura()
        end
    end

    if ply.Horde_Extra_Watchtower and ply.Horde_Extra_Watchtower:IsValid() then
        ply.Horde_Extra_Watchtower:Horde_RemoveWardenAura()
    end
    --[[
    for _, ent in pairs(ents.FindByClass("horde_warden_aura")) do
        if ent:GetPlayerParent() == ply then
            ent:Remove()
        end
    end
    ]]
end