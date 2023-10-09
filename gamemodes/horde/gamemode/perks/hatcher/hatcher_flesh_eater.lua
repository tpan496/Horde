PERK.PrintName = "Flesh Eater"
PERK.Description =
[[Stage III Antlion grants Flesh Eater through Aroma Pulse.
Flesh Eater allows player to leech {1} damage dealt, up to {2} per hit.
Flesh Eater allows Antlion to leech {2} damage dealt.]]
PERK.Icon = "materials/perks/hatcher/flesh_eater.png"
PERK.Params = {
    [1] = {value = 0.04, percent = true},
    [2] = {value = 5},
    [3] = {value = 0.1, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnAntlionPulse = function (owner, antlion, ply)
    if owner:Horde_GetPerk("hatcher_flesh_eater") and antlion:Horde_IsStage(3) then
        ply:Horde_AddFleshEater(5)
    end
end