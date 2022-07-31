GADGET.PrintName = "Watchtower Pack"
GADGET.Description = "Deploys an extra watchtower."
GADGET.Icon = "items/gadgets/watchtower_pack.png"
GADGET.Duration = 0
GADGET.Cooldown = 30
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_watchtower_pack" then return end
    if ply.Horde_Extra_Watchtower then
        ply.Horde_Extra_Watchtower:Remove()
    end
    local ent = ents.Create("horde_watchtower")
    local pos = ply:GetPos()
    local dir = (ply:GetEyeTrace().HitPos - pos)
    dir:Normalize()
    local drop_pos = pos + dir * 50
    drop_pos.z = pos.z + 15
    ent:SetPos(drop_pos)
    ent:SetAngles(Angle(0, ply:GetAngles().y, 0))
    ent:SetNWEntity("HordeOwner", ply)
    ent:SetRenderMode(RENDERMODE_TRANSCOLOR)
    ent:SetColor(Color(255,255,0,255))
    ent:Spawn()
    ply.Horde_Extra_Watchtower = ent
end

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if ply.Horde_Extra_Watchtower then
        ply.Horde_Extra_Watchtower:Remove()
    end
    ply.Horde_Extra_Watchtower = nil
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if ply.Horde_Extra_Watchtower then
        ply.Horde_Extra_Watchtower:Remove()
    end
    ply.Horde_Extra_Watchtower = nil
end