PERK.PrintName = "Bloodbath"
PERK.Description = [[
Adds {1} Critical Hit chance.
Leech 1 health on Critical Hit.]]
PERK.Icon = "materials/perks/psycho/bloodbath.png"
PERK.Params = {
    [1] = {value = 0.1, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerCriticalCheck = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_bloodbath") then
        crit_bonus.add = crit_bonus.add + 0.1
    end
end

PERK.Hooks.Horde_OnPlayerCritical = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_bloodbath") then
        HORDE:SelfHeal(ply, 1)
    end
end