PERK.PrintName = "Bounty Hunter"
PERK.Description = [[
Enemies killed under Hunter's Mark drop extra cash.]]
PERK.Icon = "materials/perks/gunslinger/bounty_hunter.png"
PERK.Params = {
    [1] = {value = 1},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not IsValid(victim.Horde_Has_Hunter_Mark) then return end
    if not victim.Horde_Has_Hunter_Mark:Horde_GetPerk("gunslinger_bounty_hunter") then return end

    local money = ents.Create("horde_money")
    local pos = victim:GetPos()
    local drop_pos = pos
    drop_pos.z = pos.z + 15
    money:SetPos(drop_pos)
    money:DropToFloor()
    money:Spawn()
end