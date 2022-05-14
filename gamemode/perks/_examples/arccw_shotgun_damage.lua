PERK.PrintName = "Shotgun Salvo"
PERK.Description = "ArcCW shotguns do 50% extra damage."

PERK.Hooks = {}

local recalc = function(ply, perk)
    if perk == "arccw_shotgun_penetration" then
        for _, wpn in pairs(ply:GetWeapons()) do
            if wpn.ArcCW then
                wpn:RecalcAllBuffs()
            end
        end
    end
end
PERK.Hooks.Horde_OnSetPerk = recalc
PERK.Hooks.Horde_OnUnsetPerk = recalc

-- You can modify ArcCW weapon stats with specially named hooks.
-- Specifically: O_Hook_STAT for overrides, M_Hook_STAT for multipliers and A_Hook_STAT for addition.
-- Edit the value in data.current
PERK.Hooks.M_Hook_Mult_Damage = function(wpn, data)
    local ply = wpn:GetOwner()
    if IsValid(ply) and ply:IsPlayer() and wpn:GetIsShotgun() and ply:Horde_GetPerk("arccw_shotgun_damage") then
        data.mult = (data.mult or 1) + 0.5
    end
end