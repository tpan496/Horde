ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Throwing Knife"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/arccw_go/w_eq_throwingknife_thrown.mdl"
ENT.Collectable = false
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInitSphere(1)
        self:DrawShadow( true )

        --self:SetAngles(Angle(0, 0, 0) )

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:SetMass(0.1)
            phys:SetBuoyancyRatio(0)
            phys:Wake()
        end

        self.dt = CurTime() + 15
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        if data.HitEntity:GetClass() == "worldspawn" then
            self:SetMoveType( MOVETYPE_NONE )
            self:SetAngles( data.OurOldVelocity:Angle() + Angle(90, 0, 0) )
            self:SetPos( data.HitPos - (data.HitNormal * 2) )
            self:EmitSound( "arccw_go/knife/knife_hitwall3.wav" )
            self.dt = CurTime() + 15
            self.Collectable = true

            self:SetTrigger(true)
            self:UseTriggerBounds(true, 24)
        else
            self:EmitSound( "arccw_go/knife/knife_hit1.wav" )

            self:FireBullets({
                Attacker = self.Owner,
                Damage = 100,
                Tracer = 0,
                Distance = 4000,
                Dir = (data.HitPos - self:GetPos()),
                Src = self:GetPos(),
                Callback = function(att, tr, dmg)
                    dmg:SetDamageType(DMG_SLASH)
                    dmg:SetAttacker(self.Owner)
                    dmg:SetInflictor(self)
    
                    if (not tr.Entity:IsValid()) or (not tr.Entity:IsNPC()) then
                        if data.HitEntity:IsNPC() then
                            data.HitEntity:TakeDamageInfo(dmg)
                        end
                    end
                end
            })
            self:Remove()
        end
    end
end

function ENT:Touch(ply)
    if !ply:IsPlayer() then return end

    ply:GiveAmmo(1, "GrenadeHL1", false)
    self:Remove()
end

function ENT:Think()
    if SERVER then
        if CurTime() >= self.dt then
            self:Remove()
        end
    end
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()
    end
end