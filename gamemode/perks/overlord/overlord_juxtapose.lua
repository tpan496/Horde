PERK.PrintName = "Juxtapose"
PERK.Description = [[+1 Fear stack.
Press SHIFT+E to create a mirror of yourself with 50% health.
The mirror applies Fear to nearby enemies.]]
PERK.Icon = "materials/perks/overlord/juxtapose.png"
PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_juxtapose" then
        ply:Horde_SetPerkCooldown(12)
        ply:Horde_SetPerkInternalCooldown(0)
        net.Start("Horde_SyncActivePerk")
        net.WriteUInt(HORDE.Status_Juxtapose, 8)
        net.WriteUInt(1, 3)
        net.Send(ply)
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_juxtapose" then
        net.Start("Horde_SyncActivePerk")
        net.WriteUInt(HORDE.Status_Juxtapose, 8)
        net.WriteUInt(0, 3)
        net.Send(ply)
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
    end
end

PERK.Hooks.Horde_UseActivePerk = function(ply)
    if not ply:Horde_GetPerk("overlord_juxtapose") then return end
    sound.Play("horde/player/overlord/projection.mp3", ply:GetPos(), 100, math.random(80, 120))
    if not SERVER then return end
    if IsValid(ply.Horde_overlord_juxtapose) then
        ply.Horde_overlord_juxtapose:Remove()
    end
    ply.Horde_overlord_juxtapose = ents.Create("npc_horde_overlord_projection")
    ply.Horde_overlord_juxtapose:SetPos(ply:GetPos() + ply:GetRight() * 45)
    ply.Horde_overlord_juxtapose:SetAngles(ply:GetAngles())
    ply.Horde_overlord_juxtapose:SetNWEntity("HordeOwner", ply)
    ply.Horde_overlord_juxtapose:Spawn()
    ply.Horde_overlord_juxtapose:SetMaxHealth(ply:GetMaxHealth() * 0.5)
    ply.Horde_overlord_juxtapose:SetHealth(ply:GetMaxHealth() * 0.5)
    ply.Horde_overlord_juxtapose:SetOwner(ply)
    if ply:GetActiveWeapon():IsValid() then
        ply.Horde_overlord_juxtapose:Give(ply:GetActiveWeapon():GetClass())
    end
    ply.Horde_overlord_juxtapose:SetColor(Color(0, 0, 100, 255))
    ply.Horde_overlord_juxtapose:SetModel(ply:GetModel())
    ply.Horde_overlord_juxtapose:AddRelationship("player D_LI 99")
    ply.Horde_overlord_juxtapose:AddRelationship("ally D_LI 99")
    ply.Horde_overlord_juxtapose:AddRelationship("npc_turret_floor D_LI 99")
    ply.Horde_overlord_juxtapose:AddRelationship("npc_vj_horde_combat_bot D_LI 99")
    ply.Horde_overlord_juxtapose:AddRelationship("npc_manhack D_LI 99")
    ply.Horde_overlord_juxtapose:AddRelationship("npc_vj_horde_vortigaunt D_LI 99")
    ply.Horde_overlord_juxtapose:AddRelationship("npc_vj_horde_rocket_turret D_LI 99")
    ply.Horde_overlord_juxtapose:AddRelationship("npc_vj_horde_spectre D_LI 99")
    ply.Horde_overlord_juxtapose:AddRelationship("npc_vj_horde_antlion D_LI 99")
    ply.Horde_overlord_juxtapose:SetNPCState(NPC_STATE_COMBAT)
    ply.Horde_overlord_juxtapose:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
    ply.Horde_overlord_juxtapose.Immune_Status_All = true
    timer.Simple(0.1, function()
        ply.Horde_overlord_juxtapose:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    end)
    -- for i = 1, 10 do
    --     timer.Simple(i, function()
    --         if ply:IsValid() and ply.Horde_overlord_juxtapose:IsValid() then
    --             local image = ply.Horde_overlord_juxtapose
    --             if image:GetEnemy() and image:GetEnemy():IsValid() and image:GetEnemy():GetPos():DistToSqr(image:GetPos()) < 10000 then
    --                 ply.Horde_overlord_juxtapose:ClearSchedule()
    --                 ply.Horde_overlord_juxtapose:ClearGoal()
    --                 ply.Horde_overlord_juxtapose:SetSchedule(SCHED_MOVE_AWAY_FROM_ENEMY)
    --                 ply.Horde_overlord_juxtapose:ClearEnemyMemory()
    --                 print("backoff")
    --             end
    --         end
    --     end)
    -- end

    timer.Simple(15, function()
        if ply:IsValid() and ply.Horde_overlord_juxtapose:IsValid() then
            ply.Horde_overlord_juxtapose:Remove()
        end
    end)
end
