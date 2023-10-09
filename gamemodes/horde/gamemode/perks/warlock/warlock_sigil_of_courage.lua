PERK.PrintName = "Sigil of Courage"
PERK.Description =
[[{1} increased mind regeneration inside your Sigils.
Sigils provide {2} Barrier regeneration per second,.]]
PERK.Icon = "materials/perks/warlock/sigil_of_courage.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 2},
}
PERK.Hooks = {}

PERK.Hooks.Horde_MindRegeneration = function (ply, bonus)
    if ply:Horde_GetPerk("warlock_sigil_of_courage") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnSigilCreated = function (ply, bonus, pos, radius, duration, level)
    if ply:Horde_GetPerk("warlock_sigil_of_courage") then
        bonus.sigil_of_courage = true

        for i = 1, duration do
            timer.Simple((i-1) * 1, function ()
                for _, e in pairs(ents.FindInSphere(pos, radius)) do
                    if e:IsPlayer() and e:Alive() then
                        e:Horde_AddBarrierStack(2)
                    end
                end
            end)
        end
    end
end