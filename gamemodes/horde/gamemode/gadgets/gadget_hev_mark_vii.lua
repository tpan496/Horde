GADGET.PrintName = "HEV Mark VII"
GADGET.Description = [[An improved version of HEV suit that is focused on damage mitigation.
Can be switched between different modes:
- Automedic: Whenever Break/Bleeding activates, provide 10 health regeneration over time for 5 seconds.
- Active Defense: Drain your armor over time, but reduces your damage taken by {2}.]]
GADGET.Icon = "items/gadgets/hev_mark_vii.png"
GADGET.Duration = 5
GADGET.Cooldown = 1
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 0.2, percent = true}
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_hev_mark_vii" then return end
    ply:EmitSound("horde/gadgets/energy_shield_on.ogg")
end

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if SERVER and gadget == "gadget_hev_mark_vii" then
        ply:EmitSound("HL1/fvox/voice_on.wav")
        ply.Horde_HEV_MK7_Mode = 0
    end
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if SERVER and gadget == "gadget_hev_mark_vii" then
        ply:EmitSound("HL1/fvox/voice_off.wav")
    end
end