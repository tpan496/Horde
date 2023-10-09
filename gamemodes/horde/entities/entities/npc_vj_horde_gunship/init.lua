AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

ENT.Model = {"models/gunship.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 200
ENT.HullType = HULL_MEDIUM
ENT.MovementType = VJ_MOVETYPE_AERIAL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE", "CLASS_PLAYER_ALLY"}
ENT.HasDeathRagdoll = false
ENT.Aerial_TargetPos = Vector(1000,1000,1000)
ENT.DeathSoundLevel = 100
ENT.Immune_Blast = true

ENT.WeaponSpread = 0.8
ENT.ShootDistance = 1000
ENT.Weapon_FiringDistanceFar = 1000
ENT.LastSeenEnemyTimeUntilReset = 3 -- Time until it resets its enemy if its current enemy is not visible
ENT.Bleeds = false -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.HasBloodParticle = false -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = false -- Does it spawn a decal when damaged?
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.FindEnemy_CanSeeThroughWalls = false
ENT.Aerial_ShouldBeFlying = true
ENT.FindEnemy_UseSphere = true

ENT.AA_GroundLimit = 75 -- If the NPC's distance from itself to the ground is less than this, it will attempt to move up
ENT.AA_MinWanderDist = 80 -- Minimum distance that the NPC should go to when wandering

ENT.TimeUntilRangeAttackProjectileRelease = 4.5
ENT.RangeAttackPos_Up = 4008 -- Up/Down spawning position for range attack
ENT.RangeAttackAnimationDelay = 4
ENT.SightDistance = 10000000 -- How far it can see
ENT.CanTurnWhileStationary = true -- If set to true, the SNPC will be able to turn while it's a stationary SNPC
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.TimeUntilRangeAttackProjectileRelease = 0.043 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 10.043 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.043 -- How much time until it can use any attack again? | Counted in Seconds
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.AnimTbl_RangeAttack = {"fire"} -- Range Attack Animations
ENT.RangeToMeleeDistance = 0.1 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 90 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.RangeDistance = 1000
ENT.Aerial_FlyingSpeed_Calm = 400 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking campared to ground SNPCs
ENT.Aerial_FlyingSpeed_Alerted = 680 -- The speed it should fly with, when it's chasing an enemy, moving away quickly, etc. | Basically running campared to ground SNPCs
ENT.HasFootStepSound = true
ENT.RangeAttackEntityToSpawn = "grenade_helicopter"

ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.PainSoundLevel = 90
ENT.AlertSoundLevel = 90
ENT.BreathSoundLevel = 90
ENT.FootStepPitch1 = 100
ENT.FootStepPitch2 = 100
ENT.FootStepSoundLevel = 80
ENT.FootStepTimeRun = 0.8 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking

ENT.IdleSoundLevel = 90
ENT.CombatIdleSoundLevel = 90

ENT.SoundTbl_Alert = {
"npc/combine_gunship/see_enemy.wav"
}
ENT.SoundTbl_CombatIdle = {
"npc/combine_gunship/ol07_advisor_00_16_13.wav",

}
ENT.SoundTbl_Idle = {
    "npc/combine_gunship/gunship_moan.wav",
    "npc/combine_gunship/ping_patrol.wav",
    "npc/combine_gunship/gunship_moan.wav",
    "npc/combine_gunship/gunship_search.wav",
}
ENT.SoundTbl_Pain = {
"npc/combine_gunship/gunship_pain.wav"
}
ENT.SoundTbl_Death = {
"npc/combine_gunship/gunship_explode2.wav"
}
ENT.FlopTime = CurTime()

function ENT:CustomOnRangeAttack_AfterStartTimer()
	self.LoopSound4 = CreateSound(self, Sound("gunship_sound2"))
	self.LoopSound4:PlayEx(500, 100)
end


function ENT:AnimationThink()
    self:AddLayeredSequence(self:LookupSequence("prop_turn"),2)
    if self.FlopTime <= CurTime() then
        self:AddLayeredSequence(self:LookupSequence("fin_ambience"),1)
        self:AddLayeredSequence(self:LookupSequence("breathing"),4)
        self.FlopTime = CurTime() + 2
    end
end

ENT.Apc_NextLowHealthSmokeT = 0
ENT.DefaultSoundTbl_MeleeAttack = {"physics/body/body_medium_impact_hard1.wav","physics/body/body_medium_impact_hard2.wav","physics/body/body_medium_impact_hard3.wav","physics/body/body_medium_impact_hard4.wav","physics/body/body_medium_impact_hard5.wav","physics/body/body_medium_impact_hard6.wav"}
ENT.DefaultSoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.DefaultSoundTbl_Impact = {"physics/flesh/flesh_impact_bullet1.wav","physics/flesh/flesh_impact_bullet2.wav","physics/flesh/flesh_impact_bullet3.wav","physics/flesh/flesh_impact_bullet4.wav","physics/flesh/flesh_impact_bullet5.wav"}


---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
    self:AnimationThink()

    self.Aerial_FlyingSpeed_Calm = 100 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking campared to ground SNPCs
    self.Aerial_FlyingSpeed_Alerted = math.random(160,120) -- The speed it should fly with, when it's chasing an enemy, moving away quickly, etc. | Basically running campared to ground SNPCs
end

--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	--self:SetKeyValue( "additionalequipment", "weapon_vj_gunship_hl2" )
	self.LoopSound = CreateSound(self, Sound("gunship_sound3"))
	self.LoopSound:PlayEx(500, 100)
    self.LoopSound2 = CreateSound(self, Sound("gunship_sound4"))
	self.LoopSound2:PlayEx(500, 100)

    local viewpos = self:GetPos() + self:GetForward() * 0 + self:GetUp() * 50 + self:GetRight() * 0
	self:SetPos(viewpos)
    self:SetCollisionBounds(Vector(180, 180, 100), -Vector(20, 20, 100))
    self.Ammo = 20
    self.fire = true

    self:SetModelScale(0.25)
end
function ENT:CustomAttack()
	if (self:GetEnemy() and self:GetEnemy() != nil) and self.fire == true then
		local ene = self:GetEnemy()
        if self:GetPos():Distance(self:GetEnemy():GetPos()) < 1000 and (self:GetSightDirection():Dot((ene:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.RangeAttackAngleRadius))) then
            local bullet = {}
            bullet.Num = 1
            bullet.Src = self:GetAttachment(self:LookupAttachment("muzzle")).Pos
            bullet.Dir = (self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()) -self:GetAttachment(self:LookupAttachment("muzzle")).Pos
            bullet.Spread = 0
            bullet.Force = 1
            bullet.Tracer = 1
            bullet.Damage = math.random(9,10)
            bullet.TracerName = "AirboatGunHeavyTracer"
            bullet.AmmoType = "Ar2"
            self:VJ_ACT_PLAYACTIVITY({"attack3"},true,false,true)
            bullet.Callback = function ( attacker, tr, dmginfo )
            end		
            if self.Ammo <= 0 then 
                self.fire = false
                return 
                self:Reload()
            end
            self:FireBullets(bullet)
            sound.Play("weapons/ar2/fire1.wav", self:GetPos())
            --self.Ammo = self.Ammo -1
        end
	end
end
function ENT:Reload()
    timer.Simple(7,function()
        if !self:IsValid() then return end
        self.Ammo = 20
        self.fire = true
        self:EmitSound(Sound("fear/vulcan/firestop.wav",85,100))
    end)
end
function ENT:CustomRangeAttackCode()
	self.DisableDefaultRangeAttackCode = true 

	local tracedata = {}
	tracedata.start = self:GetAttachment(self:LookupAttachment("muzzle")).Pos
	tracedata.endpos = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter() 
	tracedata.filter = self
	local GuardGunTrace = util.TraceLine(tracedata)
		
		local effectdata = EffectData()
		effectdata:SetEntity(self)
		effectdata:SetOrigin(GuardGunTrace.HitPos)
		util.Effect("cguard_cannon",effectdata,true,true)
		timer.Simple(1.2, function()
			if self:IsValid() then
				self:EmitSound("npc/strider/fire.wav",511,100)
				local fx1 = EffectData()
				fx1:SetEntity(self)
				fx1:SetOrigin(GuardGunTrace.HitPos)
				util.Effect("cguard_cannon_fire",fx1)
				util.Effect("cguard_cannon_mzlflash",fx1)
				
                local dmg = DamageInfo()
                dmg:SetAttacker(self)
                dmg:SetInflictor(self)
                dmg:SetDamageType(DMG_BLAST)
                dmg:SetDamage(500)
                util.BlastDamageInfo(dmg, GuardGunTrace.HitPos, 250)

				local fx = EffectData()
				fx:SetOrigin(GuardGunTrace.HitPos)
				fx:SetNormal(GuardGunTrace.HitNormal)
				util.Effect("cguard_cannon_explode",fx)
			end
		end)

end
---------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() + self:LocalToWorld(Vector(math.random(-100,200) , math.random(-100,200),math.random(100,200))))*20 
end

ENT.BreathSoundPitch1 = 100
ENT.BreathSoundPitch2 = 100

ENT.CombatIdleSoundPitch1 = 100
ENT.CombatIdleSoundPitch2 = 100
ENT.OnReceiveOrderSoundPitch1 = 100
ENT.OnReceiveOrderSoundPitch2 = 100
ENT.MoveOutOfPlayersWaySoundPitch1 = 100
ENT.MoveOutOfPlayersWaySoundPitch2 = 100
ENT.BeforeHealSoundPitch1 = 100
ENT.BeforeHealSoundPitch2 = 100
ENT.AfterHealSoundPitch1 = 100
ENT.AfterHealSoundPitch2 = 100
ENT.MedicReceiveHealSoundPitch1 = 100
ENT.MedicReceiveHealSoundPitch2 = 100
ENT.OnPlayerSightSoundPitch1 = 100
ENT.OnPlayerSightSoundPitch2 = 100
ENT.AlertSoundPitch1 = 100
ENT.AlertSoundPitch2 = 100
ENT.CallForHelpSoundPitch1 = 100
ENT.CallForHelpSoundPitch2 = 100
ENT.BecomeEnemyToPlayerPitch1 = 100
ENT.BecomeEnemyToPlayerPitch2 = 100
ENT.SuppressingPitch1 = 100
ENT.SuppressingPitch2 = 100
ENT.WeaponReloadSoundPitch1 = 100
ENT.WeaponReloadSoundPitch2 = 100
ENT.GrenadeAttackSoundPitch1 = 100
ENT.GrenadeAttackSoundPitch2 = 100
ENT.OnGrenadeSightSoundPitch1 = 100
ENT.OnGrenadeSightSoundPitch2 = 100
ENT.OnKilledEnemySoundPitch1 = 100
ENT.OnKilledEnemySoundPitch2 = 100
ENT.PainSoundPitch1 = 100
ENT.PainSoundPitch2 = 100
ENT.ImpactSoundPitch1 = 80
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = 100
ENT.DamageByPlayerPitch2 = 100
ENT.DeathSoundPitch1 = 100
ENT.DeathSoundPitch2 = 100
function ENT:CustomOnRemove()
    timer.Remove( "fire")
    VJ_STOPSOUND(self.LoopSound)
    VJ_STOPSOUND(self.LoopSound2)
end

function ENT:WhenRemoved()
    timer.Remove( "fire")
	VJ_STOPSOUND(self.LoopSound)
    VJ_STOPSOUND(self.LoopSound2)
end

function ENT:CustomOnKilled(dmginfo,hitgroup)
	VJ_STOPSOUND(self.LoopSound)
    VJ_STOPSOUND(self.LoopSound2)
    timer.Remove( "fire")

		
	util.BlastDamage(self,self,self:GetPos(),400,100)
	util.ScreenShake(self:GetPos(),100,200,1,3000)
    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetPos() +self:OBBCenter()) -- the vector of were you want the effect to spawn
    effectdata:SetScale(190) -- how big the particles are, can even be 0.1 or 0.6
    util.Effect( "Explosion", effectdata )
    ParticleEffect("vj_explosion2",self:GetPos(),Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*60,Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*50,Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*-60,Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*70,Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*-70,Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*85,Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*-85,Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*30,Angle(0,0,0),nil)
    ParticleEffect("vj_explosion2",self:GetPos() + self:GetForward()*-30,Angle(0,0,0),nil)
    VJ_EmitSound(self,{"weapons/expode4.wav"},90,self:VJ_DecideSoundPitch(110,140))
end

if CLIENT then

local mat = Material("Effects/blueblacklargebeam")
local mat2	= Material("Effects/blueblackflash")
local sparks = Material("effects/spark")
local combinemuzzle = Material("Effects/combinemuzzle2")


local EFFECT={}


function EFFECT:Init(data)
self.StartPos = data:GetStart()
self.Orig = data:GetOrigin()
if self.StartPos == nil then self.BeamLife = 0 self.BeamLifeEnd = 0 return end
self.BeamLife = CurTime() + 2
self.BeamLifeEnd = CurTime() + 3
self.BeamWidth = 20
self.BeamSpriteSize = 80
local trace = {}
trace.start = self.StartPos
trace.endpos = trace.start - Vector(0,0,90000)
trace.filter = ents.GetAll()

local tr = util.TraceLine(trace)

self:SetRenderBoundsWS(tr.StartPos, tr.HitPos)
end

function EFFECT:Think()
if self.BeamLifeEnd < CurTime() then return false end
return true
end

function EFFECT:Render( )
if self.StartPos == nil then return end
local intrplt 
local invintrplt = (self.BeamLife - CurTime())/3
intrplt = math.Clamp(1 - invintrplt,0,1)

if self.BeamLife < CurTime() then
intrplt = intrplt + invintrplt*3
end

render.SetMaterial( mat )

render.DrawBeam( self.StartPos, self.Orig, intrplt*self.BeamWidth, 0, 0, Color( 255, 255, 255, intrplt*100 ) )

render.SetMaterial(mat2)
local clr = 255*(1*intrplt - 1)
render.DrawSprite(self.StartPos,self.BeamSpriteSize,self.BeamSpriteSize,Color(clr,clr,clr,100))

end

effects.Register(EFFECT, "gunship_bellycannon_beam", true)

local EFFECT2={}


function EFFECT2:Init(data)
self.Orig = data:GetOrigin()
self.Norm = data:GetNormal()
self.ParticleLife = CurTime() + 2
self.ParticleTime = 0
self.ParticleNum = 0
self.MuzzleSize = 50
end

function EFFECT2:Think()
if self.ParticleTime < CurTime() then
local emmiter = ParticleEmitter(self.Orig,false)
for i=0,(math.Round(1 + self.ParticleNum)) do
	local particle = emmiter:Add(sparks,self.Orig + Vector(math.Rand(math.Rand(-100,-50),math.Rand(50,100)),math.Rand(math.Rand(-100,-50),math.Rand(50,100)),math.Rand(0,50)))
		if particle then
			particle:SetLifeTime(0)
			particle:SetDieTime( math.Clamp(0.1+(self.ParticleNum/math.Rand(30,40)),0.1,1) )
			particle:SetAirResistance(300)
			particle:SetStartAlpha( math.Rand( 0, 30 ) )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( math.Rand(1,5) )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( 0 )
			particle:SetColor(255,255,255,255)
			particle:SetGravity(Vector(0,0,math.Clamp(50+(self.ParticleNum*math.Rand(9,15)),50,2000)))
		end
	end
	self.ParticleTime = CurTime() + 0.1
end
if self.ParticleLife < CurTime() then
local emmiter = ParticleEmitter(self.Orig,false)
for i=0,40 do
	local particle = emmiter:Add(sparks,self.Orig + Vector(math.Rand(-20,20),math.Rand(-20,20),math.Rand(0,50)))
		if particle then
		    particle:SetVelocity(Vector(math.Rand(-30,30),math.Rand(-30,30),50)*math.Rand(14,25))
			particle:SetLifeTime(0)
			particle:SetDieTime( math.Rand( 1, 1.5 ) )
			particle:SetAirResistance(300)
			particle:SetStartAlpha( math.Rand( 0, 30 ) )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( math.Rand(1,3) )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( 0 )
			particle:SetColor(255,255,255,255)
		end
end
for i=0,20 do
	local particle = emmiter:Add(sparks,self.Orig + Vector(math.Rand(-20,20),math.Rand(-20,20),math.Rand(0,50)))
		if particle then
		    particle:SetVelocity(Vector(math.Rand(-200,200),math.Rand(-200,200),40)*math.Rand(5,12))
			particle:SetLifeTime(0)
			particle:SetDieTime( math.Rand( 1, 1.5 ) )
			particle:SetAirResistance(300)
			particle:SetStartAlpha( math.Rand( 0, 30 ) )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( math.Rand(1,3) )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( 0 )
			particle:SetColor(255,255,255,255)
		end
end
return false 
end
return true
end

function EFFECT2:Render( )
self.ParticleNum = math.Clamp(self.ParticleNum + (FrameTime()*40),0,50)
self.MuzzleSize = math.Clamp(self.MuzzleSize + FrameTime()*150,0,680)
render.SetMaterial(combinemuzzle)
render.DrawQuadEasy(self.Orig,self.Norm,self.MuzzleSize,self.MuzzleSize,Color(255,255,255,255),0)
end

effects.Register(EFFECT2, "gunship_bellycannon_particle", true)

end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Combine Gunship","npc_vj_horde_gunship", "Horde")