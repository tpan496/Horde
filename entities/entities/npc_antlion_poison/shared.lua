ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Antlion Viper"
ENT.Author 			= "Homeless_Performer"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Let it eat you!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Antlion"

if (CLIENT) then
local Name = "Antlion Viper"
local LangName = "npc_antlion_f"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end