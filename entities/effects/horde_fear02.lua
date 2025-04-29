function EFFECT:Init(data)
    local entity = data:GetEntity()
    if(!IsValid(entity)) then return end
    self:SetPos(entity:GetPos())
    self.entity = entity
    self.mins, self.maxs = entity:OBBMins(), entity:OBBMaxs()
    self.Life = 2
    self.KillTime = CurTime() + self.Life
    self.Particles = {}
    self.NextParticle = 0
end

function EFFECT:Think()
    if(IsValid(self.entity)) then
        self:SetPos(self.entity:GetPos())
    end
    return self.KillTime > CurTime() && IsValid(self.entity)
end

local mat = Material("particle/fear_particle.png")
function EFFECT:Render()
    if(!IsValid(self.entity)) then return end
    local origin = self.entity
    local style = self.Style
    local max_z_offs = 0.33
    local systime = SysTime()
    if(self.NextParticle < systime) then
        local life = math.Rand(0.2, 0.3)
        table.insert(self.Particles, {
            mat = mat,
            offset = Vector(math.random(self.mins.x, self.maxs.x), math.random(self.mins.y, self.maxs.y), math.random(self.maxs.z * -max_z_offs, self.maxs.z * max_z_offs)),
            start_w = math.random(64, 160),
            start_h = math.random(64, 128),
            end_w = 0,
            end_h = 0,
            startalpha = 255,
            endalpha = 0,
            life = life,
            killtime = systime + life,
        })
        self.NextParticle = SysTime() + 0.05
    end
    local origin = self.entity:GetPos() + self.entity:OBBCenter()
    render.SetMaterial(mat)
    for _, sprite in ipairs(self.Particles) do
        if(sprite.killtime < systime) then
            table.remove(self.Particles, _)
            continue
        end
        local fraction = 1 - (sprite.killtime - systime) / sprite.life
        local vec = origin + sprite.offset
        local current_w, current_h, current_alpha = Lerp(fraction, sprite.start_w, sprite.end_w), Lerp(fraction, sprite.start_h, sprite.end_h), Lerp(fraction, sprite.startalpha, sprite.endalpha)
        render.DrawSprite(vec, current_w, current_h, Color(0, 0, 0, current_alpha))
    end
end