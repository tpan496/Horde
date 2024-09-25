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
        self:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        self:PhysicsInitSphere(1)
        self:DrawShadow( false )


        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:SetMass(5)
            phys:SetBuoyancyRatio(0)
            phys:Wake()
            phys:EnableGravity(false)
            phys:EnableDrag(false)
        end
        timer.Simple(0, function()
            if not IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        end)
        self.dt = CurTime() + 15
    end
end

--removed the ability to recover missed knives, kept causing "changing collision rules within a callback" errors
--regardless of how it was set up
function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        if data.HitEntity:GetClass() == "worldspawn" then
            self:EmitSound( "arccw_go/knife/knife_hitwall3.wav" )
            self:Remove()
        else
            self:EmitSound( "arccw_go/knife/knife_hit1.wav" )

            self:FireBullets({
                Attacker = self:GetOwner(),
                Damage = 100,
                Tracer = 0,
                Distance = 4000,
                Dir = data.HitPos - self:GetPos(),
                Src = self:GetPos(),
                Callback = function(att, tr, dmg)
                    dmg:SetDamageType(DMG_SLASH)
                    dmg:SetAttacker(self:GetOwner())
                    dmg:SetInflictor(self)

                if (not tr.Entity:IsValid()) or (not tr.Entity:IsNPC()) and data.HitEntity:IsNPC() then
                    data.HitEntity:TakeDamageInfo(dmg)
                    end
                end
            })
            self:Remove()
        end
    end
end


function ENT:Think()
    if SERVER and CurTime() >= self.dt then
        self:Remove()
    end
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()
    end
end