local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddReactiveArmor()
    if self.Horde_ReactiveArmor == 1 then return end

    self.Horde_ReactiveArmor = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_ReactiveArmor, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveReactiveArmor()
    if not self:IsValid() then return end
    if self.Horde_ReactiveArmor == 0 then return end
    self.Horde_ReactiveArmor = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_ReactiveArmor, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetReactiveArmor()
    return self.Horde_ReactiveArmor or 0
end

function plymeta:Horde_SetReactiveArmorEnabled(enabled)
    self.Horde_ReactiveArmorEnabled = enabled
end

function plymeta:Horde_GetReactiveArmorEnabled()
    return self.Horde_ReactiveArmorEnabled or nil
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_ReactiveArmorDamage", function (ply, dmginfo, bonus, silent)
    if silent then return end
    if ply:IsValid() and ply:Horde_GetReactiveArmorEnabled() and ply:Horde_GetReactiveArmor() == 1 and dmginfo:GetAttacker() ~= ply and dmginfo:GetDamage() >= 25 and ply:Health() < dmginfo:GetDamage() then
        bonus.resistance = 1
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(ply)
        dmg:SetDamageType(DMG_BLAST)
        dmg:SetDamage(100)
        util.BlastDamageInfo(dmg, ply:GetPos(), 150)
        local effectdata = EffectData()
        effectdata:SetOrigin( ply:GetPos() )
        util.Effect("Explosion", effectdata)
        ply:Horde_RemoveReactiveArmor()
        ply:SetArmor(math.max(0, ply:Armor() - ply:GetMaxArmor() * 0.25))
        timer.Remove("Horde_RestockReactiveArmor" .. ply:SteamID())
        timer.Create("Horde_RestockReactiveArmor" .. ply:SteamID(), 6, 1, function ()
            ply:Horde_AddReactiveArmor()
        end)
    end
end)


hook.Add("Horde_ResetStatus", "Horde_ReactiveArmorReset", function(ply)
    ply.Horde_ReactiveArmor = 0
    ply.Horde_ReactiveArmorEnabled = nil
end)
