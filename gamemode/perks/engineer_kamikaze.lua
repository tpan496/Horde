PERK.PrintName = "Kamikaze"
PERK.Description = "Minions deal 200% of their max health as blast damage when killed."
PERK.Icon = "materials/perks/kamikaze.png"

PERK.Hooks = {}
PERK.Hooks.EntityRemoved = function (ent)
    local ply = ent:GetNWEntity("HordeOwner")
    if ent:IsNPC() and ply:IsPlayer() and ply:Horde_GetPerk("engineer_kamikaze") then
        local dmginfo = DamageInfo()
        dmginfo:SetInflictor(ent)
		dmginfo:SetAttacker(ply)
		dmginfo:SetDamageType(DMG_BLAST)
		dmginfo:SetDamage(ent:GetMaxHealth() * 2)
        util.BlastDamageInfo(dmginfo, ent:GetPos(), 250)
    end
end
