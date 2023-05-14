PERK.PrintName = "Coup De Grace"
PERK.Description = "Instantly kills enemies with less than {1} health."
PERK.Icon = "materials/perks/coup.png"
PERK.Params = {
     [1] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamagePost =  function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("ghost_coup") and (npc:Health() <= 0.15 * npc:GetMaxHealth()) then
        dmginfo:SetDamage(0.15 * npc:GetMaxHealth() + 1)
        dmginfo:SetDamageType(DMG_DIRECT)
    end
end