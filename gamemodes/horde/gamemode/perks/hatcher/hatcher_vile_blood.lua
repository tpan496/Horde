PERK.PrintName = "Vile Blood"
PERK.Description =
[[Stage III Antlion grants Vile Blood through Bug Pulse.
Vile Blood provides {1} increased Poison damage resistance.
Vile Blood allows player damage to inflict Break buildup.]]
PERK.Icon = "materials/perks/hatcher/vile_blood.png"
PERK.Params = {
    [1] = {value = 0.4, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnAntlionPulse = function (owner, antlion, ply)
    if owner:Horde_GetPerk("hatcher_vile_blood") and antlion:Horde_IsStage(3) then
        ply:Horde_AddVileBlood(5)
    end
end