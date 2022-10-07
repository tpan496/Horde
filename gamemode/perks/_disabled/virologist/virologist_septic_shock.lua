PERK.PrintName = "Septic Shock"
PERK.Description = [[{1} increased Break buildup.
Refreshes all Virus duration when Break procs on enemies.]]
PERK.Icon = "materials/perks/positron_array.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("chemist_beacon_of_agony")  then return end
    if HORDE:IsPoisonDamage(dmginfo) then
        dmginfo:SetDamageType(DMG_DIRECT)
    end
end