if not ArcCWInstalled then return end
AddCSLuaFile()
local att = {}
att.PrintName = "Magnum Shells"
att.Icon = Material("entities/acwatt_go_ammo_sg_magnum.png", "mips smooth")
att.Description = "A heavy loading of the default buckshot shell, improving close range damage at the cost of range and recoil."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "horde_go_shotgun_ammo"

att.Mult_Range = 0.75
att.Mult_RangeMin = 1 + (1 / 3)
--att.Mult_AccuracyMOA = 2
att.Mult_Recoil = 1.25
--att.Mult_RecoilSide = 1.25,

att.Mult_Damage = 1.15
att.Mult_DamageMin = 0.75

att.Override_Num_Priority = 2

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then return false end
end

ArcCW.LoadAttachmentType(att, "horde_go_ammo_sg_magnum")
