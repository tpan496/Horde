SWEP.Author						= "Sanikku & Syntax_Errorsanic"
SWEP.Category					= "ArcCW - Horde"
SWEP.Purpose					= "Bring forth flames upon your enemies!"
SWEP.Instructions				= "Left-Click: Fire\nReload: Regenerate Fuel"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= true

SWEP.ViewModel					= "models/weapons/sanic/c_m2.mdl"
SWEP.WorldModel					= "models/weapons/sanic/w_m2f2.mdl"
SWEP.UseHands			        = true
SWEP.ViewModelFOV      			= 50

SWEP.HoldType					= "smg"
SWEP.Primary.Automatic			= true
SWEP.Primary.ClipSize			= 100
SWEP.Primary.DefaultClip		= 100
SWEP.Primary.Ammo				= "ar2"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.ReloadDelay 				= 0.5
SWEP.Delay = 0.08

SWEP.ReloadSound = "vehicles/tank_readyfire1.wav"

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
    if ( !self:CanPrimaryAttack() ) then return end

    self:TakePrimaryAmmo(1)
    self.Owner:MuzzleFlash()
    self.Weapon:SetNextPrimaryFire( CurTime() + self.Delay )
    if (SERVER) then
        local trace = self.Owner:GetEyeTrace()
        local Distance = self.Owner:GetPos():Distance(trace.HitPos)
        if Distance < 520 then
            local Ignite = function()
                if !self:IsValid() then return end
                local flame = ents.Create("point_hurt")
                flame:SetPos(trace.HitPos)
                flame:SetOwner(self.Owner)
                flame:SetKeyValue("DamageRadius",128)
                flame:SetKeyValue("Damage",10)
                flame:SetKeyValue("DamageDelay",0.32)
                flame:SetKeyValue("DamageType", DMG_BURN)
                flame:Spawn()
                flame:Fire("TurnOn","",0)
                flame:Fire("kill","",0.72)
                if trace.HitWorld then
                    local nearbystuff = ents.FindInSphere(trace.HitPos, 100)
                    
                    for _, stuff in pairs(nearbystuff) do
                        if stuff != self.Owner then
                            if stuff:GetPhysicsObject():IsValid() && !stuff:IsNPC() && !stuff:IsPlayer() then
                                if !stuff:IsOnFire() then stuff:Ignite(math.random(16,32), 100) end
                            end
                            if stuff:IsPlayer() then
                                if stuff:GetPhysicsObject():IsValid() then
                                    stuff:Ignite(1, 100)
                                end
                            end
                            
                            if stuff:IsNPC() then
                                if stuff:GetPhysicsObject():IsValid() then
                                    local npc = stuff:GetClass()
                                    if npc == "npc_antlionguard" || npc == "npc_hunter" || npc == "npc_kleiner" || npc == "npc_gman" || npc == "npc_eli" || npc == "npc_alyx" || npc == "npc_mossman" || npc == "npc_breen" || npc == "npc_monk" || npc == "npc_vortigaunt" || npc == "npc_citizen" || npc == "npc_rebel" || npc == "npc_barney" || npc == "npc_magnusson" then
                                        stuff:Fire("Ignite","",1)
                                    end
                                    stuff:Ignite(math.random(12,16), 100)
                                end
                            end
                        end
                    end
                end
                
                if trace.Entity:IsValid() then
                    if trace.Entity:GetPhysicsObject():IsValid() && !trace.Entity:IsNPC() && !trace.Entity:IsPlayer() then
                        if !trace.Entity:IsOnFire() then trace.Entity:Ignite(math.random(16,32), 100) end
                    end
                    
                    if trace.Entity:IsPlayer() then
                        if trace.Entity:GetPhysicsObject():IsValid() then trace.Entity:Ignite(math.random(1,2), 100) end
                    end
                    
                    if trace.Entity:IsNPC() then
                        if trace.Entity:GetPhysicsObject():IsValid() then
                            local npc = trace.Entity:GetClass()
                            if npc == "npc_antlionguard" || npc == "npc_hunter" || npc == "npc_kleiner" || npc == "npc_gman" || npc == "npc_eli" || npc == "npc_alyx" || npc == "npc_mossman" || npc == "npc_breen" || npc == "npc_monk" || npc == "npc_vortigaunt" || npc == "npc_citizen" || npc == "npc_rebel" || npc == "npc_barney" || npc == "npc_magnusson" then
                                trace.Entity:Fire("Ignite","",1)
                            end
                            trace.Entity:Ignite(math.random(12,16), 100)
                        end
                    end
                end
                
                if (SERVER) then
                    local firefx = EffectData()
                    firefx:SetOrigin(trace.HitPos)
                    util.Effect("weapon_sanic_m2_explosion",firefx,true,true)
                end
            end
            timer.Simple(Distance/1520, Ignite)
        end
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
		if (SERVER) then
			self.Owner:EmitSound("ambient/fire/mtov_flame2.wav", 24, 100 )
		end
	end
	
    if self.Owner:KeyDown(IN_ATTACK) then
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
            util.Effect("effect_sanic_m2_raflam",flamefx,true,true)
        end
    end
end

function SWEP:Reload()
    self:EmitSound(Sound(self.ReloadSound)) 
    self.Weapon:DefaultReload( ACT_VM_RELOAD );
end