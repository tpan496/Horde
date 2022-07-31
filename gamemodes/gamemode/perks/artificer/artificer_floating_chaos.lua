PERK.PrintName = "Floating Chaos"
PERK.Description =
[[Unlocks Floating Chaos for Solar Seal ({1} energy, R button).
Spawns a floating orb that echoes your spells.]]
PERK.Icon = "materials/perks/artificer/floating_chaos.png"
PERK.Params = {
    [1] = {value = 25},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "artificer_floating_chaos" then
        ply:Horde_SetPerkCooldown(10)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Floating_Chaos, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "artificer_floating_chaos" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Floating_Chaos, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end


PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("artificer_floating_chaos") then return end
    local active_weapon = ply:GetActiveWeapon()
    if not active_weapon:IsValid() or not active_weapon:GetClass() == "horde_solar_seal" then return false end
    local res = active_weapon:FloatingChaos()
    if res then return true end
end