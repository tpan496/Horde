MUTATION.PrintName = "Shielding"
MUTATION.Description = "Regenerable shield.\nShield durability = 5% max health."

MUTATION.Hooks = {}

local entmeta = FindMetaTable("Entity")
function entmeta:Horde_SetMaxShieldHealth(health)
    self.Horde_MaxShieldHealth = health
end

function entmeta:Horde_GetMaxShieldHealth()
    return self.Horde_MaxShieldHealth or 0
end

function entmeta:Horde_SetShieldHealth(health)
    self.Horde_ShieldHealth = health
end

function entmeta:Horde_GetShieldHealth()
    return self.Horde_ShieldHealth or 0
end

function entmeta:Horde_SetCanRegenShield(regen)
    self.Horde_CanRegenShield = regen
end

function entmeta:Horde_GetCanRegenShield()
    return self.Horde_CanRegenShield or nil
end

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if SERVER and mutation == "shielding" then
        local col_min, col_max = ent:GetCollisionBounds()
        local radius = col_max:Distance(col_min) / 2
        local height = math.abs(col_min.z - col_max.z)
        local e = EffectData()
            e:SetOrigin(ent:GetPos())
            e:SetEntity(ent)
            e:SetRadius(radius)
            e:SetMagnitude(height)
        util.Effect("shielding", e, true, true)
        
        local id = ent:GetCreationID()
        timer.Create("Horde_RegenShield" .. id, 10, 0, function ()
            if not ent:IsValid() then timer.Remove("Horde_RegenShield" .. id) return end
            if ent:Horde_GetCanRegenShield() then
                ent:Horde_SetShieldHealth(ent:Horde_GetMaxShieldHealth())
                ent:SetNWBool("HasShield", true)
            else
                ent:Horde_SetCanRegenShield(true)
            end
        end)

        ent:Horde_SetMaxShieldHealth(math.min(300, ent:Health() * 0.05))
        ent:Horde_SetShieldHealth(ent:Horde_GetMaxShieldHealth())
        ent:SetNWBool("HasShield", true)
        ent:Horde_SetCanRegenShield(true)
    end
end

MUTATION.Hooks.EntityTakeDamage = function(target, dmg)
    if target:IsNPC() and target:Horde_GetMutation() == "shielding" then
        local health = target:Horde_GetShieldHealth()
        if health > 0 then
            target:Horde_SetShieldHealth(health - dmg:GetDamage())
            target:Horde_SetCanRegenShield(nil)
            if target:Horde_GetShieldHealth() <= 0 then
                target:SetNWBool("HasShield", false)
            end
            return true
        end
    end
end