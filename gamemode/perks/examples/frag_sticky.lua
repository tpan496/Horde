PERK.PrintName = "Sticky Grenade"
PERK.Description = "Grenades stick to enemies and surfaces."

PERK.Hooks = {}

PERK.Hooks.EntityTakeDamage = function(victim, dmginfo)
    local attacker = dmginfo:GetAttacker()
    local ent = dmginfo:GetInflictor()
    if (victim:IsNPC() or victim:IsNextBot()) and IsValid(ent) and not ent.Sticked
            and ent:GetClass() == "npc_grenade_frag" and IsValid(attacker)
            and not dmginfo:IsExplosionDamage() and attacker:Horde_GetPerk("frag_sticky") then
        ent.Sticked = true
        ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        constraint.Weld(ent, victim, 0, 0, 0, true, false)
    end
end

PERK.Hooks.OnEntityCreated = function(ent)
    timer.Simple(0, function()
        local owner = IsValid(ent) and ent:GetOwner()
        if SERVER and IsValid(ent) and ent:GetClass() == "npc_grenade_frag" and IsValid(owner)
            and owner:IsPlayer() and owner:Horde_GetPerk("frag_sticky") then
            ent:AddCallback("PhysicsCollide", function(ent2, data)
                local hit = data.HitEntity
                if not ent2.Sticked and hit:IsWorld() then
                    ent2.Sticked = true
                    ent2:GetPhysicsObject():EnableMotion(false)
                    ent2:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
                elseif not ent2.Sticked and not (hit:IsNPC() or hit:IsNextBot() or hit:IsPlayer()) then
                    ent2.Sticked = true
                    timer.Simple(0, function() if IsValid(hit) and IsValid(ent2) then ent2:SetCollisionGroup(COLLISION_GROUP_DEBRIS) constraint.Weld(ent2, hit, 0, 0, 0, true, false) end end)
                end
            end)
        end
    end)
end
