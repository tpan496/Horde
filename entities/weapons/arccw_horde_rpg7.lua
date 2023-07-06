if not ArcCWInstalled then return end
if (CLIENT) then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_rpg7")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
	killicon.Add("arccw_horde_rpg7", "vgui/hud/arccw_horde_rpg7", color_white)
    killicon.Add("horde_projectile_rpg", "vgui/hud/arccw_horde_rpg7", color_white)
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "RPG7"
SWEP.TrueName = "Ruchnoy Protivotankoviy Granatomyot"
SWEP.Trivia_Class = "Rocket Launcher"
SWEP.Trivia_Desc = "A portable, reusable, unguided, shoulder-launched, anti-tank, rocket-propelled grenade launcher."
SWEP.Trivia_Manufacturer = "Bazalt and Degtyarev plant."
SWEP.Trivia_Calibre = "Rockets"
SWEP.Trivia_Mechanism = "Explosive"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = 1958

SWEP.Slot = 3

SWEP.Spawnable = true

SWEP.UseHands = true

SWEP.ViewModel = "models/vj_weapons/c_rpg7.mdl"
SWEP.WorldModel = "models/vj_weapons/w_ins_rpg7.mdl"
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, -7),
    ang = Angle(0, 0, 0),
}
SWEP.ViewModelFOV = 60

SWEP.Damage = 500
SWEP.DamageMin = 500 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 0
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = "horde_projectile_rpg" -- entity to fire, if any
SWEP.MuzzleVelocity = 2000 -- projectile or phys bullet muzzle velocity

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 1 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 1
SWEP.ReducedClipSize = 1

SWEP.Recoil = 5
SWEP.RecoilSide = 1
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 1

SWEP.Delay = 60 / 100 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 10 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "RPG_Round" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "vj_weapons/rpg/rpg_fire.wav"
SWEP.ShootSoundSilenced = "vj_weapons/rpg/rpg_fire_far.wav"
SWEP.DistantShootSound = "vj_weapons/rpg/rpg_fire_far.wav"

--SWEP.MuzzleEffect = "muzzleflash_pistol"
--SWEP.ShellModel = "models/shells/shell_9mm.mdl"
--SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.92
SWEP.SightedSpeedMult = 0.65
SWEP.SightTime = 0.2

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-3, 0, 2),
    Ang = Angle(-0, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "rpg"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, 0, 0)
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
        Time = 0.1,
        SoundTable = {
            {
            s = "weapons/arccw/draw_secondary.wav",
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
        Time = 2.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
    },
}

SWEP.ViewModelBoneMods = {
	["missile"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

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
    self:NetworkVar("Bool", 7, "RPGInstalled")

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
    self:NetworkVar("Angle", 1, "FreeAimAngle")
    self:NetworkVar("Angle", 2, "LastAimAngle")

    self:NetworkVar("Entity", 0, "Holster_Entity")

    self:SetNWSightDelta(1)
end

if CLIENT then
function SWEP:ViewModelDrawn()
    local vm = self.Owner:GetViewModel()
    if !IsValid(vm) then return end
    if self:GetRPGInstalled() == true then
        self.ViewModelBoneMods["missile"].scale = Vector(1,1,1)
    else
        self.ViewModelBoneMods["missile"].scale = Vector(0.009, 0.009, 0.009)
    end
    self:UpdateBonePositions(vm)
end
end

function SWEP:Hook_PreReload()
    timer.Simple(2, function ()
        if IsValid(self) then
            self:SetRPGInstalled(true)
        end
    end)
end

function SWEP:Hook_OnDeploy()
    if self:Clip1() > 0 then
        self:SetRPGInstalled(true)
    else
        self:SetRPGInstalled(false)
    end
end

function SWEP:Hook_PostFireRocket()
    self:SetRPGInstalled(false)
end

function SWEP:UpdateBonePositions(vm)
    if self.ViewModelBoneMods then
        if (!vm:GetBoneCount()) then return end
        // !! WORKAROUND !! //
        // We need to check all model names :/
        local loopthrough = self.ViewModelBoneMods
        if (!hasGarryFixedBoneScalingYet) then
            allbones = {}
            for i=0, vm:GetBoneCount() do
                local bonename = vm:GetBoneName(i)
                if (self.ViewModelBoneMods[bonename]) then 
                    allbones[bonename] = self.ViewModelBoneMods[bonename]
                else
                    allbones[bonename] = { 
                        scale = Vector(1,1,1),
                        pos = Vector(0,0,0),
                        angle = Angle(0,0,0)
                    }
                end
            end
            
            loopthrough = allbones
        end
        // !! ----------- !! //
        
        for k, v in pairs( loopthrough ) do
            local bone = vm:LookupBone(k)
            if (!bone) then continue end
            
            // !! WORKAROUND !! //
            local s = Vector(v.scale.x,v.scale.y,v.scale.z)
            local p = Vector(v.pos.x,v.pos.y,v.pos.z)
            local ms = Vector(1,1,1)
            if (!hasGarryFixedBoneScalingYet) then
                local cur = vm:GetBoneParent(bone)
                while(cur >= 0) do
                    local pscale = loopthrough[vm:GetBoneName(cur)].scale
                    ms = ms * pscale
                    cur = vm:GetBoneParent(cur)
                end
            end
            
            s = s * ms
            // !! ----------- !! //
            
            if vm:GetManipulateBoneScale(bone) != s then
                vm:ManipulateBoneScale( bone, s )
            end
            if vm:GetManipulateBoneAngles(bone) != v.angle then
                vm:ManipulateBoneAngles( bone, v.angle )
            end
            if vm:GetManipulateBonePosition(bone) != p then
                vm:ManipulateBonePosition( bone, p )
            end
        end
    else
        self:ResetBonePositions(vm)
    end
end

function SWEP:ResetBonePositions(vm)
		
    if (!vm:GetBoneCount()) then return end
    for i=0, vm:GetBoneCount() do
        vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
        vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
        vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
    end
    
end

function SWEP:Think()
    if IsValid(self:GetOwner()) and self:GetClass() == "arccw_base" then
        self:Remove()
        return
    end

    local owner = self:GetOwner()

    if !IsValid(owner) or owner:IsNPC() then return end

    if self:GetState() == ArcCW.STATE_DISABLE and !self:GetPriorityAnim() then
        self:SetState(ArcCW.STATE_IDLE)
    end

    for i, v in ipairs(self.EventTable) do
        for ed, bz in pairs(v) do
            if ed <= CurTime() then
                if bz.AnimKey and (bz.AnimKey != self.LastAnimKey or bz.StartTime != self.LastAnimStartTime) then
                    continue
                end
                self:PlayEvent(bz)
                self.EventTable[i][ed] = nil
                --print(CurTime(), "Event completed at " .. i, ed)
                if table.IsEmpty(v) and i != 1 then self.EventTable[i] = nil --[[print(CurTime(), "No more events at " .. i .. ", killing")]] end
            end
        end
    end

    if CLIENT and (!game.SinglePlayer() and IsFirstTimePredicted() or true)
            and self:GetOwner() == LocalPlayer() and ArcCW.InvHUD
            and !ArcCW.Inv_Hidden and ArcCW.Inv_Fade == 0 then
        ArcCW.InvHUD:Remove()
        ArcCW.Inv_Fade = 0.01
    end

    local vm = owner:GetViewModel()

    self.BurstCount = self:GetBurstCount()

    local sg = self:GetShotgunReloading()
    if (sg == 2 or sg == 4) and owner:KeyPressed(IN_ATTACK) then
        self:SetShotgunReloading(sg + 1)
    elseif (sg >= 2) and self:GetReloadingREAL() <= CurTime() then
        self:ReloadInsert((sg >= 4) and true or false)
    end

    self:InBipod()

    if self:GetNeedCycle() and !self.Throwing and !self:GetReloading() and self:GetWeaponOpDelay() < CurTime() and self:GetNextPrimaryFire() < CurTime() and -- Adding this delays bolting if the RPM is too low, but removing it may reintroduce the double pump bug. Increasing the RPM allows you to shoot twice on many multiplayer servers. Sure would be convenient if everything just worked nicely
            (!GetConVar("arccw_clicktocycle"):GetBool() and (self:GetCurrentFiremode().Mode == 2 or !owner:KeyDown(IN_ATTACK))
            or GetConVar("arccw_clicktocycle"):GetBool() and (self:GetCurrentFiremode().Mode == 2 or owner:KeyPressed(IN_ATTACK))) then
        local anim = self:SelectAnimation("cycle")
        anim = self:GetBuff_Hook("Hook_SelectCycleAnimation", anim) or anim
        local mult = self:GetBuff_Mult("Mult_CycleTime")
        local p = self:PlayAnimation(anim, mult, true, 0, true)
        if p then
            self:SetNeedCycle(false)
            self:SetPriorityAnim(CurTime() + self:GetAnimKeyTime(anim, true) * mult)
        end
    end

    if self:GetGrenadePrimed() and !(owner:KeyDown(IN_ATTACK) or owner:KeyDown(IN_ATTACK2)) and (!game.SinglePlayer() or SERVER) then
        self:Throw()
    end

    if self:GetGrenadePrimed() and self.GrenadePrimeTime > 0 and self.isCooked then
        local heldtime = (CurTime() - self.GrenadePrimeTime)

        local ft = self:GetBuff_Override("Override_FuseTime") or self.FuseTime

        if ft and (heldtime >= ft) and (!game.SinglePlayer() or SERVER) then
            self:Throw()
        end
    end

    if IsFirstTimePredicted() and self:GetNextPrimaryFire() < CurTime() and owner:KeyReleased(IN_USE) then
        if self:InBipod() then
            self:ExitBipod()
        else
            self:EnterBipod()
        end
    end

    if ((game.SinglePlayer() and SERVER) or (!game.SinglePlayer() and true)) and self:GetBuff_Override("Override_TriggerDelay", self.TriggerDelay) then
        if owner:KeyReleased(IN_ATTACK) and self:GetBuff_Override("Override_TriggerCharge", self.TriggerCharge) and self:GetTriggerDelta(true) >= 1 then
            self:PrimaryAttack()
        else
            self:DoTriggerDelay()
        end
    end

    if self:GetCurrentFiremode().RunawayBurst then

        if self:GetBurstCount() > 0 and ((game.SinglePlayer() and SERVER) or (!game.SinglePlayer() and true)) then
            self:PrimaryAttack()
        end

        if self:Clip1() < self:GetBuff("AmmoPerShot") or self:GetBurstCount() == self:GetBurstLength() then
            self:SetBurstCount(0)
            if !self:GetCurrentFiremode().AutoBurst then
                self.Primary.Automatic = false
            end
        end
    end

    if owner:KeyReleased(IN_ATTACK) then

        if !self:GetCurrentFiremode().RunawayBurst then
            self:SetBurstCount(0)
            self.LastTriggerTime = -1 -- Cannot fire again until trigger released
            self.LastTriggerDuration = 0
        end

        if self:GetCurrentFiremode().Mode < 0 and !self:GetCurrentFiremode().RunawayBurst then
            local postburst = self:GetCurrentFiremode().PostBurstDelay or 0

            if (CurTime() + postburst) > self:GetWeaponOpDelay() then
                --self:SetNextPrimaryFire(CurTime() + postburst)
                self:SetWeaponOpDelay(CurTime() + postburst * self:GetBuff_Mult("Mult_PostBurstDelay") + self:GetBuff_Add("Add_PostBurstDelay"))
            end
        end
    end

    if owner and owner:GetInfoNum("arccw_automaticreload", 0) == 1 and self:Clip1() == 0 and !self:GetReloading() and CurTime() > self:GetNextPrimaryFire() + 0.2 then
        self:Reload()
    end

    if (!(self:GetBuff_Override("Override_ReloadInSights") or self.ReloadInSights) and (self:GetReloading() or owner:KeyDown(IN_RELOAD))) then
        if !(self:GetBuff_Override("Override_ReloadInSights") or self.ReloadInSights) and self:GetReloading() then
            self:ExitSights()
        end
    end


    if self:GetBuff_Hook("Hook_ShouldNotSight") and (self.Sighted or self:GetState() == ArcCW.STATE_SIGHTS) then
        self:ExitSights()
    elseif self:GetHolster_Time() > 0 then
        self:ExitSights()
    else

        -- no it really doesn't, past me
        local sighted = self:GetState() == ArcCW.STATE_SIGHTS
        local toggle = owner:GetInfoNum("arccw_toggleads", 0) >= 1
        local suitzoom = owner:KeyDown(IN_ZOOM)
        local sp_cl = game.SinglePlayer() and CLIENT

        -- if in singleplayer, client realm should be completely ignored
        if toggle and !sp_cl then
            if owner:KeyPressed(IN_ATTACK2) then
                if sighted then
                    self:ExitSights()
                elseif !suitzoom then
                    self:EnterSights()
                end
            elseif suitzoom and sighted then
                self:ExitSights()
            end
        elseif !toggle then
            if (owner:KeyDown(IN_ATTACK2) and !suitzoom) and !sighted then
                self:EnterSights()
            elseif (!owner:KeyDown(IN_ATTACK2) or suitzoom) and sighted then
                self:ExitSights()
            end
        end

    end

    if (!game.SinglePlayer() and IsFirstTimePredicted()) or (game.SinglePlayer() and true) then
        if self:InSprint() and (self:GetState() != ArcCW.STATE_SPRINT) then
            self:EnterSprint()
        elseif !self:InSprint() and (self:GetState() == ArcCW.STATE_SPRINT) then
            self:ExitSprint()
        end
    end

    if game.SinglePlayer() or IsFirstTimePredicted() then
        self:SetSightDelta(math.Approach(self:GetSightDelta(), self:GetState() == ArcCW.STATE_SIGHTS and 0 or 1, FrameTime() / self:GetSightTime()))
        self:SetSprintDelta(math.Approach(self:GetSprintDelta(), self:GetState() == ArcCW.STATE_SPRINT and 1 or 0, FrameTime() / self:GetSprintTime()))
    end

    if CLIENT and (game.SinglePlayer() or IsFirstTimePredicted()) then
        self:ProcessRecoil()
    end

    self:DoHeat()

    self:ThinkFreeAim()

    -- if CLIENT then
        -- if !IsValid(ArcCW.InvHUD) then
        --     gui.EnableScreenClicker(false)
        -- end

        -- if self:GetState() != ArcCW.STATE_CUSTOMIZE then
        --     self:CloseCustomizeHUD()
        -- else
        --     self:OpenCustomizeHUD()
        -- end
    -- end

    for i, k in pairs(self.Attachments) do
        if !k.Installed then continue end
        local atttbl = ArcCW.AttachmentTable[k.Installed]

        if atttbl.DamagePerSecond then
            local dmg = atttbl.DamagePerSecond * FrameTime()

            self:DamageAttachment(i, dmg)
        end
    end

    if CLIENT then
        self:DoOurViewPunch()
    end

    if self.Throwing and self:Clip1() == 0 and self:Ammo1() > 0 then
        self:SetClip1(1)
        owner:SetAmmo(self:Ammo1() - 1, self.Primary.Ammo)
    end

    -- self:RefreshBGs()

    if self:GetMagUpIn() != 0 and CurTime() > self:GetMagUpIn() then
        self:ReloadTimed()
        self:SetMagUpIn( 0 )
    end

    if self:HasBottomlessClip() and self:Clip1() != ArcCW.BottomlessMagicNumber then
        self:Unload()
        self:SetClip1(ArcCW.BottomlessMagicNumber)
    elseif !self:HasBottomlessClip() and self:Clip1() == ArcCW.BottomlessMagicNumber then
        self:SetClip1(0)
    end

    -- Performing traces in rendering contexts seem to cause flickering with c_hands that have QC attachments(?)
    -- Since we need to run the trace every tick anyways, do it here instead
    if CLIENT then
        self:BarrelHitWall()
    end

    self:GetBuff_Hook("Hook_Think")

    -- Running this only serverside in SP breaks animation processing and causes CheckpointAnimation to !reset.
    --if SERVER or !game.SinglePlayer() then
        self:ProcessTimers()
    --end

    -- Only reset to idle if we don't need cycle. empty idle animation usually doesn't play nice
    if self:GetNextIdle() != 0 and self:GetNextIdle() <= CurTime() and !self:GetNeedCycle()
            and self:GetHolster_Time() == 0 and self:GetShotgunReloading() == 0 then
        self:SetNextIdle(0)
        self:PlayIdleAnimation(true)
    end
end