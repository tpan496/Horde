GADGET.PrintName = "Agility Shard"
GADGET.Description = "{1} increased movement speed for 30 seconds."
GADGET.Icon = "items/gadgets/agility_shard.png"
GADGET.Droppable = true
GADGET.Once = true
GADGET.Cooldown = 0
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 0.2, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if ply:Horde_GetGadget() ~= "gadget_agility_shard" then return end
    ply.Horde_Has_Agility_Shard = true
    ply:Horde_SyncStatus(HORDE.Status_Agility_Shard, 1)
    timer.Simple(30, function ()
        if ply:IsValid() then
            ply.Horde_Has_Agility_Shard = nil
            ply:Horde_SyncStatus(HORDE.Status_Agility_Shard, 0)
        end
    end)
end

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if ply.Horde_Has_Agility_Shard then
        bonus_walk.increase = bonus_walk.increase + 0.2
        bonus_run.increase = bonus_run.increase + 0.2
    end
end
