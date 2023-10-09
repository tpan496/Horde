GADGET.PrintName = "Specimen Crystal (Medium)"
GADGET.Description = "Moderate size crystals left in enemy remains.\nUse to gain 500 gold."
GADGET.Icon = "items/gadgets/specimen_crystal_medium.png"
GADGET.Droppable = true
GADGET.Once = true
GADGET.Cooldown = 0
GADGET.Active = true
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if ply:Horde_GetGadget() ~= "gadget_specimen_crystal_medium" then return end
    ply:Horde_AddMoney(500)
    ply:Horde_SyncEconomy()
    ply:EmitSound("horde/dosh/dosh_" .. math.random(1, 4) .. ".ogg", 70, 100, 0.25)
end