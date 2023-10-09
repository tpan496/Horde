GADGET.PrintName = "Unstable Injection"
GADGET.Description =
[[Gives you a random effect out of the following:
- Recover 20% health.
- Gain 1 Adrenaline/Hypertrophy stack.
- Gain Fortify/Berserk/Haste
- Increases Decay status buildup by 30.]]
GADGET.Icon = "items/gadgets/unstable_injection.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Droppable = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_unstable_injection" then return end
    sound.Play("horde/gadgets/injection.ogg", ply:GetPos())

    local p = math.random(1,4)
    if p == 0 then
        sound.Play("items/medshot4.wav", ply:GetPos())
        local healinfo = HealInfo:New({amount=ply:GetMaxHealth() * 0.2, healer=ply})
        HORDE:OnPlayerHeal(ply, healinfo)
    elseif p == 1 then
        local q = math.random(1,2)
        if q == 1 then
            ply:Horde_AddAdrenalineStack(true)
        else
            ply:Horde_AddHypertrophyStack(true)
        end
    elseif p == 2 then
        local q = math.random(1,2)
        if q == 1 then
            ply:Horde_AddBerserk(5)
        else
            ply:Horde_AddFortify(5)
        end
    else
        ply:Horde_AddDebuffBuildup(HORDE.Status_Decay, 30)
    end
end