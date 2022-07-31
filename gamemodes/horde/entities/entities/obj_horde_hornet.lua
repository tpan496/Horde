AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
    self:DrawModel()
end


function ENT:Initialize()
    self.SoundTimer = CurTime()
    self.RemoveTimer = CurTime() + 3
    self.SearchTimer = CurTime() + 0.2
    if SERVER then
        self:SetMaxHealth(30)
        self:SetHealth(30)
    end
    self:SetModel( "models/horde/hornet/hornet.mdl" )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
    self:DrawShadow( false )
    self.Target = nil
    if SERVER then
    util.SpriteTrail( self, 0, Color( 255, 200, 0 ), false, 5, 0, 2.5, 0.04, "trails/smoke.vmt" )
    end
end

function ENT:Think()
    if self.Removing then return end
    if self.SoundTimer <= CurTime() then
        self:EmitSound( "Weapon_HL_Hivehand.Buzz" )
        self.SoundTimer = CurTime() + 1
    end
    if SERVER then
        if self.RemoveTimer <= CurTime() then
            self:Remove()
        end

        if self.Target and self.Target:IsValid() and self.Target:Health() > 0 then
            local ang = self:GetAngles()
            local desired = ((self.Target:GetPos() + self.Target:OBBCenter()) - self:GetPos()):Angle()
			ang = LerpAngle(0.8, ang, desired)
            self:SetAngles(desired)
        end

        if not self.Target and self.SearchTimer <= CurTime() then
            self.SearchTimer = CurTime() + 0.5
            local targets = ents.FindInSphere(self:GetPos(), 600)
            if not targets then return end
            for _, e in pairs(targets) do
                if e:IsNPC() and e:Health() > 0 and (not e:GetNWEntity("HordeOwner"):IsValid()) then
                    self.Target = e
                    return
                end
            end
        end
    end
end

function ENT:PhysicsCollide( data )
    if self.Removing then return end
    local dmg = DamageInfo()
    local owner = self:GetOwner()
    if !IsValid( self ) then
        owner = self
    end
    dmg:SetAttacker(owner)
    dmg:SetInflictor(self)
    dmg:SetDamage(40)
    dmg:SetDamageType(DMG_BULLET)
    dmg:SetDamagePosition(data.HitPos)

    data.HitEntity:TakeDamageInfo( dmg )
    
    if SERVER then
        if data.HitEntity:IsNPC() || data.HitEntity:IsPlayer() then
            self:Remove()
            self.Removing = true
        else
            if not self.Target then
                self.SearchTimer = CurTime() + 0.5
                local targets = ents.FindInSphere(self:GetPos(), 600)
                if not targets then return end
                for _, e in pairs(targets) do
                    if e:IsNPC() and not HORDE:IsPlayerMinion(e) then
                        self.Target = e
                        return
                    end
                end
                self:SetAngles( Angle( math.Rand( 0, 360 ), math.Rand( 0, 360 ), math.Rand( 0, 360 ) ) )
            end
        end
    end
end

function ENT:OnRemove()
    if SERVER then
        self.Owner:Horde_SetMinionCount(self.Owner:Horde_GetMinionCount() - 1)
    end
    self:EmitSound( "Weapon_HL_Hivehand.Hit" )
end