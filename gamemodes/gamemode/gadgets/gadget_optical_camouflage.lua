GADGET.PrintName = "Optical Camouflage"
GADGET.Description = "Grants Camouflage for 5 seconds.\n50% increased evasion during Camouflage."
GADGET.Icon = "items/gadgets/optical_camouflage.png"
GADGET.Duration = 5
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_optical_camouflage" then return end
    sound.Play("horde/gadgets/optical_camouflage_on.ogg", ply:GetPos())
    sound.Play("horde/gadgets/optical_camouflage_in.ogg", ply:GetPos())
    ply.Horde_In_Optical_Camouflage = true
    ply:ScreenFade(SCREENFADE.IN, Color(200, 200, 200, 25), 0.1, 5)
    ply:Horde_AddCamoflague()
    timer.Simple(5, function()
        if ply:IsValid() then ply.Horde_In_Optical_Camouflage = nil return end
    end)
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_optical_camouflage" then return end
    if not ply.Horde_In_Optical_Camouflage then return end
    bonus.evasion = bonus.evasion + 0.50
end