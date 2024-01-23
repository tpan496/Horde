SWEP.PrintName = "M2 Health Thrower"
SWEP.Author = "Sanikku, Syntax_Errorsanic, Gorlami"
SWEP.Category = "ArcCW - Horde (Custom)"
SWEP.Purpose = "Heal your enemies to death like god intended"
SWEP.Instructions = "Primary: Fire"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/c_healthrower.mdl"
SWEP.WorldModel = "models/weapons/w_healthrower.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 72
SWEP.Slot = 3

SWEP.HoldType = "smg"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Ammo = "horde_m2_flamethrower"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.ReloadDelay = 2
SWEP.Delay = 0.1
SWEP.ReloadSound = "ambient/machines/keyboard2_clicks.wav"
--SWEP.Duration = 4
if (CLIENT) then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/horde_m2")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("horde_m2", "vgui/hud/horde_m2", color_white)
    killicon.Add("entityflame", "vgui/hud/fire", color_white)
end

function SWEP:DrawHUD()
    if CLIENT then
        local owner = self:GetOwner()
    local x, y
    if ( owner == LocalPlayer() and owner:ShouldDrawLocalPlayer() ) then
    local tr = util.GetPlayerTrace( owner )
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
    PrecacheParticleSystem("medic_flame")
    PrecacheParticleSystem("medic_flame_explosion")
end


function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    if (not self:CanPrimaryAttack()) then return end
    self:TakePrimaryAmmo(1)
    owner:MuzzleFlash()
    self:SetNextPrimaryFire( CurTime() + self.Delay )
    if SERVER then
        local eyetrace = owner:GetEyeTrace()
        local tracedata = {}
        tracedata.start = owner:GetShootPos()
        tracedata.endpos = owner:GetShootPos() + (owner:GetAimVector() * 500)
        tracedata.filter = owner
        tracedata.mins = Vector(-25,-25,-25)
        tracedata.maxs = Vector(25,25,25)
        local trace = util.TraceHull(tracedata)
        local Distance = owner:GetPos():Distance(trace.HitPos)
        local Ignite = function()
            if not self:IsValid() then return end
            if not owner:IsValid() then return end
            local dmg = DamageInfo()
            dmg:SetAttacker(owner)
            dmg:SetInflictor(self)
            dmg:SetDamageType(DMG_NERVEGAS)
            dmg:SetDamage(40)
            dmg:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
            util.BlastDamageInfo(dmg, trace.HitPos, 128)
            for _, ent in pairs(ents.FindInSphere(trace.HitPos, 150)) do
             if ent:IsPlayer() then
                    local healinfo = HealInfo:New({amount = 5, healer = owner})
                    HORDE:OnPlayerHeal(ent, healinfo)
                elseif ent:GetClass() == "npc_vj_horde_antlion" then
                    local healinfo = HealInfo:New({amount = 5, healer = owner})
                    HORDE:OnAntlionHeal(ent, healinfo)
                end
            end
            if SERVER and trace.Hit then
                local firefx = EffectData()
                firefx:SetOrigin(trace.HitPos)
                firefx:SetScale(1)
                firefx:SetEntity(self.owner)
                util.Effect("medic_flame_explosion",firefx,true,true)
            end
    end
        timer.Simple(math.min(500, Distance) / 1520, Ignite)
    end
        end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
    local owner = self:GetOwner()
    self:SendWeaponAnim(ACT_VM_DRAW)
    if SERVER then
        owner:EmitSound("ambient/machines/keyboard2_clicks.wav", 42, 100 )
    end
    return true
end

function SWEP:Think()
    local owner = self:GetOwner()
    if owner:KeyReleased(IN_ATTACK) then
     if (not self:CanPrimaryAttack()) then return end
        if SERVER then
            self:SendWeaponAnim(ACT_VM_IDLE)
            owner:EmitSound("ambient/fire/mtov_flame2.wav", 24, 100 )
        end
    end

    if owner:KeyDown(IN_ATTACK) then
        if (not self:CanPrimaryAttack()) then return end
        if SERVER then
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            owner:EmitSound("ambient/fire/mtov_flame2.wav", math.random(27,35), math.random(32,152) )
            owner:EmitSound("ambient/machines/thumper_dust.wav", math.random(27,35), math.random(32,152) )
        end
        local trace = owner:GetEyeTrace()
        if SERVER then
            local flamefx = EffectData()
            flamefx:SetOrigin(trace.HitPos)
            flamefx:SetStart(owner:GetShootPos())
            flamefx:SetAttachment(1)
            flamefx:SetEntity(self)
            util.Effect("medic_flame",flamefx,true,true)
        end
    end
end

function SWEP:Reload()
    if self:Clip1() >= self:GetMaxClip1() then return end
    self:EmitSound(Sound(self.ReloadSound))
    self:DefaultReload(ACT_VM_RELOAD);
end