
sound.Add({
name = "Weapon_Horde_Tau_Cannon.Single",
channel = CHAN_WEAPON,
volume = VOL_NORM,
soundlevel = SNDLVL_GUNFIRE,
sound = {"horde/weapons/gauss/single1.ogg", "horde/weapons/gauss/single2.ogg"}
})
sound.Add({
name = "Weapon_Horde_Tau_Cannon.Double",
channel = CHAN_WEAPON,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = "horde/weapons/gauss/pulsemachine.ogg"
})
sound.Add({
name = "Weapon_Horde_Tau_Cannon.Double_2",
channel = CHAN_WEAPON,
volume = VOL_NORM,
pitch = 150,
soundlevel = SNDLVL_NORM,
sound = "horde/weapons/gauss/pulsemachine.ogg"
})
sound.Add({
name = "Weapon_Horde_Tau_Cannon.Double_3",
channel = CHAN_WEAPON,
volume = VOL_NORM,
pitch = 200,
soundlevel = SNDLVL_NORM,
sound = "horde/weapons/gauss/pulsemachine.ogg"
})
sound.Add({
name = "Weapon_Horde_Tau.Electro",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "horde/weapons/gauss/charged.ogg" }
})
sound.Add({
name = "Weapon_Horde_Tau_Cannon.Explode",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "horde/weapons/gauss/gauss_overcharged.ogg" }
})
sound.Add({
name = "Weapon_Horde_Tau_Cannon.DryFire",
channel = CHAN_ITEM,
volume = VOL_NORM,
soundlevel = SNDLVL_NORM,
sound = { "horde/weapons/gauss/empty.ogg" }
})

if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_tau" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_tau", "vgui/hud/horde_tau", Color( 255, 255, 255, 255 ) )
end
SWEP.Firemodes = {
    {
        Mode = 0
    }
}
SWEP.PrintName = "Tau Cannon"
SWEP.Category = "ArcCW - Horde"
SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 85
SWEP.ViewModel = "models/horde/weapons/v_gauss.mdl"
SWEP.WorldModel = "models/horde/weapons/w_gauss.mdl"
SWEP.ViewModelFlip = false
SWEP.BobScale = 1
SWEP.SwayScale = 0

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 7
SWEP.Slot = 3
SWEP.SlotPos = 0

SWEP.UseHands = false
SWEP.HoldType = "ar2"
SWEP.FiresUnderwater = true
SWEP.CSMuzzleFlashes = 1
SWEP.Base = "weapon_base"

SWEP.Spin = 0
SWEP.SpinTimer = CurTime()
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Primary.Sound = Sound( "Weapon_Horde_Tau_Cannon.Single" )
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.MaxAmmo = 9999
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "GaussEnergy"
SWEP.Primary.Damage = 55
SWEP.Primary.Spread = 0
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Delay = 0.2
SWEP.Primary.Force = 1

SWEP.Secondary.Sound = Sound( "Weapon_Horde_Tau_Cannon.Double" )
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Damage = 60
SWEP.Secondary.TakeAmmo = 5
SWEP.ReloadSound            = "ambient/machines/keyboard2_clicks.wav"

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

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
    self.Idle = 0
    self.IdleTimer = CurTime() + 1
end

function SWEP:Deploy()
    self:SetWeaponHoldType( self.HoldType )
    self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
    self:SetNextPrimaryFire( CurTime() + 0.5 )
    self:SetNextSecondaryFire( CurTime() + 0.5 )
    self.Spin = 0
    self.SpinTimer = CurTime()
    self.Idle = 0
    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
    return true
end

function SWEP:Holster()
    self.Spin = 0
    self.SpinTimer = CurTime()
    self.Idle = 0
    self.IdleTimer = CurTime()
    self:StopSound( self.Secondary.Sound )
    if SERVER then
        self.Owner:StopSound( "Weapon_Horde_Tau_Cannon.Double_2" )
        self.Owner:StopSound( "Weapon_Horde_Tau_Cannon.Double_3" )
    end
    return true
end

function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    if self.Spin == 1 then return end
    if self.Weapon:Ammo1() <= 0 then
        self.Weapon:EmitSound( "Weapon_Horde_Tau_Cannon.DryFire" )
        self:SetNextPrimaryFire( CurTime() + 0.2 )
        self:SetNextSecondaryFire( CurTime() + 0.2 )
    end
    if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then
        self.Weapon:EmitSound( "Weapon_Horde_Tau_Cannon.DryFire" )
        self:SetNextPrimaryFire( CurTime() + 0.2 )
        self:SetNextSecondaryFire( CurTime() + 0.2 )
    end
    if self.Weapon:Ammo1() <= 0 then return end
    if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then return end
    local tr = self.Owner:GetEyeTrace()
    local effectdata = EffectData()
    effectdata:SetOrigin( tr.HitPos )
    effectdata:SetNormal( tr.HitNormal )
    effectdata:SetStart( self.Owner:GetShootPos() )
    effectdata:SetAttachment( 1 )
    effectdata:SetEntity( self.Weapon )
    util.Effect( "tau_beam", effectdata )
    local bullet = {}
    bullet.Callback = function (attacker, ttt, dmginfo)
        dmginfo:SetDamageType(DMG_BURN)
    end
    bullet.Num = self.Primary.NumberofShots
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Spread = Vector( 1 * self.Primary.Spread, 1 * self.Primary.Spread, 0 )
    bullet.Tracer = 0
    bullet.Force = self.Primary.Force
    bullet.Damage = self.Primary.Damage
    bullet.AmmoType = self.Primary.Ammo
    self.Owner:FireBullets( bullet )
    self:EmitSound( self.Primary.Sound )
    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self.Owner:MuzzleFlash()
    self:TakePrimaryAmmo( self.Primary.TakeAmmo )
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
    self.Idle = 0
    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:SecondaryAttack()
    if (not self:CanPrimaryAttack()) then return end
    if self.Spin == 1 then return end
    if self.Weapon:Ammo1() < 5 then
        self.Weapon:EmitSound( "Weapon_Horde_Tau_Cannon.DryFire" )
        self:SetNextPrimaryFire( CurTime() + 0.2 )
        self:SetNextSecondaryFire( CurTime() + 0.2 )
    end
    if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then
        self.Weapon:EmitSound( "Weapon_Horde_Tau_Cannon.DryFire" )
        self:SetNextPrimaryFire( CurTime() + 0.2 )
        self:SetNextSecondaryFire( CurTime() + 0.2 )
    end
    if self.Weapon:Ammo1() < 5 then return end
    if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then return end
    self:EmitSound( self.Secondary.Sound )
    self.Weapon:SendWeaponAnim( ACT_GAUSS_SPINUP )
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
    self.Spin = 1
    self.SpinTimer = CurTime() + 7
    self.Idle = 0
    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Reload()
    if self:Clip1() >= self:GetMaxClip1() then return end
    self:EmitSound(Sound(self.ReloadSound))
    self.Weapon:DefaultReload(ACT_VM_RELOAD);
end

function SWEP:Think()
    if self.Spin == 1 then
        if self.SpinTimer < CurTime() + 6.5 and self.SpinTimer > CurTime() + 6.48 then
            self:StopSound( self.Secondary.Sound )
            if SERVER then
                self.Owner:EmitSound( "Weapon_Horde_Tau_Cannon.Double_2" )
            end
        end
        if self.SpinTimer < CurTime() + 6 and self.SpinTimer > CurTime() + 5.98 then
            if SERVER then
                self.Owner:StopSound( "Weapon_Horde_Tau_Cannon.Double_2" )
                self.Owner:EmitSound( "Weapon_Horde_Tau_Cannon.Double_3" )
            end
        end
    end
    if self.Spin == 1 and !self.Owner:KeyDown( IN_ATTACK2 ) then
        local tr = self.Owner:GetEyeTrace()
        local effectdata = EffectData()
        effectdata:SetOrigin( tr.HitPos )
        effectdata:SetNormal( tr.HitNormal )
        effectdata:SetStart( self.Owner:GetShootPos() )
        effectdata:SetAttachment( 1 )
        effectdata:SetEntity( self.Weapon )
        util.Effect( "tau_beam", effectdata )
        local bullet = {}
        bullet.Callback = function (attacker, ttt, dmginfo)
            dmginfo:SetDamageType(DMG_BURN)
        end
        bullet.Num = self.Primary.NumberofShots
        bullet.Src = self.Owner:GetShootPos()
        bullet.Dir = self.Owner:GetAimVector()
        bullet.Spread = Vector( 1 * self.Primary.Spread, 1 * self.Primary.Spread, 0 )
        bullet.Tracer = 0
        bullet.Force = self.Primary.Force
        if self.SpinTimer > CurTime() + 6.5 and self.SpinTimer <= CurTime() + 7 then
            bullet.Damage = self.Secondary.Damage
        end
        if self.SpinTimer > CurTime() + 6 and self.SpinTimer <= CurTime() + 6.5 then
            bullet.Damage = self.Secondary.Damage * 5
        end
        if self.SpinTimer <= CurTime() + 6 then
            bullet.Damage = self.Secondary.Damage * 10
        end
        bullet.AmmoType = self.Primary.Ammo
        self.Owner:FireBullets( bullet )
        self:EmitSound( self.Primary.Sound )
        self:StopSound( self.Secondary.Sound )
        if SERVER then
            self.Owner:StopSound( "Weapon_Horde_Tau_Cannon.Double_2" )
            self.Owner:StopSound( "Weapon_Horde_Tau_Cannon.Double_3" )
            self.Owner:EmitSound( "Weapon_Horde_Tau.Electro" )
        end
        self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
        self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:MuzzleFlash()
        if self.SpinTimer > CurTime() + 6.5 and self.SpinTimer <= CurTime() + 7 then
            self:TakePrimaryAmmo(math.min(self.Weapon:Clip1(), self.Secondary.TakeAmmo ))
        end
        if self.SpinTimer > CurTime() + 6 and self.SpinTimer <= CurTime() + 6.5 then
            self:TakePrimaryAmmo( math.min(self.Weapon:Clip1(), 5 ) )
        end
        if self.SpinTimer <= CurTime() + 6 then
            self:TakePrimaryAmmo( math.min(self.Weapon:Clip1(), 10 ) )
        end
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
        self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
        self.Spin = 0
        self.Idle = 0
        self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
        if self.SpinTimer > CurTime() + 6.5 and self.SpinTimer <= CurTime() + 7 then
            self.Owner:SetVelocity( self.Owner:GetForward() * -200 )
        end
        if self.SpinTimer > CurTime() + 6 and self.SpinTimer <= CurTime() + 6.5 then
            self.Owner:SetVelocity( self.Owner:GetForward() * -300 )
        end
        if self.SpinTimer <= CurTime() + 6 then
            self.Owner:SetVelocity( self.Owner:GetForward() * -400 )
        end
    end
    if self.Idle == 0 and self.IdleTimer <= CurTime() then
        if SERVER then
            if self.Spin == 0 then
                self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
            end
            if self.Spin == 1 then
                self.Weapon:SendWeaponAnim( ACT_GAUSS_SPINCYCLE )
            end
        end
        self.Idle = 1
    end
    if self.Weapon:Ammo1() > self.Primary.MaxAmmo then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, self.Primary.Ammo )
    end
    if self.Spin == 1 and self.SpinTimer <= CurTime() then
        if SERVER then
            local explode = ents.Create( "env_explosion" )
            explode:SetOwner( self.Owner )
            explode:SetPos( self:GetPos() )
            explode:Spawn()
            explode:Fire( "Explode", 0, 0 )
            self.Owner:StopSound( "Weapon_Horde_Tau_Cannon.Double_2" )
            self.Owner:StopSound( "Weapon_Horde_Tau_Cannon.Double_3" )
            self.Owner:EmitSound( "Weapon_Horde_Tau_Cannon.Explode" )
        end
        self:StopSound( self.Secondary.Sound )
        util.BlastDamage( self, self.Owner, self:GetPos(), 256, 50 )
    end
end