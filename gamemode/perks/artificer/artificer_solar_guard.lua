PERK.PrintName = "Solar Guard"
PERK.Description =
[[{1} increased Solar Seal energy regeneration.
Uses energy to reduce damage taken, up to {2}.
Damage reduction is based on remaining energy.]]
PERK.Icon = "materials/perks/artificer/solar_guard.png"
PERK.Params = {
    [1] = {value = 0.30, percent = true},
    [2] = {value = 0.30, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("artificer_solar_guard") then return end
    local wpn = ply:GetWeapon("horde_solar_seal")
    if (not wpn) or (not wpn:IsValid()) then return end
    local energy = wpn:Ammo1()
    bonus.less = bonus.less * (0.30 * energy / 100)
    wpn:SetClip1(math.min(0, wpn:Clip1() - dmginfo:GetDamage() / 2.5))
end

PERK.Hooks.Horde_OnSolarSealRegen = function(ply, regen_delay)
    if not ply:Horde_GetPerk("artificer_solar_guard") then return end
    regen_delay.delay = 0.19
end