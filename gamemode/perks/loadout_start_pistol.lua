PERK.PrintName = "Came Prepared"
PERK.Description = "Start the first wave with a {weapon} and {ammo} pistol ammo."

PERK.Parameters = {
    ["weapon"] = {type = "s", default = "weapon_pistol", weapon = true},
    ["ammo"] = {type = "i", default = 40, min = 0},
}

-- When giving weapons and ammo to player, it is best to do it at wave start/end,
-- so people can receive the benefits if they change perks alive but is unable to cheese more.
PERK.Hooks = {}
PERK.Hooks.HordeWaveStart = function(wave)
    if wave == 1 then
        for _, ply in pairs(player.GetAll()) do
            if ply:Alive() and ply:Horde_GetPerk(PERK.ClassName) then
                ply:Give(ply:Horde_GetPerkParam(PERK.ClassName, "weapon"))
                ply:GiveAmmo(ply:Horde_GetPerkParam(PERK.ClassName, "ammo"), "pistol")
            end
        end
    end
end