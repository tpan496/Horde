GADGET.PrintName = "Aerial Turret"
GADGET.Description = "Deploys a temporary aerial turret.\nTurret is destroyed when duration expires."
GADGET.Icon = "items/gadgets/turret_pack.png"
GADGET.Duration = 20
GADGET.Cooldown = 30
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_aerial_turret" then return end
    local ent = ents.Create("npc_turret_floor")
    local pos = ply:GetPos()
    local dir = (ply:GetEyeTrace().HitPos - pos)
    dir:Normalize()
    local drop_pos = pos + dir * 50
    drop_pos.z = pos.z + 15
    ent:SetPos(drop_pos)
    ent:SetAngles(Angle(0, ply:GetAngles().y, 0))
    ply:Horde_AddDropEntity(ent:GetClass(), ent)
    ent:SetNWEntity("HordeOwner", ply)
    ent:SetRenderMode(RENDERMODE_TRANSCOLOR)
    ent:SetColor(Color(255,0,0,255))
    ent:Spawn()
    ent.Horde_Is_Mini_Sentry = true

    -- Minions have no player collsion
    ent:AddRelationship("player D_LI 99")
    ent.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
    local npc_info = list.Get("NPC")[ent:GetClass()]
    if not npc_info then
        print("[HORDE] NPC does not exist in ", list.Get("NPC"))
    end
    local wpns = npc_info["Weapons"]
    if wpns then
        local wpn = wpns[math.random(#wpns)]
        ent:Give(wpn)
    end
    -- Special case for turrets
    local id = ent:GetCreationID()
    ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
    timer.Create("Horde_MinionCollision" .. id, 1, 0, function ()
        if not ent:IsValid() then timer.Remove("Horde_MinionCollision" .. id) return end
        ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
    end)
    HORDE:DropTurret(ent)
    --HORDE:DropTurret(ent)
    ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() + 1)

    ent:CallOnRemove("Horde_EntityRemoved", function()
        if ent:IsValid() and ply:IsValid() then
            timer.Remove("Horde_MinionCollision" .. ent:GetCreationID())
            ent:GetNWEntity("HordeOwner"):Horde_RemoveDropEntity(ent:GetClass(), ent:GetCreationID(), true)
            ent:GetNWEntity("HordeOwner"):Horde_SyncEconomy()
            ply:Horde_SetMinionCount(ply:Horde_GetMinionCount() - 1)
        end
    end)

    timer.Simple(20, function()
        if not ent:IsValid() then return end
        ent:TakeDamage(ent:GetMaxHealth() + 1, Entity(0), Entity(0))
    end)
end
