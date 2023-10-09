SPELL.PrintName       = "Neutron Beam"
SPELL.Weapon          = {"horde_astral_relic"}
SPELL.Mind            = {10, 20, 30}
SPELL.Price           = 0
SPELL.ChargeTime      = {1, 2, 3}
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 1
SPELL.Upgrades        = 5
SPELL.Slot            = HORDE.Spell_Slot_LMB
SPELL.DamageType      = {HORDE.DMG_PHYSICAL, HORDE.DMG_LIGHTNING}
SPELL.Icon            = "spells/neutron_beam.png"
SPELL.Type            = {HORDE.Spell_Type_Hitscan}
SPELL.Description     = [[Fires a neutron beam at the target. The beam penetrates targets.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
	ply:EmitSound("horde/weapons/nether_relic/nether_star_launch.ogg", 100, math.random(90, 110))
	local function Hitscan(damage, spread, dir, src, ignore, max_scan)
		local tr2
        wpn:FireBullets({
            Attacker = ply,
            Damage = damage,
            Tracer = 0,
            Distance = 4000,
            Dir = dir,
            Src = src,
            Spread = spread,
            IgnoreEntity = ignore,
            Callback = function(att, tr, dmg)
				tr2 = tr
            end
        })
		if not tr2 then return src end
		if max_scan <= 0 or not tr2.Hit or tr2.HitWorld or tr2.HitSky then return tr2.HitPos end
		if HORDE:IsPlayerMinion(tr2.Entity) then
			return Hitscan(damage, spread, dir, tr2.HitPos, tr2.Entity, max_scan)
		else
			return Hitscan(damage * 0.8, spread, dir, tr2.HitPos, tr2.Entity, max_scan - 1)
		end
    end

	local dir = ply:GetAimVector()
    local src = ply:GetShootPos() + dir * 10
	local level = ply:Horde_GetSpellUpgrade("neutron_beam")
    local bonus = {increase = 0, more = 1}
	hook.Run("Horde_OnPlayerSpellDamage", ply, bonus)
    local base_damage = math.floor(40 + 20 * math.pow(level, 1.1)) * bonus.more * (1 + bonus.increase)
	local max_scount = 2 + level
	if charge_stage == 1 then
		for i = 1, 3 do
			timer.Simple((i-1) * 0.25, function ()
				local pos = Hitscan(base_damage, nil, dir, src, ply, max_scount)
				sound.Play("horde/spells/neutron_beam.ogg", src, 100, math.random(60, 80))
				util.ParticleTracerEx("neutron_beam", src, pos, true, -1, -1)
			end)
		end
	elseif charge_stage == 2 then
		for i = 1, 6 do
			timer.Simple((i-1) * 0.25, function ()
				local pos = Hitscan(base_damage, nil, dir, src, ply, max_scount)
				sound.Play("horde/spells/neutron_beam.ogg", src, 100, math.random(60, 80))
				util.ParticleTracerEx("neutron_beam", src, pos, true, -1, -1)
			end)
		end
	else
		for i = 1, 9 do
			timer.Simple((i-1) * 0.25, function ()
				local pos = Hitscan(base_damage, nil, dir, src, ply, max_scount)
				sound.Play("horde/spells/neutron_beam.ogg", src, 100, math.random(60, 80))
				util.ParticleTracerEx("neutron_beam", src, pos, true, -1, -1)
			end)
		end
	end
end
SPELL.Price                      = 50
SPELL.Upgrades                   = 5
SPELL.Upgrade_Description        = "Increases damage and penetration power."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 550 + 50 * upgrade_level
end
SPELL.Levels          = {Warlock=5}