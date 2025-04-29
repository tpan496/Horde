if not ArcCWInstalled then return end
AddCSLuaFile()
local att = {}
att.PrintName = "Scattershot Shells"
att.Icon = Material("entities/acwatt_go_ammo_sg_scatter.png", "mips smooth")
att.Description = "Shells with extra pellets that increase damage against bodyshots. Also nullifies limb damage penalties at the cost of headshot multiplier."
att.Desc_Pros = {
    "Double base pellets",
    "1.25x bodyshot multiplier",
    "1.0x limb damage multiplier",
}
att.Desc_Cons = {
    "1.25x headshot multiplier",
}
att.AutoStats = true
att.Slot = "horde_go_shotgun_ammo"

att.Mult_Num = 2

--att.Mult_Range = 0.5
att.Mult_AccuracyMOA = 2

--att.Mult_Damage = 1
--att.Mult_DamageMin = 0.85

att.Override_BodyDamageMults = {
    [HITGROUP_HEAD] = 1.25,
    [HITGROUP_CHEST] = 1.25,
    [HITGROUP_STOMACH] = 1.25,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 1,
    [HITGROUP_RIGHTLEG] = 1,
}

att.Override_Num_Priority = 2

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then return false end
end

ArcCW.LoadAttachmentType(att, "horde_go_ammo_sg_scatter")
