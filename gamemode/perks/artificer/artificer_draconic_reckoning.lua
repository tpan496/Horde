PERK.PrintName = "Draconic Reckoning"
PERK.Description =
[[Lightning damage ignores enemy Lightning damage resistance.
Solar Orb has Lightning damage area of effect.
Solar Storm has {1} increased damage and gains an extra charge stage.]]
PERK.Icon = "materials/perks/artificer/draconic_reckoning.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("artificer_draconic_reckoning")  then return end
    if HORDE:IsLightningDamage(dmginfo) then
        dmginfo:ScaleDamage(1.2)
        dmginfo:SetDamageType(DMG_DIRECT)
    end
end

PERK.Hooks.Horde_OnSolarSealLaunch = function (ply, properties)
    if ply:Horde_GetPerk("artificer_draconic_reckoning") then
        properties.draconic = true
    end
end