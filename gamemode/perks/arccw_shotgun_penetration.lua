PERK.PrintName = "Buckshot Punch"
PERK.Description = "ArcCW shotguns have {amount}mm extra penetration."

PERK.Parameters = {
    ["amount"] = {type = "i", default = 20, min = 0},
}

-- You can modify ArcCW weapon stats with specially named hooks.
-- Specifically: O_Hook_STAT for overrides, M_Hook_STAT for multipliers and A_Hook_STAT for addition.
-- The return value is a table where tbl.current is the value.
PERK.Hooks = {}
PERK.Hooks.O_Hook_Penetration = function(wep, data)
    local ply = wep:GetOwner()
    if IsValid(ply) and attacker:IsPlayer() and ply:Horde_GetPerk(PERK.ClassName) then
        return {current = data.current + ply:Horde_GetPerkParam(PERK.ClassName, "amount")}
    end
end