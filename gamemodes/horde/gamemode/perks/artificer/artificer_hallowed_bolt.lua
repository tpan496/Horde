PERK.PrintName = "Hallowed Bolt"
PERK.Description =
[[Unlocks Hallowed Bolt for Solar Seal ({1} energy, R button).
Strikes the ground from above, dealing heavy Lightning damage in an area.
Recover health after killing an enemy with Hallowed Bolt.]]
PERK.Icon = "materials/perks/artificer/hallowed_bolt.png"
PERK.Params = {
    [1] = {value = 40},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "artificer_hallowed_bolt" then
        ply:Horde_SetPerkCooldown(10)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Hallowed_Bolt, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "artificer_hallowed_bolt" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Hallowed_Bolt, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end


PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("artificer_hallowed_bolt") then return end
    local active_weapon = ply:GetActiveWeapon()
    if not active_weapon:IsValid() or not active_weapon:GetClass() == "horde_solar_seal" then return false end
    local res = active_weapon:HallowedBolt()
    if res then return true end
end