PERK.PrintName = "Gravity Vacuum"
PERK.Description =
[[Unlocks Gravity Vacuum for Nether Relic ({1} energy, R button).
Attracts all active Astral Pulsars to the target.
Attracts nearby Astral Remnants to the target.]]
PERK.Icon = "materials/perks/warlock/gravity_vacuum.png"
PERK.Params = {
    [1] = {value = 10},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warlock_gravity_vacuum" then
        ply:Horde_SetPerkCooldown(5)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Gravity_Vacuum, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warlock_gravity_vacuum" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Gravity_Vacuum, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("warlock_gravity_vacuum") then return end
    local active_weapon = ply:GetActiveWeapon()
    if not active_weapon:IsValid() or not active_weapon:GetClass() == "horde_astral_relic" then return false end
    local res = active_weapon:GravityVacuum()
    if res then return true end
end