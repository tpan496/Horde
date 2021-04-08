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
    hook.Run("Horde_OnPlayerHeal", ply, healinfo)
    if (ply:GetMaxHealth() <= ply:Health()) and (healinfo:GetOverHealPercentage() <= 0) then return end
    ply:SetHealth(math.min(ply:GetMaxHealth() * (1 + healinfo:GetOverHealPercentage()), ply:Health() + healinfo:GetHealAmount()))

    local healer = healinfo:GetHealer()
    if not healer:IsPlayer() or not healer:IsValid() then return end
    if not HORDE.player_heal[healer:SteamID()] then HORDE.player_heal[healer:SteamID()] = 0 end
    HORDE.player_heal[healer:SteamID()] = HORDE.player_heal[healer:SteamID()] + healinfo:GetHealAmount()

    ply:ScreenFade(SCREENFADE.IN, Color(50, 200, 50, 10), 0.3, 0)
    if healer ~= player then
        healer:Horde_AddMoney(2)
        healer:Horde_SyncEconomy()
    end
end