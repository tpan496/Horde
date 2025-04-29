PERK.PrintName = "Ferocity"
PERK.Description = [[
Adds {1} Base Critical Hit chance.
{2} increased Critical Hit chance per {3} health missing.]]
PERK.Icon = "materials/perks/psycho/ferocity.png"
PERK.Params = {
    [1] = {value = 0.1, percent = true},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 1},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerCriticalCheck = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_ferocity") then
        crit_bonus.add = crit_bonus.add + 0.1
        if ply:Horde_GetPerk("psycho_grudge") and ply:Health() > ply:GetMaxHealth() * 0.9 then
            crit_bonus.increase = crit_bonus.increase + ply:GetMaxHealth() * 0.3 / 100
        else
            crit_bonus.increase = crit_bonus.increase + (math.max(0, 1 - ply:Health() / ply:GetMaxHealth()))
        end
    end
end