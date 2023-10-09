PERK.PrintName = "Sigil of Malediction"
PERK.Description =
[[Enemies inside your Sigils take Physical damage over time.
Damage scales with the level of your Sigil.]]
PERK.Icon = "materials/perks/warlock/sigil_of_malediction.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 5}
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetMaxMind = function (ply, bonus)
    if ply:Horde_GetPerk("warlock_sigil_of_malediction") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnSigilCreated = function (ply, bonus, pos, radius, duration, level)
    if ply:Horde_GetPerk("warlock_sigil_of_malediction") then
        bonus.sigil_of_malediction = true

        for i = 1, duration do
            timer.Simple((i-1) * 1, function ()
                for _, e in pairs(ents.FindInSphere(pos, radius)) do
                    if HORDE:IsEnemy(e) then
                        local dmginfo = DamageInfo()
                        dmginfo:SetAttacker(ply)
                        dmginfo:SetInflictor(ply)
                        dmginfo:SetDamage(20 + level * 5)
                        dmginfo:SetDamagePosition(e:GetPos())
                        dmginfo:SetDamageType(DMG_GENERIC)
                        e:TakeDamageInfo(dmginfo)
                    end
                end
            end)
        end
    end
end