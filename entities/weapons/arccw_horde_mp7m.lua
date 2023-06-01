if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mp7")
    killicon.Add("arccw_horde_mp7m", "arccw/weaponicons/arccw_go_mp7", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP7A1 Medic PDW"
SWEP.Trivia_Class = "PDW"
SWEP.Trivia_Desc = "Lightweight personal defense weapon once slated to replace the 9mm pistol as the NATO standard weapon for units that didn't need to carry full rifles."
SWEP.Trivia_Manufacturer = "Heckler und Koch"
SWEP.Trivia_Calibre = "4.6x30mm"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 2001

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mp7.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mp7.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 27
SWEP.DamageMin = 15 -- damage done at maximum range
SWEP.Range = 75 -- in METRES
SWEP.Penetration = 9
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 35 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 740

SWEP.Recoil = 0.175
SWEP.RecoilSide = 0.091
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 950 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0,
    },
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 7 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "mp7" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/mp7/mp7_01.wav"
SWEP.ShootSound = "arccw_go/mp7/mp7_02.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "arccw_go/mp7/mp7-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_3"
SWEP.ShellModel = "models/shells/shell_57.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.25

SWEP.IronSightStruct = {
    Pos = Vector(-5.26, -7, 0.95),
    Ang = Angle(0, 0.15, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, 2, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["nors"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["nofh"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["ubrms"] = {
        NameChange = "MP7A2",
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 3, bg = 1}},
    },
    ["go_mp7_mag_20"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
        WMBodygroups = {
            {ind = 2, bg = 1},
        },
    },
    ["go_mp7_mag_40"] = {
        VMBodygroups = {
            {ind = 2, bg = 2},
        },
        WMBodygroups = {
            {ind = 2, bg = 2},
        },
    },
    ["go_mp7_stock_in"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
    ["go_mp7_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 5, bg = 2},
        },
        WMBodygroups = {
            {ind = 5, bg = 2},
        },
    },
    ["go_mp7_stock_contractor"] = {
        VMBodygroups = {
            {ind = 5, bg = 3},
        },
        WMBodygroups = {
            {ind = 5, bg = 3},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 5, bg = 4},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.mp7_Parent",
                Offset = {
                    pos = Vector(0, -2.75, -4.75),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-15, 6, -3.5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.mp7_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.0225, -4.1, 0),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"nors"},
        CorrectiveAng = Angle(0, 0, 0),
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.mp7_parent",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, -1.5, 6),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.mp7_parent",
        Offset = {
            vpos = Vector(0.75, -2.2, 5),
            vang = Angle(90, 0, 0),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.mp7_parent",
        Offset = {
            vpos = Vector(0.025, -2.25, 8),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"nofh"},
    },
    {
        PrintName = "Magazine",
        Slot = "go_mp7_mag",
        DefaultAttName = "30-Round 4.6mm MP7"
    },
    {
        PrintName = "Stock",
        Slot = {"go_mp7_stock", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.mp7_parent",
        Offset = {
            vpos = Vector(0, -2.75, -4.75),
            vang = Angle(90, 0, -90),
        }
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
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.mp7_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -2.5, -3.5), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self:GetBuff_Override("NoStock") then return "fire" end
    elseif anim == "fire_iron_empty" then
        if self:GetBuff_Override("NoStock") then return "fire_empty" end
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
    },
    ["reload_smallmag"] = {
        Source = "reload_smallmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
    },
    ["reload_smallmag_empty"] = {
        Source = "reload_smallmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
    },
}

sound.Add({
    name = "ARCCW_GO_MP7.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp7/mp7_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_MP7.Slideback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp7/mp7_Slideback.wav"
})

sound.Add({
    name = "ARCCW_GO_MP7.Slideforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp7/mp7_Slideforward.wav"
})

sound.Add({
    name = "ARCCW_GO_MP7.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp7/mp7_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_MP7.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp7/mp7_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_MP7.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp7/mp7_cliphit.wav"
})


function SWEP:ChangeFiremode(pred)
    if self:GetNextSecondaryFire() > CurTime() then return end
    if !self.CanBash and !self:GetBuff_Override("Override_CanBash") then return end
    if CLIENT then return end
    local ply = self:GetOwner()
    local filter = {self:GetOwner()}
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-16, -16, -8),
        maxs = Vector(16, 16, 8),
        mask = MASK_SHOT_HULL
    })
    if tr.Hit then
        local effectdata = EffectData()
        effectdata:SetOrigin(tr.HitPos)
        effectdata:SetRadius(50)
        util.Effect("horde_heal_mist", effectdata)

        for _, ent in pairs(ents.FindInSphere(tr.HitPos, 100)) do
            if ent:IsPlayer() then
                local healinfo = HealInfo:New({amount=10, healer=ply})
                HORDE:OnPlayerHeal(ent, healinfo)
            elseif ent:GetClass() == "npc_vj_horde_antlion" then
                local healinfo = HealInfo:New({amount=10, healer=ply})
                HORDE:OnAntlionHeal(ent, healinfo)
            elseif ent:IsNPC() then
                local dmg = DamageInfo()
                dmg:SetDamage(25)
                dmg:SetDamageType(DMG_NERVEGAS)
                dmg:SetAttacker(ply)
                dmg:SetInflictor(self)
                dmg:SetDamagePosition(tr.HitPos)
                ent:TakeDamageInfo(dmg)
            end
        end
    end

    ply:EmitSound("horde/weapons/mp7m/heal.ogg", 125, 100, 1, CHAN_AUTO)

    self:SetNextSecondaryFire(CurTime() + 1)
    self:SetNextPrimaryFire(CurTime() + 0.25)
    return true
end

function SWEP:Hook_Think()
    if SERVER then return end
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-20, -20, -8),
        maxs = Vector(20, 20, 8),
        mask = MASK_SHOT_HULL
    })

    if tr.Hit and tr.Entity and tr.Entity:IsPlayer()then
        self.Horde_HealTarget = tr.Entity
    else
        self.Horde_HealTarget = nil
    end
end

local function nv_center(ent)
	return ent:LocalToWorld(ent:OBBCenter())
end

function SWEP:Hook_DrawHUD()
    if self.Horde_HealTarget then
        local pos = nv_center(self.Horde_HealTarget):ToScreen()
		surface.SetDrawColor(Color(50, 200, 50))
        surface.DrawCircle(pos.x, pos.y, 30)
        --surface.DrawLine(pos.x, 0, pos.x, ScrH())
        --surface.DrawLine(0, pos.y, ScrW(), pos.y)
        draw.DrawText(self.Horde_HealTarget:Health(), "Trebuchet24",
        pos.x - 15, pos.y - 15, Color(50, 200, 50), TEXT_ALIGN_LEFT)
    end
end