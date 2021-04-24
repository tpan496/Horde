SWEP.PrintName              = "M2 Flamethrower (Horde)"
SWEP.Author					= "Sanikku, Syntax_Errorsanic, Gorlami"
SWEP.Category				= "ArcCW - Horde"
SWEP.Purpose				= "Bring forth flames upon your enemies!"
SWEP.Instructions			= "Primary: Fire"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel				= "models/weapons/sanic/c_m2.mdl"
SWEP.WorldModel				= "models/weapons/sanic/w_m2f2.mdl"
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
        local trace = self.Owner:GetEyeTrace()
        local Distance = self.Owner:GetPos():Distance(trace.HitPos)
        --if Distance < 520 then
            local Ignite = function()
                if !self:IsValid() then return end
                local flame = ents.Create("point_hurt")
                flame:SetPos(trace.HitPos)
                flame:SetOwner(self.Owner)
                flame:SetKeyValue("DamageRadius",128)
                flame:SetKeyValue("Damage", 10)
                flame:SetKeyValue("DamageDelay",0.32)
                flame:SetKeyValue("DamageType", DMG_BURN)
                flame:Spawn()
                flame:Fire("TurnOn","",0)
                flame:Fire("kill","",0.72)

                if trace.HitWorld then
                    local nearbystuff = ents.FindInSphere(trace.HitPos, 100)

                    for _, stuff in pairs(nearbystuff) do
                        if stuff != self.Owner then
                            if stuff:IsNPC() and (not stuff:GetNWEntity("HordeOwner"):IsPlayer()) then
                                if stuff:GetPhysicsObject():IsValid() then
                                    stuff:Ignite(math.random(12,16), 100)
                                end
                            end
                        end
                    end
                end

                if trace.Entity:IsValid() then
                    if trace.Entity:IsNPC() and (not trace.Entity:GetNWEntity("HordeOwner"):IsPlayer()) then
                        if trace.Entity:GetPhysicsObject():IsValid() then
                            trace.Entity:Ignite(math.random(12,16), 100)
                        end
                    end
                end

                if (SERVER) then
                    local firefx = EffectData()
                    firefx:SetOrigin(trace.HitPos)
                    util.Effect("m2_flame_explosion",firefx,true,true)
                end
            end
            timer.Simple(math.min(500, Distance)/1520, Ignite)
        --end
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
    self:EmitSound(Sound(self.ReloadSound))
    self.Weapon:DefaultReload(ACT_VM_RELOAD);
end