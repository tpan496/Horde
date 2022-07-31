PERK.PrintName = "Assault Base"
PERK.Description = [[
The Assault class is an all-purpose fighter with high mobility and a focus on Adrenaline stacks.
Complexity: EASY

{1} increased movement speed. ({2} per level, up to {3}).

Gain Adrenaline when you kill an enemy.
Adrenaline increases damage and speed by {4}.]]
PERK.Params = {
    [1] = {percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Assault},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.20, percent = true},
    [4] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_base" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_base" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 1)
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus)
    if not ply:Horde_GetPerk("assault_base") then return end
    bonus.walkspd = bonus.walkspd * ply:Horde_GetPerkLevelBonus("assault_base")
    bonus.sprintspd = bonus.sprintspd * ply:Horde_GetPerkLevelBonus("assault_base")
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("assault_base", 1 + math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Assault)))
    end
end