PERK.PrintName = "Scorch"
PERK.Description = "{1} increased Fire damage against Ignited enemies."
PERK.Icon = "materials/perks/scorch.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_scorch")  then return end
    if npc:IsOnFire() and dmginfo:GetDamageType() == DMG_BURN or dmginfo:GetDamageType() == DMG_SLOWBURN then
        bonus.increase = bonus.increase + 0.15
    end
end