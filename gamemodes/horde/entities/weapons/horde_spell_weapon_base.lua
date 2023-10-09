SWEP.PrintName 		= "Spell Weapon"

SWEP.Author 		= "Gorlami"
SWEP.Instructions 	= ""
SWEP.Purpose 		= ""

SWEP.AdminSpawnable = false
SWEP.Spawnable 		= true

SWEP.ViewModelFOV 	= 45
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/c_arms.mdl"

SWEP.AutoSwitchTo 	= true
SWEP.AutoSwitchFrom = true

SWEP.Slot 			= 2
SWEP.SlotPos        = 2

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
SWEP.Primary.ClipSize = 0

SWEP.HoldType = "magic"
SWEP.FiresUnderwater = false
SWEP.MuzzleAttachment	= "muzzle"

SWEP.Weight = 20

SWEP.DrawCrosshair = false
SWEP.Category = "Spell - Horde"

SWEP.DrawAmmo = true
SWEP.Primary.MaxAmmo = 90
SWEP.Primary.ClipSize = -1

SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
    ["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.Base = "weapon_base"

SWEP.Secondary.Sound = "Weapon_Pistol.NPC_Single"
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.ClipSize = 0

SWEP.Delay = 0.5
SWEP.AimColor = Color(100,150,200,255)

function SWEP:DrawHUD()
    if CLIENT then
    local x, y
    local tr = self.Owner:GetEyeTrace()
    if ( self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() ) then
        local coords = tr.HitPos:ToScreen()
        x, y = coords.x, coords.y
    else
        x, y = ScrW() / 2, ScrH() / 2
    end
    surface.SetTexture( surface.GetTextureID( "vgui/hud/special_crosshair" ) )
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.DrawTexturedRect( x - 16, y - 16, 32, 32 )

    -- Charge
    if self:GetPrimaryCharging() == true then
        surface.SetDrawColor(HORDE.color_hollow)
        surface.DrawRect(x - 50, y + 20, 100, 20)

        surface.SetDrawColor(color_white)
        if self:GetPrimarySpellChargeStages() then
            for i = 1, self:GetPrimarySpellChargeStages() do
                local charged_time = self:GetPrimaryChargingTimer()
                if charged_time <= self.PrimarySpell.ChargeTime[i] then
                    if i == 1 then
                        draw.SimpleText(0, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                        surface.DrawRect(x - 50, y + 20, charged_time / self.PrimarySpell.ChargeTime[i] * 100, 20)
                    else
                        draw.SimpleText(i-1, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                        surface.DrawRect(x - 50, y + 20, (charged_time - self.PrimarySpell.ChargeTime[i-1]) / (self.PrimarySpell.ChargeTime[i] - self.PrimarySpell.ChargeTime[i-1]) * 100, 20)
                    end
                    break
                elseif i == self:GetPrimarySpellChargeStages() then
                    draw.SimpleText(i, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                    surface.DrawRect(x - 50, y + 20, 100, 20)
                    break
                end
            end
        end
    elseif self:GetSecondaryCharging() == true then
        surface.SetDrawColor(HORDE.color_hollow)
        surface.DrawRect(x - 50, y + 20, 100, 20)

        surface.SetDrawColor(color_white)
        if self:GetSecondarySpellChargeStages() then
            for i = 1, self:GetSecondarySpellChargeStages() do
                local charged_time = self:GetSecondaryChargingTimer()
                if charged_time <= self.SecondarySpell.ChargeTime[i] then
                    if i == 1 then
                        draw.SimpleText(0, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                        surface.DrawRect(x - 50, y + 20, charged_time / self.SecondarySpell.ChargeTime[i] * 100, 20)
                    else
                        draw.SimpleText(i-1, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                        surface.DrawRect(x - 50, y + 20, (charged_time - self.SecondarySpell.ChargeTime[i-1]) / (self.PrimarySpell.ChargeTime[i] - self.PrimarySpell.ChargeTime[i-1]) * 100, 20)
                    end
                    break
                elseif i == self:GetSecondarySpellChargeStages() then
                    draw.SimpleText(i, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                    surface.DrawRect(x - 50, y + 20, 100, 20)
                    break
                end
            end
        end
    elseif self:GetUtilityCharging() == true then
        surface.SetDrawColor(HORDE.color_hollow)
        surface.DrawRect(x - 50, y + 20, 100, 20)

        surface.SetDrawColor(color_white)
        if self:GetUtilitySpellChargeStages() then
            for i = 1, self:GetUtilitySpellChargeStages() do
                local charged_time = self:GetUtilityChargingTimer()
                if charged_time <= self.UtilitySpell.ChargeTime[i] then
                    if i == 1 then
                        draw.SimpleText(0, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                        surface.DrawRect(x - 50, y + 20, charged_time / self.UtilitySpell.ChargeTime[i] * 100, 20)
                    else
                        draw.SimpleText(i-1, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                        surface.DrawRect(x - 50, y + 20, (charged_time - self.UtilitySpell.ChargeTime[i-1]) / (self.PrimarySpell.ChargeTime[i] - self.PrimarySpell.ChargeTime[i-1]) * 100, 20)
                    end
                    break
                elseif i == self:GetUtilitySpellChargeStages() then
                    draw.SimpleText(i, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                    surface.DrawRect(x - 50, y + 20, 100, 20)
                    break
                end
            end
        end
    elseif self:GetUltimateCharging() == true then
        surface.SetDrawColor(HORDE.color_hollow)
        surface.DrawRect(x - 50, y + 20, 100, 20)

        surface.SetDrawColor(color_white)
        if self:GetUltimateSpellChargeStages() then
            for i = 1, self:GetUltimateSpellChargeStages() do
                local charged_time = self:GetUltimateChargingTimer()
                if charged_time <= self.UltimateSpell.ChargeTime[i] then
                    if i == 1 then
                        draw.SimpleText(0, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                        surface.DrawRect(x - 50, y + 20, charged_time / self.UltimateSpell.ChargeTime[i] * 100, 20)
                    else
                        draw.SimpleText(i-1, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                        surface.DrawRect(x - 50, y + 20, (charged_time - self.UltimateSpell.ChargeTime[i-1]) / (self.PrimarySpell.ChargeTime[i] - self.PrimarySpell.ChargeTime[i-1]) * 100, 20)
                    end
                    break
                elseif i == self:GetUltimateSpellChargeStages() then
                    draw.SimpleText(i, "Trebuchet24", x - 60, y + 19, color_white, TEXT_ALIGN_RIGHT)
                    surface.DrawRect(x - 50, y + 20, 100, 20)
                    break
                end
            end
        end
    end

    cam.Start3D(self.Owner:EyePos(), self.Owner:EyeAngles())
    local size = 5
    render.SetMaterial(Material("Sprites/light_glow02_add_noz"))
    render.DrawQuadEasy(tr.HitPos, (self.Owner:EyePos() - tr.HitPos):GetNormal(), size, size, self.AimColor, 0)
    cam.End3D()
    end
end

function SWEP:Initialize()
    self:SetHoldType("magic")
    timer.Simple(0, function()
        if not self:IsValid() then return end
        if self.Owner and not self.Owner:IsValid() then return end
        self.Owner:SetAmmo(100, "Thumper")
    end)

    if CLIENT then
        self.VElements = table.FullCopy( self.VElements )
        self.WElements = table.FullCopy( self.WElements )
        self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

        self:CreateModels(self.VElements)
        self:CreateModels(self.WElements)

        if IsValid(self.Owner) then
            local vm = self.Owner:GetViewModel()
            if IsValid(vm) then
                self:ResetBonePositions(vm)
                if (self.ShowViewModel == nil or self.ShowViewModel) then
                    vm:SetColor(Color(255,255,255,255))
                else
                    vm:SetColor(Color(255,255,255,1))
                    vm:SetMaterial("Debug/hsv")
                end
            end
        end
    end

    self:Horde_SetSpellCharging(false)
    self:SetPrimaryCharging(false)
    self:SetPrimaryChargingTimer(0)
    self:SetSecondaryCharging(false)
    self:SetSecondaryChargingTimer(0)
    self:SetUtilityCharging(false)
    self:SetUtilityChargingTimer(0)
    self:SetUltimateCharging(false)
    self:SetUltimateChargingTimer(0)

    timer.Simple(0, function() self:InitializeSpells() end)

    self:SetNextUltimateFire(CurTime())
    self.NextUtilityFire = CurTime()
    self.NextChargeSound = CurTime()

    self.Primary_Charge_Stage = 0
    self.Secondary_Charge_Stage = 0
    self.Utility_Charge_Stage = 0
    self.Ultimate_Charge_Stage = 0
end

function SWEP:Horde_GetSpellCharging()
    return self.Owner.Horde_SpellCharging
end

function SWEP:Horde_SetSpellCharging(charging)
    if charging == true then
        self.Owner.Horde_SpellCharging = true
    else
        self.Owner.Horde_SpellCharging = nil
    end
end

function SWEP:Horde_HasSpell(slot, spell)
    if slot == HORDE.Spell_Slot_LMB then
        return self.PrimarySpell == spell
    elseif slot == HORDE.Spell_Slot_RMB then
        return self.SecondarySpell == spell
    elseif slot == HORDE.Spell_Slot_Utility then
        return self.UtilitySpell == spell
    else
        return self.UltimateSpell == spell
    end
end

function SWEP:InitializeSpells()
    if self.Owner and self.Owner:IsValid() then
        if self.Owner:Horde_GetPrimarySpell() then
            self.PrimarySpell = self.Owner:Horde_GetPrimarySpell()
            self:SetPrimarySpellChargeStages(#self.PrimarySpell.Mind)
        end
        if self.Owner:Horde_GetSecondarySpell() then
            self.SecondarySpell = self.Owner:Horde_GetSecondarySpell()
            self:SetSecondarySpellChargeStages(#self.SecondarySpell.Mind)
        end
        if self.Owner:Horde_GetUtilitySpell() then
            self.UtilitySpell = self.Owner:Horde_GetUtilitySpell()
            self:SetUtilitySpellChargeStages(#self.UtilitySpell.Mind)
        end
        if self.Owner:Horde_GetUltimateSpell() then
            self.UltimateSpell = self.Owner:Horde_GetUltimateSpell()
            self:SetUltimateSpellChargeStages(#self.UltimateSpell.Mind)
        end
    end
end

function SWEP:Horde_SetSpell(spell_name)
    if not spell_name then return end
    local spell = table.Copy(HORDE.spells[spell_name])
    if not spell then return end
    local charge_bonus = {increase = 0}
    if spell.Slot == HORDE.Spell_Slot_LMB then
        self.PrimarySpell = spell
        self:SetPrimarySpellChargeStages(#self.PrimarySpell.Mind)
    elseif spell.Slot == HORDE.Spell_Slot_RMB then
        self.SecondarySpell = spell
        self:SetSecondarySpellChargeStages(#self.SecondarySpell.Mind)
    elseif spell.Slot == HORDE.Spell_Slot_Utility then
        self.UtilitySpell = spell
        self:SetUtilitySpellChargeStages(#self.UtilitySpell.Mind)
    else
        self.UltimateSpell = spell
        self:SetUltimateSpellChargeStages(#self.UltimateSpell.Mind)
    end
    self.Primary_Charge_Stage = 0
    self.Secondary_Charge_Stage = 0
    self.Utility_Charge_Stage = 0
    self.Ultimate_Charge_Stage = 0
end

function SWEP:Horde_UnsetSpell(spell_name)
    local spell = HORDE.spells[spell_name]
    if spell.Slot == HORDE.Spell_Slot_LMB then
        self.PrimarySpell = nil
        self:SetPrimarySpellChargeStages(0)
    elseif spell.Slot == HORDE.Spell_Slot_RMB then
        self.SecondarySpell = nil
        self:SetSecondarySpellChargeStages(0)
    elseif spell.Slot == HORDE.Spell_Slot_Utility then
        self.UtilitySpell = nil
        self:SetUtilitySpellChargeStages(0)
    else
        self.UltimateSpell = nil
        self:SetUltimateSpellChargeStages(0)
    end
end

function SWEP:PrimaryAttack()
    if CLIENT then return end
    local ret = hook.Run("Horde_PreSpellCharge", self.Owner, self.PrimarySpell, self, self:Horde_GetSpellCharging())
    if ret then return end
    if self:GetSecondaryCharging() == true or self:GetUtilityCharging() == true or self:GetUltimateCharging() == true then return end
    if self.PrimarySpell and self:Horde_GetMind() >= self.PrimarySpell.Mind[1] then
        if IsValid(self.Owner) then
            local res = hook.Run("Horde_PrePrimarySpell", self.Owner)
            if res then return end
            self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
            self:SetPrimaryCharging(true)
            self:Horde_SetSpellCharging(true)
            self:SetPrimaryChargingTimer(0)
        end
    else
        self:EmitSound("buttons/combine_button_locked.wav")
    end
end

function SWEP:SecondaryAttack()
    if CLIENT then return end
    local ret = hook.Run("Horde_PreSpellCharge", self.Owner, self.SecondarySpell, self, self:Horde_GetSpellCharging())
    if ret then return end
    if self:GetPrimaryCharging() == true or self:GetUtilityCharging() == true or self:GetUltimateCharging() == true then return end
    if self.SecondarySpell and self:Horde_GetMind() >= self.SecondarySpell.Mind[1] then
        if IsValid(self.Owner) then
            local res = hook.Run("Horde_PreSecondarySpell", self.Owner)
            if res then return end
            self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
            self:SetSecondaryCharging(true)
            self:Horde_SetSpellCharging(true)
            self:SetSecondaryChargingTimer(0)
        end
    else
        self:EmitSound("buttons/combine_button_locked.wav")
    end
end

function SWEP:Reload()
    if CLIENT then return end
    local ret = hook.Run("Horde_PreSpellCharge", self.Owner, self.UltimateSpell, self, self:Horde_GetSpellCharging())
    if ret then return end
    if self:GetUltimateCharging() == true then return end
    if self:GetPrimaryCharging() == true or self:GetSecondaryCharging() == true or self:GetUtilityCharging() == true then return end
    if self.UltimateSpell and self:Horde_GetMind() >= self.UltimateSpell.Mind[1] and self:CanUltimateFire() then
        if IsValid(self.Owner) then
            local res = hook.Run("Horde_PreUltimateSpell", self.Owner)
            if res then return end
            self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
            self:SetUltimateCharging(true)
            self:Horde_SetSpellCharging(true)
            self:SetUltimateChargingTimer(0)
        end
    else
        self:EmitSound("buttons/combine_button_locked.wav")
    end
end

function SWEP:Utility()
    if CLIENT then return end
    if !self:CanUtilityFire() then return end
    local ret = hook.Run("Horde_PreSpellCharge", self.Owner, self.UtilitySpell, self, self:Horde_GetSpellCharging())
    if ret then return end
    if self:GetUtilityCharging() == true then return end
    if self:GetPrimaryCharging() == true or self:GetSecondaryCharging() == true or self:GetUltimateCharging() == true then return end
    if self.UtilitySpell and self:Horde_GetMind() >= self.UtilitySpell.Mind[1] then
        if IsValid(self.Owner) then
            local res = hook.Run("Horde_PreUtilitySpell", self.Owner)
            if res then return end
            self.Weapon:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
            self:SetUtilityCharging(true)
            self:Horde_SetSpellCharging(true)
            self:SetUtilityChargingTimer(0)
        end
    else
        self:EmitSound("buttons/combine_button_locked.wav")
    end
end

function SWEP:PrimarySpellFire(stage)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)

    local ret = self.PrimarySpell.Fire(self.Owner, self, stage)
    hook.Run("Horde_OnSpellFire", self.Owner, self, stage, self.PrimarySpell)
    if ret then
        timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
                self.Weapon:DefaultReload(ACT_VM_DRAW)
                self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
            end
        end)
        return
    end
    self:Horde_AddMind(-self.PrimarySpell.Mind[stage])

    timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
            self.Weapon:DefaultReload(ACT_VM_DRAW)
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)
    local bonus = {less = 1}
    hook.Run("Horde_OnSpellCooldown", self.Owner, bonus, self.PrimarySpell)
    self:SetNextPrimaryFire( CurTime() + (self.PrimarySpell.Cooldown or self.Delay) * bonus.less )
end

function SWEP:SecondarySpellFire(stage)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)

    local ret = self.SecondarySpell.Fire(self.Owner, self, stage)
    hook.Run("Horde_OnSpellFire", self.Owner, self, stage, self.SecondarySpell)
    if ret then
        timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
                self.Weapon:DefaultReload(ACT_VM_DRAW)
                self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
            end
        end)
        return
    end
    self:Horde_AddMind(-self.SecondarySpell.Mind[stage])

    timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
            self.Weapon:DefaultReload(ACT_VM_DRAW)
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)
    
    local bonus = {less = 1}
    hook.Run("Horde_OnSpellCooldown", self.Owner, bonus, self.SecondarySpell)
    self:SetNextSecondaryFire( CurTime() + (self.SecondarySpell.Cooldown or self.Delay) * bonus.less )
end

function SWEP:UltimateSpellFire(stage)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)

    local ret = self.UltimateSpell.Fire(self.Owner, self, stage)
    hook.Run("Horde_OnSpellFire", self.Owner, self, stage, self.UltimateSpell)
    if ret then
        timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
                self.Weapon:DefaultReload(ACT_VM_DRAW)
                self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
            end
        end)
        return
    end
    self:Horde_AddMind(-self.UltimateSpell.Mind[stage])

    timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
            self.Weapon:DefaultReload(ACT_VM_DRAW)
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)

    local bonus = {less = 1}
    hook.Run("Horde_OnSpellCooldown", self.Owner, bonus, self.UltimateSpell)
    self:SetNextUltimateFire( CurTime() + (self.UltimateSpell.Cooldown or self.Delay) * bonus.less )
end

function SWEP:UtilitySpellFire(stage)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)

    local ret = self.UtilitySpell.Fire(self.Owner, self, stage)
    hook.Run("Horde_OnSpellFire", self.Owner, self, stage, self.UtilitySpell)
    if ret then
        timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
                self.Weapon:DefaultReload(ACT_VM_DRAW)
                self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
            end
        end)
        return
    end
    self:Horde_AddMind(-self.UtilitySpell.Mind[stage])

    timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
            self.Weapon:DefaultReload(ACT_VM_DRAW)
            self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)

    local bonus = {less = 1}
    hook.Run("Horde_OnSpellCooldown", self.Owner, bonus, self.UtilitySpell)
    self:SetNextUtilityFire( CurTime() + (self.UtilitySpell.Cooldown or self.Delay) * bonus.less )
end

function SWEP:ResetAnim()
    self:EmitSound("buttons/combine_button_locked.wav")
    timer.Create("UniqueName1", 1, 1, function() if IsValid(self) then
        self.Weapon:DefaultReload(ACT_VM_DRAW)
        self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
    end
end)
end

function SWEP:SetupDataTables()
	self:NetworkVar( "Float", 0, "NextUltimateFire" )
    self:NetworkVar( "Float", 1, "NextUtilityFire" )
    self:NetworkVar( "Bool",  2, "PrimaryCharging" )
    self:NetworkVar( "Bool",  3, "SecondaryCharging" )
    self:NetworkVar( "Bool",  4, "UtilityCharging" )
    self:NetworkVar( "Bool",  5, "UltimateCharging" )
    self:NetworkVar( "Float", 6, "PrimaryChargingTimer" )
    self:NetworkVar( "Float", 7, "SecondaryChargingTimer" )
    self:NetworkVar( "Float", 8, "UtilityChargingTimer" )
    self:NetworkVar( "Float", 9, "UltimateChargingTimer" )
    self:NetworkVar( "Int",  10, "PrimarySpellChargeStages")
    self:NetworkVar( "Int",  11, "SecondarySpellChargeStages")
    self:NetworkVar( "Int",  12, "UtilitySpellChargeStages")
    self:NetworkVar( "Int",  13, "UltimateSpellChargeStages")
end

function SWEP:CanUltimateFire()
    return self:GetNextUltimateFire() <= CurTime()
end

function SWEP:CanUtilityFire()
    return self:GetNextUtilityFire() <= CurTime()
end

function SWEP:Horde_GetMind()
    return self.Owner:Horde_GetMind()
end

function SWEP:Horde_AddMind(add)
    self.Owner:Horde_SetMind(math.max(0, math.min(self.Owner:Horde_GetMaxMind(), self.Owner:Horde_GetMind() + add)))
end

function SWEP:Horde_GetChargingSound()
    return "horde/spells/charge.ogg"
end

function SWEP:Horde_GetChargingSoundNextThink()
    return 1
end

function SWEP:Think()
    if self.Owner.Horde_UseSpellUtlity then
        self:Utility()
    end
    if CLIENT then return end
    if self.NextChargeSound <= CurTime() and
    ((self:GetPrimaryCharging() == true and self:GetPrimaryChargingTimer() + 0.1 <= CurTime() and self.Primary_Charge_Stage < self:GetPrimarySpellChargeStages())
    or (self:GetSecondaryCharging() == true and self:GetSecondaryChargingTimer() + 0.1 <= CurTime() and self.Secondary_Charge_Stage < self:GetSecondarySpellChargeStages())
    or (self:GetUtilityCharging() == true and self:GetUtilityChargingTimer() + 0.1 <= CurTime() and self.Utility_Charge_Stage < self:GetUtilitySpellChargeStages())
    or (self:GetUltimateCharging() == true and self:GetUltimateChargingTimer() + 0.1 <= CurTime() and self.Ultimate_Charge_Stage < self:GetUltimateSpellChargeStages())) then
        self:EmitSound(self:Horde_GetChargingSound(), 50, 100, 0.35)
        self.NextChargeSound = CurTime() + self:Horde_GetChargingSoundNextThink()
    end

    if self:GetPrimaryCharging() == true then
        if !self.Owner:KeyDown( IN_ATTACK ) then
            self:SetNextPrimaryFire( CurTime() + self.Delay )
            self:SetPrimaryCharging(false)
            self:Horde_SetSpellCharging(false)
            self:StopSound(self:Horde_GetChargingSound())

            if self.Primary_Charge_Stage == 0 then
                return
            end

            if self:GetPrimaryChargingTimer() >= self.PrimarySpell.ChargeTime[self.Primary_Charge_Stage] then
                if self:Horde_GetMind() < self.PrimarySpell.Mind[self.Primary_Charge_Stage] then
                    self:ResetAnim()
                    return
                end
                self:PrimarySpellFire(self.Primary_Charge_Stage)
            end

            self.Primary_Charge_Stage = 0
        else
            local bonus = {increase = 0}
            hook.Run("Horde_OnSpellCharge", self.Owner, bonus, self.PrimarySpell)
            self:SetPrimaryChargingTimer(self:GetPrimaryChargingTimer() + FrameTime() * (1 + bonus.increase))
            if self.Primary_Charge_Stage < self:GetPrimarySpellChargeStages() and self:GetPrimaryChargingTimer() >= self.PrimarySpell.ChargeTime[self.Primary_Charge_Stage + 1] then
                self.Primary_Charge_Stage = math.min(self.Primary_Charge_Stage + 1, self:GetPrimarySpellChargeStages())
            end
        end
    end

    if self:GetPrimaryCharging() == true and self.PrimarySpell.ChargeRelease and self:GetPrimaryChargingTimer() >= self.PrimarySpell.ChargeTime[self:GetPrimarySpellChargeStages()] then
		self:SetPrimaryCharging(false)
        self:Horde_SetSpellCharging(false)
        self:StopSound(self:Horde_GetChargingSound())
        if self:Horde_GetMind() < self.PrimarySpell.Mind[self:GetPrimarySpellChargeStages()] then
            self:ResetAnim()
            return
        end
        self:PrimarySpellFire(self:GetPrimarySpellChargeStages())
        return
	end

    if self:GetSecondaryCharging() == true then
        if !self.Owner:KeyDown( IN_ATTACK2 ) then
            self:SetNextSecondaryFire( CurTime() + self.Delay )
            self:SetSecondaryCharging(false)
            self:Horde_SetSpellCharging(false)
            self:StopSound(self:Horde_GetChargingSound())

            if self.Secondary_Charge_Stage == 0 then
                return
            end

            if self:GetSecondaryChargingTimer() >= self.SecondarySpell.ChargeTime[self.Secondary_Charge_Stage] then
                if self:Horde_GetMind() < self.SecondarySpell.Mind[self.Secondary_Charge_Stage] then
                    self:ResetAnim()
                    return
                end
                self:SecondarySpellFire(self.Secondary_Charge_Stage)
            end
            
            self.Secondary_Charge_Stage = 0
        else
            local bonus = {increase = 0}
            hook.Run("Horde_OnSpellCharge", self.Owner, bonus, self.SecondarySpell)
            self:SetSecondaryChargingTimer(self:GetSecondaryChargingTimer() + FrameTime() * (1 + bonus.increase))
            if self.Secondary_Charge_Stage < self:GetSecondarySpellChargeStages() and self:GetSecondaryChargingTimer() >= self.SecondarySpell.ChargeTime[self.Secondary_Charge_Stage + 1] then
                self.Secondary_Charge_Stage = math.min(self.Secondary_Charge_Stage + 1, self:GetSecondarySpellChargeStages())
            end
        end
    end

    if self:GetSecondaryCharging() == true and self.SecondarySpell.ChargeRelease and self:GetSecondaryChargingTimer() >= self.SecondarySpell.ChargeTime[self:GetSecondarySpellChargeStages()] then
		self:SetSecondaryCharging(false)
        self:Horde_SetSpellCharging(false)
        self:StopSound(self:Horde_GetChargingSound())
        if self:Horde_GetMind() < self.SecondarySpell.Mind[self:GetSecondarySpellChargeStages()] then
            self:ResetAnim()
            return
        end
        self:SecondarySpellFire(self:GetSecondarySpellChargeStages())
        return
	end

    if self:GetUltimateCharging() == true then
        if !self.Owner:KeyDown( IN_RELOAD ) then
            self:SetNextUltimateFire( CurTime() + self.Delay )
            self:SetUltimateCharging(false)
            self:Horde_SetSpellCharging(false)
            self:StopSound(self:Horde_GetChargingSound())

            if self.Ultimate_Charge_Stage == 0 then
                return
            end

            if self:GetUltimateChargingTimer() >= self.UltimateSpell.ChargeTime[self.Ultimate_Charge_Stage] then
                if self:Horde_GetMind() < self.UltimateSpell.Mind[self.Ultimate_Charge_Stage] then
                    self:ResetAnim()
                    return
                end
                self:UltimateSpellFire(self.Ultimate_Charge_Stage)
            end
            
            self.Ultimate_Charge_Stage = 0
        else
            local bonus = {increase = 0}
            hook.Run("Horde_OnSpellCharge", self.Owner, bonus, self.UltimateSpell)
            self:SetUltimateChargingTimer(self:GetUltimateChargingTimer() + FrameTime() * (1 + bonus.increase))
            if self.Ultimate_Charge_Stage < self:GetUltimateSpellChargeStages() and self:GetUltimateChargingTimer() >= self.UltimateSpell.ChargeTime[self.Ultimate_Charge_Stage + 1] then
                self.Ultimate_Charge_Stage = math.min(self.Ultimate_Charge_Stage + 1, self:GetUltimateSpellChargeStages())
            end
        end
    end

    if self:GetUltimateCharging() == true and self.UltimateSpell.ChargeRelease and self:GetUltimateChargingTimer() >= self.UltimateSpell.ChargeTime[self:GetUltimateSpellChargeStages()] then
		self:SetUltimateCharging(false)
        self:Horde_SetSpellCharging(false)
        self:StopSound(self:Horde_GetChargingSound())
        if self:Horde_GetMind() < self.UltimateSpell.Mind[self:GetUltimateSpellChargeStages()] then
            self:ResetAnim()
            return
        end
        self:UltimateSpellFire(self:GetUltimateSpellChargeStages())
        return
	end

    if self:GetUtilityCharging() == true then
        if !self.Owner.Horde_UseSpellUtlity then
            self:SetNextUtilityFire( CurTime() + self.Delay )
            self:SetUtilityCharging(false)
            self:Horde_SetSpellCharging(false)
            self:StopSound(self:Horde_GetChargingSound())

            if self.Utility_Charge_Stage == 0 then
                return
            end

            if self:GetUtilityChargingTimer() >= self.UtilitySpell.ChargeTime[self.Utility_Charge_Stage] then
                if self:Horde_GetMind() < self.UtilitySpell.Mind[self.Utility_Charge_Stage] then
                    self:ResetAnim()
                    return
                end
                self:UtilitySpellFire(self.Utility_Charge_Stage)
            end
            
            self.Utility_Charge_Stage = 0
        else
            local bonus = {increase = 0}
            hook.Run("Horde_OnSpellCharge", self.Owner, bonus, self.UtilitySpell)
            self:SetUtilityChargingTimer(self:GetUtilityChargingTimer() + FrameTime() * (1 + bonus.increase))
            if self.Utility_Charge_Stage < self:GetUtilitySpellChargeStages() and self:GetUtilityChargingTimer() >= self.UtilitySpell.ChargeTime[self.Utility_Charge_Stage + 1] then
                self.Utility_Charge_Stage = math.min(self.Utility_Charge_Stage + 1, self:GetUtilitySpellChargeStages())
            end
        end
    end

    if self:GetUtilityCharging() == true and self.UtilitySpell.ChargeRelease and self:GetUtilityChargingTimer() >= self.UtilitySpell.ChargeTime[self:GetUtilitySpellChargeStages()] then
		self:SetUtilityCharging(false)
        self:Horde_SetSpellCharging(false)
        self:StopSound(self:Horde_GetChargingSound())
        if self:Horde_GetMind() < self.UtilitySpell.Mind[self:GetUtilitySpellChargeStages()] then
            self:ResetAnim()
            return
        end
        self:UtilitySpellFire(self:GetUtilitySpellChargeStages())
        return
	end
end

/********************************************************
    SWEP Construction Kit base code
        Created by Clavus
    Available for public use, thread at:
        facepunch.com/threads/1032378
        
        
    DESCRIPTION:
        This script is meant for experienced scripters 
        that KNOW WHAT THEY ARE DOING. Dont come to me 
        with basic Lua questions.
        
        Just copy into your SWEP or SWEP base of choice
        and merge with your own code.
        
        The SWEP.VElements, SWEP.WElements and
        SWEP.ViewModelBoneMods tables are all optional
        and only have to be visible to the client.
********************************************************/

if CLIENT then
    SWEP.vRenderOrder = nil
    function SWEP:ViewModelDrawn()
        if self.Owner:KeyDown(IN_ATTACK) then
            local vm = LocalPlayer():GetViewModel()
            local endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 150


        end
        
        local vm = self.Owner:GetViewModel()
        if !IsValid(vm) then return end
        
        if (!self.VElements) then return end
        
        self:UpdateBonePositions(vm)

        if (!self.vRenderOrder) then
            
            // we build a render order because sprites need to be drawn after models
            self.vRenderOrder = {}

            for k, v in pairs( self.VElements ) do
                if (v.type == "Model") then
                    table.insert(self.vRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.vRenderOrder, k)
                end
            end
            
        end

        for k, name in ipairs( self.vRenderOrder ) do
        
            local v = self.VElements[name]
            if (!v) then self.vRenderOrder = nil break end
            if (v.hide) then continue end
            
            local model = v.modelEnt
            local sprite = v.spriteMaterial
            
            if (!v.bone) then continue end
            
            local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
            
            if (!pos) then continue end
            
            if (v.type == "Model" and IsValid(model)) then

                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)

                model:SetAngles(ang)
                //model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale(v.size)
                model:EnableMatrix( "RenderMultiply", matrix )
                
                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() != v.material) then
                    model:SetMaterial( v.material )
                end
                
                if (v.skin and v.skin != model:GetSkin()) then
                    model:SetSkin(v.skin)
                end
                
                if (v.bodygroup) then
                    for k, v in pairs( v.bodygroup ) do
                        if (model:GetBodygroup(k) != v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end
                
                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end
                
                render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
                render.SetBlend(v.color.a/255)
                model:DrawModel()
                render.SetBlend(1)
                render.SetColorModulation(1, 1, 1)
                
                if (v.surpresslightning) then
                    render.SuppressEngineLighting(false)
                end
                
            elseif (v.type == "Sprite" and sprite) then
                
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial(sprite)
                render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
                
            elseif (v.type == "Quad" and v.draw_func) then
                
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                
                cam.Start3D2D(drawpos, ang, v.size)
                    v.draw_func( self )
                cam.End3D2D()

            end
            
        end
        
    end

    
    SWEP.wRenderOrder = nil
    function SWEP:DrawWorldModel()
        if IsValid(self.Owner) and self.Owner:KeyDown(IN_ATTACK) then
            local endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 150


        end
        
        if (self.ShowWorldModel == nil or self.ShowWorldModel) then
            self:DrawModel()
        end
        
        if (!self.WElements) then return end
        
        if (!self.wRenderOrder) then

            self.wRenderOrder = {}

            for k, v in pairs( self.WElements ) do
                if (v.type == "Model") then
                    table.insert(self.wRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.wRenderOrder, k)
                end
            end

        end
        
        if (IsValid(self.Owner)) then
            bone_ent = self.Owner
        else
            // when the weapon is dropped
            bone_ent = self
        end
        
        for k, name in pairs( self.wRenderOrder ) do
        
            local v = self.WElements[name]
            if (!v) then self.wRenderOrder = nil break end
            if (v.hide) then continue end
            
            local pos, ang
            
            if (v.bone) then
                pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
            else
                pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
            end
            
            if (!pos) then continue end
            
            local model = v.modelEnt
            local sprite = v.spriteMaterial
            
            if (v.type == "Model" and IsValid(model)) then

                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)

                model:SetAngles(ang)
                //model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale(v.size)
                model:EnableMatrix( "RenderMultiply", matrix )
                
                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() != v.material) then
                    model:SetMaterial( v.material )
                end
                
                if (v.skin and v.skin != model:GetSkin()) then
                    model:SetSkin(v.skin)
                end
                
                if (v.bodygroup) then
                    for k, v in pairs( v.bodygroup ) do
                        if (model:GetBodygroup(k) != v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end
                
                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end
                
                render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
                render.SetBlend(v.color.a/255)
                model:DrawModel()
                render.SetBlend(1)
                render.SetColorModulation(1, 1, 1)
                
                if (v.surpresslightning) then
                    render.SuppressEngineLighting(false)
                end
                
            elseif (v.type == "Sprite" and sprite) then
                
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial(sprite)
                render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
                
            elseif (v.type == "Quad" and v.draw_func) then
                
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                
                cam.Start3D2D(drawpos, ang, v.size)
                    v.draw_func( self )
                cam.End3D2D()

            end
            
        end
        
    end

    function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
        
        local bone, pos, ang
        if (tab.rel and tab.rel != "") then
            
            local v = basetab[tab.rel]
            
            if (!v) then return end
            
            // Technically, if there exists an element with the same name as a bone
            // you can get in an infinite loop. Let's just hope nobody's that stupid.
            pos, ang = self:GetBoneOrientation( basetab, v, ent )
            
            if (!pos) then return end
            
            pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                
        else
        
            bone = ent:LookupBone(bone_override or tab.bone)

            if (!bone) then return end
            
            pos, ang = Vector(0,0,0), Angle(0,0,0)
            local m = ent:GetBoneMatrix(bone)
            if (m) then
                pos, ang = m:GetTranslation(), m:GetAngles()
            end
            
            if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
                ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
                ang.r = -ang.r // Fixes mirrored models
            end
        
        end
        
        return pos, ang
    end

    function SWEP:CreateModels( tab )

        if (!tab) then return end

        // Create the clientside models here because Garry says we cant do it in the render hook
        for k, v in pairs( tab ) do
            if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
                    string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
                
                v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
                if (IsValid(v.modelEnt)) then
                    v.modelEnt:SetPos(self:GetPos())
                    v.modelEnt:SetAngles(self:GetAngles())
                    v.modelEnt:SetParent(self)
                    v.modelEnt:SetNoDraw(true)
                    v.createdModel = v.model
                else
                    v.modelEnt = nil
                end
                
            elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
                and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
                
                local name = v.sprite.."-"
                local params = { ["$basetexture"] = v.sprite }
                // make sure we create a unique name based on the selected options
                local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
                for i, j in pairs( tocheck ) do
                    if (v[j]) then
                        params["$"..j] = 1
                        name = name.."1"
                    else
                        name = name.."0"
                    end
                end

                v.createdSprite = v.sprite
                v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
                
            end
        end
        
    end
    
    local allbones
    local hasGarryFixedBoneScalingYet = false

    function SWEP:UpdateBonePositions(vm)
        
        if self.ViewModelBoneMods then
            
            if (!vm:GetBoneCount()) then return end
            
            // !! WORKAROUND !! //
            // We need to check all model names :/
            local loopthrough = self.ViewModelBoneMods
            if (!hasGarryFixedBoneScalingYet) then
                allbones = {}
                for i=0, vm:GetBoneCount() do
                    local bonename = vm:GetBoneName(i)
                    if (self.ViewModelBoneMods[bonename]) then 
                        allbones[bonename] = self.ViewModelBoneMods[bonename]
                    else
                        allbones[bonename] = { 
                            scale = Vector(1,1,1),
                            pos = Vector(0,0,0),
                            angle = Angle(0,0,0)
                        }
                    end
                end
                
                loopthrough = allbones
            end
            // !! ----------- !! //
            
            for k, v in pairs( loopthrough ) do
                local bone = vm:LookupBone(k)
                if (!bone) then continue end
                
                // !! WORKAROUND !! //
                local s = Vector(v.scale.x,v.scale.y,v.scale.z)
                local p = Vector(v.pos.x,v.pos.y,v.pos.z)
                local ms = Vector(1,1,1)
                if (!hasGarryFixedBoneScalingYet) then
                    local cur = vm:GetBoneParent(bone)
                    while(cur >= 0) do
                        local pscale = loopthrough[vm:GetBoneName(cur)].scale
                        ms = ms * pscale
                        cur = vm:GetBoneParent(cur)
                    end
                end
                
                s = s * ms
                // !! ----------- !! //
                
                if vm:GetManipulateBoneScale(bone) != s then
                    vm:ManipulateBoneScale( bone, s )
                end
                if vm:GetManipulateBoneAngles(bone) != v.angle then
                    vm:ManipulateBoneAngles( bone, v.angle )
                end
                if vm:GetManipulateBonePosition(bone) != p then
                    vm:ManipulateBonePosition( bone, p )
                end
            end
        else
            self:ResetBonePositions(vm)
        end
            
    end
        
    function SWEP:ResetBonePositions(vm)
        
        if (!vm:GetBoneCount()) then return end
        for i=0, vm:GetBoneCount() do
            vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
            vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
            vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
        end
        
    end

    /**************************
        Global utility code
    **************************/

    // Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
    // Does not copy entities of course, only copies their reference.
    // WARNING: do not use on tables that contain themselves somewhere down the line or youll get an infinite loop
    function table.FullCopy( tab )

        if (!tab) then return nil end
        
        local res = {}
        for k, v in pairs( tab ) do
            if (type(v) == "table") then
                res[k] = table.FullCopy(v) // recursion ho!
            elseif (type(v) == "Vector") then
                res[k] = Vector(v.x, v.y, v.z)
            elseif (type(v) == "Angle") then
                res[k] = Angle(v.p, v.y, v.r)
            else
                res[k] = v
            end
        end
        
        return res
        
    end
    
end


function SWEP:OnDrop()
	self:Remove() -- You can't drop fists
end