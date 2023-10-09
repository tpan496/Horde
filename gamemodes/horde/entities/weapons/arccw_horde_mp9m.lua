if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mp9")
    killicon.Add("arccw_horde_mp9m", "arccw/weaponicons/arccw_go_mp9", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP9N Medic PDW"
SWEP.Trivia_Class = "PDW"
SWEP.Trivia_Desc = "9mm machine pistol developed from the Steyr TMP, with side-folding stock."
SWEP.Trivia_Manufacturer = "Brugger and Thomet"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Short-Recoil Locking Barrel"
SWEP.Trivia_Country = "Switzerland"
SWEP.Trivia_Year = 2001

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mp9.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mp9.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 35
SWEP.DamageMin = 13 -- damage done at maximum range
SWEP.Range = 45 -- in METRES
SWEP.Penetration = 6
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 400

SWEP.Recoil = 0.335
SWEP.RecoilSide = 0.215
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 900 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 12 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 250 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "mp9" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/mp9/mp9_01.wav"
SWEP.ShootSound = "arccw_go/mp9/mp9_02.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "arccw_go/mp9/mp9-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.98
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.240

SWEP.IronSightStruct = {
    Pos = Vector(-4.72, -5, 0.85),
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
    ["ubrms"] = {
        NameChange = "MP9",
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
        WMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        WMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.mp9_Parent",
                Offset = {
                    pos = Vector(0, -2.5, -3.35),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
    ["go_mp9_stock_in"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
        },
        WMBodygroups = {
            {ind = 3, bg = 2},
        },
    },
    ["go_mp9_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 3, bg = 3},
        },
        WMBodygroups = {
            {ind = 3, bg = 3},
        },
    },
    ["go_mp9_stock_contractor"] = {
        VMBodygroups = {
            {ind = 3, bg = 4},
        },
        WMBodygroups = {
            {ind = 3, bg = 4},
        },
    },
    ["go_mp9_mag_15"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
    ["go_mp9_barrel_med"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
        },
        WMBodygroups = {
            {ind = 1, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -2.9, 10),
            }
        }
    },
    ["go_mp9_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 1},
        },
        WMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -2.9, 17),
            },
            [2] = {
                vpos = Vector(0, -1.8, 12),
            }
        },
        VMElements = {
            {
                Model = "models/editor/axis_helper.mdl",
                Bone = "v_weapon.mp9_parent",
                Offset = {
                    pos = Vector(0, -2.9, 10),
                    ang = Angle(90, 0, -90),
                },
                Scale = Vector(0, 0, 0),
                IsMuzzleDevice = true
            }
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12, 5.5, -3),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.mp9_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -4.2, 1),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        CorrectiveAng = Angle(0, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.mp9_parent",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, -1.3, 5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.mp9_parent",
        Offset = {
            vpos = Vector(-0.9, -3.4, 4.5),
            vang = Angle(90, 0, 180),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Barrel",
        Slot = "go_mp9_barrel",
        DefaultAttName = "130mm B&T Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.mp9_parent",
        Offset = {
            vpos = Vector(0, -2.9, 7.5),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Magazine",
        Slot = "go_mp9_mag",
        DefaultAttName = "30-Round 9mm B&T"
    },
    {
        PrintName = "Stock",
        Slot = {"go_mp9_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.mp9_parent",
        Offset = {
            vpos = Vector(0, -2.5, -3.35),
            vang = Angle(90, 0, -90),
        },
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
        Bone = "v_weapon.mp9_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.75, -2.5, -3), -- offset that the attachment will be relative to the bone
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
        Source = {"fire1", "fire2", "fire3"},
        Time = 0.25,
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
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3
    },
    ["reload_smallmag"] = {
        Source = "reload_smallmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3
    },
    ["reload_smallmag_empty"] = {
        Source = "reload_smallmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3
    },
}

sound.Add({
    name = "ARCCW_GO_MP9.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp9/mp9_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_MP9.BoltBack",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp9/mp9_boltback.wav"
})

sound.Add({
    name = "ARCCW_GO_MP9.BoltForward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp9/mp9_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_MP9.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp9/mp9_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_MP9.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp9/mp9_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_MP9.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp9/mp9_cliphit.wav"
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