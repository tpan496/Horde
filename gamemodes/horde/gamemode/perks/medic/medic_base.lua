PERK.PrintName = "Medic Base"
PERK.Description = [[
The Medic class is a durable support class that focuses on healing and buffing teammates.
Complexity: MEDIUM

Amplifies healing by {1}. ({2} per level, up to {3}).

Regenerate {4} health per second.]]
PERK.Params = {
    [1] = {percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Medic},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.20, percent = true},
    [4] = {value = 0.01, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "medic_base" then
        ply:Horde_SetHealthRegenPercentage(0.01)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "medic_base" then
        ply:Horde_SetHealthRegenPercentage(0)
    end
end

PERK.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("medic_base") then
        healinfo:SetHealAmount(healinfo:GetHealAmount() * healer:Horde_GetPerkLevelBonus("medic_base"))
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("medic_base", 1 + math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Medic)))
    end
end