local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddHemorrhage(inflictor)
    if self:IsPlayer() then
        local id = self:GetCreationID()
        timer.Create("Horde_HemorrhageLoop" .. id, 0.5, 0, function ()
            if not self:IsValid() or not self:Alive() or self.Horde_Debuff_Active[HORDE.Status_Bleeding] then
                timer.Remove(id)
                return
            end
            self:Horde_AddDebuffBuildup(HORDE.Status_Hemorrhage, 2, inflictor)
        end)
    end
end

function entmeta:Horde_ActivateHemorrhage()
    local r = {0.3, 0.35, 0.4, 0.5, 0.5}
    self:SetHealth(self:Health() - self:GetMaxHealth() * r[HORDE.difficulty])
    if self:Health() <= 0 then
        local dmg = DamageInfo()
        if inflictor and inflictor:IsValid() then
            dmg:SetAttacker(inflictor)
            dmg:SetInflictor(inflictor)
        else
            dmg:SetAttacker(Entity(0))
            dmg:SetInflictor(Entity(0))
        end
        dmg:SetDamageType(DMG_DIRECT)
        dmg:SetDamage(100)
        self:TakeDamageInfo(dmg)
    end
    self:EmitSound("horde/status/bleeding_trigger.ogg")

    local e = EffectData()
    e:SetOrigin(self:GetPos() + Vector(0,0,30))
    util.Effect( "horde_status_bleeding", e, true, true )

    self.Horde_Debuff_Active[HORDE.Status_Hemorrhage] = true
    local str = "Horde_Remove_" .. tostring(HORDE.Status_Hemorrhage) .. "_" .. self:SteamID()
    timer.Remove(str)
    timer.Create(str, 1, 1, function ()
        self:Horde_RemoveDebuff(HORDE.Status_Hemorrhage)
    end)
    local id = self:GetCreationID()
    timer.Remove("Horde_HemorrhageLoop" .. id)
    self:ScreenFade( SCREENFADE.IN, Color( 255, 0, 0, 100 ), 1, 1 )
end