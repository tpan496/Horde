PERK.PrintName = "Displacer"
PERK.Description = [[Press SHIFT+E to teleport a targeted minion to your side.
Recover {1} of the teleported minion's health.
Displacer has a cooldown of {2} seconds.]]
PERK.Icon = "materials/perks/displacer.png"
PERK.Params = {
    [1] = {value = 0.05, percent = true},
    [2] = {value = 3},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_displacer" then
        ply:Horde_SetPerkCooldown(3)
        ply:Horde_SetPerkInternalCooldown(0)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Displacer, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "engineer_displacer" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Displacer, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("engineer_displacer") then return end

    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity

    if ent:IsValid() and not ent:IsWorld() then
        if ent:GetPos():DistToSqr(ply:GetPos()) > 250000 then
            return true
        end
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
            if ent:GetClass() == "npc_vj_horde_rocket_turret" then
                ent:SetAngles(Angle(0,0,0))
                HORDE:DropTurret(ent)
            end
            ent:SetHealth(math.min(ent:GetMaxHealth(), ent:GetMaxHealth() * 0.05 + ent:Health()))
        else
            return true
        end
    end

    sound.Play("weapons/physcannon/physcannon_pickup.wav", ply:GetPos())
end