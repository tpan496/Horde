if SERVER then
util.AddNetworkString("Horde_SyncExp")
end

HORDE.Rank_Novice = "Novice" -- 0 - 4
HORDE.Rank_Amateur = "Amateur" -- 5 - 9
HORDE.Rank_Skilled = "Skilled" -- 10 - 14
HORDE.Rank_Professional = "Professional" -- 15 - 19
HORDE.Rank_Expert = "Expert" -- 20 - 24
HORDE.Rank_Champion = "Champion" -- 25 - 29
HORDE.Rank_Master = "Master" -- 30 - 100
HORDE.player_ranks = {}
HORDE.player_exps = {}
HORDE.max_level = 100

HORDE.Rank_Colors = {
    [HORDE.Rank_Novice] = color_white,
    [HORDE.Rank_Amateur] = Color(50,205,50),
    [HORDE.Rank_Skilled] = Color(135,206,235),
    [HORDE.Rank_Professional] = Color(220,0,220),
    [HORDE.Rank_Expert] = Color(255,69,0),
    [HORDE.Rank_Champion] = Color(255,215,0),
    [HORDE.Rank_Master] = HORDE.color_crimson
}

local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetExp(class_name)
    if not self.Horde_Exps then self.Horde_Exps = {} end
    return self.Horde_Exps[class_name] or 0
end

function plymeta:Horde_SetExp(class_name, exp)
    if not self:IsValid() then return end
    if not self.Horde_Exps then self.Horde_Exps = {} end
    self.Horde_Exps[class_name] = exp
    local level = self:Horde_GetLevel(class_name)
    if exp >= HORDE:GetExpToNextLevel(level + 1) then
        self:Horde_SetLevel(class_name, level + 1)
        self.Horde_Exps[class_name] = 0
    end
end

function plymeta:Horde_GetLevel(class_name)
    if not self.Horde_Levels then self.Horde_Levels = {} end
    return self.Horde_Levels[class_name] or 0
end

function plymeta:Horde_SetLevel(class_name, level)
    if not self:IsValid() then return end
    if not self.Horde_Levels then self.Horde_Levels = {} end
    self.Horde_Levels[class_name] = level
    local rank, rank_level = HORDE:LevelToRank(level)
    self:Horde_SetRankLevel(class_name, rank_level)
    self:Horde_SetRank(class_name, rank)
end

function plymeta:Horde_GetRankLevel(class_name)
    if not self.Horde_RankLevels then self.Horde_RankLevels = {} end
    return self.Horde_RankLevels[class_name] or 0
end

function plymeta:Horde_SetRankLevel(class_name, level)
    if not self:IsValid() then return end
    if not self.Horde_RankLevels then self.Horde_RankLevels = {} end
    self.Horde_RankLevels[class_name] = level
end

function plymeta:Horde_GetRank(class_name)
    if not self.Horde_Ranks then self.Horde_Ranks = {} end
    return self.Horde_Ranks[class_name] or HORDE.Rank_Novice
end

function plymeta:Horde_SetRank(class_name, rank)
    if not self:IsValid() then return end
    if not self.Horde_Ranks then self.Horde_Ranks = {} end
    self.Horde_Ranks[class_name] = rank
end

function plymeta:Horde_SyncExp()
    for name, class in pairs(HORDE.classes) do
        net.Start("Horde_SyncExp")
            net.WriteEntity(self)
            net.WriteUInt(class.order, 4)
            net.WriteUInt(self:Horde_GetExp(name), 32)
            net.WriteUInt(self:Horde_GetLevel(name), 8)
        net.Broadcast()
    end
end

function HORDE:GetExpToNextLevel(level)
    return math.floor(50 + 2 * math.pow(1.1, level) + level * 25 + 100 * math.floor(level / 5))
end

function HORDE:LevelToRank(level)
    if level < 30 then
        local rank = HORDE.Rank_Novice
        if level < 5 then
        elseif level < 10 then
            rank = HORDE.Rank_Amateur
        elseif level < 15 then
            rank = HORDE.Rank_Skilled
        elseif level < 20 then
            rank = HORDE.Rank_Professional
        elseif level < 25 then
            rank = HORDE.Rank_Expert
        elseif level < 30 then
            rank = HORDE.Rank_Champion
        end
        return rank, level % 5
    else
        return HORDE.Rank_Master, level - 30
    end
end

if CLIENT then
net.Receive("Horde_SyncExp", function(length)
    local ply = net.ReadEntity()
    local class_order = net.ReadUInt(4)
    local exp = net.ReadUInt(32)
    local level = net.ReadUInt(8)
    ply:Horde_SetLevel(HORDE.order_to_class_name[class_order], level)
    ply:Horde_SetExp(HORDE.order_to_class_name[class_order], exp)
end)
end