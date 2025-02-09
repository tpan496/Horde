PERK.PrintName = "Grudge"
PERK.Description = [[
{1} increased Critical Hit chance per {2} health missing.
{3} increased movement speed per {4} health missing, up to {5}.]]
PERK.Icon = "materials/perks/psycho/grudge.png"
PERK.Params = {
    [1] = {value = 0.01, percent = true},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.01, percent = true},
    [5] = {value = 0.5, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerCriticalCheck = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_grudge") then
        crit_bonus.increase = crit_bonus.increase + (math.max(0, 1 - ply:Health() / ply:GetMaxHealth()))
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function (ply, bonus_walk, bonus_run)
    if ply:Horde_GetPerk("psycho_grudge") then
        local increase = math.min(0.5, math.max(0, (1 - ply:Health() / ply:GetMaxHealth())))
        bonus_walk.increase = bonus_walk.increase + increase
        bonus_run.increase = bonus_run.increase + increase
    end
end