if not ArcCWInstalled then return end
-- Referenced From GSO
ENT.Type = "anim"
ENT.Base = "item_healthvial"
ENT.PrintName = "Vial"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

AddCSLuaFile()

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        self:Remove()
    end
end

