PERK.PrintName = "Poach"
PERK.Description = [[
Enemies killed under Hunter's Mark restore health to nearby players.]]
PERK.Icon = "materials/perks/gunslinger/poach.png"
PERK.Params = {
    [1] = {value = 1},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnNPCKilled = function(victim, killer, wpn)
    if not IsValid(victim.Horde_Has_Hunter_Mark) then return end
    if not victim.Horde_Has_Hunter_Mark:Horde_GetPerk("gunslinger_poach") then return end

    for _, ent in pairs(ents.FindInSphere(victim:GetPos(), 250)) do
        if ent:IsPlayer() then
            local healinfo = HealInfo:New({amount=10, healer=victim.Horde_Has_Hunter_Mark})
            HORDE:OnPlayerHeal(ent, healinfo)
        end
    end
end