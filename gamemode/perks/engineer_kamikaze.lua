PERK.PrintName = "Kamikaze"
PERK.Description = "Minions deal 200% of their max health as Blast damage on death."
PERK.Icon = "materials/perks/kamikaze.png"

PERK.Hooks = {}
PERK.Hooks.EntityRemoved = function (ent)
    local ply = ent:GetNWEntity("HordeOwner")
    if ent:IsNPC() and ply:IsPlayer() and ply:Horde_GetPerk("engineer_kamikaze") then
        local dmg
		dmg = ent:GetMaxHealth() * 2
        util.BlastDamage(ent, ply, ent:GetPos(), 250, dmg)
        local pos = ent:GetPos()
        local eff = EffectData()
        eff:SetStart(pos)
        eff:SetOrigin(pos)
        util.Effect("Explosion", eff)
    end
end
