if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_gluon" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_gluon", "vgui/hud/horde_gluon", Color( 255, 255, 255, 255 ) )
end

sound.Add(
{
name = "Weapon_HL_Gluon_Gun.Single",
channel = CHAN_WEAPON,
volume = VOL_NORM,
soundlevel = SNDLVL_GUNFIRE,
sound = "horde/weapons/gluon/egon_windup2.ogg"
} )
sound.Add(
{
name = "Weapon_HL_Gluon_Gun.Double",
channel = CHAN_WEAPON,
volume = VOL_NORM,
soundlevel = SNDLVL_GUNFIRE,
sound = "horde/weapons/gluon/egon_off1.ogg"
} )
sound.Add(
{
name = "Weapon_HL_Gluon_Gun.Run",
channel = CHAN_WEAPON,
volume = VOL_NORM,
soundlevel = SNDLVL_GUNFIRE,
sound = "horde/weapons/gluon/egon_run3.ogg"
})

SWEP.PrintName = "Gluon Gun"
SWEP.Category = "ArcCW - Horde"
SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false


SWEP.UseHands = true

SWEP.ViewModelFOV = 85
SWEP.ViewModel = "models/horde/weapons/v_gluon.mdl"
SWEP.WorldModel = "models/horde/weapons/w_gluon.mdl"
SWEP.ViewModelFlip = false
SWEP.BobScale = 1
SWEP.SwayScale = 0

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 7
SWEP.Slot = 3
SWEP.SlotPos = 2

SWEP.UseHands = false
SWEP.HoldType = "ar2"
SWEP.FiresUnderwater = true
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = 1
SWEP.Base = "weapon_base"

SWEP.Sound = 0
SWEP.SoundTimer = CurTime()
SWEP.Attack = 0
SWEP.AttackTimer = CurTime()
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Primary.Sound = Sound( "Weapon_HL_Gluon_Gun.Single" )
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 50
SWEP.Primary.MaxAmmo = 9999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "GaussEnergy"
SWEP.Primary.Damage = 15
SWEP.Primary.Spread = 0
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = 1


SWEP.Secondary.Sound = Sound( "Weapon_HL_Gluon_Gun.Double" )
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.ReloadSound            = "ambient/machines/keyboard2_clicks.wav"

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
surface.SetTexture( surface.GetTextureID( "vgui/hud/special_crosshair" ) )
surface.SetDrawColor( 255, 255, 255, 255 )
surface.DrawTexturedRect( x - 16, y - 16, 32, 32 )
end
end

function SWEP:Deploy()
self:SetWeaponHoldType( self.HoldType )
self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
self:SetNextPrimaryFire( CurTime() + 0.5 )
self:SetNextSecondaryFire( CurTime() + 0.5 )
self.Sound = 0
self.SoundTimer = CurTime()
self.Attack = 0
self.AttackTimer = CurTime()
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
return true
end

function SWEP:Holster()
self.Sound = 0
self.SoundTimer = CurTime()
self.Attack = 0
self.AttackTimer = CurTime()
self.Idle = 0
self.IdleTimer = CurTime()
if SERVER then
self.Owner:StopSound( "Weapon_HL_Gluon_Gun.Run" )
end
self:StopSound( self.Primary.Sound )
return true
end

function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    if self.Weapon:Clip1() <= 0 then
        self.Weapon:EmitSound( "HL.DryFire" )
        self:SetNextPrimaryFire( CurTime() + 0.2 )
        self:SetNextSecondaryFire( CurTime() + 0.2 )
    end
    if self.AttacksUnderwater == false and self.Owner:WaterLevel() == 3 then
        self.Weapon:EmitSound( "HL.DryFire" )
        self:SetNextPrimaryFire( CurTime() + 0.2 )
        self:SetNextSecondaryFire( CurTime() + 0.2 )
    end
    local bullet = {}
    bullet.Num = self.Primary.NumberofShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector( 1 * self.Primary.Spread, 1 * self.Primary.Spread, 0 )
    bullet.Tracer = 0
    bullet.Force = self.Primary.Force
    bullet.Damage = self.Primary.Damage
    bullet.AmmoType = self.Primary.Ammo
    bullet.Distance = 1000
    bullet.Callback = function (ent, tr, dmginfo)
        dmginfo:SetDamageType(DMG_BURN)
        local dmg = DamageInfo()
		dmg:SetAttacker(self.Owner)
		dmg:SetInflictor(self)
		dmg:SetDamageType(DMG_BURN)
		dmg:SetDamage(8)
		util.BlastDamageInfo(dmg, tr.HitPos, 100)
        util.Decal("Scorch", tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
    end
    self.Owner:FireBullets( bullet )
    if self.Attack == 0 then
        self:EmitSound( self.Primary.Sound )
        self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Sound = 1
        self.SoundTimer = CurTime() + 2
    end
    self:TakePrimaryAmmo( self.Primary.TakeAmmo )
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
    self.Attack = 1
    self.AttackTimer = CurTime() + self.Primary.Delay + 0.05
    self.Idle = 1
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
    if self.Attack == 1 and self.Sound == 1 and self.SoundTimer <= CurTime() then
        self:StopSound( self.Primary.Sound )
        if SERVER then
            self.Owner:EmitSound( "Weapon_HL_Gluon_Gun.Run" )
        end
        self.Sound = 0
    end
    if self.Attack == 1 then
        local tr = self.Owner:GetEyeTrace()
        local effectdata = EffectData()
        effectdata:SetOrigin( tr.HitPos )
        effectdata:SetNormal( tr.HitNormal )
        effectdata:SetStart( self.Owner:GetShootPos() )
        effectdata:SetAttachment( 1 )
        effectdata:SetEntity( self.Weapon )
        util.Effect( "gluon_beam", effectdata )
    end
    if self.Attack == 1 and self.AttackTimer <= CurTime() then
        if SERVER then
            self.Owner:StopSound( "Weapon_HL_Egon.Run" )
        end
        self:StopSound( self.Primary.Sound )
        self:EmitSound( self.Secondary.Sound )
        self.Idle = 0
        self.IdleTimer = CurTime()
        self.Attack = 0
    end
    if self.Attack == 1 and self.Weapon:Ammo1() <= 0 then
        if SERVER then
            self.Owner:StopSound( "Weapon_HL_Egon.Run" )
        end
        self:StopSound( self.Primary.Sound )
        self:EmitSound( self.Secondary.Sound )
        self.Idle = 0
        self.IdleTimer = CurTime()
        self.Attack = 0
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

function SWEP:Reload()
    if self:Clip1() >= self:GetMaxClip1() then return end
    self:EmitSound(Sound(self.ReloadSound))
    self.Weapon:DefaultReload( ACT_VM_IDLE );
end