GADGET.PrintName = "IED"
GADGET.Description =
[[Drops an Improvised Explosive Device on the ground.
IED explodes when an enemy comes in range.
You have 5 IED charges.
IED recharges after detonation.]]
GADGET.Icon = "items/gadgets/ied.png"
GADGET.Duration = 0
GADGET.Cooldown = 0.5
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 5},
}
GADGET.Hooks = {}
GADGET.Charges = 5

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_ied" then return end
    if not ply.Horde_IEDS then ply.Horde_IEDS = {} end
    if ply:Horde_GetGadgetCharges() <= 0 then
        return
    end
    if ply:Horde_GetGadgetCharges() == 5 then
        ply.Horde_IEDS = {}
    end
    local ent = ents.Create("horde_ied")
    local pos = ply:GetPos()
    local drop_pos = pos
    drop_pos.z = pos.z + 15
    ent:SetPos(drop_pos)
    ent.Horde_Owner = ply
    ent:Spawn()
    table.insert(ply.Horde_IEDS, ent)
    ply:Horde_SetGadgetCharges(ply:Horde_GetGadgetCharges() - 1)
end

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_ied" then return end
    if not ply.Horde_IEDS then ply.Horde_IEDS = {} end
    ply:Horde_SetGadgetCharges(5)
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_ied" then return end
    if (not ply.Horde_IEDS) or table.IsEmpty(ply.Horde_IEDS) then return end
    for _, ied in pairs(ply.Horde_IEDS) do
        if ied:IsValid() then
            ied:Detonate()
        end
    end
end