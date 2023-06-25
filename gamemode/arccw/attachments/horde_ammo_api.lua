att.PrintName = "AP/I Rounds"
att.Icon = Material("entities/acwatt_go_ammo_api.png", "mips smooth")
att.Description = "Armor-piercing incendiary rounds which ignite targets and improves range and long range damage, though at the cost of reduced damage overall."
att.Desc_Pros = {
    "pro.ignite"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "go_ammo"


att.Mult_Range = 1.5

att.Mult_Damage = 0.85
att.Mult_DamageMin = 1.1

att.Override_DamageType = DMG_BURN

att.Override_PhysTracerProfile = 1

att.Hook_Compatible = function(wep)
    if wep:GetIsShotgun() then return false end
end