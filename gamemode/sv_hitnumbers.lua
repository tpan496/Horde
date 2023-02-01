util.AddNetworkString("Horde_HitnumbersSpawn")
util.AddNetworkString("Horde_HitnumbersDebuffSpawn")

-- Enable/Disable this addon globally.
local on = true

hook.Add("PostEntityTakeDamage", "Horde_HitnumbersDamagePost", function(target, dmginfo, took)
	if not GetConVar("horde_display_damage"):GetBool() then return end
    if not took then return end
	local attacker         = dmginfo:GetAttacker()
	local attackerIsPlayer = attacker:IsPlayer()

	if not ( attackerIsPlayer ) then return end
	if attacker == target  then return end
    if not target:IsNPC() then return end

	local dmgAmount = dmginfo:GetDamage()
	local dmgType   = dmginfo:GetDamageType()
	-- Get damage position.
	local pos = dmginfo:GetDamagePosition()
	if dmgType == DMG_CLUB or dmgType == DMG_SLASH then
		pos = util.TraceHull({
			start  = attacker:GetShootPos(),
			endpos = attacker:GetShootPos() + (attacker:GetAimVector() * 100),
			filter = attacker,
			mins   = Vector(-10,-10,-10),
			maxs   = Vector( 10, 10, 10),
			mask   = MASK_SHOT_HULL,
		}).HitPos
	end
    if !pos or dmginfo:IsExplosionDamage() then
        pos = target:GetPos()
    end

	-- Create and send the indicator to players.
	net.Start("Horde_HitnumbersSpawn", true)

	-- Damage amount.
	net.WriteFloat(dmgAmount)

	-- Type of damage.
	net.WriteUInt(dmgType, 32)

	-- Damage position.
	net.WriteVector(pos)

	-- Send indicator to receiver, else all players.
	net.Send(attacker)
end)

hook.Add("Horde_PostEnemyDebuffApply", "Horde_HitnumbersDebuff", function (target, inflictor, debuff, pos)
    if not GetConVar("horde_display_damage"):GetBool() then return end
    if IsValid(inflictor) and inflictor:IsPlayer() then
        net.Start("Horde_HitnumbersDebuffSpawn", true)

        -- Debuff
        net.WriteUInt(debuff, 32)

        -- Damage position.
        net.WriteVector(pos)

        -- Send indicator to receiver, else all players.
        net.Send(inflictor)
    end
end)