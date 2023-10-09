SWEP.PrintName = "SLAM (Horde)"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Ammo = "slam"
--SWEP.Primary.MaxAmmo = 9
SWEP.Primary.Delay = 1.25
SWEP.Primary.Automatic = false
SWEP.Primary.DefaultClip = 1
SWEP.Primary.ClipSize = -1

SWEP.HoldType = "slam"
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel	= "models/weapons/w_slam.mdl"
SWEP.UseHands			    = true
SWEP.ViewModelFOV      		= 50
SWEP.Slot                   = 1

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		    = "none"
SWEP.Secondary.Delay = 0.5

-- Sounds
local SatchelSound = Sound("weapons/slam/throw.wav")
local TripmineSound = Sound("weapons/slam/mine_mode.wav")
local DetonatorSound = Sound("weapons/slam/buttonclick.wav")

local NONE, SATCHEL, TRIPMINE = 0, 1, 2 -- the three possible animation states of the SLAM

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "ActiveSatchel")
end

function SWEP:Initialize()
	self.State = NONE
	self:SetActiveSatchel(0)
end

function SWEP:PrimaryAttack()
	if (self.Owner:GetAmmoCount("slam") > 0 and self:GetNextPrimaryFire() <= CurTime()) then
		if not self.Owner.Horde_Slams then
			self.Owner.Horde_Slams = HORDE.Queue:Create()
		end
		
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        --self.Owner:SetAmmo(math.min(10, self.Owner:GetAmmoCount("slam")), "slam")
		if self.Owner.Horde_Slams:size() >= 4 then
			local s = self.Owner.Horde_Slams:pop()
			while !IsValid(s) and self.Owner.Horde_Slams:size() > 0 do
				s = self.Owner.Horde_Slams:pop()
			end
			if IsValid(s) then
				s:Remove()
			end
		end
		self:StickTripmine()
	end
end

function SWEP:ThrowSatchel()
	local owner = self:GetOwner()
	if (SERVER and IsValid(owner)) then
		local slam = ents.Create("npc_satchel_horde")
		if (IsValid(slam)) then
			if (self:GetActiveSatchel() > 0) then
				self:AnimateAttack(ACT_SLAM_THROW_THROW, ACT_SLAM_THROW_THROW2, SatchelSound, 1)
			else
				self:AnimateAttack(ACT_SLAM_THROW_THROW_ND, ACT_SLAM_THROW_THROW_ND2, SatchelSound, 1)
			end

			timer.Simple(0.5, function()
                if !IsValid(owner) then return end
                local src = owner:GetShootPos()
                local ang = owner:GetAimVector()
                local throw = ang * 200
                slam:SetPos(src + ang * 10)
                slam.HordeOwner = owner
                slam:Spawn()

				owner.Horde_Slams:push(slam)

                local phys = slam:GetPhysicsObject()
                if (IsValid(phys)) then
                    phys:SetVelocity(throw)
                end
            end)
		end
		owner:SetAnimation(PLAYER_ATTACK1)
	end
end

function SWEP:StickTripmine()
	local owner = self:GetOwner()
	if (SERVER and IsValid(owner)) then
		local ignore = {owner, self}
		local spos = owner:GetShootPos()
		local epos = spos + owner:GetAimVector() * 42

		local tr = util.TraceLine({ start = spos, endpos = epos, filter = ignore, mask = MASK_SOLID })
		if (tr.HitWorld) then
			local slam = ents.Create("npc_tripmine_horde")
			if (IsValid(slam)) then
				local tr_ent = util.TraceEntity({ start = spos, endpos = epos, filter = ignore, mask = MASK_SOLID }, slam)
				if (tr_ent.HitWorld) then
					if (self:GetActiveSatchel() > 0) then
						self:AnimateAttack(ACT_SLAM_STICKWALL_ATTACH, ACT_SLAM_STICKWALL_ATTACH2, TripmineSound, 0)
					else
						self:AnimateAttack(ACT_SLAM_TRIPMINE_ATTACH, ACT_SLAM_TRIPMINE_ATTACH2, TripmineSound, 0)
					end

					local ang = tr_ent.HitNormal:Angle()
					ang.p = ang.p + 90

					slam:SetPos(tr_ent.HitPos + (tr_ent.HitNormal * 3))
					slam:SetAngles(ang)
                    slam.HordeOwner = owner
					slam:Spawn()

					owner.Horde_Slams:push(slam)
				end
			end
            owner:SetAnimation(PLAYER_ATTACK1)
        else
            self:ThrowSatchel()
		end
	end
end

function SWEP:AnimateAttack(animation1, animation2, sound, newSatchel)
	self:SendWeaponAnim(animation1)
	local holdup = self:GetOwner():GetViewModel():SequenceDuration()

	timer.Simple(holdup * 0.6, function()
		if (IsValid(self)) then
			self:EmitSound(sound)
		end
	end)
	timer.Simple(holdup, function()
		if (IsValid(self)) then
			self:SendWeaponAnim(animation2)
		end
	end)
	timer.Simple(holdup + 0.1, function()
		if (IsValid(self)) then
			self:TakePrimaryAmmo(1)
			self:ChangeActiveSatchel(newSatchel)
		end
	end)
end

function SWEP:ChangeActiveSatchel(amount)
	if (IsValid(self)) then
		self:SetActiveSatchel(self:GetActiveSatchel() + amount)
		self:Deploy()
	end
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	if (SERVER and self:GetActiveSatchel() > 0 and self:GetNextSecondaryFire() <= CurTime() and IsValid(owner)) then
		self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
		if (self.State == SATCHEL) then
			self:SendWeaponAnim(ACT_SLAM_THROW_DETONATE)
		elseif (self.State == TRIPMINE) then
			self:SendWeaponAnim(ACT_SLAM_STICKWALL_DETONATE)
		else
			self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)
		end
		self:EmitSound(DetonatorSound)

		for _, slam in pairs(ents.FindByClass("npc_satchel_horde")) do
			if (slam.HordeOwner == self.Owner) then
				slam:Detonate()
			end
		end

		self:Deploy()
	end
end

function SWEP:CanAttachSLAM()
	local result = false

	if (IsValid(self)) then
		local owner = self:GetOwner()

		if (IsValid(owner)) then
			local ignore = {owner, self}
			local spos = owner:GetShootPos()
			local epos = spos + owner:GetAimVector() * 42
			local tr = util.TraceLine({start = spos, endpos = epos, filter = ignore, mask = MASK_SOLID})

			result = tr.HitWorld
		end
	end

	return result
end

function SWEP:ChangeAnimation()
	-- just change the animation, when the weapon is currently active
	if (IsValid(self:GetOwner()) and self:GetOwner():GetActiveWeapon() == self) then
		if (self:CanAttachSLAM()) then
			if (self.State == SATCHEL) then
				if (self:GetActiveSatchel() > 0) then
					self:SendWeaponAnim(ACT_SLAM_THROW_TO_STICKWALL)
				else
					self:SendWeaponAnim(ACT_SLAM_THROW_TO_TRIPMINE_ND)
				end
				self.State = TRIPMINE
			elseif (self.State == NONE) then
				if (self:GetActiveSatchel() > 0) then
					self:SendWeaponAnim(ACT_SLAM_DETONATOR_THROW_DRAW)
					self.State = SATCHEL
				else
					self:SendWeaponAnim(ACT_SLAM_TRIPMINE_DRAW)
					self.State = TRIPMINE
				end
			end
		elseif self.Owner:GetAmmoCount("slam") > 0 then
			if (self.State == TRIPMINE) then
				if (self:GetActiveSatchel() > 0) then
					self:SendWeaponAnim(ACT_SLAM_STICKWALL_TO_THROW)
				else
					self:SendWeaponAnim(ACT_SLAM_STICKWALL_TO_THROW_ND)
				end
			elseif (self.State == NONE) then
				if (self:GetActiveSatchel() > 0) then
					self:SendWeaponAnim(ACT_SLAM_DETONATOR_THROW_DRAW)
				else
					self:SendWeaponAnim(ACT_SLAM_THROW_ND_DRAW)
				end
			end
			self.State = SATCHEL
		else
		--	self:SendWeaponAnim(ACT_SLAM_DETONATOR_DRAW)
		end
	end
end

function SWEP:Deploy()
    self.State = NONE
    self:ChangeAnimation()
	return true
end

-- Reload does nothing
function SWEP:Reload()
end
