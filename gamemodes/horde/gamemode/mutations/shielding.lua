MUTATION.PrintName = "Shielding"
MUTATION.Description = "Regenerable shield.\nShield durability = max(300, 5% max health)."

MUTATION.Hooks = {}

local entmeta = FindMetaTable("Entity")
local shldmat = Material('models/props_combine/portalball001_sheet')

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
    if mutation == "shielding" then
        ent.Horde_Mutation_Shielding = true
        if CLIENT then
            local col_min, col_max = ent:GetCollisionBounds()
            local radius = col_max:Distance( col_min ) / 2
            local height = math.abs( col_min.z - col_max.z )
            local id = ent:EntIndex()
            local damageSphereColor = Color( 0, 255, 255, 100 )
            hook.Add( "PostDrawTranslucentRenderables", "Horde_ShieldingEffect" .. id, function( isDrawingDepth, isDrawSkybox, isDraw3DSkybox )
                if isDraw3DSkybox then return end

                if not ent:IsValid() or not ent.Horde_Mutation_Shielding then
                    hook.Remove("PostDrawTranslucentRenderables", "Horde_ShieldingEffect" .. id)
                    return
                end

                if ent:GetNW2Bool("HasShield") == false then return end

                local pos = ent:GetPos()
                pos.z = pos.z + height / 2

                local wasDamaged = ent:GetNW2Bool( "ShieldDamaged", false )
                if wasDamaged  then
                    render.DrawSphere( pos, radius + 5, 50, 50, damageSphereColor )
                end

                render.SetMaterial( shldmat )
                render.DrawSphere( pos, radius + 5, 50, 50 )
            end)
        end

        if SERVER then
            local id = ent:GetCreationID()
            timer.Create("Horde_RegenShield" .. id, 10, 0, function ()
                if not ent:IsValid() or not ent.Horde_Mutation_Shielding then timer.Remove("Horde_RegenShield" .. id) return end
                if ent:Horde_GetCanRegenShield() then
                    ent:Horde_SetShieldHealth(ent:Horde_GetMaxShieldHealth())
                    ent:SetNW2Bool("HasShield", true)
                else
                    ent:Horde_SetCanRegenShield(true)
                end
            end)

            ent:Horde_SetMaxShieldHealth( math.min( 300, math.max( 50, ent:Health() * 0.05 ) ) )
            ent:Horde_SetShieldHealth(ent:Horde_GetMaxShieldHealth())
            ent:SetNW2Bool("HasShield", true)
            ent:Horde_SetCanRegenShield(true)
        end
    end
end

MUTATION.Hooks.EntityTakeDamage = function(target, dmg)
    if CLIENT then return end
    if target:IsNPC() and target:Horde_HasMutation("shielding") then
        local health = target:Horde_GetShieldHealth()
        if health > 0 then
            target:Horde_SetShieldHealth(health - dmg:GetDamage())
            target:Horde_SetCanRegenShield(nil)
            if target:Horde_GetShieldHealth() <= 0 then
                target:SetNW2Bool("HasShield", false)
            else
                target:SetNW2Bool("ShieldDamaged", true)
                timer.Simple( 0.2, function()
                    if not IsValid( target ) then return end
                    target:SetNW2Bool("ShieldDamaged", false)
                end)
            end

            return true
        end
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "shielding" then return end
    ent.Horde_Mutation_Shielding = nil
    local id = ent:EntIndex()
    hook.Remove("PostDrawTranslucentRenderables", "Horde_ShieldingEffect" .. id)
    timer.Remove("Horde_RegenShield" .. id)
end