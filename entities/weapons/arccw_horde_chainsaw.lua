if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_chainsaw")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_chainsaw", "vgui/hud/arccw_horde_chainsaw", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Chainsaw"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Brrrrrrrrrrrrrrrr"
SWEP.Trivia_Manufacturer = "Top Gear"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Sharp Edge"
SWEP.Trivia_Country = "Britain"
SWEP.Trivia_Year = 1949

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.SpeedMult = 0.85

SWEP.ViewModel = "models/horde/weapons/c_chainsaw.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-15, 7, -5),
    ang = Angle(0, 0, 180),
}
SWEP.WorldModel = "models/horde/weapons/c_chainsaw.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 160
SWEP.Melee2Damage = 28

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 80
SWEP.MeleeAttackTime = 0.4
SWEP.MeleeTime = 1.2
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 70
SWEP.Melee2AttackTime = 0
SWEP.Melee2Time = 0.15
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.Primary.Ammo = "Battery"
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100

SWEP.MeleeSwingSound = ""
SWEP.MeleeMissSound = {
    "horde/weapons/chainsaw/chainsaw_deselect1.ogg",
    "horde/weapons/chainsaw/chainsaw_deselect2.ogg"
}
SWEP.MeleeHitSound =
{"horde/weapons/chainsaw/chainsaw_impact_conc1.ogg",
"horde/weapons/chainsaw/chainsaw_impact_conc2.ogg",
"horde/weapons/chainsaw/chainsaw_impact_conc3.ogg",}
SWEP.MeleeHitNPCSound =
{"horde/weapons/chainsaw/chainsaw_impact_flesh1.ogg",
"horde/weapons/chainsaw/chainsaw_impact_flesh2.ogg",
"horde/weapons/chainsaw/chainsaw_impact_flesh3.ogg",}

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "melee2"

SWEP.AttachmentElements = {
}

SWEP.Attachments = {
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 0.9,
    },
    ["draw"] = {
        Source = "draw",
        Time = 2,
        SoundTable = {
            {
            s = "horde/weapons/chainsaw/Chainsaw_FalseStart1.ogg",
            t = 0.1
            },
        },
    },
    ["bash"] = {
        Source = {"heavyattack1","heavyattack2"},
        Time = 1,
        --[[SoundTable = {
            {
            s = "horde/weapons/chainsaw/chainsaw_deselect1.ogg",
            t = 0.1
            },
            {
            s = "horde/weapons/chainsaw/chainsaw_deselect2.ogg",
            t = 0.1
            },
        },]]--
    },
    ["bash2"] = {
        Source = "attack1",
        Time = 0.3,
        --[[SoundTable = {
            {
            s = "horde/weapons/chainsaw/chainsaw_deselect1.ogg",
            t = 0.1
            },
        },]]--
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(2, 5, -2)
SWEP.ActiveAng = Angle(-0, 0, -0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)

function SWEP:Hook_ShouldNotFireFirst()
    if self:Clip1() <= 0 then return false end
    self:SetClip1(self:Clip1() - 1)
end

function SWEP:Bash(melee2)
    if self:Clip1() <= 0 then
        self.MeleeDamage = 130
        self.Melee2Damage = 0
        if melee2 then return end
        self.MeleeMissSound = {
            "horde/weapons/crowbar/cbar_miss1.wav",
        }
    else
        self.MeleeDamage = 160
        self.Melee2Damage = 35
        self.MeleeMissSound = {
            "horde/weapons/chainsaw/chainsaw_deselect1.ogg",
            "horde/weapons/chainsaw/chainsaw_deselect2.ogg"
        }
    end
    melee2 = melee2 or false
    if self:GetState() == ArcCW.STATE_SIGHTS
            or (self:GetState() == ArcCW.STATE_SPRINT and !self:CanShootWhileSprint())
            or self:GetState() == ArcCW.STATE_CUSTOMIZE then
        return
    end
    if self:GetNextPrimaryFire() > CurTime() or self:GetGrenadePrimed() or self:GetPriorityAnim() then return end

    if !self.CanBash and !self:GetBuff_Override("Override_CanBash") then return end

    self:GetBuff_Hook("Hook_PreBash")

    self.Primary.Automatic = true

    local mult = self:GetBuff_Mult("Mult_MeleeTime")
    local mt = self.MeleeTime * mult

    if melee2 then
        mt = self.Melee2Time * mult
    end

    mt = mt * self:GetBuff_Mult("Mult_MeleeWaitTime")

    local bashanim = "bash"
    local canbackstab = self:CanBackstab(melee2)

    if melee2 then
        bashanim = canbackstab and self:SelectAnimation("bash2_backstab") or self:SelectAnimation("bash2") or bashanim
    else
        bashanim = canbackstab and self:SelectAnimation("bash_backstab") or self:SelectAnimation("bash") or bashanim
    end

    bashanim = self:GetBuff_Hook("Hook_SelectBashAnim", bashanim) or bashanim

    if bashanim and self.Animations[bashanim] then
        if SERVER then self:PlayAnimation(bashanim, mult, true, 0, true) end
    else
        self:ProceduralBash()

        self:MyEmitSound(self.MeleeSwingSound, 75, 100, 1, CHAN_USER_BASE + 1)
    end

    if CLIENT then
        self:OurViewPunch(-self.BashPrepareAng * 0.05)
    end
    self:SetNextPrimaryFire(CurTime() + mt )

    if melee2 then
        if self.HoldtypeActive == "pistol" or self.HoldtypeActive == "revolver" then
            self:GetOwner():DoAnimationEvent(self.Melee2Gesture or ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE)
        else
            self:GetOwner():DoAnimationEvent(self.Melee2Gesture or ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
        end
    else
        if self.HoldtypeActive == "pistol" or self.HoldtypeActive == "revolver" then
            self:GetOwner():DoAnimationEvent(self.MeleeGesture or ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE)
        else
            self:GetOwner():DoAnimationEvent(self.MeleeGesture or ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
        end
    end

    local mat = self.MeleeAttackTime

    if melee2 then
        mat = self.Melee2AttackTime
    end

    mat = mat * self:GetBuff_Mult("Mult_MeleeAttackTime") * math.pow(mult, 1.5)

    self:SetTimer(mat or (0.125 * mt), function()
        if !IsValid(self) then return end
        if !IsValid(self:GetOwner()) then return end
        if self:GetOwner():GetActiveWeapon() != self then return end

        if CLIENT then
            self:OurViewPunch(-self.BashAng * 0.05)
        end

        self:MeleeAttack(melee2)
    end)

    self:DoLunge()
    self:SetClip1(self:Clip1() - 1)
end

function SWEP:Reload()
    if self:Clip1() >= self:GetMaxClip1() then return end
    --self:EmitSound(Sound(self.ReloadSound))
    self.Weapon:SendWeaponAnim(ACT_VM_HOLSTER)
	self:SetNextPrimaryFire(CurTime() + 1)
	timer.Simple(1, function ()
		if !IsValid(self.Weapon) then return end
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		local ammo = self.Owner:GetAmmoCount(self.Primary.Ammo)
		local clip = math.min(self.Primary.ClipSize, ammo + self:Clip1())
		local diff = clip - self:Clip1()
		self.Owner:SetAmmo(ammo - diff, self.Primary.Ammo)
		self.Weapon:SetClip1(clip)
	end)
end