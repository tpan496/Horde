PERK.PrintName = "Bio Barrier"
PERK.Description =
[[Stage II Antlion grants 20 Barrier through Bug Pulse.
Barrier uses charges to absorb all debuff buildup and damage taken.
Each player has a maximum of 50 Barrier.]]
PERK.Icon = "materials/perks/hatcher/bio_barrier.png"
PERK.Params = {
    [1] = {value = 5},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnAntlionPulse = function (owner, antlion, ply)
    if owner:Horde_GetPerk("hatcher_bio_barrier") and antlion:Horde_IsStage(2) then
        ply:Horde_AddBarrierStack(20)
    end
end