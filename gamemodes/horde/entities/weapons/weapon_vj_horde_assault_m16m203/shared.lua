SWEP.Base 				= "weapon_vj_base"
SWEP.PrintName			= "M16A4"
SWEP.Author 			= "func_brush"
SWEP.Contact			= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose			= "This weapon is made for Players and NPCs"
SWEP.Instructions		= "Controls are like a regular weapon."
SWEP.Category			= "Horde"
SWEP.MadeForNPCsOnly	= true
SWEP.HoldType 			= "smg"

SWEP.WorldModel						= "models/weapons/w_rif_m4a1.mdl"

SWEP.NPC_NextPrimaryFire 			= 0.064*6
SWEP.NPC_TimeUntilFire 				= 1
SWEP.NPC_TimeUntilFireExtraTimers	= {0.064, 0.064*2, 0.064*3}

SWEP.NPC_HasReloadSound	= false

SWEP.NPC_HasSecondaryFire 		= true
SWEP.NPC_SecondaryFireEnt 		= "horde_projectile_he_round"
SWEP.NPC_SecondaryFireChance	= 1
SWEP.NPC_SecondaryFireNext 		= VJ_Set(5, 5)
SWEP.NPC_SecondaryFireSound 	= {")weapons/fesiugmw2/fire/m203.wav"}

SWEP.HasDryFireSound = false

SWEP.Primary.Damage		= 40
SWEP.Primary.Force		= 5
SWEP.Primary.ClipSize	= 30
SWEP.Primary.Ammo		= "SMG1"

SWEP.Primary.Sound				= {")weapons/fesiugmw2/fire/m4.wav"}

SWEP.PrimaryEffects_MuzzleParticles 	= {"muzzleflash_4"}
SWEP.PrimaryEffects_MuzzleAttachment 	= 1
SWEP.PrimaryEffects_ShellAttachment 	= 2
SWEP.PrimaryEffects_ShellType 			= "VJ_Weapon_RifleShell1"
SWEP.PrimaryEffects_SpawnDynamicLight 	= false

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

-- All related settings can be found here: https://github.com/DrVrej/VJ-Base/blob/v2.16.0/lua/weapons/weapon_vj_base/shared.lua