SPELL.PrintName      = "Static Guard"
SPELL.Weapon         = {"horde_solar_seal"}
SPELL.Mind           = {5, 10}
SPELL.ChargeTime     = {0, 0.5}
SPELL.ChargeRelease  = nil
SPELL.Cooldown       = 5
SPELL.Slot           = HORDE.Spell_Slot_Utility
SPELL.DamageType     = {HORDE.DMG_LIGHTNING}
SPELL.Icon           = "spells/static_guard.png"
SPELL.Type           = {HORDE.Spell_Type_Guard}
SPELL.Description    = [[Parries attacks by generating static fields. When the parry is successful, reduces damage taken by 90% and deals heavy Lightning damage back to the attacker. Only triggers when the damage received is at least 10.
Charging the spell increases parry invincible window.]]
SPELL.Fire           = function (ply, wpn, charge_stage)
    HORDE:SimpleParticleSystem("static_guard", ply:GetPos() + ply:GetForward() * 15 + Vector(0, 0, 35), ply:EyeAngles())
    ply:EmitSound("horde/spells/static_guard.ogg")
    ply.Horde_Has_Static_Guard = true
    if charge_stage > 1 then
        timer.Simple(0.5, function ()
            if ply:IsValid() then
                ply.Horde_Has_Static_Guard = nil
            end
        end)
    else
        timer.Simple(0.3, function ()
            if ply:IsValid() then
                ply.Horde_Has_Static_Guard = nil
            end
        end)
    end
end
SPELL.Hooks = {}
SPELL.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply.Horde_Has_Static_Guard and dmginfo:GetDamage() >= 10 then
        bonus.less = bonus.less * 0.1
        ply:EmitSound("horde/spells/static_guard_retaliate.ogg")
        local e = EffectData()
        if dmginfo:GetDamagePosition() ~= Vector(0,0,0) then
            e:SetOrigin(dmginfo:GetDamagePosition())
        else
            e:SetOrigin(ply:GetPos() + Vector(0,0,30))
        end
            
        util.Effect("horde_static_guard", e, true, true)
        if dmginfo:GetAttacker() then
            local ent = dmginfo:GetAttacker()
            local dmg = DamageInfo()
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply)
            dmg:SetDamageType(DMG_SHOCK)
            dmg:SetDamage(100 + dmginfo:GetDamage() * 2)
            dmg:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
            util.BlastDamageInfo(dmg, ent:GetPos(), 150)
            local LT = ents.Create("info_target")
            LT:SetKeyValue("targetname","static_guard_target_" .. LT:EntIndex())
            LT:SetPos(ent:GetPos() + ent:OBBCenter())
            LT:Fire("kill","",0.5)
            LT:Spawn()
            local idx = LT:EntIndex()
            timer.Simple(0.1, function ()
                if !ply:IsValid() then return end
                local LA = ents.Create("env_laser")
                LA:SetKeyValue("lasertarget", "static_guard_target_" .. idx)
                LA:SetKeyValue("rendercolor", "50 50 255")
                LA:SetKeyValue("texture", "sprites/laserbeam.spr")
                LA:SetKeyValue("dissolvetype", "1")
                LA:SetKeyValue("width", "4")
                LA:SetKeyValue("damage", "0")
                LA:SetKeyValue("noiseamplitude", "10")
                LA:SetOwner(ply)
                LA:Spawn()
                LA:Fire("Kill","",0.25)
                LA:SetPos(ply:GetPos() + ply:OBBCenter())
            end)
        end
    end
end
SPELL.Price = 300