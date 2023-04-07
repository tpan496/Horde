PERK.PrintName = "Ionization"
PERK.Description = "{1} increased Ignite damage.\nFire damage ignores enemy Fire resistance."
PERK.Icon = "materials/perks/ionization.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_ionization")  then return end
    if dmginfo:GetInflictor():GetClass() == "entityflame" then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_ionization")  then return end
	if HORDE:IsFireDamage(dmginfo) then
    dmginfo:SetDamageType(DMG_DIRECT)
	end
end