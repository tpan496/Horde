GADGET.PrintName = "Matriarch Womb"
GADGET.Description = [[
Spawns 1 friendly headcrab when used.
The headcrab dies after 10 seconds.]]
GADGET.Icon = "items/gadgets/matriarch_womb.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Droppable = true
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_matriarch_womb" then return end
    
    local ent = ents.Create("npc_vj_horde_headcrab")
    ent:SetPos(ply:GetPos() + ply:GetForward() * 50 + Vector(0,0,1) * 10)
    ent:Spawn()
    ent:SetNWEntity("HordeOwner", ply)
    local id = ent:GetCreationID()
    ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
    timer.Create("Horde_MinionCollision" .. id, 1, 0, function ()
        if not ent:IsValid() then timer.Remove("Horde_MinionCollision" .. id) return end
        ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
    end)
    ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() + 1)
    ent:CallOnRemove("Horde_EntityRemoved", function()
        if ent:IsValid() and ply:IsValid() then
            timer.Remove("Horde_MinionCollision" .. ent:GetCreationID())
            ent:GetNWEntity("HordeOwner"):Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID(), true)
            ent:GetNWEntity("HordeOwner"):Horde_SyncEconomy()
            ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
        end
    end)

    timer.Simple(10, function ()
        if ent:IsValid() then ent:Remove() end
    end)
end