PERK.PrintName = "Tren Perfume"
PERK.Description =
[[Adds {1} maximum Hypertrophy stacks.
Press R to shoot a spore that provides Hypertrophy to players in an area.
Effect lasts for {2} seconds and has a cooldown of {3} seconds.]]
PERK.Icon = "materials/perks/carcass/aas_perfume.png"
PERK.Params = {
    [1] = {value = 2},
    [2] = {value = 5},
    [3] = {value = 10},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "carcass_aas_perfume" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() + 2)
        ply:Horde_SetPerkCooldown(10)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_AAS_Perfume, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "carcass_aas_perfume" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() - 2)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_AAS_Perfume, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("carcass_aas_perfume") then return end
    local active_weapon = ply:GetActiveWeapon()
    if not active_weapon:IsValid() or not active_weapon:GetClass() == "horde_carcass" then return false end
    local res = active_weapon:AAS_Perfume()
    if res then return true end
end