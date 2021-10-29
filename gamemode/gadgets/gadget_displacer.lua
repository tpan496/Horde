GADGET.PrintName = "Displacer"
GADGET.Description = "Instantly moves the targeted minion to your side."
GADGET.Icon = "items/gadgets/displacer.png"
GADGET.Duration = 0
GADGET.Cooldown = 2
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_displacer" then return end

    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity

    if ent:IsValid() then
        local owner = ent:GetNWEntity("HordeOwner")
        if owner:IsValid() and owner == ply then
            local item = HORDE.items[ent:GetClass()]
            if not item then return end
            local pos = ply:GetPos()
            local dir = (ply:GetEyeTrace().HitPos - pos)
            dir:Normalize()
            local drop_pos = pos + dir * item.entity_properties.x
            drop_pos.z = pos.z + item.entity_properties.z
            ent:SetPos(drop_pos)
            ent:SetAngles(Angle(0, ply:GetAngles().y + item.entity_properties.yaw, 0))
            if ent:GetClass() == "npc_turret_floor" then
                ply:PickupObject(ent)
                ent:GetPhysicsObject():EnableMotion(true)
            end
        end
    end

    sound.Play("weapons/physcannon/physcannon_pickup.wav", ply:GetPos())
end