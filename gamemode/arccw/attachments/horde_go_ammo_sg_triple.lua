if not ArcCWInstalled then return end
AddCSLuaFile()
local att = {}
att.PrintName = "Triple-Hit Shells"
att.Icon = Material("entities/acwatt_go_ammo_sg_triple.png", "mips smooth")
att.Description = "A shell with three projectiles each, more accurate and powerful at range."
att.Desc_Pros = {
    "Fires 3 pellets",
}
att.Desc_Cons = {
    "Fires 3 pellets",
}
att.AutoStats = true
att.Slot = "horde_go_shotgun_ammo"

att.Override_Num = 3
att.Mult_Range = 1.25
att.Mult_AccuracyMOA = 0.5

--att.Mult_Damage = 0.9
--att.Mult_DamageMin = 0.9

att.Override_Num_Priority = 2

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then return false end
end

ArcCW.LoadAttachmentType(att, "horde_go_ammo_sg_triple")
