if not ArcCWInstalled then return end
AddCSLuaFile()
local att = {}
att.PrintName = "Slug Shells"
att.Icon = Material("entities/acwatt_go_ammo_sg_slug.png", "mips smooth")
att.Description = "A single lead slug that improves accuracy and long range performance, though does not scatter."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "horde_go_shotgun_ammo"

att.Override_Num = 1
att.Mult_Range = 1.5
att.Mult_AccuracyMOA = 0.25

--att.Mult_Damage = 0.9
--att.Mult_DamageMin = 1.1

att.Override_Num_Priority = 2

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then return false end
end

ArcCW.LoadAttachmentType(att, "horde_go_ammo_sg_slug")
