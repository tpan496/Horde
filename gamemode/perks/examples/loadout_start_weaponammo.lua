PERK.PrintName = "Came Prepared"
PERK.Description = "Start the first wave with a {weapon} and {ammoamount} ammo for it."

 = {
    ["weapon"] = {type = "s", default = "weapon_pistol", weapon = true},
    ["ammoamount"] = {type = "i", default = 40, min = 0},
}

-- When giving weapons and ammo to player, it is best to do it at wave start/end,
-- so people can receive the benefits if they change perks alive but is unable to cheese more.
PERK.Hooks = {}
PERK.Hooks.HordeWaveStart = function(wave)
    if wave == 1 then
        for _, ply in pairs(player.GetAll()) do
            if ply:Alive() and ply:Horde_GetPerk("loadout_start_weaponammo") then
                local wpn = ply:Give(ply:Horde_GetPerkParam("loadout_start_weaponammo", "weapon"))
                if IsValid(wpn) then
                    local ammotype = wpn:GetPrimaryAmmoType()
                    if ammotype == -1 and wpn.Primary then ammotype = wpn.Primary.Ammo end
                    ply:GiveAmmo(ply:Horde_GetPerkParam("loadout_start_weaponammo", "ammoamount"), ammotype)
                end
            end
        end
    end
end