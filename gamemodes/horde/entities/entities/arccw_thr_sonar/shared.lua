ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Sonar Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/w_grenade.mdl"
ENT.FuseTime = 2
ENT.ArmTime = 0
ENT.ImpactFuse = false
ENT.Armed = false
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE

ENT.NextEffect = CurTime()

AddCSLuaFile()

if SERVER then
util.AddNetworkString("Horde_HighlightSonar")
end

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:DrawShadow( true )

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
            phys:SetDamping(0.2, 0)
        end

        self.SpawnTime = CurTime()
        self:SetColor(Color(0, 0, 0))

        if self.FuseTime <= 0 then
            self:Detonate()
        end
    end
end

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Armed" )

    if SERVER then
        self:SetArmed(false)
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        if data.Speed > 75 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_hard" .. math.random(1,3) .. ".wav"))
        elseif data.Speed > 25 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_soft" .. math.random(1,3) .. ".wav"))
        end

        if (CurTime() - self.SpawnTime >= self.ArmTime) and self.ImpactFuse then
            self:Detonate()
        end
        if data.HitEntity:IsWorld() then
            self:SetMoveType(MOVETYPE_NONE)
        end
        
    end
end

if SERVER then
hook.Add("Horde_OnPlayerDamage", "Horde_SonarBonus", function (ply, npc, bonus, hitgroup, dmginfo)
    if npc.Horde_Sonar_Highlight and hitgroup == HITGROUP_HEAD then
        bonus.more = bonus.more * 1.15
    end
end)
end

function ENT:Think()
    if !self.SpawnTime then self.SpawnTime = CurTime() end

    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime and !self.Armed then
        self:Detonate()
        self:SetArmed(true)
        timer.Simple(5, function ()
            if !IsValid(self) then return end
            self:Remove()
        end)
    end

    if self:GetArmed() then
        if self.NextEffect <= CurTime() then
            if SERVER then
                self:EmitSound("npc/combine_gunship/gunship_ping_search.wav")
                for _, ent in pairs(ents.FindInSphere(self:GetPos(), 300)) do
                    if HORDE:IsEnemy(ent) then
                        net.Start("Horde_HighlightSonar")
                            net.WriteEntity(ent)
                            net.WriteBool(true)
                            ent.Horde_Sonar_Highlight = true
                        net.Broadcast()
                        local id = ent:GetCreationID()
                        timer.Remove("Horde_SonarHighlightRemove" .. id)
                        timer.Create("Horde_SonarHighlightRemove" .. id, 10, 0, function ()
                            net.Start("Horde_HighlightSonar")
                                net.WriteEntity(ent)
                                net.WriteBool(false)
                                ent.Horde_Sonar_Highlight = nil
                            net.Broadcast()
                        end)
                    end
                end
            else
                if not self.emitter then self.emitter = ParticleEmitter(self:GetPos(), true) end
                if not self.emitter2 then self.emitter2 = ParticleEmitter(self:GetPos()) end
                local smoke = self.emitter:Add("effects/splashwake3", self:GetPos())
                smoke:SetDieTime(0.75)
                smoke:SetStartAlpha(200)
                smoke:SetEndAlpha(0)
                smoke:SetStartSize(10)
                smoke:SetEndSize(300)
                smoke:SetColor(50, 50, 200)
                smoke:SetAirResistance(1000)
                smoke:SetLighting( false )
                smoke:SetCollide(true)
                smoke:SetAngles(Vector(0,0,1):Angle())
                smoke:SetBounce(0)
                smoke:SetNextThink(CurTime() + FrameTime())
                smoke:SetThinkFunction( function(pa)
                    if !pa then return end
                    local col1 = Color(100, 105, 255)
                    local col2 = Color(100, 100, 200)

                    local col3 = col1
                    local d = pa:GetLifeTime() / pa:GetDieTime()
                    col3.r = Lerp(d, col1.r, col2.r)
                    col3.g = Lerp(d, col1.g, col2.g)
                    col3.b = Lerp(d, col1.b, col2.b)

                    pa:SetColor(col3.r, col3.g, col3.b)
                    pa:SetNextThink(CurTime() + FrameTime())
                end)

                local smoke2 = self.emitter2:Add("effects/splashwake3", self:GetPos())
                smoke2:SetDieTime(0.75)
                smoke2:SetStartAlpha(200)
                smoke2:SetEndAlpha(0)
                smoke2:SetStartSize(10)
                smoke2:SetEndSize(300)
                smoke2:SetColor(50, 50, 200)
                smoke2:SetAirResistance(1000)
                smoke2:SetLighting( false )
                smoke2:SetCollide(true)
                smoke2:SetBounce(0)
                smoke2:SetNextThink(CurTime() + FrameTime())
                smoke2:SetThinkFunction( function(pa)
                    if !pa then return end
                    local col1 = Color(100, 105, 255)
                    local col2 = Color(100, 100, 200)

                    local col3 = col1
                    local d = pa:GetLifeTime() / pa:GetDieTime()
                    col3.r = Lerp(d, col1.r, col2.r)
                    col3.g = Lerp(d, col1.g, col2.g)
                    col3.b = Lerp(d, col1.b, col2.b)

                    pa:SetColor(col3.r, col3.g, col3.b)
                    pa:SetNextThink(CurTime() + FrameTime())
                end)

                if !self:IsValid() then return end
                if !IsValid(self.emitter) then return end
            end
            self.NextEffect = CurTime() + 1
        end
    end
end

function ENT:Explode()
    if !self:IsValid() then return end
    self:EmitSound("ambient/explosions/explode_1.wav", 100, 100, 1, CHAN_ITEM)

    local attacker = self

    if self:GetOwner():IsValid() then
        attacker = self:GetOwner()
    end

    local dmginfo = DamageInfo()
    dmginfo:SetDamage(150)
    dmginfo:SetDamageType(DMG_BULLET)
    dmginfo:SetAttacker(attacker)
    dmginfo:SetInflictor(self)
    util.BlastDamageInfo(dmginfo, self:GetPos(), 250)

    local ed = EffectData()
    ed:SetOrigin(self:GetPos())
    util.Effect("horde_shrapnel_grenade_explosion", ed, true, true)
end

function ENT:Detonate()
    if !self:IsValid() or self:WaterLevel() > 2 then return end
    if !self.Armed then return end

    self.Armed = false

    self:Explode()

    self:Remove()
end

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    self:DrawModel()
end