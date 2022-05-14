PERK.PrintName = "Void Siphon"
PERK.Description =
[[Hitting enemies with Void Spear restores energy.
Increases Void Spear damage according to remaining energy.]]
PERK.Icon = "materials/subclasses/necromancer.png"
PERK.Params = {
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("necromancer_void_siphon") and dmginfo:GetInflictor() and dmginfo:GetInflictor():GetClass() == "projectile_horde_void_projectile" then
        local wpn = ply:GetWeapon("horde_void_projector")
        wpn:SetClip1(math.min(100, wpn:Clip1() + math.min(20, dmginfo:GetDamage() / 5)))
    end
end

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply, properties)
    if ply:Horde_GetPerk("necromancer_void_siphon") then
        properties.siphon = true
    end
end