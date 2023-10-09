SPELL.PrintName       = "Meteor"
SPELL.Weapon          = {"horde_astral_relic"}
SPELL.Mind            = {10, 20, 30}
SPELL.Price           = 0
SPELL.ChargeTime      = {1, 2, 3}
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 1
SPELL.Slot            = HORDE.Spell_Slot_LMB
SPELL.DamageType      = {HORDE.DMG_PHYSICAL, HORDE.DMG_BLAST}
SPELL.Icon            = "spells/meteor.png"
SPELL.Type            = {HORDE.Spell_Type_AOE}
SPELL.Description     = [[Hurls a meteor at the target. Charged meteor deals extra Blast damage.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
	ply:EmitSound("horde/weapons/nether_relic/nether_star_launch.ogg", 100, math.random(90, 110))
	local ent = ents.Create("projectile_horde_meteor")
    ent:SetOwner(ply)
	ent:SetCharged(charge_stage)

	local level = ply:Horde_GetSpellUpgrade("meteor")
	ent:SetSpellLevel(level)
	ent:SetSpellBaseDamages({120 + math.pow(level, 1.1) * 25})
    ent:SetPos( ply:EyePos() + (ply:GetAimVector() * 16 ))
	ent:SetAngles( ply:EyeAngles() )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if (!IsValid( phys )) then ent:Remove() return end
    local velocity = ply:GetAimVector()
	velocity = velocity * 2000
    phys:ApplyForceCenter(velocity)
end
SPELL.Price                      = 50
SPELL.Upgrades                   = 5
SPELL.Upgrade_Description        = "Increases damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 550 + 50 * upgrade_level
end