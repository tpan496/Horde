if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Katana"
SWEP.Author = "DrVrej"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.Category = "VJ Base"
SWEP.MadeForNPCsOnly = true -- Is this weapon meant to be for NPCs only?
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire = 1 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire = 0.5 -- How much time until the bullet/projectile is fired?
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel = "models/horde/weapons/c_katana.mdl"
SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-7, -15, 10)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand" -- The bone it will use as the main point (Owner's bone)
SWEP.WorldModel_Invisible = false -- Should the world model be invisible?
SWEP.WorldModel_NoShadow = false -- Should the world model have a shadow?
SWEP.HoldType = "melee"
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage = 40 -- Damage
SWEP.IsMeleeWeapon = true -- Should this weapon be a melee weapon?
SWEP.MeleeWeaponDistance = 85 -- If it's this close, it will attack
SWEP.MeleeWeaponSound_Hit = {"horde/weapons/katana/melee_katana_01.ogg",
"horde/weapons/katana/melee_katana_02.ogg",
"horde/weapons/katana/melee_katana_03.ogg"} -- Sound it plays when it hits something
SWEP.MeleeWeaponSound_Miss = {"weapons/iceaxe/iceaxe_swing1.wav"} -- Sound it plays when it misses (Doesn't hit anything)
SWEP.MeleeAttackDamageAngleRadius = 75

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
    local meleeHitEnt = false
    local owner = self:GetOwner()
		for _,v in ipairs(ents.FindInSphere(owner:GetPos(), self.MeleeWeaponDistance)) do
			if ((v:IsNPC() or (v:IsPlayer() && v:Alive())) && (owner:Disposition(v) != D_LI) && (v != owner) && (v:GetClass() != owner:GetClass()) or (v:GetClass() == "prop_physics") or v:GetClass() == "func_breakable_surf" or v:GetClass() == "func_breakable" && (owner:GetForward():Dot((v:GetPos() -owner:GetPos()):GetNormalized()) > math.cos(math.rad(owner.MeleeAttackDamageAngleRadius)))) then
                local dmginfo = DamageInfo()
				dmginfo:SetDamage(self.Primary.Damage)
				if v:IsNPC() or v:IsPlayer() then dmginfo:SetDamageForce(owner:GetForward() * ((dmginfo:GetDamage() + 100) * 70)) end
				dmginfo:SetInflictor(owner)
				dmginfo:SetAttacker(owner)
				dmginfo:SetDamageType(DMG_SLASH)
				v:TakeDamageInfo(dmginfo, owner)
				if v:IsPlayer() then
					v:ViewPunch(Angle(math.random(-1, 1)*10, math.random(-1, 1)*10, math.random(-1, 1)*10))
                    v:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, 30, owner)
                end
				VJ_DestroyCombineTurret(owner, v)
				self:CustomOnPrimaryAttack_MeleeHit(v)
				meleeHitEnt = true
			end
		end
		if meleeHitEnt == true then
			local meleeSd = VJ_PICK(self.MeleeWeaponSound_Hit)
			if meleeSd != false then
				self:EmitSound(meleeSd, 100, math.random(90, 100))
			end
		else
			if owner.IsVJBaseSNPC == true then owner:CustomOnMeleeAttack_Miss() end
			local meleeSd = VJ_PICK(self.MeleeWeaponSound_Miss)
			if meleeSd != false then
				self:EmitSound(meleeSd, 100, math.random(90, 100))
			end
		end
    return true
end