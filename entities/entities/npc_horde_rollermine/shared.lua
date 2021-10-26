ENT.Base            = "npc_vj_creature_base"
ENT.Type            = "ai"
ENT.PrintName       = "Rollermine"
ENT.Author          = ""
ENT.Contact         = "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose         = "Horde Boss"
ENT.Instructions    = "Don't change anything."
ENT.Category        = "Horde"

if (CLIENT) then
local Name = "Rollermine"
local LangName = "npc_horde_rollermine"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
