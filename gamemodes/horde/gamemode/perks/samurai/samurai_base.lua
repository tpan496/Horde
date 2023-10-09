PERK.PrintName = "Samurai Base"
PERK.Description =
[[COMPLEXITY: HIGH
    
Inflicts Bleeding buildup by {1} of base Melee damage. ({2} + {3} per level, up to {4}).
{5} increased Global damage resistance. ({6} per level, up to {7}).

SHIFT+E to activate Quickstep.
Dashes torwards the input direction.
Provides 100% evasion during Quickstep.]]
PERK.Icon = "materials/subclasses/samurai.png"
PERK.Params = {
    [1] = {percent = true, base = 0.1, level = 0.01, max = 0.35, classname = "Samurai"},
    [2] = {value = 0.1, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.35, percent = true},
    [5] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = "Samurai"},
    [6] = {value = 0.01, percent = true},
    [7] = {value = 0.25, percent = true},
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "samurai_base" then
        ply:Horde_SetPerkCooldown(3)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Quickstep, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)

        HORDE:CheckDemonStompCharges(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "samurai_base" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Quickstep, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        ply:Horde_SetPerkCharges(0)
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("samurai_base") then return end
    if ply:Horde_GetPerkCharges() <= 0 then
        return true
    end

    if ply:Horde_GetSpamPerkCooldown() > CurTime() then return true end
    ply:Horde_SetSpamPerkCooldown(CurTime() + 0.25)
    local id = ply:SteamID()

    local max_charges = 1
    if ply:Horde_GetPerk("samurai_focus_slash") then
        max_charges = max_charges + 1
    end
    if ply:Horde_GetPerk("samurai_demon_stomp") then
        max_charges = max_charges + 1
    end
    if ply:Horde_GetPerk("samurai_blade_dance") then
        max_charges = max_charges + 1
    end
    if ply:Horde_GetPerk("samurai_foresight") then
        max_charges = max_charges + 1
    end
    ply:Horde_SetPerkCharges(ply:Horde_GetPerkCharges() - 1)
    
    timer.Remove("Horde_Demonstomp_Charge_recovery" .. id)
    timer.Create("Horde_Demonstomp_Charge_recovery" .. id, 3, 0, function ()
        if !ply:IsValid() or (not ply:Horde_GetPerk("samurai_base")) then timer.Remove("Horde_Demonstomp_Charge_recovery" .. id) return end
        if ply:Horde_GetPerkCharges() >= max_charges then timer.Remove("Horde_Demonstomp_Charge_recovery" .. id) return end
        ply:Horde_SetPerkCharges(math.min(max_charges, ply:Horde_GetPerkCharges() + 1))
    end)

    local dir = ply:GetForward()
    if ply:KeyDown(IN_MOVERIGHT) then
        dir = ply:GetRight()
    elseif ply:KeyDown(IN_MOVELEFT) then
        dir = -ply:GetRight()
    elseif ply:KeyDown(IN_BACK) then
        dir = -dir
    elseif ply:KeyDown(IN_FORWARD) then
    else
        dir = -dir
    end
    local vel
    if ply:IsOnGround() then
        vel = dir * 1000
    else
        vel = dir * 500
    end
    ply:SetLocalVelocity(vel)
    ply.Horde_In_Quickstep = true
    sound.Play("horde/player/quickstep.ogg", ply:GetPos(), 100, math.random(80,120))
    if ply:Horde_GetPerk("samurai_demon_stomp") then
        sound.Play("horde/player/demon_stomp.ogg", ply:GetPos(), 150, 100)
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(ply)
        dmginfo:SetInflictor(ply)
        dmginfo:SetDamage(50)
        dmginfo:SetDamageType(DMG_CRUSH)
        HORDE:ApplyDamageInRadius(ply:GetPos(), 150, dmginfo, function (ent)
            HORDE:SelfHeal(ply, 5)
        end)

        local e = EffectData()
            e:SetNormal(Vector(0,0,1))
            e:SetOrigin(ply:GetPos())
            e:SetRadius(175)
        util.Effect("horde_demon_stomp", e, true, true)
    end

    local t = 0.5
    if ply:Horde_GetPerk("samurai_blade_dance") then
        t = 0.75
    end

    timer.Create("Horde_Quickstep_Effect" .. id, t, 1, function()
        timer.Remove("Horde_Quickstep_Effect" .. id)
        if ply:IsValid() then
            ply.Horde_In_Quickstep = nil
        end
    end)

    if ply:Horde_GetPerkCharges() > 0 then
        return true
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if ply.Horde_In_Quickstep then
        bonus.evasion = bonus.evasion + 1.00
    end
    if not ply:Horde_GetPerk("samurai_base")  then return end
    bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("samurai_base")
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("samurai_base") then return end
    if HORDE:IsMeleeDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, dmginfo:GetDamage() * (0.1 + ply:Horde_GetPerkLevelBonus("samurai_base")), ply, dmginfo:GetDamagePosition())
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("samurai_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Samurai")))
    end
end