PERK.PrintName = "Shotgun Salvo"
PERK.Description = "ArcCW shotguns do {percent} extra damage."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.5, min = 0, percent = true},
}

PERK.Hooks = {}

local recalc = function(ply, perk)
    if perk == "arccw_shotgun_penetration" then
        for _, wep in pairs(ply:GetWeapons()) do
            if wep.ArcCW then
                wep:RecalcAllBuffs()
            end
        end
    end
end
PERK.Hooks.Horde_OnSetPerk = recalc
PERK.Hooks.Horde_OnUnsetPerk = recalc

-- You can modify ArcCW weapon stats with specially named hooks.
-- Specifically: O_Hook_STAT for overrides, M_Hook_STAT for multipliers and A_Hook_STAT for addition.
-- Edit the value in data.current
PERK.Hooks.M_Hook_Mult_Damage = function(wep, data)
    local ply = wep:GetOwner()
    if IsValid(ply) and ply:IsPlayer() and wep:GetIsShotgun() and ply:Horde_GetPerk("arccw_shotgun_damage") then
        data.mult = (data.mult or 1) + ply:Horde_GetPerkParam("arccw_shotgun_damage", "percent")
    end
end