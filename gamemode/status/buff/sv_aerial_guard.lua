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

function plymeta:Horde_GetUnwaveringGuardEnabled(enabled)
    return self.Horde_UnwaveringGuardEnabled
end

function plymeta:Horde_SetUnwaveringGuardEnabled(enabled)
    self.Horde_UnwaveringGuardEnabled = enabled
end

function plymeta:Horde_GetGracefulGuardEnabled(enabled)
    return self.Horde_GracefulGuardEnabled
end

function plymeta:Horde_SetGracefulGuardEnabled(enabled)
    self.Horde_GracefulGuardEnabled = enabled
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_AerialGuardDamageTaken", function (ply, dmginfo, bonus, silent)
    if ply:Horde_GetAerialGuardEnabled() == 0 then return end
    if dmginfo:GetDamage() <= 0 then return end
    
    if HORDE:IsPhysicalDamage(dmginfo) or ply:Horde_GetPerk("berserker_unwavering_guard") then
        if ply:Horde_GetAerialGuard() == 1 or ply.Horde_In_Steadfast_Parry then
            bonus.less = bonus.less * 0.35
            
            if ply.Horde_In_Steadfast_Parry then
                ply.Horde_Steadfast_Parry_Penalty = 0
                ply:Horde_SetPerkCooldown(0)
                ply:Horde_SetPerkInternalCooldown(ply:Horde_GetPerkCooldown())
                net.Start("Horde_PerkStartCooldown")
                    net.WriteUInt(ply:Horde_GetPerkCooldown(), 8)
                net.Send(ply)
            end
            
            local id = ply:SteamID()
            if timer.Exists("Horde_Steadfast_Parry_Effect" .. id) then
                timer.Adjust("Horde_Steadfast_Parry_Effect" .. id, 0.5, nil, nil)
            end
            
            local e = EffectData()
            if dmginfo:GetDamagePosition() ~= Vector(0,0,0) then
                e:SetOrigin(dmginfo:GetDamagePosition())
            else
                e:SetOrigin(ply:GetPos() + Vector(0,0,30))
            end
                
            util.Effect("horde_aerial_parry", e, true, true)
            if not silent then
                sound.Play("horde/gadgets/guard" .. tostring(math.random(1,2)) ..".ogg", ply:GetPos(), 125, 100, 1, CHAN_AUTO)
            end

            if ply:Horde_GetGracefulGuardEnabled() then
                timer.Simple(0, function()
                    if not ply:IsValid() then return end
                    for debuff, buildup in pairs(ply.Horde_Debuff_Buildup) do
                        ply:Horde_RemoveDebuff(debuff)
                        ply:Horde_ReduceDebuffBuildup(debuff, buildup)
                    end
                end)
                local healinfo = HealInfo:New({amount=10, healer=ply})
                HORDE:OnPlayerHeal(ply, healinfo)
                local id = ply:SteamID()
                timer.Remove("Horde_GracefulGuardBuff" .. id)
                timer.Create("Horde_GracefulGuardBuff" .. id, 1, 10, function ()
                    local healinfo = HealInfo:New({amount=1, healer=ply})
                    HORDE:OnPlayerHeal(ply, healinfo)
                end)
            elseif ply:Horde_GetUnwaveringGuardEnabled() then
                local id = ply:SteamID()
                timer.Remove("Horde_UnwaveringGuardBuff" .. id)
                timer.Create("Horde_UnwaveringGuardBuff" .. id, 10, 1, function ()
                    if ply:IsValid() then
                        ply.HasUnwaveringGuardBuff = nil
                        net.Start("Horde_SyncStatus")
                            net.WriteUInt(HORDE.Status_Unwavering_Guard, 8)
                            net.WriteUInt(0, 8)
                        net.Send(ply)
                    end
                end)

                if not ply.HasUnwaveringGuardBuff then
                    ply.HasUnwaveringGuardBuff = true
                    net.Start("Horde_SyncStatus")
                        net.WriteUInt(HORDE.Status_Unwavering_Guard, 8)
                        net.WriteUInt(1, 8)
                    net.Send(ply)
                end
            end
        end
    end
    if ply.HasUnwaveringGuardBuff then
        bonus.less = bonus.less * 0.75
    end
end)

hook.Add("PlayerButtonDown", "Horde_AerialGuardActivate", function (ply, key)
    if key == KEY_SPACE and ply:Horde_GetAerialGuardEnabled() and ply:IsOnGround() then
        ply:Horde_AddAerialGuard()
        ply.Horde_Aerial_Guard_Pressed = true
        timer.Simple(0.5, function ()
            if not ply:IsValid() then return end
            ply.Horde_Aerial_Guard_Pressed = nil
        end)
    end
end)
hook.Add("PlayerTick", "Horde_AerialGuardOn", function(ply, mv)
    if not ply:Horde_GetAerialGuardEnabled() or not ply:Alive() then return end
    if ply.Horde_Aerial_Guard_Pressed then return end
    if ply:IsOnGround() then
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
