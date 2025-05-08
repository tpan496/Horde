PERK.PrintName = "Eldritch Protection"
PERK.Description =
[[{1} increased mind regeneration.
Gain a shield every {2} seconds that reduces damage taken by {3}.
Releases a burst of Cold damage on hit.]]
PERK.Icon = "materials/perks/necromancer/eldritch_protection.png"

PERK.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 8 },
    [3] = { value = 0.4, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_MindRegeneration = function(ply, bonus)
    if ply:Horde_GetPerk("necromancer_eldritch_protection") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_eldritch_protection" then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_EldritchShield, 8)
            net.WriteUInt(1, 8)
        net.Send(ply)
        local id = ply:SteamID()
        timer.Remove("Horde_RecoverEldritchShield" .. id)
        ply.Horde_Eldritch_Shield_Cooldown = nil
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_eldritch_protection" then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_EldritchShield, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        local id = ply:SteamID()
        timer.Remove("Horde_RecoverEldritchShield" .. id)
        ply.Horde_Eldritch_Shield_Cooldown = nil
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("necromancer_eldritch_protection") then return end
    local attacker = dmginfo:GetAttacker()
    if HORDE:IsPlayerOrMinion(attacker) or dmginfo:GetDamage() <= 0 or not ply:Alive() then return end
    if (not ply.Horde_Eldritch_Shield_Cooldown) or (ply.Horde_Eldritch_Shield_Cooldown <= CurTime()) then
        ply:EmitSound("physics/glass/glass_cup_break2.wav")
        bonus.resistance = bonus.resistance + 0.4
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_EldritchShield, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)

        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(ply)
        dmg:SetDamageType(DMG_REMOVENORAGDOLL)
        dmg:SetDamage(150)
        util.BlastDamageInfo(dmg, ply:GetPos(), 200)

        local effectdata = EffectData()
        effectdata:SetOrigin(ply:GetPos())
        effectdata:SetScale(1)
        effectdata:SetEntity(ply)
        util.Effect("GlassImpact", effectdata)

        local id = ply:SteamID()
        ply:ScreenFade(SCREENFADE.IN, Color(0, 191, 255, 50), 2.5, 0)
        timer.Create("Horde_RecoverEldritchShield" .. id, 8, 1, function()
            if IsValid(ply) then
                net.Start("Horde_SyncStatus")
                    net.WriteUInt(HORDE.Status_EldritchShield, 8)
                    net.WriteUInt(1, 8)
                net.Send(ply)
            end
        end)
        ply.Horde_Eldritch_Shield_Cooldown = CurTime() + 8
    end
end