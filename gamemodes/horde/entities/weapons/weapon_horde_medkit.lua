
AddCSLuaFile()

SWEP.PrintName = "Medkit"
SWEP.Author = "robotboy655, MaxOfS2D, code_gs"
SWEP.Purpose = "Heal other people with primary attack, heal yourself with secondary attack, revive players with reload."

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.HoldType = "slam"

SWEP.HealSound = Sound( "HealthKit.Touch" )
SWEP.DenySound = Sound( "WallHealth.Deny" )

SWEP.HealCooldown = 0.5 -- Time between successful heals
SWEP.DenyCooldown = 0.5 -- Time between unsuccessful heals

SWEP.HealAmount = 20 -- Maximum heal amount per use
SWEP.HealRange = 64 -- Range in units at which healing works

SWEP.AmmoRegenRate = 0.25 -- Number of seconds before each ammo regen
SWEP.AmmoRegenAmount = 1 -- Amount of ammo refilled every AmmoRegenRate seconds

SWEP.DeathSyncTime = 0.5 -- Time to wait before syncing dead players
SWEP.NextDeathSync = 0
SWEP.DeadPlayers = {}
SWEP.ReviveProgress = 0
SWEP.ReviveRange = 75
SWEP.ReviveSpeed = 20 -- Amount of progress per second

if SERVER then
	util.AddNetworkString( "horde_medkit_deadplayers" )
end

function SWEP:Initialize()

	self:SetHoldType( self.HoldType )

	-- Prevent large ammo jumps on-creation
	-- if DefaultClip < ClipSize
	self:SetLastAmmoRegen( CurTime() )

	if ( CLIENT ) then
		self.AmmoDisplay = {
			Draw = true,
			PrimaryClip = 0
		}
	end

end

function SWEP:Deploy()

	-- Regen what we've gained since we've holstered
	-- and realign the timer
	self:Regen( false )

	return true

end

function SWEP:SetupDataTables()

	self:NetworkVar( "Float", 0, "LastAmmoRegen" )
	self:NetworkVar( "Float", 1, "NextIdle" )

end

function SWEP:PrimaryAttack()
	if self:GetOwner():KeyDown( IN_RELOAD ) then return end

	local owner = self:GetOwner()
	local dolagcomp = SERVER and owner:IsPlayer()

	if ( dolagcomp ) then
		owner:LagCompensation( true )
	end

	local startpos = owner:GetShootPos()
	local tr = util.TraceLine( {
		start = startpos,
		endpos = startpos + owner:GetAimVector() * self.HealRange,
		filter = owner
	} )

	if ( dolagcomp ) then
		owner:LagCompensation( false )
	end

	self:DoHeal( tr.Entity )

end

function SWEP:SecondaryAttack()
	if self:GetOwner():KeyDown( IN_RELOAD ) then return end

	self:DoHeal( self:GetOwner() )

end

function SWEP:Reload()
	if not IsFirstTimePredicted() then return end

	-- Loop over dead players and find the closest one
	local closestPlayer = nil
	local closestPos = nil
	local closestDistance = math.huge
	for ply, pos in pairs( self.DeadPlayers ) do
		if not IsValid( ply ) then continue end
		if ply:Alive() then continue end

		local distance = pos:Distance( self:GetOwner():GetPos() )
		if distance < closestDistance then
			closestDistance = distance
			closestPlayer = ply
			closestPos = pos
		end
	end

	if not closestPlayer or closestDistance > self.ReviveRange then
		self.RevivingPlayer = nil
		self.ReviveProgress = 0
		self.RevivingPos = nil
		return
	end

	if self.RevivingPlayer == closestPlayer then
		if self.ReviveProgress >= 100 then
			if SERVER then
				self:RevivePlayer( self.RevivingPlayer )
			else
				self.DeadPlayers[self.RevivingPlayer] = nil
			end

			self.RevivingPlayer = nil
			self.ReviveProgress = 0
			self.RevivingPos = nil
			return
		end

		self.ReviveProgress = self.ReviveProgress + self.ReviveSpeed * ( CurTime() - self.LastReviveTime )
		self.LastReviveTime = CurTime()
		return
	end

	self.ReviveProgress = 0
	self.RevivingPlayer = closestPlayer
	self.RevivingPos = closestPos
	self.LastReviveTime = CurTime()
end

local DAMAGE_YES = 2

-- Basic black/whitelist function
-- Checking if the entity's health is below its max is done in SWEP:DoHeal
function SWEP:CanHeal( ent )

	-- ent may be NULL here, but these functions return false for it
	if ( ent:IsPlayer() or ent:IsNPC() ) then
		local takedamage = ent:GetInternalVariable( "m_takedamage" )

		-- Don't heal turrets and helicopters
		return takedamage == nil or takedamage == DAMAGE_YES
	end

	return false

end

function SWEP:DoHeal( ent )
	if ( !self:CanHeal( ent ) ) then self:HealFail( ent ) return false end

	local health, maxhealth = ent:Health(), ent:GetMaxHealth()
	if self:GetOwner():Horde_GetPerk( "medic_painkillers" ) then
		maxhealth = maxhealth * 1.20
	end

	if ( health >= maxhealth ) then self:HealFail( ent ) return false end

	-- Check regen right before we access the clip
	-- to make sure we're up to date
	self:Regen( true )

	local healamount = self.HealAmount

	-- No support for "damage kits"
	if ( healamount > 0 ) then
		healamount = math.min( maxhealth - health, healamount )
		local ammo = self:Clip1()
		if ( ammo < healamount ) then self:HealFail( ent ) return false end

		-- Heal ent
		self:SetClip1( ammo - healamount )
		if SERVER then
			if ent:IsPlayer() then
				local healinfo = HealInfo:New( { amount = healamount, healer = self:GetOwner() } )
				HORDE:OnPlayerHeal( ent, healinfo )
			else
				ent:SetHealth( health + healamount )
			end
		end
	else
		healamount = 0
	end

	self:HealSuccess( ent, healamount )

	return true

end

function SWEP:HealSuccess( ent, healamount )

	-- Do effects
	self:EmitSound( self.HealSound )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

	local owner = self:GetOwner()

	if ( owner:IsValid() ) then
		owner:SetAnimation( PLAYER_ATTACK1 )
	end

	local curtime = CurTime()

	-- Reset regen time
	self:SetLastAmmoRegen( curtime )

	-- Set next idle time
	local endtime = curtime + self:SequenceDuration()
	self:SetNextIdle( endtime )

	-- Set next firing time
	endtime = endtime + self.HealCooldown
	self:SetNextPrimaryFire( endtime )
	self:SetNextSecondaryFire( endtime )

end

function SWEP:HealFail( ent )

	-- Do effects
	self:EmitSound( self.DenySound )

	-- Setup next firing time
	local endtime = CurTime() + self.DenyCooldown
	self:SetNextPrimaryFire( endtime )
	self:SetNextSecondaryFire( endtime )

end

function SWEP:Think()

	-- Try ammo regen
	-- but keep it aligned to the last action time
	self:Regen( true )

	-- Do idle anim
	self:Idle()

	if SERVER and self.NextDeathSync < CurTime() then
		self.NextDeathSync = CurTime() + self.DeathSyncTime

		local deadPlayers = {}
		for _, ply in pairs( player.GetAll() ) do
			if not ply:Alive() and ply.Medkit_DeathPos then
				deadPlayers[ply] = ply.Medkit_DeathPos
			end
		end

		self.DeadPlayers = deadPlayers

		net.Start( "horde_medkit_deadplayers" )
		net.WriteEntity( self )
		net.WriteUInt( table.Count( deadPlayers ), 8 )
		for ply, pos in pairs( deadPlayers ) do
			net.WriteEntity( ply )
			net.WriteVector( pos )
		end
		net.Send( self:GetOwner() )
	end

	if not self:GetOwner():KeyDown( IN_RELOAD ) then
		self.RevivingPlayer = nil
		self.ReviveProgress = 0
		self.RevivingPos = nil
	end
end

if CLIENT then
	net.Receive( "horde_medkit_deadplayers", function()
		local medkit = net.ReadEntity()
		if not IsValid( medkit ) then return end

		local deadPlayers = {}
		local num = net.ReadUInt( 8 )
		for _ = 1, num do
			deadPlayers[net.ReadEntity()] = net.ReadVector()
		end

		medkit.DeadPlayers = deadPlayers
	end )

	-- Draw the dead players and revive progerss bar
	function SWEP:DrawHUD()

		for ply, pos in pairs( self.DeadPlayers ) do
			if not IsValid( ply ) then continue end

			surface.SetDrawColor( 255, 0, 0, 255 )
			local drawPos = pos + Vector( 0, 0, 40 )
			local screenpos = drawPos:ToScreen()

			-- Holy cross
			surface.DrawLine( screenpos.x - 30, screenpos.y, screenpos.x + 30, screenpos.y )
			surface.DrawLine( screenpos.x - 30, screenpos.y + 1, screenpos.x + 30, screenpos.y + 1 )
			surface.DrawLine( screenpos.x - 30, screenpos.y + 2, screenpos.x + 30, screenpos.y + 2 )

			surface.DrawLine( screenpos.x, screenpos.y - 30, screenpos.x, screenpos.y + 80 )
			surface.DrawLine( screenpos.x - 1, screenpos.y - 30, screenpos.x, screenpos.y + 80 )
			surface.DrawLine( screenpos.x + 1, screenpos.y - 30, screenpos.x, screenpos.y + 80 )

			-- Draw player name
			draw.SimpleTextOutlined( ply:GetName(), "ChatFont", screenpos.x, screenpos.y + 90, Color( 255, 0, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black )

			local isCloseEnough = pos:Distance( self:GetOwner():GetPos() ) <= self.ReviveRange
			if isCloseEnough then
				draw.SimpleTextOutlined( "Hold R to revive", "ChatFont", screenpos.x, screenpos.y + 115, Color( 0, 255, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black )

				-- Draw revive progress bar
				if IsValid( self.RevivingPlayer ) and self.ReviveProgress > 0 then
					local barWidth = 200
					local barHeight = 20
					local barX = screenpos.x - barWidth / 2
					local barY = screenpos.y + 130

					surface.SetDrawColor( 100, 100, 100, 255 )
					surface.DrawRect( barX, barY, barWidth, barHeight )

					surface.SetDrawColor( 0, 255, 0, 255 )
					surface.DrawRect( barX, barY, ( self.ReviveProgress / 100 ) * barWidth, barHeight )
				end
			else
				draw.SimpleTextOutlined( "Too far to revive", "ChatFont", screenpos.x, screenpos.y + 115, Color( 255, 0, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
			end
		end
	end
end

if SERVER then
	hook.Add( "PlayerDeath", "HordeMedkitRevive", function( ply )
		ply.Medkit_DeathPos = ply:GetPos()
	end )

	function SWEP:RevivePlayer( ply )
		if not ply.Medkit_DeathPos then return end

		ply.Medit_Respawning = true
		ply:Spawn()
		ply:SetPos( ply.Medkit_DeathPos )
		ply.Medkit_DeathPos = nil
		ply.Medit_Respawning = false

		ply:EmitSound( "ambient/levels/labs/electric_explosion1.wav" )

		local owner = self:GetOwner()
		owner:Horde_AddMoney( 50 )
		owner:Horde_SyncEconomy()
	end

	hook.Add( "Horde_OnPlayerShouldRespawnDuringWave", "HordeMedkitRevive", function( ply )
		if ply.Medit_Respawning then
			return true
		end
	end )
end

function SWEP:Regen( keepaligned )

	local curtime = CurTime()
	local lastregen = self:GetLastAmmoRegen()
	local timepassed = curtime - lastregen
	local regenrate = self.AmmoRegenRate

	-- Not ready to regenerate
	if ( timepassed < regenrate ) then return false end

	local ammo = self:Clip1()
	local maxammo = self.Primary.ClipSize

	-- Already at/over max ammo
	if ( ammo >= maxammo ) then return false end

	if ( regenrate > 0 ) then
		self:SetClip1( math.min( ammo + math.floor( timepassed / regenrate ) * self.AmmoRegenAmount, maxammo ) )

		-- If we are setting the last regen time from the Think function,
		-- keep it aligned with the last action time to prevent late Thinks from
		-- creating hiccups in the rate
		self:SetLastAmmoRegen( keepaligned == true and curtime + timepassed % regenrate or curtime )
	else
		self:SetClip1( maxammo )
		self:SetLastAmmoRegen( curtime )
	end

	return true

end

function SWEP:Idle()

	-- Update idle anim
	local curtime = CurTime()

	if ( curtime < self:GetNextIdle() ) then return false end

	self:SendWeaponAnim( ACT_VM_IDLE )
	self:SetNextIdle( curtime + self:SequenceDuration() )

	return true

end

-- The following code does not need to exist on the server, so bail
if ( SERVER ) then return end

function SWEP:CustomAmmoDisplay()

	local display = self.AmmoDisplay
	display.PrimaryClip = self:Clip1()

	return display

end
