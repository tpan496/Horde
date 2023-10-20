AddCSLuaFile()

SWEP.PrintName = "Horde Medkit"
SWEP.Author = "robotboy655 & MaxOfS2D"
SWEP.Purpose = "Heal people with your primary attack, or yourself with the secondary."
SWEP.Category = "ArcCW - Horde" -- edit this if you like

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HealAmount = 20 -- Maximum heal amount per use
SWEP.MaxAmmo = 100 -- Maxumum ammo

local HealSound = Sound( "HealthKit.Touch" )
local DenySound = Sound( "WallHealth.Deny" )
function SWEP:Initialize()

	self:SetHoldType( "slam" )

	if ( CLIENT ) then return end

	timer.Create( "medkit_ammo" .. self:EntIndex(), 1, 0, function()
		if ( self:Clip1() < self.MaxAmmo ) then self:SetClip1( math.min( self:Clip1() + 2, self.MaxAmmo ) ) end
	end )

end


function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

	if ( self:GetOwner():IsPlayer() ) then
		self:GetOwner():LagCompensation( true )
	end

	local tr = util.TraceLine( {
		start = self:GetOwner():GetShootPos(),
		endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 100,
		filter = self:GetOwner()
	} )

	if ( self:GetOwner():IsPlayer() ) then
		self:GetOwner():LagCompensation( false )
	end

	local ent = tr.Entity

	if not ent:IsValid() then self:HealFail(ent) return end

	local maxhealth,health = ent:GetMaxHealth(),ent:Health()

	if self:GetOwner():Horde_GetPerk("medic_painkillers") then
		maxhealth = maxhealth*1.20
	end

	if health >= maxhealth then self:HealFail(ent) return end

	local need = self.HealAmount
	
	if need > 0 then
		need = math.min(maxhealth - health,need)
	end

	if ( self:Clip1() >= need && need > 0 && ( ent:IsPlayer() or ent:GetClass() == "npc_vj_horde_antlion")) then

		self:TakePrimaryAmmo( need )

        local healinfo = HealInfo:New({amount=need, healer=self:GetOwner()})
		if ent:IsPlayer() then
			HORDE:OnPlayerHeal(ent, healinfo)
		else
            HORDE:OnAntlionHeal(ent, healinfo)
		end
		self:HealSuccess(ent)
	else
		self:HealFail(ent)
	end

end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then return end

	local ent = self:GetOwner()

	local maxhealth,health = ent:GetMaxHealth(),ent:Health()

	if self:GetOwner():Horde_GetPerk("medic_painkillers") then
		maxhealth = maxhealth*1.20
	end

	if health >= maxhealth then self:HealFail(ent) return end

	local need = self.HealAmount

	if need > 0 then
	need = math.min(maxhealth - health,need)
	end

	if ( IsValid( ent ) && self:Clip1() >= need) then

		self:TakePrimaryAmmo( need )

        local healinfo = HealInfo:New({amount=need, healer=self:GetOwner()})

		HORDE:OnPlayerHeal(ent, healinfo)

		self:HealSuccess(ent)
	else
		self:HealFail(ent)
	end

end

function SWEP:HealSuccess(ent)

	self:GetOwner():EmitSound( HealSound )

	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	local endtime = CurTime() + self:SequenceDuration()
	endtime = endtime + 0.5
	self:SetNextPrimaryFire( endtime )
	self:SetNextSecondaryFire( endtime )
	self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
	
	timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 1, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

end

function SWEP:HealFail(ent)

	self:GetOwner():EmitSound( DenySound )

	local endtime = CurTime() + 1
	self:SetNextPrimaryFire( endtime )
	self:SetNextSecondaryFire( endtime )
end

function SWEP:OnRemove()

	timer.Stop( "medkit_ammo" .. self:EntIndex() )
	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

	return true

end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay

end