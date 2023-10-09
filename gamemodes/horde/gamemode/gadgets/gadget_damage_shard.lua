GADGET.PrintName = "Damage Shard"
GADGET.Description = "{1} increased Global damage for 30 seconds."
GADGET.Icon = "items/gadgets/damage_shard.png"
GADGET.Droppable = true
GADGET.Once = true
GADGET.Active = true
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 0.25, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if ply:Horde_GetGadget() ~= "gadget_damage_shard" then return end
    ply.Horde_Has_Damage_Shard = true
    ply:Horde_SyncStatus(HORDE.Status_Damage_Shard, 1)
    timer.Simple(30, function ()
        if ply:IsValid() then
            ply.Horde_Has_Damage_Shard = nil
            ply:Horde_SyncStatus(HORDE.Status_Damage_Shard, 0)
        end
    end)
end

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply.Horde_Has_Damage_Shard then
        bonus.increase = bonus.increase + 0.2
    end
end
