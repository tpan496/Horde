PERK.PrintName = "Necromastery"
PERK.Description =
[[+{1} to maximum Spectres alive.
Unlocks the Devour skill for Void Projector (R button).
Instantly kills a targeted non-elite enemy and spawn a Spectre.]]
PERK.Icon = "materials/perks/necromancer/necromastery.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnRaiseSpectre = function (ply, properties)
    if ply:Horde_GetPerk("necromancer_necromastery") then
        properties.necromastery = true
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_necromastery" then
        ply.Horde_Spectre_Max_Count = ply.Horde_Spectre_Max_Count + 1

        ply:Horde_SetPerkCooldown(10)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Devour, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "necromancer_necromastery" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Devour, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)

        ply.Horde_Spectre_Max_Count = ply.Horde_Spectre_Max_Count - 1

        if HORDE.player_drop_entities[ply:SteamID()] then
            for id, ent in pairs(HORDE.player_drop_entities[ply:SteamID()]) do
                if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_spectre" then
                    ent:Remove()
                end
            end
        end
    end
end


PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("necromancer_necromastery") then return end
    local active_weapon = ply:GetActiveWeapon()
    if not active_weapon:IsValid() or not active_weapon:GetClass() == "horde_void_projector" then return false end
    local res = active_weapon:Devour()
    if res then return true end
end