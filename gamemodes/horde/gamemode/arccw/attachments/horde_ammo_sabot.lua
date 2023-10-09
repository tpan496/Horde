if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Sabot Rounds"
att.Icon = Material("attachments/horde_ammo_sabot.png", "mips smooth")
att.Description = "Sabot round that causes projectile to deal only Blunt damage."
att.Desc_Pros = {
    "x1.25 Blunt Damage"
}
att.Desc_Cons = {
    "-No Blast Damage"
}
att.AutoStats = true
att.Slot = "horde_ammo"
att.Hook_PostFireRocket = function(wep, rocket)
    if CLIENT then return end
    if not wep.ShootEntity then return end
    rocket.ProjectileSabotRound = true
end

ArcCW.LoadAttachmentType(att, "horde_ammo_sabot")