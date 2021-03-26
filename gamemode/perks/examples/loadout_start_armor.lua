PERK.PrintName = "Dressed Up"
PERK.Description = "Gain {amount} armor at the start of the first wave."

 = {
    ["amount"] = {type = "i", default = 40, min = 0, max = 255},
}

-- When giving weapons and ammo to player, it is best to do it at wave start/end,
-- so people can receive the benefits if they change perks alive but is unable to cheese more.
PERK.Hooks = {}
PERK.Hooks.HordeWaveStart = function(wave)
    if wave == 1 then
        for _, ply in pairs(player.GetAll()) do
            if ply:Alive() and ply:Horde_GetPerk("loadout_start_armor") then
                ply:SetArmor(ply:Armor() + ply:Horde_GetPerkParam("loadout_start_armor", "amount"))
            end
        end
    end
end