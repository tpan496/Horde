local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddAerialGuard()
    if self.Horde_AerialGuard == 1 then return end
    self.Horde_AerialGuard = 1
end

function plymeta:Horde_RemoveAerialGuard()
    if not self:IsValid() then return end
    if self.Horde_AerialGuard == 0 then return end
    self.Horde_AerialGuard = 0
end

function plymeta:Horde_GetAerialGuard()
    return self.Horde_AerialGuard or 0
end

function plymeta:Horde_GetAerialGuardEnabled()
    return self.Horde_AerialGuardEnabled
end

function plymeta:Horde_SetAerialGuardEnabled(enabled)
    self.Horde_AerialGuardEnabled = enabled
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_AerialGuardDamageTaken", function (ply, dmginfo, bonus, silent)
    if not ply:Horde_GetAerialGuardEnabled() then return end
    if ply:Horde_GetAerialGuard() == 1 and HORDE:IsPhysicalDamage(dmginfo) then
        bonus.less = bonus.less * 0.40
        if not silent then
            sound.Play("horde/gadgets/guard" .. tostring(math.random(1,2)) ..".ogg", ply:GetPos(), 125, 100, 1, CHAN_AUTO)
        end
    end
end)

hook.Add("PlayerTick", "Horde_AerialGuardOn", function(ply, mv)
    if not ply:Horde_GetAerialGuardEnabled() or not ply:Alive() then return end
    if not ply:IsOnGround() then
        if ply:Horde_GetAerialGuard() == 1 or ply.Horde_ShouldAerialGuard then return end
        ply.Horde_ShouldAerialGuard = true
        timer.Create("Horde_AerialGuard" .. ply:UniqueID(), 0.1, 1, function()
            if ply.Horde_ShouldAerialGuard then
                ply:Horde_AddAerialGuard()
            end
        end)
    else
        ply.Horde_ShouldAerialGuard = nil
        ply:Horde_RemoveAerialGuard()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_AerialGuardReset", function(ply)
    ply.Horde_AerialGuard = 0
end)

hook.Add("DoPlayerDeath", "Horde_AerialGuardDoPlayerDeath", function(victim)
    if victim:IsPlayer() and victim:IsValid() then
        victim:Horde_RemoveAerialGuard()
    end
end)
