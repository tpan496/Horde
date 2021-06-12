GADGET.PrintName = "Hardening Injection"
GADGET.Description = "Movespeed reduced by 50%.\n25% increased Global damage resistance.\n25% increased Physical damage resistance."
GADGET.Icon = "items/gadgets/hardening_injection.png"
GADGET.Duration = 5
GADGET.Cooldown = 25
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_hardening_injection" then return end
    sound.Play("horde/gadgets/injection.ogg", ply:GetPos())
    sound.Play("horde/gadgets/energy_shield_in.ogg", ply:GetPos())
    ply.Horde_In_Hardening_Injection = true
    ply:ScreenFade(SCREENFADE.IN, Color(50, 200, 200, 25), 0.1, 5)
    timer.Simple(5, function()
        if ply:IsValid() then ply.Horde_In_Hardening_Injection = nil return end
    end)
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_hardening_injection" then return end
    if not ply.Horde_In_Hardening_Injection then return end
    bonus.resistance = bonus.resistance + 0.25
    if dmginfo:GetDamageType() == DMG_BULLET or dmginfo:GetDamageType() == DMG_CRUSH or dmginfo:GetDamageType() == DMG_GENERIC or dmginfo:GetDamageType() == DMG_BUCKSHOT or dmginfo:GetDamageType() == DMG_SLASH or dmginfo:GetDamageType() == DMG_CLUB or dmginfo:GetDamageType() == DMG_SNIPER then
        bonus.resistance = bonus.resistance + 0.25
    end
end

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, mv)
    if ply:Horde_GetGadget() ~= "gadget_hardening_injection" then return end
    if not ply.Horde_In_Hardening_Injection then return end
    ply:SetWalkSpeed(ply:GetWalkSpeed() * 0.5)
    ply:SetRunSpeed(ply:GetRunSpeed() * 0.5)
end