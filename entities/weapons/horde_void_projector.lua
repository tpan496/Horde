SWEP.Base = "horde_spell_weapon_base"
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_void_projector" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_void_projector", "vgui/hud/horde_void_projector", Color( 255, 255, 255, 255 ) )
	killicon.Add( "projectile_horde_void_projectile", "vgui/hud/horde_void_projector", Color( 255, 255, 255, 255 ) )
end

SWEP.PrintName 		= "Void Projector"

SWEP.Author 		= "Gorlami"
SWEP.Instructions 	= "Manipulates dark energy."
SWEP.Purpose 		= "Necromancer Unique Weapon."

SWEP.AdminSpawnable = false
SWEP.Spawnable 		= true
SWEP.Category = "ArcCW - Horde"

SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

if CLIENT then
SWEP.VElements = {
	["void_projector"] = {
        type = "Sprite",
        sprite = "sprites/blueflare1",
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
    return "horde/spells/void_charge.ogg"
end

function SWEP:Horde_GetChargingSoundNextThink()
    return 0.5
end