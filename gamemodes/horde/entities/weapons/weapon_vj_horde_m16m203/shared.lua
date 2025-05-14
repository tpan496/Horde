---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "M16A4"
SWEP.Author 					= "func_brush"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 				= true -- Is this weapon meant to be for NPCs only?
SWEP.NPC_TimeUntilFire 				= 1
SWEP.NPC_TimeUntilFireExtraTimers 	= {0.064, 0.064*2, 0.064*3}
SWEP.NPC_NextPrimaryFire 			= 0.064*6
SWEP.WorldModel						= "models/weapons/w_rif_m4a1.mdl"
SWEP.HoldType 						= "smg"
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 40 -- Damage
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.ClipSize			= 30 -- Max amount of bullets per clip
SWEP.Primary.Ammo				= "smg1" -- Ammo type
SWEP.Primary.TakeAmmo = 0
SWEP.Primary.Sound				= {")weapons/fesiugmw2/fire/m4.wav"}
SWEP.PrimaryEffects_MuzzleParticles = {"muzzleflash_4"}
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = 2
SWEP.PrimaryEffects_ShellType = "VJ_Weapon_RifleShell1"

SWEP.NPC_HasSecondaryFire = true
SWEP.NPC_SecondaryFireSound = {")weapons/fesiugmw2/fire/m203.wav"}
SWEP.NPC_SecondaryFireChance = 1
SWEP.NPC_SecondaryFireNext = VJ_Set(5, 5)

function SWEP:CustomOnSecondaryAttack()
	local owner = self:GetOwner()
	local proj = ents.Create(self.NPC_SecondaryFireEnt)
	proj:SetPos(owner:GetShootPos())
	proj:SetAngles(owner:GetAimVector():Angle())
	proj:SetOwner(owner)
	proj:Spawn()
	proj:Activate()
	local phys = proj:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:SetVelocity(owner:GetAimVector() * 2000)
	end
	return true
end
