include("shared.lua")
killicon.AddAlias("npc_satchel_horde", "npc_tripmine")

local lmat = Material("sprites/glow04_noz")
ENT.NextGlowStart = CurTime()
ENT.NextGlowEnd = CurTime() + 0.5
ENT.NextBeep = CurTime() + 0.5

local BeepSound = Sound("weapons/c4/c4_beep1.wav")

function ENT:Glow()
    render.SetMaterial(lmat)
    render.DrawSprite(self:GetPos(), 32, 32, Color(255,0,0))
end

function ENT:Draw()
    if SERVER then return end
    self.Entity:DrawModel()
    if self.NextGlowEnd <= CurTime() then
        self.NextGlowStart = CurTime() + 0.5
        self.NextGlowEnd = CurTime() + 1
    end
    if self.NextGlowStart <= CurTime() then
        self:Glow()
        if self.NextBeep <= CurTime() then
            self:EmitSound(BeepSound)
            self.NextBeep = CurTime() + 1
        end
    end
end