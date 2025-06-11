if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_nade_knife")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    --killicon.Add("arccw_horde_throwing_knife", "arccw/weaponicons/arccw_go_nade_knife", Color(0, 0, 0, 255))
    killicon.Add("arccw_horde_thr_knife", "arccw/weaponicons/arccw_go_nade_knife", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base_nade"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Pistols" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Throwing Knife"
SWEP.Trivia_Class = "Knife"
SWEP.Trivia_Desc = "Skeletonized knife intended for throwing. It's all in the wrist."
SWEP.Trivia_Manufacturer = "Cold Steel"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Sharp Edge"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 2004

SWEP.Slot = 3

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

SWEP.Primary.ClipSize = -1
SWEP.BottomlessClip = true
SWEP.KeepIfEmpty = true

SWEP.MuzzleVelocity = 10000
SWEP.ShootEntity = "arccw_horde_thr_knife"

SWEP.Primary.Ammo = "horde_arccw_knives"

SWEP.ShootWhileSprint = true
SWEP.Secondary.Automatic = true

SWEP.SpeedMult = 1

SWEP.TTTWeaponType = "weapon_ttt_confgrenade"
SWEP.NPCWeaponType = "weapon_grenade"
SWEP.NPCWeight = 25

SWEP.Delay = 0.5
SWEP.PullPinTime = 0.1

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetCrouch = nil
SWEP.BarrelOffsetHip = Vector(0, 0, 0)

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
}

function SWEP:CustomInitialize()
    timer.Simple(0, function ()
        self.Primary.Ammo = "horde_arccw_knives"
    end)
end

function SWEP:Hook_Think()
    --if SERVER then return end
    local ply = self:GetOwner()
    if !ply:HasWeapon("arccw_horde_kunai") then return end
    if not self.Is_In_Rapid_Throw then return end
    
    if self.Anim1 and self.PlayThrowAnim_Curtime <= CurTime() then
        self:PlayAnimation("pre_throw", mult, pred, startfrom, tt, skipholster, true, absolute)
        self.Anim1 = nil
        self.Anim2 = true
        self.Anim3 = nil
    elseif self.Anim2 and self.PlayThrowAnim_Curtime + 0.2 <= CurTime() then
        self:PlayAnimation("throw", mult, pred, startfrom, tt, skipholster, true, absolute)
        self:FireRocket("arccw_horde_thr_knife", 1000, ply:EyeAngles(), true)
        ply:SetAmmo(ply:GetAmmoCount(self.Primary.Ammo) - 1, self.Primary.Ammo)
        --self.PlayThrowAnim_Curtime = CurTime()
        self.Anim1 = nil
        self.Anim2 = nil
        self.Anim3 = true
    elseif self.Anim3 and self.PlayThrowAnim_Curtime + 0.3 <= CurTime() then
        self:PlayAnimation("draw", 0.5, pred, startfrom, tt, skipholster, true, absolute)
        self.Is_In_Rapid_Throw = nil
        self.Anim1 = nil
        self.Anim2 = nil
        self.Anim3 = nil
    end
end

function SWEP:SecondaryAttack()
    if self:GetNextPrimaryFire() > CurTime() then return end
    if self:GetNextSecondaryFire() > CurTime() then return end
    local ply = self:GetOwner()
    
    if ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end
    --print(ply:GetWeapon("arccw_horde_kunai").Primary.Ammo)
    self.Is_In_Rapid_Throw = true
    self.Anim1 = true
    self.PlayThrowAnim_Curtime = CurTime()
    
    self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
    self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
end