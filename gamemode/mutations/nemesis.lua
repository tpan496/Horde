MUTATION.PrintName = "Nemesis"
MUTATION.Description = "Explodes on death.\nDeals 25% maximum health as poison damage."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if SERVER and mutation == "nemesis" then
        local col_min, col_max = ent:GetCollisionBounds()
        local height = math.abs(col_min.z - col_max.z)
        local radius = col_max:Distance(col_min) / 2
        local e = EffectData()
            e:SetOrigin(ent:GetPos())
            e:SetEntity(ent)
            e:SetRadius(radius)
            e:SetMagnitude(height)
        util.Effect("nemesis", e, true, true)
    end
end

MUTATION.Hooks.Horde_OnEnemyKilled = function(victim, killer, weapon)
    if victim:Horde_GetMutation() == "nemesis" then
        local e = EffectData()
		    e:SetOrigin(victim:GetPos())
	    util.Effect("nemesis_explosion", e)

        local dmginfo = DamageInfo()
        dmginfo:SetInflictor(killer)
		dmginfo:SetAttacker(victim)
		dmginfo:SetDamageType(DMG_ACID)
		dmginfo:SetDamage(math.min(victim:GetMaxHealth() * 0.25, 50))
        dmginfo:SetDamageForce(Vector(0,0,0))
        util.BlastDamageInfo(dmginfo, victim:GetPos(), 250)
        
        sound.Play("vj_acid/acid_splat.wav", victim:GetPos())
    end
end