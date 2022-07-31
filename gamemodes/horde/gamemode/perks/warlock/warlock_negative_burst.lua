PERK.PrintName = "Negative Burst"
PERK.Description =
[[Unlocks Negative Burst for Nether Relic ({1} energy, R button).
Deals Physical damage and knockback around you based on missing energy.
Recover {2} energy for each enemy killed by Negative Burst.]]
PERK.Icon = "materials/perks/warlock/negative_burst.png"
PERK.Params = {
    [1] = {value = 30},
    [2] = {value = 10},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warlock_negative_burst" then
        ply:Horde_SetPerkCooldown(10)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Negative_Burst, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warlock_negative_burst" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Negative_Burst, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("warlock_negative_burst") then return end
    local active_weapon = ply:GetActiveWeapon()
    if not active_weapon:IsValid() or not active_weapon:GetClass() == "horde_astral_relic" then return false end
    local res = active_weapon:NegativeBurst()
    if res then return true end
end