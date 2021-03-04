PERK.PrintName = "Loaded Box"
PERK.Description = "ArcCW weapons with >= {threshold} magazine capacity get {percent} more."

PERK.Parameters = {
    ["threshold"] = {type = "i", default = 60, min = 0},
    ["percent"] = {type = "f", default = 0.25, min = 0, percent = true},
}

PERK.Hooks = {}

--[[]
PERK.Hooks.M_Hook_Mult_ClipSize = function(wep, data)
    local ply = wep:GetOwner()
    if IsValid(ply) and ply:IsPlayer() and ply:Horde_GetPerk("arccw_mg_magazine")
            and (wep.RegularClipSize or wep.Primary.ClipSize) >= ply:Horde_GetPerkParam("arccw_mg_magazine", "threshold") then
        data.mult = (data.mult or 1) + ply:Horde_GetPerkParam("arccw_mg_magazine", "percent")
    end
end
]]

PERK.Hooks.Hook_GetCapacity = function(wep, data)
    local ply = wep:GetOwner()
    if IsValid(ply) and ply:IsPlayer() and ply:Horde_GetPerk("arccw_mg_magazine")
            and data >= ply:Horde_GetPerkParam("arccw_mg_magazine", "threshold") then
        return math.ceil(data * (1 + ply:Horde_GetPerkParam("arccw_mg_magazine", "percent")))
    end
end