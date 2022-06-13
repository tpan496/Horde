PERK.PrintName = "Godslayer"
PERK.Description =
[[Fire damage ignores enemy Fire damage resistance.
Solar Orb has {1} increased damage and gains an extra charge stage.
Solar Storm can leave behind ground flames.]]
PERK.Icon = "materials/perks/artificer/godslayer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("artificer_godslayer")  then return end
    if HORDE:IsFireDamage(dmginfo) then
        dmginfo:ScaleDamage(1.2)
        dmginfo:SetDamageType(DMG_DIRECT)
    end
end

PERK.Hooks.Horde_OnSolarSealStrike = function (ply, properties)
    if ply:Horde_GetPerk("artificer_godslayer") then
        properties.godslayer = true
    end
end