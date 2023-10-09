SPELL.PrintName       = "Pulsar"
SPELL.Weapon          = {"horde_astral_relic"}
SPELL.Mind            = {80}
SPELL.ChargeTime      = {5}
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 60
SPELL.Upgrades        = 3
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = {HORDE.DMG_LIGHTNING}
SPELL.Icon            = "spells/pulsar.png"
SPELL.Type            = {HORDE.Spell_Type_Projectile}
SPELL.Description     = [[Launches a pulsar that bounces between targets.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    local tr = util.TraceHull( {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ( ply:GetAimVector() * 100000 ),
		filter = ply,
		mins = Vector( -10, -10, -10 ),
		maxs = Vector( 10, 10, 10 ),
		mask = MASK_SHOT_HULL
	})
	
	local ent = ents.Create("projectile_horde_pulsar")
    ent:SetOwner(ply)
	
	local level = ply:Horde_GetSpellUpgrade("pulsar")
	ent:SetSpellLevel(level)
	ent:SetSpellBaseDamages({math.floor(150 + math.pow(level, 1.2) * 50)})
    ent:SetPos( ply:EyePos() + (ply:GetAimVector() * 16 ))
	ent:SetAngles( ply:EyeAngles() )

	ent.Target = tr.Entity
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (!IsValid( phys )) then ent:Remove() return end
    local velocity = ply:GetAimVector()
	velocity = velocity * 500
	phys:ApplyForceCenter(velocity)
end
SPELL.Price                      = 1500
SPELL.Upgrades                   = 3
SPELL.Upgrade_Description        = "Increases damage and number of bounces."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 800 + 100 * upgrade_level
end