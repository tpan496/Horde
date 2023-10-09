PERK.PrintName = "Bulwark"
PERK.Description = "Watchtowers generate 1 armor battery every {1} seconds."
PERK.Icon = "materials/perks/bulwark.png"
PERK.Params = {
    [1] = {value = 30},
}

PERK.Hooks = {}
PERK.Hooks.Horde_WardenWatchtower = function(ply, watchtower)
    if ply:Horde_GetPerk("warden_bulwark") then
        if watchtower.Horde_Battery and watchtower.Horde_Battery:IsValid() then
            watchtower.Horde_Battery:Remove()
        end
        watchtower.Horde_Battery = ents.Create("item_battery")
        watchtower.Horde_Battery:SetPos(watchtower:GetPos() - watchtower:GetAngles():Forward() * 60)
        watchtower.Horde_Battery:AddEFlags(EFL_NO_DAMAGE_FORCES)
        watchtower.Horde_Battery:Spawn()
   end
end