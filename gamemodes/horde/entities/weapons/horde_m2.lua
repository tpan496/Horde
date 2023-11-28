SWEP.PrintName              = "M2 Flamethrower (Horde)"
SWEP.Author					= "Sanikku, Syntax_Errorsanic, Gorlami"
SWEP.Category				= "ArcCW - Horde"
SWEP.Purpose				= "Bring forth flames upon your enemies!"
SWEP.Instructions			= "Primary: Fire"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel				= "models/horde/weapons/c_m2.mdl"
SWEP.WorldModel				= "models/horde/weapons/w_m2f2.mdl"
SWEP.UseHands			    = true
SWEP.ViewModelFOV      		= 50
SWEP.Slot                   = 3

SWEP.HoldType				= "smg"
SWEP.Primary.Automatic		= true
SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Ammo			= "ar2"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		    = "none"
SWEP.ReloadDelay 			= 2
SWEP.Delay                  = 0.08
SWEP.ReloadSound            = "ambient/machines/keyboard2_clicks.wav"

if (CLIENT) then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/horde_m2")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
	killicon.Add("horde_m2", "vgui/hud/horde_m2", color_white)
    killicon.Add("entityflame", "vgui/hud/fire", color_white)
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

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end

function SWEP:Precache()
	util.PrecacheSound("ambient/machines/keyboard2_clicks.wav")
	util.PrecacheSound("ambient/machines/thumper_dust.wav")
	util.PrecacheSound("ambient/fire/mtov_flame2.wav")
	util.PrecacheSound("ambient/fire/ignite.wav")
	util.PrecacheSound("vehicles/tank_readyfire1.wav")
end

function SWEP:PrimaryAttack()
    if (not self:CanPrimaryAttack()) then return end

    self:TakePrimaryAmmo(1)
    self.Owner:MuzzleFlash()
    self.Weapon:SetNextPrimaryFire( CurTime() + self.Delay )
    if (SERVER) then
        local eyetrace = self.Owner:GetEyeTrace()
        local tracedata = {}
        tracedata.start = self.Owner:GetShootPos()
        tracedata.endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 500)
        tracedata.filter = self.Owner
        tracedata.mins = Vector(-25,-25,-25)
        tracedata.maxs = Vector(25,25,25)
        local trace = util.TraceHull(tracedata)
        local Distance = self.Owner:GetPos():Distance(trace.HitPos)
        local Ignite = function()
            if not self:IsValid() then return end
            if not self.Owner:IsValid() then return end
            local dmg = DamageInfo()
            dmg:SetAttacker(self.Owner)
            dmg:SetInflictor(self)
            dmg:SetDamageType(DMG_BURN)
            dmg:SetDamage(15)
            util.BlastDamageInfo(dmg, trace.HitPos, 128)

            if (SERVER) and trace.Hit then
                local firefx = EffectData()
                firefx:SetOrigin(trace.HitPos)
                firefx:SetScale(1)
                firefx:SetEntity(self.Weapon.Owner)
                util.Effect("m2_flame_explosion",firefx,true,true)
            end
        end
        timer.Simple(math.min(500, Distance)/1520, Ignite)
    end
end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	if (SERVER) then
		self.Owner:EmitSound("ambient/machines/keyboard2_clicks.wav", 42, 100 )
	end
	return true
end

function SWEP:Think()
	if self.Owner:KeyReleased(IN_ATTACK) then
        if (not self:CanPrimaryAttack()) then return end
		if (SERVER) then
			self.Owner:EmitSound("ambient/fire/mtov_flame2.wav", 24, 100 )
		end
	end

    if self.Owner:KeyDown(IN_ATTACK) then
        if (not self:CanPrimaryAttack()) then return end
        if (SERVER) then
            self.Owner:EmitSound("ambient/fire/mtov_flame2.wav", math.random(27,35), math.random(32,152) )
            self.Owner:EmitSound("ambient/machines/thumper_dust.wav", math.random(27,35), math.random(32,152) )
        end
        local trace = self.Owner:GetEyeTrace()
        if (SERVER) then
            local flamefx = EffectData()
            flamefx:SetOrigin(trace.HitPos)
            flamefx:SetStart(self.Owner:GetShootPos())
            flamefx:SetAttachment(1)
            flamefx:SetEntity(self.Weapon)
            util.Effect("m2_flame",flamefx,true,true)
        end
    end
end

function SWEP:Reload()
    if self:Clip1() >= self:GetMaxClip1() then return end
    self:EmitSound(Sound(self.ReloadSound))
    self.Weapon:DefaultReload(ACT_VM_RELOAD);
end