if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_nade_knife")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_throwing_knife", "arccw/weaponicons/arccw_go_nade_knife", Color(0, 0, 0, 255))
    killicon.Add("arccw_horde_thr_knife", "arccw/weaponicons/arccw_go_nade_knife", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base_nade"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Kunai"
SWEP.Trivia_Class = "Knife"
SWEP.Trivia_Desc = "Skeletonized knife intended for throwing. It's all in the wrist."
SWEP.Trivia_Manufacturer = "Cold Steel"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Sharp Edge"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 2004

SWEP.Slot = 4

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_eq_throwingknife.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/w_eq_throwingknife_thrown.mdl"
SWEP.ViewModelFOV = 60

SWEP.WorldModelOffset = {
    pos = Vector(3, 2, -1),
    ang = Angle(-10, 0, 180)
}

SWEP.FuseTime = false

SWEP.Throwing = true

SWEP.Primary.ClipSize = 1

SWEP.MuzzleVelocity = 10000
--SWEP.ShootEntity = "arccw_horde_thr_knife"

SWEP.Primary.Ammo = "GrenadeHL1"

SWEP.TTTWeaponType = "weapon_ttt_confgrenade"
SWEP.NPCWeaponType = "weapon_grenade"
SWEP.NPCWeight = 25

SWEP.PullPinTime = 0

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetCrouch = nil
SWEP.BarrelOffsetHip = Vector(0, 0, 0)

SWEP.PrimaryBash = true
SWEP.CanBash = true

SWEP.MeleeDamage = 45
SWEP.Melee2Damage = 45

SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 60
SWEP.MeleeAttackTime = 0.2
SWEP.MeleeTime = 0.65
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 80
SWEP.Melee2AttackTime = 0.5
SWEP.Melee2Time = 1.25
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.Animations = {
    ["draw"] = {
        Source = "deploy",
        SoundTable = {
            {
                s = "arccw_go/knife/knife_deploy1.wav",
                t = 0
            }
        }
    },
    ["pre_throw"] = {
        Source = "swing_build",
        Time = 0.1
    },
    ["throw"] = {
        Source = "swing_throw",
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE,
        Time = 0.1,
        SoundTable = {
            {
                s = "arccw_go/knife/knife_slash1.wav",
                t = 0
            }
        }
    },
    ["bash"] = {
        Source = {"swing_misscenter", "swing_hitcenter"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = "swing_throw",
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE,
        Time = 0.15,
        SoundTable = {
            {
                s = "arccw_go/knife/knife_slash1.wav",
                t = 0
            }
        }
    },
    ["idle"] = false,
}

function SWEP:GetPrimaryAmmoType()
    return "GrenadeHL1"
end

function SWEP:SecondaryAttack()
    if self:GetNextSecondaryFire() > CurTime() then return end
    local ply = self:GetOwner()
    if ply:GetAmmoCount("GrenadeHL1") <= 0 then return end
    self:FireRocket("arccw_horde_thr_knife", 4000, ply:EyeAngles())
    ply:SetAmmo(ply:GetAmmoCount("GrenadeHL1")-1, "GrenadeHL1")
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
    local anim = self:SelectAnimation("bash2")
    self:PlayAnimation( anim )
    timer.Simple(0.15, function ()
        if self:IsValid() then
            self:PlayAnimation("draw")
        end
    end)
end