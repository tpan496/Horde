PERK.PrintName = "Assault Base"
PERK.Description = "The Assault is an all-purpose fighter with high mobility and a focus on Adrenaline stacks.\nComplexity: EASY\n\n{1} increased movement speed.\nGain Adrenaline when you kill an enemy.\nAdrenaline increases damage and speed by {2}."
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.06, percent = true},
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
    bonus.walkspd = bonus.walkspd * 1.2
    bonus.sprintspd = bonus.sprintspd * 1.2
end