ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Combine Guard"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"

if (CLIENT) then
	local Name = "Projectile"
	local LangName = "obj_vj_horde_platoon_rpg_projectile"
	language.Add(LangName, Name)
	killicon.AddAlias(LangName, "arccw_horde_rpg7")
	language.Add("#"..LangName, Name)
	killicon.AddAlias("#"..LangName, "arccw_horde_rpg7")
end