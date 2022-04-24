local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddBleedingEffect(inflictor)
    if self:IsPlayer() then
        local id = "Horde_BleedingEffect" .. self:SteamID()
        timer.Create(id, 0.5, 0, function ()
            if not self:IsValid() or not self.Horde_Debuff_Active[HORDE.Status_Bleeding] then timer.Remove(id) return end
            self:SetHealth(self:Health() - 2)
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
                dmg:SetDamage(1000)
                self:TakeDamageInfo(dmg)
            end
            sound.Play("player/pl_pain5.wav", self:GetPos())
        end)
    else
        local perc_health = self:Health() * 0.01
        local id = self:GetCreationID()
        timer.Create("Horde_BleedingEffect" .. id, 0.5, 0, function ()
            if not self:IsValid() or not self.Horde_Debuff_Active[HORDE.Status_Bleeding] then timer.Remove(id) return end
            local dmg = DamageInfo()
            if inflictor and inflictor:IsValid() then
                dmg:SetAttacker(inflictor)
                dmg:SetInflictor(self)
            else
                dmg:SetAttacker(self)
                dmg:SetInflictor(self)
            end
            dmg:SetDamagePosition(self:GetPos())
            dmg:SetDamageType(DMG_DIRECT)
            dmg:SetDamage(math.max(20, 15 + perc_health))
            self:TakeDamageInfo(dmg)
            sound.Play("player/pl_pain5.wav", self:GetPos())
        end)
    end
end