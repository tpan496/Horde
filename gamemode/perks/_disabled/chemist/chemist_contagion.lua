PERK.PrintName = "Contagion"
PERK.Description = [[Generates an explosion when Break triggers.
The explosion deals Poison damage over time.]]
PERK.Icon = "materials/perks/positron_array.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnNPCTriggerBreak = function (duration, npc, ply)
    if not ply:Horde_GetPerk("chemist_contagion")  then return end
    local pos = npc:GetPos()
    
    for _, ent in pairs(ents.FindInSphere(pos, 150)) do
        if ent:IsNPC() and HORDE:IsPlayerOrMinion(ent) ~= true then
            ent:TakeDamageOverTime(ply, 10, DMG_NERVEGAS, 0.5, 5)
        end
    end
end