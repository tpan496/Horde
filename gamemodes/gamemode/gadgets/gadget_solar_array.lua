GADGET.PrintName = "Solar Array"
GADGET.Description = "Drops an armor battery."
GADGET.Icon = "items/gadgets/solar_array.png"
GADGET.Duration = 0
GADGET.Cooldown = 30
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_solar_array" then return end
    local ent = ents.Create("item_battery")
    local pos = ply:EyePos()
    local dir = ply:GetAimVector()
    local drop_pos = pos + dir * 50
    drop_pos.z = pos.z + 15
    ent:SetPos(drop_pos)
    ent:SetAngles(Angle(0, ply:GetAngles().y, 0))
    ent:Spawn()
end