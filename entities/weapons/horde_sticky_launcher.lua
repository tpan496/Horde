if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/horde_sticky_launcher")
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_sticky_launcher", "vgui/hud/horde_sticky_launcher", Color( 255, 255, 255, 255 ) )
    killicon.Add( "horde_sticky_bomb", "vgui/hud/horde_sticky_launcher", Color( 255, 255, 255, 255 ) )
end

SWEP.PrintName = "Stickybomb Launcher"
SWEP.Category = "Horde"
SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 65
SWEP.ViewModel = "models/horde/weapons/c_sticky_launcher.mdl"
SWEP.WorldModel = "models/horde/weapons/w_sticky_launcher.mdl"
SWEP.ViewModelFlip = false
SWEP.BobScale = 1
SWEP.SwayScale = 0

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 3
SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.UseHands = true
SWEP.HoldType = "ar2"
SWEP.FiresUnderwater = true
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = 1
SWEP.Base = "weapon_base"

SWEP.WalkSpeed = 186
SWEP.RunSpeed = 372

SWEP.Reloading = 0
SWEP.ReloadingTimer = CurTime()
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()
SWEP.Recoil = 0
SWEP.RecoilTimer = CurTime()

SWEP.Primary.Sound = Sound("horde/weapons/sticky_launcher/stickybomblauncher_shoot.wav")
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 32
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Grenade"
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Delay = 0.6
SWEP.Primary.Force = 800

SWEP.ReloadSound = Sound("horde/weapons/sticky_launcher/stickybomblauncher_reload.wav")

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.ActivePos = Vector(0, -4, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.StickyOwner = nil
SWEP.Stickies = {}
SWEP.LastSticky = nil

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
    self.Idle = 0
    self.IdleTimer = CurTime() + 1
end

function SWEP:DrawHUD()
    if CLIENT then
    local x, y
    local tr = self.Owner:GetEyeTrace()
    if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
        local coords = tr.HitPos:ToScreen()
        x, y = coords.x, coords.y
    else
        x, y = ScrW() / 2, ScrH() / 2
    end
    surface.SetTexture( surface.GetTextureID( "vgui/hud/gl_crosshair" ) )
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( x - ScrW() / 40, y - ScrW() / 40, ScrW() / 20, ScrW() / 20 )
    end
end

function SWEP:Deploy()
    self:SetWeaponHoldType( self.HoldType )
    self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
    self:SetNextPrimaryFire( CurTime() + 0.5 )
    self:SetNextSecondaryFire( CurTime() + 0.5 )
    self.Reloading = 0
    self.ReloadingTimer = CurTime()
    self.Idle = 0
    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
    self.Recoil = 0
    self.RecoilTimer = CurTime()
    self.Owner:SetWalkSpeed( self.WalkSpeed )
    self.Owner:SetRunSpeed( self.RunSpeed )
    return true
end

function SWEP:Holster()
    self.Reloading = 0
    self.ReloadingTimer = CurTime()
    self.Idle = 0
    self.IdleTimer = CurTime()
    self.Recoil = 0
    self.RecoilTimer = CurTime()
    if self.Owner ~= self.StickyOwner then
        if self.Stickies then
            for _, sticky in pairs(self.Stickies) do
                sticky:Remove()
            end
        end
        self.Stickies = nil
        self.StickyOwner = self.Owner
    end
    return true
end

function SWEP:PrimaryAttack()
    if self.Reloading == 1 then
        self.Reloading = 2
    else
        if !( self.Reloading == 0 ) then return end
        if self.Weapon:Clip1() <= 0 and self.Weapon:Ammo1() <= 0 then
            self.Weapon:EmitSound( "Weapon_Shotgun.Empty" )
            self:SetNextPrimaryFire( CurTime() + 0.2 )
            self:SetNextSecondaryFire( CurTime() + 0.2 )
        end
        if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then
            self.Weapon:EmitSound( "Weapon_Shotgun.Empty" )
            self:SetNextPrimaryFire( CurTime() + 0.2 )
            self:SetNextSecondaryFire( CurTime() + 0.2 )
        end
        if self.Weapon:Clip1() <= 0 then
            self:Reload()
        end
        if self.Weapon:Clip1() <= 0 then return end
        if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then return end
        if SERVER then
            local entity = ents.Create( "horde_sticky_bomb" )
            entity:SetOwner( self.Owner )
            if IsValid( entity ) then
                local Forward = self.Owner:EyeAngles():Forward()
                local Right = self.Owner:EyeAngles():Right()
                local Up = self.Owner:EyeAngles():Up()
                entity:SetPos( self.Owner:GetShootPos() + Forward * 8 + Right * 4 + Up * -4 )
                entity:SetAngles( self.Owner:EyeAngles() )
                entity:Spawn()
                local phys = entity:GetPhysicsObject()
                phys:SetVelocity( self.Owner:GetAimVector() * self.Primary.Force )
                phys:AddAngleVelocity( Vector( math.Rand( -500, 500 ), math.Rand( -500, 500 ), math.Rand( -500, 500 ) ) )
                if not self.Stickies then
                    self.Stickies = {}
                end
                table.insert(self.Stickies, entity)
                if table.Count(self.Stickies) > 8 then
                    self.Stickies[1]:Remove()
                    table.remove(self.Stickies, 1)
                end
            end
        end
        self:EmitSound(self.Primary.Sound)
        if SERVER then
            self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self.Owner:SetAnimation(PLAYER_ATTACK1)
        end
        self:TakePrimaryAmmo(self.Primary.TakeAmmo)
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
        self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
        self.Idle = 0
        self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
        self.Recoil = 1
        self.RecoilTimer = CurTime() + 0.2
        self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(-3, 0, 0))
    end
end

function SWEP:SecondaryAttack()
    if CLIENT then return end
    if self.Stickies and #self.Stickies > 0 then
        for k, sticky in ipairs(self.Stickies) do
            if sticky:IsValid() then
                sticky:Remove()
            end
        end
        self.Stickies = {}
        self.Owner:EmitSound("horde/weapons/sticky_launcher/stickybomblauncher_det.wav")
    end
end

function SWEP:Reload()
    if CLIENT then return end
    if self.Reloading == 0 and self.Weapon:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() > 0 then
        self.Weapon:SendWeaponAnim( ACT_RELOAD_START )
        self.Owner:SetAnimation( PLAYER_RELOAD )
        self:SetNextPrimaryFire( CurTime() + 0.5 )
        self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.Reloading = 1
        self.ReloadingTimer = CurTime() + 0.4
        self.Idle = 1
    end
end

function SWEP:Think()
    if CLIENT then return end
    if self.Recoil == 1 and self.RecoilTimer <= CurTime() then
        self.Recoil = 0
    end
    if self.Recoil == 1 then
        self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( 0.23, 0, 0 ) )
    end
    if self.Reloading == 1 and self.ReloadingTimer <= CurTime() and self.Weapon:Clip1() < self.Primary.ClipSize and self.Weapon:Ammo1() > 0 then
        self.Owner:EmitSound("horde/weapons/sticky_launcher/stickybomblauncher_reload.wav")
        self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
        self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
        self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
        self.Reloading = 1
        self.ReloadingTimer = CurTime() + 0.675
        self.Idle = 1
    end
    if self.Reloading == 1 and self.ReloadingTimer <= CurTime() and self.Weapon:Clip1() == self.Primary.ClipSize then
        self.Weapon:SendWeaponAnim( ACT_RELOAD_FINISH )
        self:SetNextPrimaryFire( CurTime() + 0.5 )
        self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.Reloading = 0
        self.ReloadingTimer = CurTime() + 0.5
        self.Idle = 0
        self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
    end
    if self.Reloading == 1 and self.ReloadingTimer <= CurTime() and self.Weapon:Clip1() > 0 and self.Weapon:Ammo1() <= 0 then
        self.Weapon:SendWeaponAnim( ACT_RELOAD_FINISH )
        self:SetNextPrimaryFire( CurTime() + 0.5 )
        self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.Reloading = 0
        self.ReloadingTimer = CurTime() + 0.5
        self.Idle = 0
        self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
    end
    if self.Reloading == 2 and self.ReloadingTimer <= CurTime() then
        self.Weapon:SendWeaponAnim( ACT_RELOAD_FINISH )
        self:SetNextPrimaryFire( CurTime() + 0.5 )
        self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.Reloading = 3
        self.ReloadingTimer = CurTime() + 0.5
        self.Idle = 0
        self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
    end
    if self.Reloading == 3 and self.ReloadingTimer <= CurTime() then
        self.Reloading = 0
    end
    if self.Idle == 0 and self.IdleTimer <= CurTime() then
        if SERVER then
            self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
        end
        self.Idle = 1
    end
end

local lst = SysTime()
local function scrunkly()
    local ret = (SysTime() - (lst or SysTime())) * GetConVar("host_timescale"):GetFloat()
    return ret
end
local f_lerp = Lerp
local m_appor = math.Approach
local function ApprVecAng(from, to, dlt)
    local ret = (isangle(from) and isangle(to)) and Angle() or Vector()
    ret[1] = m_appor(from[1], to[1], dlt)
    ret[2] = m_appor(from[2], to[2], dlt)
    ret[3] = m_appor(from[3], to[3], dlt)

    return ret
end

function SWEP:GetViewModelPosition(pos, ang)
    if SERVER then return end
    local owner = self:GetOwner()
    if !IsValid(owner) or !owner:Alive() then return end
    local SP = game.SinglePlayer()
    local FT = scrunkly()
    local CT = CurTime()
    local TargetTick = (1 / FT) / 66.66

    if TargetTick < 1 then
        FT = FT * TargetTick
    end

    local FT5, FT10 = FT * 5, FT * 10
    local oldpos, oldang = Vector(), Angle()
    local asight = nil

    oldpos:Set(pos)
    oldang:Set(ang)

    actual = self.ActualVMData or {
        pos = Vector(),
        ang = Angle(),
        down = 1,
        sway = 1,
        bob = 1
    }

    local target = {}
    target.pos = self.ActivePos
    target.ang = self.ActiveAng
    target.down = 1
    target.sway = 2
    target.bob = 2

    local speed = target.speed or 3
    actual.pos = LerpVector(speed, actual.pos, target.pos)
    actual.ang = LerpAngle(speed, actual.ang, target.ang)
    actual.down = f_lerp(speed, actual.down, target.down)
    actual.sway = f_lerp(speed, actual.sway, target.sway)
    actual.bob = f_lerp(speed, actual.bob, target.bob)
    actual.evpos = f_lerp(speed, actual.evpos or Vector(), target.evpos or Vector())
    actual.evang = f_lerp(speed, actual.evang or Angle(), target.evang or Angle())
    actual.pos = ApprVecAng(actual.pos, target.pos, speed * 0.1)
    actual.ang = ApprVecAng(actual.ang, target.ang, speed * 0.1)
    actual.down = m_appor(actual.down, target.down, speed * 0.1)

    ang:RotateAroundAxis(oldang:Right(), actual.ang.x)
    ang:RotateAroundAxis(oldang:Up(), actual.ang.y)
    ang:RotateAroundAxis(oldang:Forward(), actual.ang.z)
    ang:RotateAroundAxis(oldang:Right(), actual.evang.x)
    ang:RotateAroundAxis(oldang:Up(), actual.evang.y)
    ang:RotateAroundAxis(oldang:Forward(), actual.evang.z)
    pos = pos + (oldang:Right() * actual.evpos.x)
    pos = pos + (oldang:Forward() * actual.evpos.y)
    pos = pos + (oldang:Up() * actual.evpos.z)
    pos = pos + actual.pos.x * ang:Right()
    pos = pos + actual.pos.y * ang:Forward()
    pos = pos + actual.pos.z * ang:Up()
    pos = pos - Vector(0, 0, actual.down)

    lst = SysTime()
    return pos, ang
end