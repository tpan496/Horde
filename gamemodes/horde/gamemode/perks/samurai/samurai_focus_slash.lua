PERK.PrintName = "Focus Slash"
PERK.Description =
[[Adds 1 charge to Quickstep.
{1} increased Melee damage during Quickstep.]]
PERK.Icon = "materials/perks/samurai/focus_slash.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("samurai_focus_slash") then return end
    if not ply.Horde_In_Quickstep then return end
    if HORDE:IsMeleeDamage(dmginfo) then
        bonus.increase = bonus.increase + 1.00
        sound.Play("horde/player/focus_slash.ogg", ply:GetPos())
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "samurai_focus_slash" then
        HORDE:CheckDemonStompCharges(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "saamurai_focus_slash" then
        HORDE:CheckDemonStompCharges(ply)
    end
end