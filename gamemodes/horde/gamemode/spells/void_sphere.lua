SPELL.PrintName      = "Void Sphere"
SPELL.Weapon         = { "horde_void_projector" }

SPELL.Mind           = { 5, 10, 15 }
SPELL.ChargeTime     = { 0, 0.5, 1 }
SPELL.ChargeRelease  = nil
SPELL.Cooldown       = 1
SPELL.Upgrades       = 5

SPELL.Slot           = HORDE.Spell_Slot_LMB
SPELL.DamageType     = { HORDE.DMG_COLD }
SPELL.Type           = { HORDE.Spell_Type_Projectile, HORDE.Spell_Type_AOE }

SPELL.Icon           = "spells/void_sphere.png"
SPELL.Description    = [[Projects void energy that deals Cold damage. Charge for differnet effects.]]

SPELL.Fire           = function ( ply, _, charge_stage )

    local function SpawnProjectile( pos, angles, force, _ )

        local ent = ents.Create( "projectile_horde_void_projectile" )
        ent:SetOwner( ply )
        ent:SetPos( pos )
        ent:SetAngles( angles )

        local level = ply:Horde_GetSpellUpgrade( "void_sphere" )
        ent:SetCharged( charge_stage - 1 )
        ent:SetSpellLevel( level )
        ent:SetSpellBaseDamages( { math.floor( 30 + math.pow( level, 1.1 ) * 5.5 ), math.floor( 10 + math.pow( level, 1.1 ) * 7 ) } )
        ent:Spawn()
        ent:GetPhysicsObject():ApplyForceCenter( force )

    end

    local ar = ply:EyeAngles()
    if charge_stage == 1 then

        SpawnProjectile( ply:EyePos() + ( ar:Forward() * 16 ), ar, ar:Forward() * 1200 )

    elseif charge_stage == 2 then

        SpawnProjectile( ply:EyePos() + ( ar:Forward() * 16 ), ar, ar:Forward() * 1300 )
        ar:RotateAroundAxis( ar:Up(), 15 )

        SpawnProjectile( ply:EyePos() + ( ar:Forward() * 16 ), ar, ar:Forward() * 1300 )
        ar = ply:EyeAngles()

        ar:RotateAroundAxis( ar:Up(), -15 )
        SpawnProjectile( ply:EyePos() + ( ar:Forward() * 16 ), ar, ar:Forward() * 1300 )

    else

        SpawnProjectile( ply:EyePos() + ( ar:Forward() * 16 ), ar, ar:Forward() * 1400 )

    end

    ply:EmitSound( "horde/weapons/void_projector/void_spear_launch.ogg", 100, math.random( 70, 90 ) )

end

SPELL.Price                         = 50
SPELL.Upgrades                      = 5
SPELL.Upgrade_Description           = "Increases damage."

SPELL.Upgrade_Prices                = function ( upgrade_level )
    return 550 + 50 * upgrade_level
end