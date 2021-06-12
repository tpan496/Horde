PERK.PrintName = "Kamikaze"
PERK.Description = "Minions deal {1} of their max health as Blast damage on death."
PERK.Icon = "materials/perks/kamikaze.png"
PERK.Params = {
    [1] = {value = 2, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityRemoved = function (ent)
    local ply = ent:GetNWEntity("HordeOwner")
    if (ent:IsNPC() and ply:IsPlayer() and ply:Horde_GetPerk("engineer_kamikaze")) or (ent.Horde_Has_Parasite and ent.Horde_Has_Parasite:IsPlayer() and ent.Horde_Has_Parasite:Horde_GetPerk("engineer_kamikaze")) then
        if ent.Horde_Has_Parasite:IsPlayer() then
            ply = ent.Horde_Has_Parasite
        end
        local dmg = ent:GetMaxHealth() * 2
        util.BlastDamage(ent, ply, ent:GetPos(), 250, dmg)
        local pos = ent:GetPos()
        local eff = EffectData()
        eff:SetStart(pos)
        eff:SetOrigin(pos)
        util.Effect("Explosion", eff)
    end
end
