PERK.PrintName = "Cluster Bombs"
PERK.Description = "Grenades and SLAMs spawn 3 mini-nades on detonation.\nMini-nades do 20% less damage."
PERK.Icon = "materials/perks/frag_cluster.png"

local exp = {npc_grenade_frag = true, npc_satchel = true, npc_tripmine = true}
PERK.Hooks = {}
PERK.Hooks.EntityRemoved = function(ent)
    local owner = ent:GetInternalVariable("m_hThrower")
    if not owner then ent = ent:GetInternalVariable("m_hOwner") end
    if SERVER and IsValid(ent) and exp[ent:GetClass()] and IsValid(owner)
            and owner:IsPlayer() and owner:Horde_GetPerk("demolition_frag_cluster") then
        local dmg = 100
        local rad = 200
        for i = 1, 3 do
            local prop = ents.Create("prop_physics")
            prop:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
            prop:SetModelScale(0.25, 0)
            prop:SetPos(ent:GetPos() + VectorRand() * 4 + Vector(0, 0, 8))
            prop:SetAngles(AngleRand())
            prop:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            prop:Spawn()
            prop:Activate()
            timer.Simple(0, function() prop:GetPhysicsObject():AddVelocity(VectorRand() * 300 + Vector(0, 0, 200)) end)
            timer.Simple(0.5 + i * 0.1, function() if IsValid(prop) then
                local e = EffectData()
                e:SetOrigin(prop:GetPos())
                util.Effect("Explosion", e)
                util.BlastDamage(prop, owner, prop:GetPos(), rad, dmg)
                prop:Remove()
            end end)
        end
    end
end