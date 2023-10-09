ENT.Base            = "npc_vj_creature_base"
ENT.Type            = "ai"
ENT.PrintName       = "Gamma Gonome"
ENT.Author          = ""
ENT.Contact         = "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose         = "Horde Boss"
ENT.Instructions    = "Don't change anything."
ENT.Category        = "Zombies"

if (CLIENT) then
local Name = "Gamma Gonome"
local LangName = "npc_vj_horde_gamma_gonome"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
