if not ArcCWInstalled then return end --this still relies on content from arccw
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_nade_knife")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_throwing_knife", "arccw/weaponicons/arccw_go_nade_knife", Color(0, 0, 0, 255))
    killicon.Add("arccw_horde_thr_knife", "arccw/weaponicons/arccw_go_nade_knife", Color(0, 0, 0, 255))
end
SWEP.Base = "weapon_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Kunai"
SWEP.Slot = 1


SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_eq_throwingknife.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/w_eq_throwingknife_thrown.mdl"
SWEP.ViewModelFOV = 72


SWEP.WElements = {
    ["mr sharp"] = { type = "Model", model = "models/weapons/arccw_go/w_eq_throwingknife_thrown.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 2, -1), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.RegenerationTimer = CurTime()
SWEP.AmmoRegenAmount = 1 -- Per second

SWEP.Primary.ClipSize = -1

SWEP.HoldType = "knife"
SWEP.Primary.Ammo = "GrenadeHL1"
SWEP.Primary.MaxAmmo = 5
SWEP.Primary.Automatic = true
SWEP.NPCWeight = 25

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0.1
--arccw shit the bed

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )

    if CLIENT then
    self.WElements = table.FullCopy( self.WElements )
    self:CreateModels( self.WElements ) -- create worldmodels
    end
end
function SWEP:GetPrimaryAmmoType()
    return "GrenadeHL1"
end

function SWEP:Deploy()
    local owner = self:GetOwner()
    self:SetWeaponHoldType( self.HoldType )
    self:SendWeaponAnim( ACT_VM_DRAW )
    self:EmitSound("arccw_go/knife/knife_deploy1.wav")
    self:SetNextPrimaryFire( CurTime() + 0.5 )
    self:SetNextSecondaryFire( CurTime() + 0.5 )
    self.RegenerationTimer = CurTime() + 2.25
    if SERVER and self.HolsterTime then
        local ammoCount = math.floor( ( CurTime() - self.HolsterTime ) * self.AmmoRegenAmount )
        owner:SetAmmo( math.min( owner:GetAmmoCount( "GrenadeHL1" ) + ammoCount, self.Primary.MaxAmmo ), self.Primary.Ammo )
    end
    return true
end

function SWEP:Holster()
    self.RegenerationTimer = CurTime()
    self.HolsterTime = CurTime()
    return true
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.5)
    self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
    self:DoAttack()
        self:EmitSound("arccw_go/knife/knife_slash1.wav")
end

function SWEP:SecondaryAttack()
  if self:GetNextSecondaryFire() > CurTime() then return end
    local ply = self:GetOwner()
    local owner = self:GetOwner()
    if ply:GetAmmoCount("GrenadeHL1") <= 0 then return end
    owner:SetAnimation( PLAYER_ATTACK1 )
    self:EmitSound("arccw_go/knife/knife_slash2.wav")
    if ( CLIENT ) then return end

    local ent = ents.Create( "arccw_horde_thr_knife" )
    if ( not IsValid( ent ) ) then return end
    local Forward = owner:GetAimVector()

    ent:SetPos( owner:GetShootPos() + Forward * 32 )
    ent:SetAngles( owner:EyeAngles() )
    ent:SetOwner( owner )
    ent:Spawn()
    ent:Activate()
    ent:SetVelocity( Forward * 4000 )
    ent:GetPhysicsObject():SetVelocityInstantaneous( Forward * 4000)

        ply:SetAmmo(ply:GetAmmoCount("GrenadeHL1") -1, "GrenadeHL1")
        self:SetNextSecondaryFire(CurTime() + 1)
        self:SendWeaponAnim(ACT_VM_RELEASE)
        self.RegenerationTimer = CurTime() + 2.25
    timer.Simple(0.3, function ()
        if self:IsValid() then
            self:SendWeaponAnim(ACT_VM_DRAW)
        end
    end)
end

function SWEP:Think()
    local owner = self:GetOwner()
    if self.RegenerationTimer <= CurTime() and self:Ammo1() < self.Primary.MaxAmmo then
        owner:SetAmmo( self:Ammo1() + self.AmmoRegenAmount , self.Primary.Ammo )
        self.RegenerationTimer = CurTime() + 2.25
    end
    if self:Ammo1() > self.Primary.MaxAmmo then
        owner:SetAmmo( self.Primary.MaxAmmo, self.Primary.Ammo )
    end
end

function SWEP:FindHullIntersection(VecSrc, tr, Mins, Maxs, pEntity)
    local VecHullEnd = VecSrc + ((tr.HitPos - VecSrc) * 2)
    local tracedata = {}
    tracedata.start  = VecSrc
    tracedata.endpos = VecHullEnd
    tracedata.filter = pEntity
    tracedata.mask   = MASK_SOLID
    tracedata.mins   = Mins
    tracedata.maxs   = Maxs
    local tmpTrace = util.TraceLine( tracedata )

    if tmpTrace.Hit then
      tr = tmpTrace
      return tr
    end

    local Distance = 2000
    for i = 0, 1 do
      for j = 0, 1 do
        for k = 0, 1 do
          local VecEnd = Vector()
          VecEnd.x = VecHullEnd.x + (i > 0 and Maxs.x or Mins.x)
          VecEnd.y = VecHullEnd.y + (j > 0 and Maxs.y or Mins.y)
          VecEnd.z = VecHullEnd.z + (k > 0 and Maxs.z or Mins.z)
          tracedata.endpos = VecEnd
          tmpTrace = util.TraceLine( tracedata )
          if tmpTrace.Hit then
            local ThisDistance = (tmpTrace.HitPos - VecSrc):Length()
            if (ThisDistance < Distance) then
              tr = tmpTrace
              Distance = ThisDistance
            end
          end
        end
      end
    end
    return tr
end

function SWEP:DoAttack()
    --credit to xdshot for this logic https://steamcommunity.com/sharedfiles/filedetails/?id=506283460, i'd have lost my marbles by now
    local Attacker = self:GetOwner()
    local Range = 95

    Attacker:LagCompensation(true)
    local Forward = Attacker:GetAimVector()
    local AttackSrc = Attacker:GetShootPos()
    local AttackEnd = AttackSrc + Forward * Range
    local tracedata = {}

    tracedata.start   = AttackSrc
    tracedata.endpos  = AttackEnd
    tracedata.filter  = Attacker
    tracedata.mask    = MASK_SOLID
    tracedata.mins    = Vector( -16, -16, -18 ) -- head_hull_mins
    tracedata.maxs    = Vector( 16, 16, 18 ) -- head_hull_maxs

    local tr = util.TraceLine( tracedata )
    if not tr.Hit then tr = util.TraceHull( tracedata ) end

    if tr.Hit and ( not (IsValid(tr.Entity) and tr.Entity) or tr.HitWorld ) then
        local HullDuckMins, HullDuckMaxs = Attacker:GetHullDuck()
        tr = self:FindHullIntersection(AttackSrc, tr, HullDuckMins, HullDuckMaxs, Attacker)
        AttackEnd = tr.HitPos
    end

    local HitEntity = IsValid(tr.Entity) and tr.Entity or Entity(0) -- Ugly hack to destroy glass surf. 0 is worldspawn.
    local DidHitPlrOrNPC = HitEntity and ( HitEntity:IsPlayer() or HitEntity:IsNPC() ) and IsValid( HitEntity )
    local Force = Forward:GetNormalized() * 300
    local damageinfo = DamageInfo()
    damageinfo:SetAttacker( Attacker )
    damageinfo:SetInflictor( self )
    damageinfo:SetDamage( 75 )
    damageinfo:SetDamageType(DMG_SLASH)
    damageinfo:SetDamageForce( Force )
    damageinfo:SetDamagePosition( AttackEnd )
    HitEntity:DispatchTraceAttack( damageinfo, tr, Forward )
    Attacker:SetAnimation( PLAYER_ATTACK1 )

    local Act = ACT_VM_HITCENTER or ACT_VM_MISSCENTER
    if Act then
      self:SendWeaponAnim( Act )
    end

    if DidHitPlrOrNPC then
        local Snd = Sound("physics/flesh/flesh_impact_bullet" .. math.random( 1,2,3,4,5 ) .. ".wav")
        self:EmitSound( Snd )
    end
    Attacker:LagCompensation(false) -- Don't forget to disable it!
end

--nuclear approach so i don't have to open blender and recompile a worldmodel

local entMeta = FindMetaTable( "Entity" )
local entity_GetTable = entMeta.GetTable
if CLIENT then
    local entity_ManipulateBoneScale = entMeta.ManipulateBoneScale
    local entity_ManipulateBoneAngles = entMeta.ManipulateBoneAngles
    local entity_ManipulateBonePosition = entMeta.ManipulateBonePosition

    local zeroVector = Vector( 0, 0, 0 )
    local zeroAngle = Angle( 0, 0, 0 )
    local oneVector = Vector( 1, 1, 1 )

    SWEP.wRenderOrder = nil
    function SWEP:DrawWorldModel()
        local selfTbl = entity_GetTable( self )
        if selfTbl.ShowWorldModel == nil or selfTbl.ShowWorldModel then
            self:DrawModel()
        end
        if not selfTbl.WElements then return end

        if not selfTbl.wRenderOrder then
            selfTbl.wRenderOrder = {}

            for k, v in pairs( selfTbl.WElements ) do
                if v.type == "Model" then
                    table.insert( selfTbl.wRenderOrder, 1, k )
                elseif v.type == "Sprite" or v.type == "Quad" then
                    table.insert( selfTbl.wRenderOrder, k )
                end
            end
        end

        if IsValid( self:GetOwner() ) then
            bone_ent = self:GetOwner()
        else
            -- -- when the weapon is dropped
            bone_ent = self
        end

        for _, name in pairs( selfTbl.wRenderOrder ) do
            local v = selfTbl.WElements[name]
            if not v then
                selfTbl.wRenderOrder = nil
                break
            end
            if v.hide then continue end

            local pos, ang

            if v.bone then
                pos, ang = self:GetBoneOrientation( selfTbl.WElements, v, bone_ent )
            else
                pos, ang = self:GetBoneOrientation( selfTbl.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
            end

            if not pos then continue end

            local model = v.modelEnt
            local sprite = v.spriteMaterial

            if v.type == "Model" and IsValid( model ) then
                model:SetPos( pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis( ang:Up(), v.angle.y )
                ang:RotateAroundAxis( ang:Right(), v.angle.p )
                ang:RotateAroundAxis( ang:Forward(), v.angle.r )

                model:SetAngles( ang )
                -- --model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale( v.size )
                model:EnableMatrix( "RenderMultiply", matrix )

                if v.material == "" then
                    model:SetMaterial( "" )
                elseif model:GetMaterial() ~= v.material then
                    model:SetMaterial( v.material )
                end

                if v.skin and v.skin ~= model:GetSkin() then
                    model:SetSkin( v.skin )
                end

                if v.bodygroup then
                    for k, v in pairs( v.bodygroup ) do
                        if model:GetBodygroup( k ) ~= v then
                            model:SetBodygroup( k, v )
                        end
                    end
                end

                if v.surpresslightning then
                    render.SuppressEngineLighting( true )
                end

                render.SetColorModulation( v.color.r / 255, v.color.g / 255, v.color.b / 255 )
                render.SetBlend( v.color.a / 255 )
                model:DrawModel()
                render.SetBlend( 1 )
                render.SetColorModulation( 1, 1, 1 )

                if v.surpresslightning then
                    render.SuppressEngineLighting( false )
                end
            elseif v.type == "Sprite" and sprite then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial( sprite )
                render.DrawSprite( drawpos, v.size.x, v.size.y, v.color )
            elseif v.type == "Quad" and v.draw_func then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis( ang:Up(), v.angle.y )
                ang:RotateAroundAxis( ang:Right(), v.angle.p )
                ang:RotateAroundAxis( ang:Forward(), v.angle.r )

                cam.Start3D2D( drawpos, ang, v.size )
                v.draw_func( self )
                cam.End3D2D()
            end
        end
    end

    function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
        local bone, pos, ang
        if tab.rel and tab.rel ~= "" then
            local v = basetab[tab.rel]

            if not v then return end

            -- -- Technically, if there exists an element with the same name as a bone
            -- -- you can get in an infinite loop. Let's just hope nobody's that stupid.
            pos, ang = self:GetBoneOrientation( basetab, v, ent )
            if not pos then return end

            pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis( ang:Up(), v.angle.y )
            ang:RotateAroundAxis( ang:Right(), v.angle.p )
            ang:RotateAroundAxis( ang:Forward(), v.angle.r )
        else
            bone = ent:LookupBone( bone_override or tab.bone )

            if not bone then return end

            pos, ang = Vector( 0, 0, 0 ), Angle( 0, 0, 0 )
            local m = ent:GetBoneMatrix( bone )
            if m then
                pos, ang = m:GetTranslation(), m:GetAngles()
            end

            if IsValid( self:GetOwner() ) and self:GetOwner():IsPlayer() and ent == self:GetOwner():GetViewModel() and self.ViewModelFlip then
                ang.r = -ang.r ---- Fixes mirrored models
            end
        end

        return pos, ang
    end

    function SWEP:CreateModels( tab )
        if not tab then return end

        -- -- Create the clientside models here because Garry says we can't do it in the render hook
        for _, v in pairs( tab ) do
            if (v.type == "Model" and v.model and v.model ~= "" and (not IsValid( v.modelEnt ) or v.createdModel ~= v.model) and
                    string.find( v.model, ".mdl" ) and file.Exists( v.model, "GAME" )) then
                v.modelEnt = ClientsideModel( v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE )
                if (IsValid( v.modelEnt )) then
                    v.modelEnt:SetPos( self:GetPos() )
                    v.modelEnt:SetAngles( self:GetAngles() )
                    v.modelEnt:SetParent( self )
                    v.modelEnt:SetNoDraw( true )
                    v.createdModel = v.model
                else
                    v.modelEnt = nil
                end
            elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite)
                    and file.Exists( "materials/" .. v.sprite .. ".vmt", "GAME" )) then
                local name = v.sprite .. "-"
                local params = { ["$basetexture"] = v.sprite }
                -- -- make sure we create a unique name based on the selected options
                local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
                for i, j in pairs( tocheck ) do
                    if (v[j]) then
                        params["$" .. j] = 1
                        name = name .. "1"
                    else
                        name = name .. "0"
                    end
                end
                v.createdSprite = v.sprite
                v.spriteMaterial = CreateMaterial( name, "UnlitGeneric", params )
            end
        end
    end

    local allbones
    local hasGarryFixedBoneScalingYet = false

    function SWEP:UpdateBonePositions( vm )
        if self.ViewModelBoneMods then
            if (not vm:GetBoneCount()) then return end

            -- -- !! WORKAROUND !! ----
            -- -- We need to check all model names :/
            local loopthrough = self.ViewModelBoneMods
            if (not hasGarryFixedBoneScalingYet) then
                allbones = {}
                for i = 0, vm:GetBoneCount() do
                    local bonename = vm:GetBoneName( i )
                    if (self.ViewModelBoneMods[bonename]) then
                        allbones[bonename] = self.ViewModelBoneMods[bonename]
                    else
                        allbones[bonename] = {
                            scale = Vector( 1, 1, 1 ),
                            pos = Vector( 0, 0, 0 ),
                            angle = Angle( 0, 0, 0 )
                        }
                    end
                end

                loopthrough = allbones
            end
            --!! ----------- !! --

            for k, v in pairs( loopthrough ) do
                local bone = vm:LookupBone( k )
                if (not bone) then continue end

                -- -- !! WORKAROUND !! ----
                local s = Vector( v.scale.x, v.scale.y, v.scale.z )
                local p = Vector( v.pos.x, v.pos.y, v.pos.z )
                local ms = Vector( 1, 1, 1 )
                if (not hasGarryFixedBoneScalingYet) then
                    local cur = vm:GetBoneParent( bone )
                    while (cur >= 0) do
                        local pscale = loopthrough[vm:GetBoneName( cur )].scale
                        ms = ms * pscale
                        cur = vm:GetBoneParent( cur )
                    end
                end

                s = s * ms
                --!! ----------- !! --

                if vm:GetManipulateBoneScale( bone ) ~= s then
                    vm:ManipulateBoneScale( bone, s )
                end
                if vm:GetManipulateBoneAngles( bone ) ~= v.angle then
                    vm:ManipulateBoneAngles( bone, v.angle )
                end
                if vm:GetManipulateBonePosition( bone ) ~= p then
                    vm:ManipulateBonePosition( bone, p )
                end
            end
        else
            self:ResetBonePositions( vm )
        end
    end

    function SWEP:ResetBonePositions( vm )
        local vmBones = vm:GetBoneCount()
        if not vmBones then return end
        for i = 0, vmBones do
            entity_ManipulateBoneScale( vm, i, oneVector )
            entity_ManipulateBoneAngles( vm, i, zeroAngle )
            entity_ManipulateBonePosition( vm, i, zeroVector )
        end
    end

    function table.FullCopy( tab )
        if (not tab) then return nil end

        local res = {}
        for k, v in pairs( tab ) do
            if (type( v ) == "table") then
                res[k] = table.FullCopy( v ) ---- recursion ho!
            elseif (type( v ) == "Vector") then
                res[k] = Vector( v.x, v.y, v.z )
            elseif (type( v ) == "Angle") then
                res[k] = Angle( v.p, v.y, v.r )
            else
                res[k] = v
            end
        end

        return res
    end
end
