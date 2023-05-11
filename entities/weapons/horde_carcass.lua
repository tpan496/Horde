
AddCSLuaFile()
if CLIENT then
    killicon.Add("horde_carcass", "vgui/hud/punch", Color(0, 0, 0, 255))
end

SWEP.PrintName = "Carcass Biosystem"
SWEP.Author = "Gorlami"
SWEP.Purpose = ""

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

SWEP.HitDistance = 75

SWEP.Charging = 0
SWEP.ChargingTimer = 0

SWEP.Charged = 0
SWEP.Delay = 0.4
SWEP.DrainInterval = 0.1
SWEP.LastDrain = CurTime()
SWEP.BaseDamage = 20
SWEP.TransferInterval = 0.1
SWEP.LastTransfer = CurTime()
SWEP.ToggleInterval = 0.5
SWEP.LastToggle = CurTime()
SWEP.ThrustInterval = 1
SWEP.LastThrust = CurTime()

local sndPowerUp		= Sound("horde/player/carcass/intestine_throw.ogg")
local sndPowerDown		= Sound("horde/player/carcass/intestine_throw.ogg")
local sndTooFar			= Sound("buttons/button10.wav")
local SwingSound = Sound( "WeaponFrag.Throw" )
local HitSound = Sound( "Flesh.ImpactHard" )
local pull = false
local biothruster = true
local intestine_endpos
local target_pos

function SWEP:Initialize()
	nextshottime = CurTime()
	self:SetHoldType( "fist" )
end

function SWEP:SetupDataTables()

	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )
	self:NetworkVar( "Int", 2, "Combo" )

end

function SWEP:SecondaryAttack()
	
end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )

end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + self.Delay )

	self.Charging = 1
	self.ChargingTimer = CurTime() + 0.5
end

function SWEP:Punch(charged)
	self.Charged = charged
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local anim = "fists_left"
	local right = math.random(0,1)
	if ( right == 1) then anim = "fists_right" end
	if ( self:GetCombo() >= 2 ) then
		anim = "fists_uppercut"
	end

	if charged == 1 then
		anim = "fists_uppercut"
	end

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( SwingSound )

	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.1 )

	self:SetNextPrimaryFire( CurTime() + self.Delay )
end

local phys_pushscale = GetConVar( "phys_pushscale" )

function SWEP:DealDamage()
	if SERVER then
		local level = self.Owner:Horde_GetUpgrade("horde_carcass")
		self.BaseDamage = 25 + 8 * level
	end

	local anim = self:GetSequenceName(self.Owner:GetViewModel():GetSequence())

	self.Owner:LagCompensation( true )

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

	if ( !IsValid( tr.Entity ) ) then
		tr = util.TraceHull( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end

	-- We need the second part for single player because SWEP:Think is ran shared in SP
	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then
		self:EmitSound( HitSound )
	end

	if tr.Hit and tr.Entity:IsWorld() and self.Charged == 1 and self.Owner:Horde_GetPerk("carcass_reinforced_arms") then
		local hitnormal = tr.HitNormal
		self.Owner:SetVelocity(self.Owner:GetVelocity() + hitnormal * 250)
	end

	local hit = false
	local scale = phys_pushscale:GetFloat()

	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then
		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end

		self:FireBullets({
            Attacker = attacker,
            Inflictor = self,
            Damage = self.BaseDamage,
            Tracer = -1,
			HullSize = 10,
            Distance = 75,
            Dir = tr.HitPos - self:GetOwner():GetShootPos(),
            Src = self:GetOwner():GetShootPos(),
            Callback = function(att, trb, dmginfo)
                dmginfo:SetAttacker( attacker )
				dmginfo:SetInflictor( self )
				dmginfo:SetDamage(self.BaseDamage)
				local bonus = {increase = 0, more = 1}
				local ply = self.Owner
				if self.Charged == 1 then
					dmginfo:ScaleDamage(2)
				end
				if ply:Horde_GetPerk("carcass_reinforced_arms") then
					bonus.more = bonus.more * math.max(1, ply:GetVelocity():Length() / 180)
				end
				if ply.Horde_Bio_Thruster_Stack and ply.Horde_Bio_Thruster_Stack > 0 then
					bonus.increase = bonus.increase + ply.Horde_Bio_Thruster_Stack * 0.1
				end

				dmginfo:ScaleDamage((1 + bonus.increase) * bonus.more)
				dmginfo:SetDamageType(DMG_CLUB)
				if ( anim == "fists_left" ) then
					dmginfo:SetDamageForce( self.Owner:GetRight() * 4912 * scale + self.Owner:GetForward() * 9998 * scale ) -- Yes we need those specific numbers
				elseif ( anim == "fists_right" ) then
					dmginfo:SetDamageForce( self.Owner:GetRight() * -4912 * scale + self.Owner:GetForward() * 9989 * scale )
				elseif ( anim == "fists_uppercut" ) then
					dmginfo:SetDamageForce( self.Owner:GetUp() * 5158 * scale + self.Owner:GetForward() * 10012 * scale )
					local dmg = DamageInfo()
					dmg:SetAttacker(attacker)
					dmg:SetInflictor(trb.Entity)
					dmg:SetDamageType(DMG_CLUB)
					dmg:SetDamage(dmginfo:GetDamage() / 2)
					dmg:SetDamageForce(Vector(0,0,0))
					dmg:SetDamageCustom(HORDE.DMG_SPLASH)

					if ply:Horde_GetPerk("carcass_reinforced_arms") then
						local vmult = math.max(1, ply:GetVelocity():Length() / 180)
						util.BlastDamageInfo(dmg, dmginfo:GetDamagePosition(), 140 * vmult)
						dmginfo:SetDamageForce(self.Owner:GetUp() * 5158 * scale * vmult + self.Owner:GetForward() * 10012 * scale * vmult)
					else
						util.BlastDamageInfo(dmg, dmginfo:GetDamagePosition(), 140)
					end
				end

                if (not trb.Entity:IsValid()) or (not trb.Entity:IsNPC()) then
                    tr.Entity:TakeDamageInfo(dmginfo)
                end
            end
        })

		SuppressHostEvents( NULL ) -- Let the breakable gibs spawn in multiplayer on client
		SuppressHostEvents( self.Owner )

		hit = true

	end

	if ( IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass() * scale, tr.HitPos )
		end
	end

	if ( SERVER ) then
		if ( hit && anim != "fists_uppercut" ) then
			self:SetCombo( self:GetCombo() + 1 )
		else
			self:SetCombo( 0 )
		end
	end

	self.Owner:LagCompensation( false )

end

function SWEP:OnDrop()

	self:Remove() -- You can't drop fists

end

function SWEP:Reload()
	if CLIENT then return end
	HORDE:UsePerkSkill(self.Owner)
end

function SWEP:TwinHeart()
	if self.LastToggle > CurTime() then return end
	self.LastToggle = CurTime() + self.ToggleInterval
	local ply = self.Owner
	if ply.Horde_TwinHeartStack <= 0 then
		ply.TwinHeartToggleOn = false
		return
	end

	ply.TwinHeartToggleOn = !ply.TwinHeartToggleOn
end

function SWEP:AAS_Perfume()
	local ply = self.Owner
	local rocket = ents.Create("projectile_horde_aas_perfume")
    local vel = 2000
    local ang = ply:EyeAngles()

    local src = ply:GetPos() + Vector(0,0,50) + ply:GetEyeTrace().Normal * 5

    if !rocket:IsValid() then print("!!! INVALID ROUND " .. rocket) return end

    local rocketAng = Angle(ang.p, ang.y, ang.r)

    rocket:SetAngles(rocketAng)
    rocket:SetPos(src)

    rocket:SetOwner(ply)
    rocket.Owner = ply
    rocket.Inflictor = rocket

    rocket.Damage = 100
    rocket.BlastRadius = 150

    local RealVelocity = (ply:GetAbsVelocity() or Vector(0, 0, 0)) + ang:Forward() * vel / 0.0254
    rocket.CurVel = RealVelocity -- for non-physical projectiles that move themselves

    rocket:Spawn()
    rocket:Activate()
    if !rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
        rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
    end

    if rocket.Launch and rocket.SetState then
        rocket:SetState(1)
        rocket:Launch()
    end

    ply:EmitSound("horde/player/carcass/aas.ogg")
end

function SWEP:Deploy()

	local speed = GetConVarNumber( "sv_defaultdeployspeed" )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
	vm:SetPlaybackRate( speed )

	self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() / speed )
	self:SetNextSecondaryFire( CurTime() + vm:SequenceDuration() / speed )
	self:UpdateNextIdle()

	if ( SERVER ) then
		self:SetCombo( 0 )
	end

	return true

end

function SWEP:Holster()

	self:SetNextMeleeAttack( 0 )

	return true

end

function SWEP:DoTrace( endpos )
	local trace = {}
		trace.start = self.Owner:GetShootPos()
		trace.endpos = trace.start + (self.Owner:GetAimVector() * 14096) --14096 is length modifier.
		if(endpos) then trace.endpos = (endpos - self.Tr.HitNormal * 7) end
		trace.filter = { self.Owner, self.Weapon }
		
	self.Tr = nil
	self.Tr = util.TraceLine( trace )
end

function SWEP:StartAttack()
	local ply = self.Owner
	if SERVER and ply:Horde_GetPerk("carcass_bio_thruster") then
		if not ply:IsValid() then return end
		if self.LastThrust > CurTime() then return end
		self.LastThrust = CurTime() + self.ThrustInterval
		local id = ply:SteamID()
		timer.Remove("Horde_BioThrusterDegen" .. id)
		timer.Create("Horde_BioThrusterDegen" .. id, 3, 0, function ()
			if !ply:IsValid() then timer.Remove("Horde_BioThrusterDegen" .. id) end
            if !ply:Alive() then return end
            ply.Horde_Bio_Thruster_Stack = math.max(0, ply.Horde_Bio_Thruster_Stack - 1)
			ply:Horde_SyncStatus(HORDE.Status_Bio_Thruster, ply.Horde_Bio_Thruster_Stack)
        end)
		ply.Horde_Bio_Thruster_Stack = math.min(5, ply.Horde_Bio_Thruster_Stack + 1)
		ply:Horde_SyncStatus(HORDE.Status_Bio_Thruster, ply.Horde_Bio_Thruster_Stack)
	
		local dir = ply:GetAimVector()
		dir:Normalize()

		local force = 800
		if ply:IsSprinting() then
			force = 800
		else
			force = 650
		end
		local vel = dir * force
		ply:SetLocalVelocity(vel)
		
		ply:SetHealth(ply:Health() - ply:GetMaxHealth() * 0.05 * ply.Horde_Bio_Thruster_Stack)
		if ply:Health() <= 0 then
			ply:Kill()
		end
		ply:EmitSound("horde/player/carcass/biothruster" .. math.random(1,2) .. ".ogg")
		ply:EmitSound("horde/player/carcass/pain.ogg")
		return
	end

	if SERVER and ply:Horde_GetPerk("carcass_grappendix") then
	else
		return
	end
	-- Get begining and end poins of trace.
	local gunPos = self.Owner:GetShootPos() -- Start of distance trace.
	local disTrace = self.Owner:GetEyeTrace() -- Store all results of a trace in disTrace.
	local hitPos = disTrace.HitPos -- Stores Hit Position of disTrace.
	
	-- Calculate Distance
	-- Thanks to rgovostes for this code.
	local x = (gunPos.x - hitPos.x)^2;
	local y = (gunPos.y - hitPos.y)^2;
	local z = (gunPos.z - hitPos.z)^2;
	local distance = math.sqrt(x + y + z);
	
	-- Only latches if distance is less than distance CVAR, or CVAR negative
	local distanceCvar = 1000
	inRange = false
	if distanceCvar < 0 or distance <= distanceCvar then
		inRange = true
	end
	
	if inRange then
		if (SERVER) then
			
			if (!self.Horde_Intestine) then -- If the beam does not exist, draw the beam.
				-- grapple_beam
				self.Horde_Intestine = ents.Create( "horde_intestine" )
					self.Horde_Intestine:SetPos( self.Owner:GetShootPos() )
					self.Horde_Intestine.Owner = self.Owner
				self.Horde_Intestine:Spawn()
			end
			
			self.Horde_Intestine:SetParent( self.Owner )
			self.Horde_Intestine:SetOwner( self.Owner )
		
		end
		
		self:DoTrace()
		self.speed = 10000 -- Rope latch speed. Was 3000.
		self.startTime = CurTime()
		self.endTime = CurTime() + self.speed
		self.dtt = -1
		
		if (SERVER && self.Horde_Intestine) then
			if self.Tr.Entity:IsNPC() then
				self.Horde_Intestine:GetTable():SetEndPos( self.Tr.HitPos + self.Tr.Entity:OBBCenter() )
			else
				self.Horde_Intestine:GetTable():SetEndPos( self.Tr.HitPos )
			end
			
		end
		
		self:UpdateAttack()
		
		self.Weapon:EmitSound( sndPowerDown )
	else
		-- Play a sound
		self.Weapon:EmitSound( sndTooFar )
	end
end

function SWEP:UpdateAttack()
	if !self.Owner then return end
	if self.Owner:Horde_GetPerk("carcass_bio_thruster") then return end
	if !(self.Owner:Horde_GetPerk("carcass_grappendix")) then return end
	
	self.Owner:LagCompensation( true )
	
	if (!intestine_endpos) then
		intestine_endpos = self.Tr.HitPos
		if self.Tr.Entity:IsNPC() then
			intestine_endpos = intestine_endpos + self.Tr.Entity:OBBCenter()
		end
		if pull == true then
			target_pos = self.Owner:GetPos() + self.Owner:OBBCenter()
		else
			target_pos = self.Tr.HitPos
		end
	end
	
	if (SERVER && self.Horde_Intestine) then
		self.Horde_Intestine:GetTable():SetEndPos( intestine_endpos )
	end	
	
	if ( self.Tr.Entity:IsValid() ) then
		intestine_endpos = self.Tr.Entity:GetPos()
		if self.Tr.Entity:IsNPC() then
			intestine_endpos = intestine_endpos + self.Tr.Entity:OBBCenter()
		end
		if ( SERVER ) then
			self.Horde_Intestine:GetTable():SetEndPos( intestine_endpos )
			if pull == true then
				if !HORDE:IsEnemy(self.Tr.Entity) then
					return
				end
			end
		end
	end
	
	local vVel, Distance
	if pull == true then
		vVel = ((self.Owner:GetPos() + self.Owner:OBBCenter()) - self.Tr.Entity:GetPos())
		Distance = self.Tr.Entity:GetPos():Distance(self.Owner:GetPos()+ self.Owner:OBBCenter())
	else
		vVel = (intestine_endpos - self.Owner:GetPos())
		Distance = intestine_endpos:Distance(self.Owner:GetPos())
	end
	
	local et = (self.startTime + (Distance/self.speed))
	if(self.dtt != 0) then
		self.dtt = (et - CurTime()) / (et - self.startTime)
	end
	if(self.dtt < 0) then
		self.Weapon:EmitSound( sndPowerUp )
		self.dtt = 0
	end
	
	if(self.dtt == 0) then
		local zVel = self.Owner:GetVelocity().z
		vVel = vVel:GetNormalized()*(math.Clamp(Distance,0,7))
		if( SERVER ) then
		local gravity = GetConVarNumber("sv_gravity")
		vVel:Add(Vector(0,0,(gravity/100)*1.5)) -- Player speed. DO NOT MESS WITH THIS VALUE!
		if(zVel < 0) then
			vVel:Sub(Vector(0,0,zVel/100))
		end
		if pull == true then
			self.Tr.Entity:SetVelocity(vVel)
		else
			self.Owner:SetVelocity(vVel * 1.5)
		end
		end
	end
	
	intestine_endpos = nil

	if self.LastDrain <= CurTime() then
		self.Owner:SetHealth(self.Owner:Health() - self.Owner:GetMaxHealth() * 0.01)
		if self.Owner:Health() <= 0 then
			self.Owner:Kill()
			return
		end
		self.LastDrain = CurTime() + self.DrainInterval
	end
	
	self.Owner:LagCompensation( false )
	
end

function SWEP:EndAttack( shutdownsound )
	
	if ( CLIENT ) then return end
	if ( !self.Horde_Intestine ) then return end
	
	self.Horde_Intestine:Remove()
	self.Horde_Intestine = nil
	
end

function SWEP:Think()

	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	if ( idletime > 0 && CurTime() > idletime ) then

		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )

		self:UpdateNextIdle()

	end

	local meleetime = self:GetNextMeleeAttack()

	if ( meleetime > 0 && CurTime() > meleetime ) then

		self:DealDamage()

		self:SetNextMeleeAttack( 0 )

	end

	if SERVER and self.Charging == 1 and !self.Owner:KeyDown( IN_ATTACK ) then
        self:SetNextPrimaryFire( CurTime() + self.Delay )
        self.Charging = 0

		if self.ChargingTimer <= CurTime() then
			self:Punch(1)
		else
			self:Punch(0)
		end
    end
	
	if SERVER and self.Charging == 1 then
		self:SetNextPrimaryFire( CurTime() + self.Delay )
	end

	if SERVER and self.Charging == 1 and self.ChargingTimer <= CurTime() + 0.2 then
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "seq_admire" ) )
	end

	if ( SERVER && CurTime() > self:GetNextPrimaryFire() + 0.1 ) then

		self:SetCombo( 0 )

	end

	if ( self.Owner:KeyPressed( IN_ATTACK2 ) ) then
	
		self:StartAttack()
		
	elseif ( self.Owner:KeyDown( IN_ATTACK2 ) && inRange ) then
	
		self:UpdateAttack()
		
	elseif ( self.Owner:KeyReleased( IN_ATTACK2 ) && inRange ) then
	
		self:EndAttack( true )
	
	end

	if SERVER then
		local ply = self.Owner
		if ply.TwinHeartToggleOn and self.LastTransfer <= CurTime() then
			if ply.TwinHeartToggleOn == true then
				if ply.Horde_TwinHeartStack <= 0 then
					ply.TwinHeartToggleOn = false
					return
				end
				sound.Play("items/medshot4.wav", ply:GetPos())
				ply.Horde_TwinHeartStack = math.max(0, ply.Horde_TwinHeartStack - 1)
				ply:Horde_SyncStatus(HORDE.Status_Twin_Heart, ply.Horde_TwinHeartStack)
				local healinfo = HealInfo:New({amount = ply:GetMaxHealth() * 0.01, healer=self.Owner})
				local id = ply:SteamID()
				--timer.Remove("Horde_TwinHeartStacking" .. id)
				HORDE:OnPlayerHeal(ply, healinfo)
				self.LastTransfer = CurTime() + self.TransferInterval
			end
		end
	end
end