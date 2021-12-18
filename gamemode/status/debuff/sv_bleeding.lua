local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddBleedingEffect()
    if self:IsPlayer() then
        timer.Create("Horde_BleedingEffect" .. self:SteamID(), 0.5, 0, function ()
            if not self.Horde_Debuff_Active[HORDE.Status_Bleeding] then return end
            local dmg = DamageInfo()
            dmg:SetAttacker(Entity(0))
            dmg:SetInflictor(Entity(0))
            dmg:SetDamageType(DMG_SLASH)
            dmg:SetDamage(2)
            self:TakeDamageInfo(dmg)
            sound.Play("player/pl_pain5.wav", self:GetPos())
        end)
    end
end