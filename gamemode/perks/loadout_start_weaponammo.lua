PERK.PrintName = "Came Prepared"
PERK.Description = "Start the first wave with a {weapon} and {ammoamount} ammo for it."

PERK.Parameters = {
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
                local wep = ply:Give(ply:Horde_GetPerkParam("loadout_start_weaponammo", "weapon"))
                if IsValid(wep) then
                    local ammotype = wep:GetPrimaryAmmoType()
                    if ammotype == -1 and wep.Primary then ammotype = wep.Primary.Ammo end
                    ply:GiveAmmo(ply:Horde_GetPerkParam("loadout_start_weaponammo", "ammoamount"), ammotype)
                end
            end
        end
    end
end