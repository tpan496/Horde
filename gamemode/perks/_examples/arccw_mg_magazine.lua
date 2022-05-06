PERK.PrintName = "Loaded Box"
PERK.Description = "ArcCW weapons with >= 60 magazine capacity get 50 percent more."

PERK.Hooks = {}
PERK.Hooks.Hook_GetCapacity = function(wpn, data)
    local ply = wpn:GetOwner()
    if IsValid(ply) and ply:IsPlayer() and ply:Horde_GetPerk("arccw_mg_magazine")
            and data >= 60 then
        return math.ceil(data * 1.5)
    end
end