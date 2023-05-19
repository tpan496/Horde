if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_gau")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_gau", "vgui/hud/arccw_horde_gau", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "GAU-19"
SWEP.Trivia_Class = "Heavy Machine Gun"
SWEP.Trivia_Desc = "Three-barrel rotary heavy machine gun."

if CLIENT then
SWEP.Trivia_Manufacturer = "General Dynamics"
SWEP.Trivia_Calibre = "12.7x99mm NATO"
SWEP.Trivia_Mechanism = "Electric"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = 1982
end

SWEP.Slot = 4

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_gau.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModel = "models/horde/weapons/w_gau.mdl"
SWEP.WorldModelOffset = {
    pos = Vector(0, 5, -35),
    ang = Angle(0, 0, 0),
    scale = 1,
}
SWEP.ViewModelFOV = 65

SWEP.DefaultBodygroups = "100000"

SWEP.Damage = 37
SWEP.DamageMin = 33
SWEP.Range = 1500 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 7
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 150 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 150
SWEP.ReducedClipSize = 150

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.8
SWEP.RecoilSide = 0.5
SWEP.RecoilRise = 0

SWEP.Delay = 60 / 1300 -- lazy, fix this l8r btich -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0,
    },
}

SWEP.NPCWeaponType = {"weapon_ar2", "weapon_smg1"}
SWEP.NPCWeight = 150
SWEP.CanBash = true

SWEP.AccuracyMOA = 1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "AlyxGun" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 105 -- pitch of shoot sound

SWEP.ShootSound =			"horde/weapons/gau/gaufire.wav"
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/aug.wav"
SWEP.ShootDrySound =        "weapons/fesiugmw2/fire/dryfire_rifle.wav"
SWEP.ShootSoundSilenced =	"horde/weapons/gau/gaufire.wav"

SWEP.MuzzleEffect = "muzzleflash_4"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 90, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.875
SWEP.SightedSpeedMult = 0.35
SWEP.SightTime = 0.25
SWEP.IronSightStruct = false

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-2, 5, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.SprintPos = Vector(0, 0, 1)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 27

SWEP.AttachmentElements = {
    ["optic_mw2_mp5krearsight"] = { VMBodygroups = {{ind = 2, bg = 0}} },
    ["grip"] = { VMBodygroups = {{ind = 3, bg = 1}} },
}

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(-1.9, -1, 0.67),
            vang = Angle(0, 0, 90),
            wpos = Vector(15.625, -0.253, -6.298),
            wang = Angle(-8.829, -0.556, 90)
        },
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Camouflage",
        DefaultAttName = "None",
        Slot = "mw2_wepcamo",
        FreeSlot = true,
    },
	{
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(0, -0.5, 0.5),
            vang = Angle(0, 0, 0),
            wpos = Vector(9.625, 1.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Animations = {
    ["draw"] = {
        Source = "draw",
        Time = 30/30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 113/24,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "horde/weapons/gau/reload.wav", 		t = 0},
					},
    },
    ["spin"] = {
        Source = "shoot1",
        Time = 5/30,
        ShellEjectAt = 0,
    },
}

function SWEP:SecondaryAttack()
    return false
end

SWEP.lastRev = 0
SWEP.lastRevSound = 0
SWEP.revDelay = 0.75
SWEP.revved = nil
SWEP.revving = nil
SWEP.revSound = Sound("horde/weapons/gau/rev.ogg")
SWEP.spinSound = Sound("horde/weapons/gau/spin.ogg")
SWEP.unrevSound = Sound("horde/weapons/gau/unrev.ogg")

function SWEP:Hook_ShouldNotFireFirst()
    if not self.revved then return true end
end

function SWEP:Rev()
	if self.lastRev > CurTime() then return end
    self.revving = true
    self:SendWeaponAnim(181)

	--self.Owner:SetWalkSpeed( 80 )
	--self.Owner:SetRunSpeed( 80 )
	--self:EmitSound(self.spinSound)
	--self.Weapon:SetNextPrimaryFire( CurTime () + self.revSpeed )
    self.lastRev = CurTime() + 0.25
    timer.Simple(0.25, function ()
        self.revved = true
        self.revving = nil
    end)
end

function SWEP:Spin()
	if self.lastRev > CurTime() then return end
    self:SendWeaponAnim(181)
    self.lastRev = CurTime() + 0.25
end

function SWEP:Hook_Think()
    if self:GetReloading() then return end
	if self.Owner:KeyDown( IN_ATTACK2 ) || self.Owner:KeyDown( IN_ATTACK ) == true then
        if not self.revved and not self.revving then
            self:EmitSound(self.revSound)
            self:Rev()
        end
        if self.revved then
            self:Spin()
        end
        self.SpeedMult = 0.5
    else
        self.SpeedMult = 0.875
        if self.revved then
            self:EmitSound(self.unrevSound)
        end
        self.revved = nil
        self.revving = nil
	end

    if SERVER then
    if self.revved and self.lastRevSound <= CurTime() then
        sound.Play(self.spinSound, self:GetPos(), 80)
        self.lastRevSound = CurTime() + 0.14
    end
    end
end