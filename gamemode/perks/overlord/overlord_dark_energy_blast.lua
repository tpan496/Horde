PERK.PrintName = "Dark Energy Blast"
PERK.Description = [[Dark Energy Blast deals {1} more damage.
Dark Energy Blast has {2} reduced cooldown.]]
PERK.Icon = "materials/perks/overlord/dark_energy_blast.png"
PERK.Params = {
    [1] = { value = 2, percent = true },
    [2] = { value = 0.66, percent = true },
}
PERK.Hooks = {}
--Additional effects are in entities\projectile_horde_hyperblast_projectile\shared.lua
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_dark_energy_blast" then
        ply:Horde_SetPerkCooldown(10)
        ply:Horde_SetPerkInternalCooldown(0)
        
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_DarkEnergyBlast, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
        
        net.Start("Horde_PerkStartCooldown")
            net.WriteUInt(ply:Horde_GetPerkInternalCooldown(), 8)
        net.Send(ply)
        
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_dark_energy_blast" then
        net.Start("Horde_SyncActivePerk")
        net.WriteUInt(HORDE.Status_DarkEnergyBlast, 8)
        net.WriteUInt(0, 3)
        net.Send(ply)
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
    end
end
