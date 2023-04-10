PERK.PrintName = "Pneumatic Legs"
PERK.Description =
[[Adds {1} maximum Hypertrophy stacks.
Press SPACE in air to descend, dealing area Physical damage based on your speed.
{2} reduced fall damage taken.]]
PERK.Icon = "materials/perks/carcass/pneumatic_legs.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 0.9, percent = true},
    [3] = {value = 5},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "carcass_pneumatic_legs" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() + 1)
        ply.Horde_Pneumatic_Leg_Ready = true
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "carcass_pneumatic_legs" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() - 1)
        ply.Horde_Pneumatic_Leg_Ready = nil
    end
end

PERK.Hooks.Horde_GetFallDamage = function(ply, speed, bonus)
    if ply:Horde_GetPerk("carcass_pneumatic_legs") then
        bonus.less = bonus.less * 0.1
        local dmg = math.max(0, math.ceil(0.2418 * speed - 141.75)) * 2
        if dmg < 10 then return end
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(ply)
        dmginfo:SetInflictor(ply)
        dmginfo:SetDamageType(DMG_GENERIC)
        dmginfo:SetDamage(dmg)
        dmginfo:SetDamagePosition(ply:GetPos())
        util.BlastDamageInfo(dmginfo, ply:GetPos(), 250)
        local e = EffectData()
            e:SetNormal(Vector(0,0,1))
            e:SetOrigin(ply:GetPos())
            e:SetRadius(250)
        util.Effect("seismic_wave", e, true, true)
        ply.Horde_Pneumatic_Leg_Ready = true
    end
end

PERK.Hooks.PlayerButtonDown = function (ply, key)
    if key == KEY_SPACE and ply:Horde_GetPerk("carcass_pneumatic_legs") and !ply:IsOnGround() then
        local dir = Vector(0,0,-1)
        local vel = dir * math.max(590, (ply:GetVelocity():Length() + 250))
        ply:SetLocalVelocity(vel)
    end
end
/*
PERK.Hooks.PlayerButtonDown = function (ply, key)
    if key == KEY_SPACE and ply:Horde_GetPerk("carcass_pneumatic_legs") and ply:IsOnGround() then
        if ply.Horde_Pneumatic_Leg_Ready then
            timer.Simple(0.1, function()
                if not ply:IsValid() then return end
                net.Start("Horde_SyncStatus")
                    net.WriteUInt(HORDE.Status_Pneumatic_Legs, 8)
                    net.WriteUInt(0, 8)
                net.Send(ply)
                local dir = ply:GetForward() * 0.7 + ply:GetUp() * 0.3
                dir:Normalize()

                local force = 800
                if ply:IsSprinting() then
                    force = 800
                else
                    force = 650
                end
                local vel = dir * force
                ply:SetLocalVelocity(vel)
                ply.Horde_Pneumatic_Leg_Ready = nil
                ply.Horde_Pneumatic_Leg_Leaping = true
                sound.Play("horde/player/pneumatic_legs.ogg", ply:GetPos())
                
                local id = ply:SteamID()
                timer.Remove("Horde_PneumaticLeg" .. id)
                timer.Create("Horde_PneumaticLeg" .. id, 5, 1, function ()
                    if (not ply:IsValid()) or (not ply:Horde_GetPerk("carcass_pneumatic_legs")) then return end
                    net.Start("Horde_SyncStatus")
                        net.WriteUInt(HORDE.Status_Pneumatic_Legs, 8)
                        net.WriteUInt(1, 8)
                    net.Send(ply)
                    ply.Horde_Pneumatic_Leg_Ready = true
                    ply.Horde_Pneumatic_Leg_Leaping = nil
                end)
            end)
        else
            ply.Horde_Pneumatic_Leg_Leaping = nil
        end
    end
end*/