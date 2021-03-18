PERK.PrintName = "Headhunter"
PERK.Description = "Headshot damage stacks.\nEach stack increases 8% headshot damage."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.ScaleNPCDamage = function(npc, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if SERVER and IsValid(attacker) and attacker:IsPlayer() and hitgroup == HITGROUP_HEAD and attacker:Horde_GetPerk("ghost_headhunter") then
        print("Activate headhunter")
        HORDE:HeadhunterStack(attacker)
    end
end