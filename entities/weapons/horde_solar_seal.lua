SWEP.Base = "horde_spell_weapon_base"

if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_solar_seal" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_solar_seal", "vgui/hud/horde_solar_seal", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_solar_projectile", "vgui/hud/horde_solar_seal", Color( 255, 255, 255, 255 ) )
end
SWEP.PrintName 		= "Solar Seal"

SWEP.Author 		= "Gorlami"
SWEP.Instructions 	= "Manipulates solar power."
SWEP.Purpose 		= "Artificer Unique Weapon."

SWEP.AimColor = Color(200,150,100,255)

SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

if CLIENT then
SWEP.VElements = {
	["solar_seal"] = {
        type = "Sprite",
        sprite = "sprites/orangeflare1",
        bone = "ValveBiped.Grenade_body",
        rel = "",
        pos = Vector(-0.519, 0.518, -0.519),
        size = { x = 6, y = 6 },
        color = Color(255, 255, 255, 255),
        nocull = true,
        additive = true,
        vertexalpha = true,
        vertexcolor = true,
        ignorez = false}
}
end

function SWEP:Horde_GetChargingSound()
    return "horde/spells/solar_orb_charge.ogg"
end

function SWEP:Horde_GetChargingSoundNextThink()
    return 0.5
end

if SERVER then
	util.AddNetworkString("Horde_SolarStormTracer")
	util.AddNetworkString("Horde_SolarOrbTracer")
end

if CLIENT then
net.Receive("Horde_SolarStormTracer", function ()
	local charged = net.ReadUInt(3)
	local startpos = net.ReadVector()
	local endpos = net.ReadVector()
	if charged == 1 then
		util.ParticleTracerEx("solar_storm_charged", startpos, endpos, true, LocalPlayer():EntIndex(), -1)
		util.ParticleTracerEx("solar_storm_charged", startpos, endpos, true, LocalPlayer():EntIndex(), -1)
		ParticleEffect("solar_storm_hit", endpos, Angle(0,0,0), nil)
	elseif charged == 2 then
		util.ParticleTracerEx("draconic_storm", startpos, endpos, true, LocalPlayer():EntIndex(), -1)
		ParticleEffect("draconic_storm_hit", endpos, Angle(0,0,0), nil)
	else
		util.ParticleTracerEx("solar_storm", startpos, endpos, true, LocalPlayer():EntIndex(), -1)
		ParticleEffect("solar_storm_hit", endpos, Angle(0,0,0), nil)
	end
end)
end