PERK.PrintName = "Skewering"
PERK.Description = [[
Enemies you hit with headshots are Skewered.
Players have +{1} Critical Hit chance when they hit Skewered enemies.]]
PERK.Icon = "materials/perks/psycho/skewering.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("psycho_skewering") and hitgroup == HITGROUP_HEAD then
        npc.Horde_Skewered = true
    end

    if npc.Horde_Skewered and not ply:Horde_GetPerk("psycho_base") then
        local p = math.random()
        if p <= 0.1 then
            bonus.more = bonus.more * 1.5
            hook.Run("Horde_OnPlayerCritical", ply, npc, bonus, hitgroup, dmginfo)
            sound.Play("horde/player/crit.ogg", ply:GetPos())
        end
    end
end

PERK.Hooks.Horde_OnPlayerCriticalCheck = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if npc.Horde_Skewered then
        crit_bonus.add = crit_bonus.add + 0.15
    end
end