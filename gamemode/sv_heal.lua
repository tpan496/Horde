--Horde's healing framework
-- Healing is affected by skill bonuses and is logged.

HealInfo = {}
HealInfo.__index = HealInfo

function HealInfo:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function HealInfo:SetHealAmount(amount)
    self.amount = amount
end

function HealInfo:GetHealAmount()
    return self.amount or 0
end

function HealInfo:SetHealer(healer)
    self.healer = healer
end

function HealInfo:GetHealer(healer)
    return self.healer
end

function HealInfo:SetOverHealPercentage(percentage)
    self.over_heal_percentage = percentage
end

function HealInfo:GetOverHealPercentage()
    return self.over_heal_percentage or 0
end

-- Call this if you want Horde to recognize your healing
function HORDE:OnPlayerHeal(ply, healinfo)
    hook.Run("Horde_ApplyHeal", ply, healinfo)
    print(ply:Health() + healinfo:GetHealAmount())

    ply:SetHealth(math.min(ply:GetMaxHealth() * (1 + healinfo:GetOverHealPercentage()), ply:Health() + healinfo:GetHealAmount()))
end