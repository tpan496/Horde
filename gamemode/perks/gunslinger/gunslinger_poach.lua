PERK.PrintName = "Poach"
PERK.Description = [[
{1} increased Hunter's Mark duration.
Enemies killed under Hunter's Mark has {2} chance to drop consumable gadgets.
Elites enemies have {3} extra chance to drop gadgets.]]
PERK.Icon = "materials/perks/gunslinger/poach.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not IsValid(victim.Horde_Has_Hunter_Mark) then return end
    if not victim.Horde_Has_Hunter_Mark:Horde_GetPerk("gunslinger_poach") then return end
    local p = math.random()
    local run = nil
    if victim:Horde_IsElite() then
        if p <= 0.5 then
            run = true
        end
    else
        if p <= 0.25 then
            run = true
        end
    end
    if run then
        local gadgets = {
            gadget_agility_shard = 0.20,
            gadget_damage_shard = 0.20,
            gadget_vitality_shard = 0.20,
            gadget_cleansing_shard = 0.18,
            gadget_elixir = 0.02,
            gadget_specimen_crystal_small = 0.13,
            gadget_specimen_crystal_medium = 0.05,
            gadget_specimen_crystal_large = 0.02,
        }

        p = math.random()
        local c = 0
        for gadget, q in pairs(gadgets) do
            c = c + q
            if p <= c then
                local gadget_box = ents.Create("horde_gadgetbox")
                gadget_box.Horde_Gadget = gadget
                gadget_box:SetPos(victim:GetPos())
                gadget_box:Spawn()
                return
            end
        end
        local gadget_box = ents.Create("horde_gadgetbox")
        gadget_box.Horde_Gadget = "gadget_specimen_crystal_large"
        gadget_box:SetPos(victim:GetPos())
        gadget_box:Spawn()
    end
end