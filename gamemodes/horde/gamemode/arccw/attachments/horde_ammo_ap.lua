if not ArcCWInstalled then return end

AddCSLuaFile()
local att = {}
att.PrintName = "Armor Piercing Rounds"
att.Icon = Material("attachments/horde_ammo_ap.png", "mips smooth")
att.Description = "Armor piercing round that increases damage at the cost of area of effect."
att.Desc_Pros = {
    "x1.15 Blast Damage",
}
att.Desc_Cons = {
    "x0.7 Area of Effect"
}
att.AutoStats = true
att.Slot = "horde_ammo"
att.Hook_PostFireRocket = function(wep, rocket)
    if CLIENT then return end
    if not wep.ShootEntity then return end
    rocket.Horde_Armor_Piercing = true
end

ArcCW.LoadAttachmentType(att, "horde_ammo_ap")