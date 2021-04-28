PERK.PrintName = "Napalm"
PERK.Description = "Blast damage causes enemies to flinch for 1.5 second."
PERK.Icon = "materials/perks/napalm.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.75, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_napalm")  then return end
    if dmginfo:GetDamageType() == DMG_BLAST then
        npc:MoveStop()
        timer.Remove("Horde_Flinch" .. npc:GetCreationID())
        timer.Create("Horde_Flinch" .. npc:GetCreationID(), 1.5, 1, function()
            if not npc:IsValid() then return end
            npc:MoveStart()
        end)
    end
end