if not ArcCWInstalled then return end
if (CLIENT) then
	SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_horde_javelin")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
	killicon.Add("arccw_horde_javelin", "arccw/weaponicons/arccw_horde_javelin", color_white)
    killicon.Add("horde_projectile_javelin", "arccw/weaponicons/arccw_horde_javelin", color_white)
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "FGM-148 JAVELIN"
SWEP.TrueName = "FGM-148 JAVELIN"
SWEP.Trivia_Class = "Guided Rocket Launcher"
SWEP.Trivia_Desc = "Fire-and-forget missile with lock-on before launch and automatic self-guidance."
SWEP.Trivia_Manufacturer = "Raytheon & Lockheed Martin"
SWEP.Trivia_Calibre = "Guided Shell"
SWEP.Trivia_Mechanism = "Explosive"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = 1996

SWEP.Slot = 3

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
end

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_javelin.mdl"
SWEP.WorldModel = "models/weapons/c_javelin.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-15, 12, -10),
    ang = Angle(0, 0, 180),
}
SWEP.ViewModelFOV = 60

SWEP.Damage = 1000
SWEP.DamageMin = 1000 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 0
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = "horde_projectile_javelin" -- entity to fire, if any
SWEP.MuzzleVelocity = 0 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 1 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 1
SWEP.ReducedClipSize = 1

SWEP.Recoil = 15
SWEP.RecoilSide = 1
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 2

SWEP.Delay = 60 / 100 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
        PrintName = "Direct Attack Mode"
    },
    {
        Mode = 3,
        PrintName = "Top Attack Mode"
    },
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 10 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "RPG_Round" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "horde/weapons/javelin/fire.ogg"
SWEP.ShootSoundSilenced = "horde/weapons/javelin/fire.ogg"
SWEP.DistantShootSound = "horde/weapons/javelin/fire.ogg"

--SWEP.MuzzleEffect = "muzzleflash_pistol"
--SWEP.ShellModel = "models/shells/shell_9mm.mdl"
--SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SightTime = 0.175

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.5

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-5, 0, 2),
    Ang = Angle(-0, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "rpg"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(-2, 2, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(-2, -7.145, -11.561)
SWEP.HolsterAng = Angle(36.533, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(12, -8, -4.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.AttachmentElements = {

}

SWEP.ExtraSightDist = 5

SWEP.RejectAttachments = {["go_homemade_auto"] = true, ["go_perk_burst"] = true}
SWEP.Attachments = {
    {
        PrintName = "Ammo",
        Slot = "horde_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
}

SWEP.Animations = {
    ["idle"] = {
    Source = "idle",
    Time = 10,
    },
    ["draw"] = {
        Source = "draw",
        Time = 1.5,
        SoundTable = {
            {
            s = "horde/weapons/javelin/draw.ogg",
            t = 0
            }
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
        RestoreAmmo = 1,
    },
    ["fire_iron"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 4,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
        SoundTable = {
            {
            s = "horde/weapons/javelin/reload.ogg",
            t = 0
            },
            {
                s = "horde/weapons/javelin/reload2.ogg",
                t = 2
                }
        },
    },
}

SWEP.Scoped = nil
SWEP.LastLockSound = CurTime()
SWEP.LockingTarget = nil

function SWEP:ShouldDrawCrosshair()
    return false
end

function SWEP:Hook_ShouldNotFire()
    if !IsValid(self:GetLocked_Target()) then return true end
end

function SWEP:Hook_ShouldNotSight()
    return true
end

SWEP.LockDuration = 1.25
sound.Add({
    name = "JAVELIN_LOCK",
    channel = 16,
    volume = 1.0,
    sound = "horde/weapons/javelin/locking.ogg"
})
SWEP.LockSound = Sound("JAVELIN_LOCK")

function SWEP:Hook_Think()
    if self.Owner:KeyDown(IN_ATTACK2) then
        self.Owner:SetFOV(25, 0)
        self.Owner:DrawViewModel(false)
        self.Scoped = true
        self.SpeedMult = 0.5

        local tr = util.TraceLine({
            start = self.Owner:GetShootPos(),
            endpos = self.Owner:GetShootPos() + self:GetOwner():GetAimVector() * 10000,
            filter = {self, self.Owner},
            mask = MASK_SHOT_HULL
        })
        if CLIENT then
            local trdistanceraw = tostring( self.Owner:GetPos( ):Distance( tr.HitPos ) )
		    local trdistance =  math.Clamp( math.Round( trdistanceraw ), 0, 10000 )  
            self.trdistance = trdistance
        end

        if CLIENT and self.LastLockSound <= CurTime() then
            if IsValid(self:GetLocked_Target()) then
                self.LastLockSound = CurTime() + 0.2
                self:EmitSound(self.LockSound)
            elseif IsValid(self.LockingTarget) then
                self.LastLockSound = CurTime() + 0.5
                self:EmitSound(self.LockSound)
            end
        end
		
		if( tr.Hit ) then
			local ent = tr.Entity
			if IsValid(ent) and ent:IsNPC() and (not ent:IsPlayer()) and (not ent:GetNWEntity("HordeOwner"):IsValid()) then
                if self.LockingTarget ~= ent then
                    self.LockStart = CurTime()
                else
                    if self.LockStart + self.LockDuration <= CurTime() then
                        if SERVER then
                            self:SetLocked_Target(ent)
                        end
                    end
                end
                self.LockingTarget = ent
			else
				self.LockingTarget = nil
			end
		end
    else
        self.Owner:SetFOV(0, 0)
        self.Scoped = nil
        self.LockingTarget = nil
        self:SetLocked_Target(NULL)
        self.Owner:DrawViewModel(true)
        self.SpeedMult = 0.9
    end
end

function SWEP:SetupDataTables()
    self:NetworkVar("Int", 0, "NWState")
    self:NetworkVar("Int", 1, "FireMode")
    self:NetworkVar("Int", 2, "BurstCountUM")
    self:NetworkVar("Int", 3, "LastLoad")
    self:NetworkVar("Int", 4, "NthReload")
    self:NetworkVar("Int", 5, "NthShot")

    -- 2 = insert
    -- 3 = cancelling
    -- 4 = insert empty
    -- 5 = cancelling empty
    self:NetworkVar("Int", 6, "ShotgunReloading")
    self:NetworkVar("Int", 7, "MagUpCount")

    self:NetworkVar("Bool", 0, "HeatLocked")
    self:NetworkVar("Bool", 1, "NeedCycle")
    self:NetworkVar("Bool", 2, "InBipod")
    self:NetworkVar("Bool", 3, "InUBGL")
    self:NetworkVar("Bool", 4, "InCustomize")
    self:NetworkVar("Bool", 5, "GrenadePrimed")
    self:NetworkVar("Bool", 6, "NWMalfunctionJam")
    self:NetworkVar("Bool", 7, "UBGLDebounce")

    self:NetworkVar("Float", 0, "Heat")
    self:NetworkVar("Float", 1, "WeaponOpDelay")
    self:NetworkVar("Float", 2, "ReloadingREAL")
    self:NetworkVar("Float", 3, "MagUpIn")
    self:NetworkVar("Float", 4, "NextPrimaryFireSlowdown")
    self:NetworkVar("Float", 5, "NextIdle")
    self:NetworkVar("Float", 6, "Holster_Time")
    self:NetworkVar("Float", 7, "NWSightDelta")
    self:NetworkVar("Float", 8, "NWSprintDelta")
    self:NetworkVar("Float", 9, "NWPriorityAnim")

    self:NetworkVar("Vector", 0, "BipodPos")

    self:NetworkVar("Angle", 0, "BipodAngle")
    self:NetworkVar("Angle", 1, "FreeAimAngle")
    self:NetworkVar("Angle", 2, "LastAimAngle")

    self:NetworkVar("Entity", 0, "Holster_Entity")
    self:NetworkVar("Entity", 1, "Locked_Target")

    self:SetNWSightDelta(1)
end

SWEP.ScopeTexture = Material("arccw/javelinscope.png")

local function DrawJavelinIcon(text, x, y, color)
    surface.DrawCircle(x, y, ScreenScale(15), color)
    if text == "HANG\nFIRE" then
        draw.DrawText(text, "Horde_Javeline", x, y - ScreenScale(8), color, 1, 1)
        return
    end
    draw.DrawText(text, "Horde_Javeline", x, y - ScreenScale(4), color, 1, 1)
end

function SWEP:Hook_DrawHUD()
	if self.Scoped then
        surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
        surface.DrawLine( 0, ScrH()/2, ScrW(), ScrH()/2)
        surface.DrawLine(ScrW()/2, 0, ScrW()/2, ScrH() )

        if IsValid(self:GetLocked_Target()) then
            local pos = self:GetLocked_Target():GetPos() + self:GetLocked_Target():OBBCenter()
            pos = pos:ToScreen()
            surface.SetDrawColor( Color( 255, 0,0, 255 ) )
            surface.DrawLine( 0, pos.y, ScrW(), pos.y )
            surface.DrawLine( pos.x, 0, pos.x, ScrH() )
            surface.DrawCircle(pos.x, pos.y, 25)
        elseif IsValid(self.LockingTarget) then
            local pos = self.LockingTarget:GetPos() + self.LockingTarget:OBBCenter()
            pos = pos:ToScreen()
            surface.SetDrawColor( Color( 0, 255,0, 255 ) )
            --surface.DrawLine( 0, pos.y, ScrW(), pos.y )
            --surface.DrawLine( pos.x, 0, pos.x, ScrH() )
            surface.DrawCircle(pos.x, pos.y, 25)
            surface.DrawCircle(pos.x, pos.y, 20)
        end

        surface.SetDrawColor( Color( 0, 255,0, 255 ) )

        surface.SetMaterial( self.ScopeTexture )
        surface.SetDrawColor( Color( 255,255,255, 255 ) )
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

        if IsValid(self:GetLocked_Target()) then
            DrawJavelinIcon("SEEK", ScrW() * 0.7, ScrH() * 0.15, Color(255, 0, 0))
            draw.SimpleText("LOCK", "Horde_Javeline", ScrW()/2, ScrH() * 0.6, Color(255,0,0), 1, 1 )
        elseif IsValid(self.LockingTarget) then
            DrawJavelinIcon("SEEK", ScrW() * 0.7, ScrH() * 0.15, Color(0, 255, 0))
            draw.SimpleText( ">", "Horde_Javeline", ScrW() * 0.40, ScrH() * 0.6, Color(255,255,255), 1, 1 )
		    draw.SimpleText((self.trdistance or 0) .. " units", "Horde_Javeline", ScrW()/2, ScrH() * 0.6, Color(255,255,255), 1, 1 )
		    draw.SimpleText( "<", "Horde_Javeline", ScrW() * 0.60, ScrH() * 0.6, Color(255,255,255), 1, 1 )
        else
            DrawJavelinIcon("SEEK", ScrW() * 0.7, ScrH() * 0.15,  Color(13, 173, 13, 50))
            draw.SimpleText( ">", "Horde_Javeline", ScrW() * 0.40, ScrH() * 0.6, Color(255,255,255), 1, 1 )
		    draw.SimpleText((self.trdistance or 0) .. " units", "Horde_Javeline", ScrW()/2, ScrH() * 0.6, Color(255,255,255), 1, 1 )
		    draw.SimpleText( "<", "Horde_Javeline", ScrW() * 0.60, ScrH() * 0.6, Color(255,255,255), 1, 1 )
        end

        DrawJavelinIcon("100%", ScrW() * 0.2075, ScrH() * 0.7, Color(0, 255, 0))
        DrawJavelinIcon("CLU", ScrW() * 0.2075, ScrH() * 0.5, Color(0, 255, 0))
        if self:GetCurrentFiremode().Mode == 2 then
            DrawJavelinIcon("TOP", ScrW() * 0.79, ScrH() * 0.3, Color( 13, 173, 13, 50 ))
            DrawJavelinIcon("DIR", ScrW() * 0.79, ScrH() * 0.5, Color(0, 255, 0))
        else
            DrawJavelinIcon("TOP", ScrW() * 0.79, ScrH() * 0.3, Color(0, 255, 0))
            DrawJavelinIcon("DIR", ScrW() * 0.79, ScrH() * 0.5, Color( 13, 173, 13, 50 ))
        end
		
		DrawJavelinIcon("WFOV", ScrW() * 0.4, ScrH() * 0.15, Color(0, 255, 0))
		DrawJavelinIcon("HANG\nFIRE", ScrW() * 0.43, ScrH() * 0.85, Color( 13, 173, 13, 50 ))
		DrawJavelinIcon("NFOW", ScrW() * 0.6, ScrH() * 0.15, Color( 13, 173, 13, 50 ))
        DrawJavelinIcon("DAY",  ScrW() * 0.3, ScrH() * 0.15, Color( 13, 173, 13, 50 ))
        DrawJavelinIcon("NIGHT",ScrW() * 0.2075, ScrH() * 0.3, Color( 13, 173, 13, 50 ))
        DrawJavelinIcon("BCU",  ScrW() * 0.3, ScrH() * 0.85, Color(0, 255, 0))
        
        if self:Clip1() > 0 then
            DrawJavelinIcon("EMPTY", ScrW() * 0.7, ScrH() * 0.85, Color(100, 0, 0))
            DrawJavelinIcon("READY", ScrW() * 0.6, ScrH() * 0.85, Color(0, 255, 0))
        else
            DrawJavelinIcon("EMPTY", ScrW() * 0.7, ScrH() * 0.85, Color(255, 0, 0))
            DrawJavelinIcon("READY", ScrW() * 0.6, ScrH() * 0.85, Color( 13, 173, 13, 50 ))
        end

        if( LocalPlayer():FlashlightIsOn() ) then 
            DrawJavelinIcon("FLIR", ScrW() * 0.79, ScrH() * 0.7, Color( 13, 173, 13, 50 ))
		else 
            DrawJavelinIcon("FLIR", ScrW() * 0.79, ScrH() * 0.7, Color( 13, 173, 13, 50 ))
		end
	end
end

function SWEP:Hook_PostFireRocket(rocket)
    local RealVelocity
    if self:GetCurrentFiremode().Mode == 2 then
        RealVelocity = self:GetOwner():GetAimVector() * 500 + Vector(0,0,1) * 150
    else
        RealVelocity = self:GetOwner():GetAimVector() * 500 + Vector(0,0,1) * 500
    end
    
    rocket.CurVel = RealVelocity -- for non-physical projectiles that move themselves

    if !rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
        rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
    end
    rocket.Target = self:GetLocked_Target()
end