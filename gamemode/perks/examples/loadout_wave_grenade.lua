PERK.PrintName = "Backpocket Grenade"
PERK.Description = "At the start of every wave, gain one {weapon}."

PERK.Parameters = {
    ["weapon"] = {type = "s", default = "weapon_frag", weapon = true},
    ["ammotype"] = {type = "s", default = "grenade", ammo = true},
}

-- When giving weapons and ammo to player, it is best to do it at wave start/end,
-- so people can receive the benefits if they change perks alive but is unable to cheese more.
PERK.Hooks = {}
PERK.Hooks.HordeWaveStart = function(wave)
    for _, ply in pairs(player.GetAll()) do
        if ply:Alive() and ply:Horde_GetPerk("loadout_wave_grenade") then
            local wpn = ply:Horde_GetPerkParam("loadout_wave_grenade", "weapon")
            if ply:HasWeapon(wpn) then
                ply:GiveAmmo(1, ply:Horde_GetPerkParam("loadout_wave_grenade", "ammotype"))
            else
                ply:Give(wpn)
            end
        end
    end
end