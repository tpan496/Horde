local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddBleedingEffect(inflictor)
    if self:IsPlayer() then
        local id = "Horde_BleedingEffect" .. self:SteamID()
        local d = self:GetMaxHealth() * 0.02
        local bones = self:GetBoneCount()
        timer.Create(id, 0.5, 0, function ()
            if not self:IsValid() or not self.Horde_Debuff_Active[HORDE.Status_Bleeding] then timer.Remove(id) return end
            self:SetHealth(self:Health() - d)
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
            sound.Play("player/pl_pain5.wav", self:GetPos())
            for bone = 1, bones-1 do
                local p, angle = self:GetBonePosition(bone)
                local e = EffectData()
                e:SetOrigin(p)
                util.Effect( "horde_status_bleeding", e, true, true )
            end
        end)
    else
        local perc_health = self:Health() * 0.01
        local mult = self:GetMaxHealth() / self:Health()
        local id = self:GetCreationID()
        local base_dmg = 30 * mult + perc_health
        local bones = self:GetBoneCount()
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
            dmg:SetDamageType(DMG_CRUSH)
            dmg:SetDamage(base_dmg)
            self:TakeDamageInfo(dmg)
            sound.Play("player/pl_pain5.wav", self:GetPos())

            for bone = 1, bones-1 do
                local p, angle = self:GetBonePosition(bone)
                local e = EffectData()
                e:SetOrigin(p)
                util.Effect( "horde_status_bleeding", e, true, true )
            end
        end)
    end
end