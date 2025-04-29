ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Throwing Knife"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/arccw_go/w_eq_throwingknife_thrown.mdl"
ENT.Collectable = false
ENT.CollisionGroup = COLLISION_GROUP_PASSABLE_DOOR

ENT.KnifeDamage = 100
ENT.Kniferadiustimer = 0
ENT.KnifeUpgrade = 1

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
            phys:AddAngleVelocity(Vector(0, 750, 0))
            phys:Wake()
        end

        self.dt = CurTime() + 30
        self.Kniferadiustimer = CurTime() + 1.5
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        if data.HitEntity:GetClass() == "worldspawn" or data.HitEntity:IsPlayer() then
            local tr = {
                start = self:GetPos(),
                endpos = self:GetPos() - Vector(0, 0, 15),
                mask = MASK_SOLID_BRUSHONLY,
                filter = self,
            }
            if(util.TraceLine(tr).HitWorld) then
                self:SetMoveType( MOVETYPE_NONE )
                self:SetAngles( data.OurOldVelocity:Angle() + Angle(90, 0, 0) )
                self:SetPos( data.HitPos - (data.HitNormal * 2) )
                self:EmitSound( "arccw_go/knife/knife_hitwall3.wav" )
                self.dt = CurTime() + 30
                self.Collectable = true
                self:SetTrigger(true)
                self:UseTriggerBounds(true, 24)
            else
                self:EmitSound("arccw_go/knife/knife_hitwall3.wav")
                self:GetPhysicsObject():SetDamping(2, 2)
            end
        else
            if self.Dropped then return end
            self:EmitSound( "arccw_go/knife/knife_hit1.wav" )
            if(IsValid(data.HitEntity)) then
                if(!data.HitEntity.Horde_Impale_Kunai) then
                    data.HitEntity.Horde_Impale_Kunai = 1
                else
                    data.HitEntity.Horde_Impale_Kunai = data.HitEntity.Horde_Impale_Kunai + 1
                end
            end
            
            local ply = self.Owner
            if ply:Horde_GetCurrentSubclass() == "Gunslinger" then
                local level = ply:Horde_GetUpgrade("arccw_horde_kunai")
                self.KnifeUpgrade = 1 + (level * 0.03)
            end
            
            self:FireBullets({
                Attacker = self.Owner,
                Damage = self.KnifeDamage * self.KnifeUpgrade,
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
            self.Dropped = true
            self:Remove()
        end
    end
end

function ENT:Touch(ply)
    if !ply:IsPlayer() then return end
    local item = HORDE.items["arccw_horde_kunai"]
    if item.whitelist and not item.whitelist[ply:Horde_GetCurrentSubclass()] then return end
    if ply:HasWeapon("arccw_horde_kunai") then
        --ply:SetAmmo(ply:GetAmmoCount("horde_arccw_knives") + 1, "horde_arccw_knives")
        ply:GiveAmmo(1, "horde_arccw_knives", false)
        self:Remove()
    end
end

function ENT:Think()
    if SERVER then
        if CurTime() >= self.Kniferadiustimer then
            for _, ent in pairs(ents.FindInSphere(self:GetPos(), 100)) do
                if not ent:IsPlayer() then continue end
                local item = HORDE.items["arccw_horde_kunai"]
                if item.whitelist and not item.whitelist[ent:Horde_GetCurrentSubclass()] then continue end
                if not ent:HasWeapon("arccw_horde_kunai") then continue end
                self:Touch(ent)
            end
        end
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

hook.Add("Horde_OnEnemyKilled", "Horde_DropItemOnKill", function (victim, ply, wpn)
    --if CLIENT then return end
    if not victim.Horde_Impale_Kunai then return end
    local k = victim.Horde_Impale_Kunai
    for i = 1, k do
    local drop_kunai = ents.Create("arccw_horde_thr_knife")
        --prop:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
        --prop:SetModelScale(0.25, 0)
        drop_kunai:SetPos(victim:GetPos() + VectorRand() * 4 + Vector(0, 0, 8))
        drop_kunai:SetAngles(AngleRand())
        drop_kunai:SetOwner(ply)
        drop_kunai.Owner = ply
        drop_kunai.Inflictor = drop_kunai
        drop_kunai.Dropped = true
        drop_kunai:Spawn()
        drop_kunai:Activate()
        drop_kunai:GetPhysicsObject():AddVelocity(VectorRand() * 50 + Vector(0, 0, 250))
        drop_kunai:SetCollisionGroup(1)
    end
end)

--[[
local GrenadeType = {
    arccw_horde_thr_knife = {Text = "Knife", Font = "CloseCaption_Italic", Min_display_distance = 400, Font_color = Color(0, 255, 0, 255)},
}

hook.Add("HUDPaint", "Proximity_Knife_Display", function()
    local ply = LocalPlayer()
    if !ply:Alive() or not ply:Horde_GetPerk("berserker_base") or not ply:Horde_GetPerk("samurai_base") then return end
    for _, ent in ipairs(ents.FindInSphere(ply:GetPos(), 400)) do
        local grenade = GrenadeType[ent:GetClass()]
        if grenade then
            local pos = ent:LocalToWorld(ent:OBBCenter()):ToScreen()
            local dist = ply:GetPos():Distance(ent:GetPos())
            if math.Round(dist) < grenade.Min_display_distance then
                draw.SimpleText(grenade.Text, grenade.Font, pos.x + 1, pos.y + 1, grenade.Font_color, 0, 0)
            end
        end
    end
end)


if(CLIENT) then
    local mat = Material("models/debug/debugwhite")
    hook.Add("PostDrawOpaqueRenderables", "MaterialOverride", function()
        cam.Start3D()
        render.SuppressEngineLighting(true)
        render.SetColorModulation(0, 1, 0)
        render.MaterialOverride(mat)
        for k,v in ipairs(ents.FindByClass("arccw_horde_thr_knife")) do
            v:DrawModel()
        end
        render.MaterialOverride(nil)
        render.SuppressEngineLighting(false)
        cam.End3D()
    end)
end
]]
