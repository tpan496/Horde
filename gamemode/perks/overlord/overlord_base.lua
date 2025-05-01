PERK.PrintName = "Overlord Base"
PERK.Description = [[
The Overlord class focuses on debilitating enemies with their intimidating presence 
causing them to take more damage and deal less damage.

{1} increased damage with Shotguns ({2} per level, up to {3})
{4} increased presence radius ({5} per level, up to {6}).

Your active perk skill also has your presence.

Enemies in your presence are afflicted with Fear.
Enemies afflicted with Fear are also afflicted with Agony and Suffering

Enemies afflicted with Agony take {7} more damage.
Enemies afflicted with Suffering deal {8} less damage.

Maximum Fear stacks is {9}.
Fear lasts for {10} seconds and stacks fall off consecutively.
Maximum Fear stacks is increased by {11} for every perk skill tier unlocked.

Has access to Shotguns and Watchtower Modules that augment your presence.

Shift + E to use Dark Energy Blast which fires a Combine energy ball at your enemies that 
deals damage in an area of effect proportional to the amount of Fear stacks.

Dark Energy Blast -
Cannot headshot.
Deals {12} physical damage per Fear stack.
Blast radius is equal to your presence.
Presence lingers for {13} seconds.
Has a {14} second cooldown.
]]
PERK.Params = {
    [1] = { percent = true, level = 0.01, max = 0.25, classname = "Overlord" },
    [2] = { value = 0.01, percent = true },
    [3] = { value = 0.25, percent = true },

    [4] = { percent = true, level = 0.01, max = 0.25, classname = "Overlord" },
    [5] = { value = 0.01, percent = true },
    [6] = { value = 0.25, percent = true },
    
    [7] = { percent = true, value = 0.04 },
    [8] = { percent = true, value = 0.04 },
    
    [9] = { value = 2 },
    [10] = { value = 5 },
    [11] = { value = 1 },
    
    [12] = { value = 55 },
    [13] = { value = 5 },
    [14] = { value = 30 },
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_base" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 2)
        if not ply:Horde_GetPerk("overlord_juxtapose") then
            ply:Horde_SetPerkCooldown(30)
            ply:Horde_SetPerkInternalCooldown(0)
            net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_DarkEnergyBlast, 8)
            net.WriteUInt(1, 3)
            net.Send(ply)
        end
        ply:Horde_AddOverlordPresence()
    end
end


PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_base" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 2)
        if not ply:Horde_GetPerk("overlord_juxtapose") then
            net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_DarkEnergyBlast, 8)
            net.WriteUInt(0, 3)
            net.Send(ply)
        end
        
        ply:Horde_RemoveOverlordPresence()
        
        for _, ent in pairs(ents.FindByClass("projectile_horde_hyperblast_projectile")) do
            if ent:GetOwner() == ply then
                ent:Remove()
            end
        end
        for _, ent in pairs(ents.FindByClass("npc_vj_horde_overlord_projection")) do
            if ent:GetNWEntity("HordeOwner") == ply then
                ent:Remove()
            end
        end
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function(ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("overlord_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Overlord")))
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("overlord_base") then return end
    if HORDE:IsCurrentWeapon(dmginfo, "Shotgun") == true then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("overlord_base")
    end
end
--[[
PERK.Hooks.Horde_OnPlayerDebuffApply = function(ply, debuff, bonus, inflictor)
    if not ply:Horde_GetPerk("overlord_base") then return end
    bonus.less = bonus.less * (1 - ply:Horde_GetPerkLevelBonus("overlord_base"))
end
]]
PERK.Hooks.Horde_OnSpecialUpgradeBuySell = function(ply)
    if SERVER then
        if not ply:Horde_GetPerk("overlord_base") then return end
        ply:Horde_AddOverlordPresence()
    end
end

PERK.Hooks.Horde_UseActivePerk = function(ply)
    if not ply:Horde_GetPerk("overlord_base") then return end
    if ply:Horde_GetPerk("overlord_juxtapose") then return end
    local rocket = ents.Create("projectile_horde_hyperblast_projectile")
    local vel = 1500
    local ang = ply:EyeAngles()

    local src = ply:GetPos() + Vector(0, 0, 50) + ply:GetEyeTrace().Normal * 5

    if !rocket:IsValid() then print("!!! INVALID ROUND " .. rocket) return end

    local rocketAng = Angle(ang.p, ang.y, ang.r)

    rocket:SetAngles(rocketAng)
    rocket:SetPos(src)

    rocket:SetOwner(ply)
    rocket.Owner = ply
    rocket.Inflictor = rocket

    local RealVelocity = (ply:GetAbsVelocity() or Vector(0, 0, 0)) + ang:Forward() * vel / 0.0254
    rocket.CurVel = RealVelocity -- for non-physical projectiles that move themselves

    rocket:Spawn()
    rocket:Activate()
    if !rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
        timer.Simple(0.1, function()
            if !rocket:IsValid() then return end
            rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
        end)
    end

    if rocket.Launch and rocket.SetState then
        rocket:SetState(1)
        rocket:Launch()
    end

    sound.Play("weapons/ar2/ar2_altfire.wav", ply:GetPos())
end

PERK.Hooks.DoPlayerDeath = function (ply)
    if not ply:Horde_GetPerk("overlord_base") then return end
    for _, ent in pairs(ents.FindByClass("projectile_horde_hyperblast_projectile")) do
        if ent:GetOwner() == ply then
            ent:Remove()
        end
    end
    for _, ent in pairs(ents.FindByClass("npc_vj_horde_overlord_projection")) do
        if ent:GetNWEntity("HordeOwner") == ply then
            ent:Remove()
        end
    end
end
