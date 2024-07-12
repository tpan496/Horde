if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mp7")
    killicon.Add("arccw_horde_mp7m", "arccw/weaponicons/arccw_go_mp7", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_mp7"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP7A1 Medic PDW"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mp7.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mp7.mdl"

SWEP.Primary.ClipSize = 35 -- DefaultClip is automatically set.

SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0,
    },
}

SWEP.ShootVol = 75 -- volume of shoot sound

function SWEP:ChangeFiremode(pred)
    if self:GetNextSecondaryFire() > CurTime() then return end
    if not self.CanBash and not self:GetBuff_Override("Override_CanBash") then return end
    if CLIENT then return end
    local ply = self:GetOwner()
    local filter = {self:GetOwner()}
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-16, -16, -8),
        maxs = Vector(16, 16, 8),
        mask = MASK_SHOT_HULL
    })
    if tr.Hit then
        local effectdata = EffectData()
        effectdata:SetOrigin(tr.HitPos)
        effectdata:SetRadius(50)
        util.Effect("horde_heal_mist", effectdata)

        for _, ent in pairs(ents.FindInSphere(tr.HitPos, 100)) do
            if ent:IsPlayer() then
                local healinfo = HealInfo:New({amount = 10, healer = ply})
                HORDE:OnPlayerHeal(ent, healinfo)
            elseif ent:GetClass() == "npc_vj_horde_antlion" then
                local healinfo = HealInfo:New({amount = 10, healer = ply})
                HORDE:OnAntlionHeal(ent, healinfo)
            elseif ent:IsNPC() then
                local dmg = DamageInfo()
                dmg:SetDamage(25)
                dmg:SetDamageType(DMG_NERVEGAS)
                dmg:SetAttacker(ply)
                dmg:SetInflictor(self)
                dmg:SetDamagePosition(tr.HitPos)
                ent:TakeDamageInfo(dmg)
            end
        end
    end

    ply:EmitSound("horde/weapons/mp7m/heal.ogg", 125, 100, 1, CHAN_AUTO)

    self:SetNextSecondaryFire(CurTime() + 1)
    self:SetNextPrimaryFire(CurTime() + 0.25)
    return true
end

function SWEP:Hook_Think()
    if SERVER then return end
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-20, -20, -8),
        maxs = Vector(20, 20, 8),
        mask = MASK_SHOT_HULL
    })

    if tr.Hit and tr.Entity and tr.Entity:IsPlayer() then
        self.Horde_HealTarget = tr.Entity
    else
        self.Horde_HealTarget = nil
    end
end

local function nv_center(ent)
    return ent:LocalToWorld(ent:OBBCenter())
end

function SWEP:Hook_DrawHUD()
    if self.Horde_HealTarget then
        local pos = nv_center(self.Horde_HealTarget):ToScreen()
        surface.SetDrawColor(Color(50, 200, 50))
        surface.DrawCircle(pos.x, pos.y, 30)
        --surface.DrawLine(pos.x, 0, pos.x, ScrH())
        --surface.DrawLine(0, pos.y, ScrW(), pos.y)
        draw.DrawText(self.Horde_HealTarget:Health(), "Trebuchet24",
        pos.x - 15, pos.y - 15, Color(50, 200, 50), TEXT_ALIGN_LEFT)
    end
end
