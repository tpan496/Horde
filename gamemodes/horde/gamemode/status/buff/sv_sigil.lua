local plymeta = FindMetaTable("Player")

HORDE.Sigil_Courage = 0
HORDE.Sigil_Malediction = 1

function plymeta:Horde_AddSigil(sigil, duration, bonus, level)
    timer.Remove("Horde_RemoveSigil" .. sigil .. self:SteamID())
    timer.Create("Horde_RemoveSigil" .. sigil .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveSigil(sigil)
    end)

    if not self.Horde_Sigils then self.Horde_Sigils = {} end
    self.Horde_Sigils[sigil] = level or 0
    self.Horde_Sigil_Level = level
    self.Horde_Sigil_Bonus = bonus
    net.Start("Horde_SyncStatus")
        net.WriteUInt(sigil, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveSigil(sigil)
    if not self:IsValid() then return end
    if not self.Horde_Sigils then self.Horde_Sigils = {} return end
    if not self.Horde_Sigils[sigil] then return end
    self.Horde_Sigils[sigil] = nil
    self.Horde_Sigil_Level = nil
    self.Horde_Sigil_Bonus = nil
    net.Start("Horde_SyncStatus")
        net.WriteUInt(sigil, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetSigil()
    return self.Horde_Sigils
end

hook.Add("Horde_OnPlayerSpellDamage", "Horde_MysticFieldDamageTaken", function (ply, bonus)
    if ply.Horde_Sigils and ply.Horde_Sigils[HORDE.Status_SigilArcana] and ply:Horde_GetSpellWeapon() then
        bonus.increase = bonus.increase + (0.25 + 0.1 * ply.Horde_Sigil_Level)
    end
end)

hook.Add("Horde_MindRegeneration", "Horde_MindRegenSigil", function (ply, bonus)
    if ply.Horde_Sigil_Bonus and ply.Horde_Sigil_Bonus.sigil_of_courage and ply:Horde_GetSpellWeapon() then
        bonus.increase = bonus.increase + 0.25
    end
end)

hook.Add("Horde_OnSpellCharge", "Horde_SpellChargeSigil", function (ply, bonus)
    if ply.Horde_Sigils and ply.Horde_Sigils[HORDE.Status_SigilAlacrity] and ply:Horde_GetSpellWeapon() then
        bonus.increase = bonus.increase + (0.25 + 0.1 * ply.Horde_Sigil_Level)
    end
end)