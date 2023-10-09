if SERVER then
util.AddNetworkString("Horde_SyncMind")
util.AddNetworkString("Horde_SyncMaxMind")
end

local plymeta = FindMetaTable("Player")

function plymeta:Horde_RecalcAndSetMaxMind()
    timer.Simple(0, function ()
        if not self:Horde_GetSpellWeapon() then return end
        local bonus = {increase = 0, more = 1, add = 0}
        hook.Run("Horde_OnSetMaxMind", self, bonus)
        self:Horde_SetMaxMind(100 * bonus.more * (1 + bonus.increase) + bonus.add)
        self:Horde_SetMind(self:Horde_GetMaxMind())
    end)
end

function plymeta:Horde_SetMaxMind(mind)
    self.Horde_MaxMind = mind
    self.Horde_MindRegenLast = CurTime()
    if SERVER then
        net.Start("Horde_SyncMaxMind")
            net.WriteUInt(mind, 16)
        net.Send(self)
    end
end

function plymeta:Horde_GetMaxMind()
    return self.Horde_MaxMind or 0
end

function plymeta:Horde_SetMind(mind)
    self.Horde_Mind = mind
    if SERVER then
        net.Start("Horde_SyncMind")
            net.WriteUInt(mind, 16)
        net.Send(self)
    end
end

function plymeta:Horde_GetMind()
    return self.Horde_Mind or 0
end

function plymeta:Horde_SetMindRegenTick(tick)
    self.Horde_MindRegenTick = tick
    self.Horde_MindRegenLast = CurTime()
end

function plymeta:Horde_GetMindRegenTick()
    return self.Horde_MindRegenTick
end
hook.Add("Horde_PlayerMoveBonus", "Horde_ChargingPenalty", function (ply, bonus_walk, bonus_run)
    if ply.Horde_SpellCharging then
        bonus_run.more = bonus_run.more * 0.64
        bonus_walk.more = bonus_walk.more * 0.8
        ply:SetJumpPower(100)
    end
end)

hook.Add("PlayerTick", "Horde_MindRegen", function (ply)
    if SERVER then
    if ply:Horde_GetMaxMind() > 0 and ply:Horde_GetMind() < ply:Horde_GetMaxMind() and ply:Horde_GetMindRegenTick() > 0 and ply.Horde_MindRegenLast < CurTime() then
        ply:Horde_SetMind(ply:Horde_GetMind() + 1)
        local bonus = {increase = 0}
        hook.Run("Horde_MindRegeneration", ply, bonus)
        ply.Horde_MindRegenLast = ply:Horde_GetMindRegenTick() / (1 + bonus.increase) + CurTime()
        if ply:Armor() > 0 then
            ply:Horde_SetMind(math.min(ply:Horde_GetMaxMind(), ply:Horde_GetMind() + ply:Armor() / 2))
            ply:SetArmor(0)
        end
    end
    end
end)

if CLIENT then
net.Receive("Horde_SyncMind", function ()
    MySelf:Horde_SetMind(net.ReadUInt(16))
end)

net.Receive("Horde_SyncMaxMind", function ()
    MySelf:Horde_SetMaxMind(net.ReadUInt(16))
end)
end