MUTATION.PrintName = "Nemesis"
MUTATION.Description = "Leaves behind poisonous clouds on death.\nClouds deal Poison damage based on victim's health."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "nemesis" then
        if SERVER then
            local e = ents.Create("obj_mutation_nemesis")
            local col_min, col_max = ent:GetCollisionBounds()
            local height = math.abs(col_min.z - col_max.z)
            local p = ent:GetPos()
            p.z = p.z + height / 2
            e:SetPos(p)
            e:SetParent(ent)
            ent.Horde_Nemesis_Orb = e
        end
    end
end

MUTATION.Hooks.Horde_OnEnemyKilled = function(victim, killer, weapon)
    if victim:Horde_HasMutation("nemesis") then
        local victim_pos = victim:GetPos()
        for i =0,10 do
            timer.Simple(0.5 + i * 0.2, function ()
                local rand = VectorRand()
                if rand.z < 0 then rand.z = -rand.z end
                local pos = victim_pos + rand * math.Rand(10, 50)
                for _, e1 in pairs(ents.FindInSphere(pos, 150)) do
                    if HORDE:IsPlayerOrMinion(e1) == true then
                        local dmginfo = DamageInfo()
                        dmginfo:SetDamage(math.max(5, 0.05 * e1:GetMaxHealth()))
                        dmginfo:SetAttacker(Entity(0))
                        dmginfo:SetInflictor(Entity(0))
                        dmginfo:SetDamagePosition(pos)
                        dmginfo:SetDamageType(DMG_ACID)
                        e1:TakeDamageInfo(dmginfo)
                    end
                end
                local e = EffectData()
                    e:SetOrigin(pos)
                util.Effect("corruption", e, true, true)
                sound.Play("ambient/levels/canals/toxic_slime_sizzle2.wav", pos)
            end)
        end
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "nemesis" then return end
    if SERVER then
        ent.Horde_Nemesis_Orb:Remove()
    end
    ent:StopParticles()
end