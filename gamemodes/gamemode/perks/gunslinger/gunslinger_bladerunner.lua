PERK.PrintName = "Bladerunner"
PERK.Description = [[
{1} increased Hunter's Mark duration.
Enemies under Hunter's Mark take {2} more headshot damage.
{3} reduced damage taken from enemies with Hunter's Mark.]]
PERK.Icon = "materials/perks/gunslinger/bladerunner.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 0.30, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not IsValid(npc.Horde_Has_Hunter_Mark) then return end
    if not npc.Horde_Has_Hunter_Mark:Horde_GetPerk("gunslinger_bladerunner") then return end
    if hitgroup == HITGROUP_HEAD then
        bonus.more = bonus.more * 1.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("gunslinger_bladerunner")  then return end
    local inflictor = dmginfo:GetInflictor()
    if not inflictor:IsNPC() then return end
    if not inflictor.Horde_Has_Hunter_Mark then return end
    bonus.less = bonus.less * 0.7
end
