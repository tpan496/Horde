if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_hivehand" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_hivehand", "vgui/hud/horde_hivehand", Color( 255, 255, 255, 255 ) )
    killicon.Add( "obj_horde_hornet", "vgui/hud/horde_hivehand", Color( 255, 255, 255, 255 ) )
    killicon.Add( "obj_horde_hornet_alt", "vgui/hud/horde_hivehand", Color( 255, 255, 255, 255 ) )
end

sound.Add(
{
name = "Weapon_HL_Hivehand.Single",
channel = CHAN_WEAPON,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "horde/weapons/hornet/ag_fire1.wav",
"horde/weapons/hornet/ag_fire2.wav",
"horde/weapons/hornet/ag_fire3.wav" }
} )
sound.Add(
{
name = "Weapon_HL_Hivehand.Buzz",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "horde/hornet/ag_buzz1.wav",
"horde/weapons/hornet/ag_buzz2.wav",
"horde/weapons/hornet/ag_buzz3.wav" }
} )
sound.Add(
{
name = "Weapon_HL_Hivehand.Hit",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "horde/weapons/hornet/ag_hornethit1.wav",
"horde/weapons/hornet/ag_hornethit2.wav",
"horde/weapons/hornet/ag_hornethit3.wav" }
} )

SWEP.PrintName = "Hivehand"
SWEP.Category = "ArcCW - Horde"
SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 85
SWEP.ViewModel = "models/horde/weapons/v_hgun.mdl"
SWEP.WorldModel = "models/horde/weapons/w_hgun.mdl"
SWEP.ViewModelFlip = false
SWEP.BobScale = 1
SWEP.SwayScale = 0

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 3
SWEP.Slot = 3
SWEP.SlotPos = 3

SWEP.UseHands = false
SWEP.HoldType = "ar2"
SWEP.FiresUnderwater = true
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = 1
SWEP.Base = "weapon_base"

SWEP.RegenerationTimer = CurTime()
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Primary.Sound = Sound( "Weapon_HL_Hivehand.Single" )
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 8
SWEP.Primary.MaxAmmo = 8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Hornet"
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Delay = 0.25
SWEP.Primary.Force = 100

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0.1

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
    self.Idle = 0
    self.IdleTimer = CurTime() + 1
end

function SWEP:DrawHUD()
if CLIENT then
    local x, y
        if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
            local tr = util.GetPlayerTrace( self.Owner )
            local trace = util.TraceLine( tr )
            local coords = trace.HitPos:ToScreen()
            x, y = coords.x, coords.y
        else
            x, y = ScrW() / 2, ScrH() / 2
        end
        surface.SetTexture( surface.GetTextureID( "vgui/hud/hornetgun_crosshair" ) )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( x - 16, y - 16, 32, 32 )
    end
end

function SWEP:Deploy()
    self:SetWeaponHoldType( self.HoldType )
    self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
    self:SetNextPrimaryFire( CurTime() + 0.5 )
    self:SetNextSecondaryFire( CurTime() + 0.5 )
    self.RegenerationTimer = CurTime() + 0.5
    self.Idle = 0
    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
    return true
end

function SWEP:Holster()
    self.RegenerationTimer = CurTime()
    self.Idle = 0
    self.IdleTimer = CurTime()
    return true
end

function SWEP:PrimaryAttack()
if self.Weapon:Ammo1() <= 0 then return end
if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then return end
if SERVER then
    local entity = ents.Create( "obj_horde_hornet" )
    entity:SetOwner( self.Owner )
    entity:SetNWEntity("HordeOwner", self.Owner)
    if IsValid( entity ) then
        self.Owner:Horde_SetMinionCount(self.Owner:Horde_GetMinionCount() + 1)
        local Forward = self.Owner:EyeAngles():Forward()
        local Right = self.Owner:EyeAngles():Right()
        local Up = self.Owner:EyeAngles():Up()
        entity:SetPos( self.Owner:GetShootPos() + Forward * 12 + Right * 4 + Up * -6 )
        entity:SetAngles( self.Owner:EyeAngles() )
        entity:Spawn()
        local phys = entity:GetPhysicsObject()
        phys:SetMass( 1 )
        phys:EnableGravity( false )
        timer.Create( "Flight"..entity:EntIndex(), 0, 0, function()
        if !IsValid( phys ) then
            timer.Stop( "Flight" )
        end
        if IsValid( entity ) and IsValid( phys ) then
            phys:ApplyForceCenter( entity:GetForward() * 100 )
        end
        end)
    end
end
    self:EmitSound( self.Primary.Sound )
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self:TakePrimaryAmmo( self.Primary.TakeAmmo )
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
    self.RegenerationTimer = CurTime() + 0.5
    self.Idle = 0
    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:SecondaryAttack()
    if self.Weapon:Ammo1() <= 0 then return end
    if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then return end
    if SERVER then
        local entity = ents.Create( "obj_horde_hornet_alt" )
        entity:SetOwner( self.Owner )
        entity:SetNWEntity("HordeOwner", self.Owner)
        if IsValid( entity ) then
            self.Owner:Horde_SetMinionCount(self.Owner:Horde_GetMinionCount() + 1)
            local Forward = self.Owner:EyeAngles():Forward()
            local Right = self.Owner:EyeAngles():Right()
            local Up = self.Owner:EyeAngles():Up()
            entity:SetPos( self.Owner:GetShootPos() + Forward * 12 + Right * 4 + Up * -6 )
            entity:SetAngles( self.Owner:EyeAngles() )
            entity:Spawn()
            local phys = entity:GetPhysicsObject()
            phys:SetMass( 1 )
            phys:EnableGravity( false )
            timer.Create( "Flight"..entity:EntIndex(), 0, 0, function()
                if !IsValid( phys ) then
                    timer.Stop( "Flight" )
                end
                if IsValid( entity ) and IsValid( phys ) then
                    phys:ApplyForceCenter( entity:GetForward() * 100 )
                end
            end)
        end
    end
    self:EmitSound( self.Primary.Sound )
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self:TakePrimaryAmmo( self.Primary.TakeAmmo )
    self:SetNextPrimaryFire( CurTime() + self.Secondary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
    self.RegenerationTimer = CurTime() + 0.5
    self.Idle = 0
    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Reload()
end

function SWEP:Think()
    if self.RegenerationTimer <= CurTime() and self.Weapon:Ammo1() < self.Primary.MaxAmmo then
        self.Owner:SetAmmo( self.Weapon:Ammo1() + 1, self.Primary.Ammo )
        self.RegenerationTimer = CurTime() + 0.5
    end
    if self.Idle == 0 and self.IdleTimer <= CurTime() then
        if SERVER then
            self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
        end
        self.Idle = 1
    end
    if self.Weapon:Ammo1() > self.Primary.MaxAmmo then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, self.Primary.Ammo )
    end
end