local u1 = {
    "[Shotgun]",
    "[Drum-Shotgun]",
    "[Rifle]",
    "[TacticalShotgun]",
    "[AR]",
    "[AUG]",
    "[AK47]",
    "[LMG]",
    "[SilencerAR]"
}
local u2 = {
    ["Brainrot"] = "All"
}
local u3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("Players")
local u5 = workspace.CurrentCamera
local u6 = game:GetService("TweenService")
game:GetService("UserInputService")
local u7 = u4.LocalPlayer
local u8 = u7:GetMouse()
local u9 = u3.SkinAssets
local u10 = u7.Character or u7.CharacterAdded:Wait()
local u11 = u7.Character.Humanoid.Animator:LoadAnimation(u3:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("Shoot"))
local u12 = u7.Character.Humanoid.Animator:LoadAnimation(u3:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("ShootLeft"))
local u13 = u7.Character.Humanoid.Animator:LoadAnimation(u3.Animations.GunCombat.ShootRight)
local u14 = u7.Character.Humanoid.Animator:LoadAnimation(u3:WaitForChild("Animations"):WaitForChild("GunCombat"):WaitForChild("AimShoot"))
local u15 = workspace:GetServerTimeNow()
local _ = game.PlaceId == 88976059384565
local u16 = {
    ["SoundPlay"] = function()
    end
}
do
    local v16_loaded = false
    local v16_sound_url = "https://raw.githubusercontent.com/martinmangos/sunshine-xd/refs/heads/main/GunSoundPlay.lua"
    local v16_read_ok, v16_source = pcall(readfile, "GunSoundPlay.lua")
    if v16_read_ok and type(v16_source) == "string" and #v16_source > 0 then
        local v16_chunk_ok, v16_chunk = pcall(loadstring, v16_source)
        if v16_chunk_ok and type(v16_chunk) == "function" then
            local v16_mod_ok, v16_module = pcall(v16_chunk)
            if v16_mod_ok and type(v16_module) == "table" and type(v16_module.SoundPlay) == "function" then
                u16 = v16_module
                v16_loaded = true
            end
        end
    end
    if not v16_loaded and game and game.HttpGet then
        local v16_http_ok, v16_http_source = pcall(function()
            return game:HttpGet(v16_sound_url)
        end)
        if v16_http_ok and type(v16_http_source) == "string" and #v16_http_source > 0 then
            local v16_chunk_ok, v16_chunk = pcall(loadstring, v16_http_source)
            if v16_chunk_ok and type(v16_chunk) == "function" then
                local v16_mod_ok, v16_module = pcall(v16_chunk)
                if v16_mod_ok and type(v16_module) == "table" and type(v16_module.SoundPlay) == "function" then
                    u16 = v16_module
                    v16_loaded = true
                end
            end
        end
    end
    if not v16_loaded then
        local v16_ok, v16_module = pcall(function()
            return require(u3:WaitForChild("GunSoundPlay"))
        end)
        if v16_ok and type(v16_module) == "table" and type(v16_module.SoundPlay) == "function" then
            u16 = v16_module
        end
    end
end
local function u23(p17, p18) --[[ Line: 47 ]]
    if p18 == 0 then
        return p17.Keypoints[1].Value
    end
    if p18 == 1 then
        return p17.Keypoints[#p17.Keypoints].Value
    end
    for v19 = 1, #p17.Keypoints - 1 do
        local v20 = p17.Keypoints[v19]
        local v21 = p17.Keypoints[v19 + 1]
        if v20.Time <= p18 and p18 < v21.Time then
            local v22 = (p18 - v20.Time) / (v21.Time - v20.Time)
            return Color3.new((v21.Value.R - v20.Value.R) * v22 + v20.Value.R, (v21.Value.G - v20.Value.G) * v22 + v20.Value.G, (v21.Value.B - v20.Value.B) * v22 + v20.Value.B)
        end
    end
end
local function u25(p24) --[[ Line: 72 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u7
        [3] = u11
        [4] = u3
        [5] = u12
        [6] = u13
        [7] = u14
        [8] = u1
    --]]
    if u10 ~= u7.Character then
        u11 = u7.Character.Humanoid.Animator:LoadAnimation(u3.Animations.GunCombat.Shoot)
        u12 = u7.Character.Humanoid.Animator:LoadAnimation(u3.Animations.GunCombat.ShootLeft)
        u13 = u7.Character.Humanoid.Animator:LoadAnimation(u3.Animations.GunCombat.ShootRight)
        u14 = u7.Character.Humanoid.Animator:LoadAnimation(u3.Animations.GunCombat.AimShoot)
    end
    if _G.Aimed or (_G.MobleAimingIn or table.find(u1, p24.Parent.Name)) then
        u14:Play()
        return
    elseif p24:GetAttribute("DualWield") then
        u12:Play()
        u13:Play()
    else
        u11:Play()
    end
end
shared.playerShot = u25
local u44 = {
    ["getCanShoot"] = function(arg1)
        if not arg1 then return end
        local Humanoid = arg1:FindFirstChild("Humanoid")
        if not Humanoid or Humanoid.Health <= 0 or Humanoid:GetState() == Enum.HumanoidStateType.Dead then return end
        local BodyEffects = arg1:FindFirstChild("BodyEffects")
        if not BodyEffects then return end
        local class_Tool = arg1:FindFirstChildWhichIsA("Tool")
        if not class_Tool or not class_Tool:FindFirstChild("Handle") or not class_Tool:FindFirstChild("Ammo") then return end
        if game:GetService("RunService"):IsClient() then
            if BodyEffects:FindFirstChild("Block") then
                shared.playerShot(class_Tool.Handle)
                class_Tool.Handle.NoAmmo:Play()
                return
            end
            if class_Tool.Ammo.Value == 0 then
                class_Tool.Handle.NoAmmo:Play()
                return
            end
        end
        if workspace:GetAttribute("SERVER_AIM") then return end
        if arg1:FindFirstChild("FULLY_LOADED_CHAR") == nil then return end
        if arg1:FindFirstChild("FORCEFIELD") then return end
        if arg1:FindFirstChild("GRABBING_CONSTRAINT") then return end
        if arg1:FindFirstChild("Christmas_Sock") then return end
        if BodyEffects.Cuff.Value == true then return end
        if BodyEffects.Attacking.Value == true then return end
        if BodyEffects["K.O"].Value == true then return end
        if BodyEffects.Grabbed.Value then return end
        if BodyEffects.Reload.Value == true then return end
        if BodyEffects.Dead.Value == true then return end
        if class_Tool:GetAttribute("Cooldown") then return end
        return true
    end,
    ["getAim"] = function(p26, p27) --[[ Name: getAim, Line 99 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u5
            [3] = u8
        --]]
        local v28 = RaycastParams.new()
        local v29 = { u7.Character }
        local v30 = p27 or 200
        for _, v31 in workspace.Ignored:GetChildren() do
            table.insert(v29, v31)
        end
        v28.FilterDescendantsInstances = v29
        v28.FilterType = Enum.RaycastFilterType.Exclude
        v28.IgnoreWater = true
        local v32
        if _G.MobileShiftLock or _G.MobleAimingIn then
            local v33 = u5.CFrame.Position
            local v34 = u5.CFrame.LookVector * v30
            local v35 = workspace:Raycast(v33, v34, v28)
            if v35 then
                v32 = v35.Position
            else
                v32 = v33 + v34
            end
        else
            local v36 = u5:ScreenPointToRay(u8.X, u8.Y)
            local v37 = workspace:Raycast(v36.Origin, v36.Direction * v30, v28)
            if v37 then
                v32 = v37.Position
            else
                local v38 = u5.CFrame
                local v39 = v38.Position + v38.LookVector * v30
                local v40 = v38.LookVector
                local v41 = v36.Origin
                local v42 = v36.Direction
                v32 = v41 + v42 * ((v39 - v41):Dot(v40) / v42:Dot(v40))
            end
        end
        local v43 = v32 - p26
        return v43.Unit, v43.Magnitude
    end
}
local u45 = {}
function u44.shoot(p46) --[[ Line: 145 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u44
        [3] = u7
        [4] = u9
        [5] = u23
        [6] = u6
        [7] = u15
        [8] = u25
        [9] = u45
        [10] = u2
        [11] = u16
    --]]
    local u47 = p46.Shooter
    local u48 = p46.Handle
    local v49 = p46.AimPosition
    local u50 = p46.BeamColor
    local v51 = p46.isReflecting
    local u52 = p46.Hit
    local u53 = p46.Range or 200
    u48 = u48
    local u54
    if u48 then
        u54 = u48:GetAttribute("SkinName")
    end
    local u55 = p46.IsLeftHand
    local u56 = u4:GetPlayerFromCharacter(u47)
    if u56 then
        u56 = u56:GetAttribute("GunFX") == true
    end
    local _, v57 = u44.getAim(u48.Position, u53)
    if u47 ~= u7.Character then
        v57 = u53
    end
    local u58 = p46.ForcedOrigin or u48.Muzzle.WorldPosition
    local v59 = (v49 - u58).Unit
    local v60 = RaycastParams.new()
    local v62 = workspace.Ignored:GetChildren()
    local v61 = {u47, table.unpack(v62)}
    v60.FilterDescendantsInstances = v61
    v60.FilterType = Enum.RaycastFilterType.Exclude
    v60.IgnoreWater = true
    local u63, u64, u65
    if u52 then
        u63 = p46.Hit
        u64 = p46.AimPosition
        u65 = p46.Normal
    else
        local v66 = workspace:Raycast(u58, v59 * u53, v60)
        if v66 then
            u63 = v66.Instance
            u64 = v66.Position
            u65 = v66.Normal
        else
            u64 = u58 + v59 * math.min(v57, u53)
            u65 = nil
            u63 = nil
        end
    end
    if u63 then
        local _ = u63.Name == "Head"
    end
    local u67 = Instance.new("Part")
    u67:SetAttribute("OwnerCharacter", u47.Name)
    u67.Name = "BULLET_RAYS"
    u67.Anchored = true
    u67.CanCollide = false
    u67.Size = Vector3.new(0, 0, 0)
    u67.Transparency = 1
    game.Debris:AddItem(u67, 1)
    u67.CFrame = CFrame.new(u58, u64)
    u67.Material = Enum.Material.SmoothPlastic
    u67.Parent = workspace.Ignored.Siren.Radius
    local v68 = Instance.new("Attachment")
    v68.Position = Vector3.new(0, 0, 0)
    v68.Parent = u67
    local v69 = Instance.new("Attachment")
    local v70 = -(u64 - u58).magnitude
    v69.Position = Vector3.new(0, 0, v70)
    v69.Parent = u67
    local u71 = false
    local u72 = nil
    local v73
    if u48 then
        local v74 = u48.Parent
        if v74 then
            v74 = u48.Parent.Name
        end
        if v74 and not u56 and (u54 and u54 ~= "" or u9.GunSkinMuzzleParticle:FindFirstChild(v74)) then
            if u54 == "" then
                u54 = v74
            else
                u54 = u54 or v74
            end
            local v75 = u55 and "LeftMuzzle" or "Muzzle"
            if u9.GunSkinMuzzleParticle:FindFirstChild(u54) then
                if not v51 then
                    if u9.GunSkinMuzzleParticle[u54]:FindFirstChild(v75) or u55 then
                        local v76 = u48.Parent:FindFirstChild("Default") and u48.Parent.Default:FindFirstChild("Mesh") and u48.Parent.Default.Mesh:FindFirstChild(v75) or u48:FindFirstChild(v75)
                        local v77
                        if u55 then
                            local v78
                            if u48.Parent:FindFirstChild("Default") and u48.Parent.Default:FindFirstChild("Mesh") then
                                v78 = u48.Parent.Default.Mesh.DualWieldLeftHandMesh:FindFirstChild(v75) or v76
                            else
                                v78 = v76
                            end
                            v77 = v78 ~= v76
                            if v77 then
                                v76 = v78
                            end
                        else
                            v77 = false
                        end
                        if v76 then
                            local v79
                            if v77 then
                                v79 = v76
                            elseif u9.GunSkinMuzzleParticle[u54].Muzzle:FindFirstChild("Different_GunMuzzle") then
                                v79 = u9.GunSkinMuzzleParticle[u54][v75].Different_GunMuzzle[v74]
                            else
                                v79 = u9.GunSkinMuzzleParticle[u54][v75]
                            end
                            for _, v80 in v79:GetChildren() do
                                local v81 = v80:GetAttribute("EmitCount") or 1
                                local u82 = u55 and v80 and v80 or v80:Clone()
                                u82.Parent = v76
                                u82:Emit(v81)
                                if not v77 then
                                    task.delay(u82.Lifetime.Max, function() --[[ Line: 267 ]]
                                        --[[
                                        Upvalues:
                                            [1] = u82
                                        --]]
                                        u82:Destroy()
                                    end)
                                end
                            end
                        end
                    else
                        local v83 = u9.GunSkinMuzzleParticle[u54]:GetChildren()
                        local v84 = v83[math.random(#v83)]:Clone()
                        v84.Parent = v68
                        v84:Emit(v84.Rate)
                    end
                end
                u71 = true
            end
            if u9.GunBeam:FindFirstChild(u54) then
                local v85 = u9.GunBeam[u54]
                local v86 = u55 and "LeftGunBeam" or "GunBeam"
                local v87 = v85:FindFirstChild(v86) or v85.GunBeam
                local _ = u55 and (v87:IsA("BasePart") and v87:FindFirstChild("LeftHandBeam"))
                if v87:IsA("BasePart") then
                    v73 = {
                        ["Parent"] = nil,
                        ["Attachment0"] = nil,
                        ["Attachment1"] = nil
                    }
                    local v88 = v87:FindFirstChild("Different_GunBeam")
                    if v88 and v88:FindFirstChild(v74) then
                        local v89 = v88[v74][v86]
                        if v89 and v89:IsA("BasePart") then
                            u72 = v89:Clone()
                        elseif v89 then
                            v73 = v89:Clone() or v73
                        end
                    else
                        u72 = v87:Clone()
                    end
                else
                    v73 = v87:Clone()
                end
            else
                v73 = game.ReplicatedStorage.GunBeam:Clone()
                v73.Color = u50 and ColorSequence.new(u50) or v73.Color
            end
        else
            v73 = game.ReplicatedStorage.GunBeam:Clone()
            v73.Color = u50 and ColorSequence.new(u50) or v73.Color
        end
    else
        v73 = nil
    end
    task.spawn(function() --[[ Line: 325 ]]
        --[[
        Upvalues:
            [1] = u72
            [2] = u64
            [3] = u58
            [4] = u23
            [5] = u63
            [6] = u65
            [7] = u56
            [8] = u54
            [9] = u9
            [10] = u67
            [11] = u48
            [12] = u71
            [13] = u6
        --]]
        if u72 then
            local v90 = (u64 - u58).magnitude
            local v91 = v90 / 725
            u72.Anchored = true
            u72.CanCollide = false
            u72.CanQuery = false
            u72.CFrame = CFrame.new(u58, u64)
            local v92 = u72.CFrame * CFrame.new(0, 0, -v90)
            u72.Parent = workspace.Ignored.Siren.Radius
            task.delay(v91 + 5, function() --[[ Line: 341 ]]
                --[[
                Upvalues:
                    [1] = u72
                --]]
                u72:Destroy()
                u72 = nil
            end)
            if u72:GetAttribute("SpecialEffects") then
                for _, v93 in pairs(u72:GetDescendants()) do
                    if v93:IsA("Trail") and v93:GetAttribute("ColorRandom") then
                        local v94 = v93:GetAttribute("ColorRandom")
                        v93.Color = ColorSequence.new(u23(v94, math.random()))
                    end
                end
            end
            local v95 = game:GetService("TweenService"):Create(u72, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                ["CFrame"] = u72.CFrame * CFrame.new(0, 0, -0.1)
            })
            v95:Play()
            task.wait(0.05)
            if v95.PlaybackState ~= Enum.PlaybackState.Completed then
                v95:Pause()
            end
            local v96 = nil
            if _G.Reduce_Lag and not u72:GetAttribute("NoSlow") or u72:GetAttribute("LOWGFX") then
                u72.CFrame = v92
            else
                v96 = game:GetService("TweenService"):Create(u72, TweenInfo.new(v91, Enum.EasingStyle.Linear), {
                    ["CFrame"] = v92
                })
                v96:Play()
                task.wait(v91)
            end
            if u72:FindFirstChild("Impact") and (u63 and (u65 and not u63.Parent:FindFirstChild("Humanoid"))) then
                if v96 and v96.PlaybackState ~= Enum.PlaybackState.Completed then
                    task.wait(0.05)
                end
                if not u72:FindFirstChild("NoNormal") then
                    u72.CFrame = CFrame.new(u64, u64 - u65)
                end
                for _, v97 in pairs(u72.Impact:GetChildren()) do
                    if v97:IsA("ParticleEmitter") then
                        v97:Emit(v97:GetAttribute("EmitCount") or 1)
                    end
                end
            else
                for _, v98 in pairs(u72:GetChildren()) do
                    if v98:IsA("BasePart") then
                        v98.Transparency = 1
                    end
                end
            end
            if u72 then
                for _, v99 in pairs(u72:GetDescendants()) do
                    if v99:IsA("ParticleEmitter") then
                        v99.Enabled = false
                    end
                end
            end
        elseif u63 and (u63:IsDescendantOf(workspace.MAP) and (not u56 and (u54 and (u9.GunBeam:FindFirstChild(u54) and u9.GunBeam[u54]:FindFirstChild("Impact"))))) then
            local u100 = u9.GunBeam[u54].Impact:Clone()
            u100.Parent = workspace.Ignored
            u100:PivotTo(CFrame.new(u64, u64 + u65 * 5) * CFrame.Angles(-1.5707963267948966, 0, 0))
            for _, v101 in pairs(u100:GetDescendants()) do
                if v101:IsA("ParticleEmitter") then
                    v101:Emit(v101:GetAttribute("EmitCount") or 1)
                end
            end
            task.delay(1.5, function() --[[ Line: 410 ]]
                --[[
                Upvalues:
                    [1] = u100
                --]]
                u100:Destroy()
                u100 = nil
            end)
        end
        local v102 = Instance.new("PointLight")
        v102.Brightness = 0.5
        v102.Range = 15
        v102.Shadows = true
        v102.Color = Color3.new(1, 1, 1)
        v102.Parent = u67
        local v103 = u48:FindFirstChild("ShootBBGUI")
        local v104 = v103 and (not u71 and v103:FindFirstChild("Shoot"))
        if v104 then
            v104.Size = UDim2.new(0, 0, 0, 0)
            v104.ImageTransparency = 1
            v104.Visible = true
            u6:Create(v104, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                ["ImageTransparency"] = 0.4,
                ["Size"] = UDim2.new(1, 0, 1, 0)
            }):Play()
            u6:Create(v102, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                ["Range"] = 0
            }):Play()
            wait(0.4)
            u67:Destroy()
            u6:Create(v104, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.In, 0, false, 0), {
                ["ImageTransparency"] = 1,
                ["Size"] = UDim2.new(1, 0, 1, 0)
            }):Play()
            wait(0.2)
            v104.Visible = false
        end
    end)
    v73.Attachment0 = v68
    v73.Attachment1 = v69
    v73.Name = "NewGunBeam"
    v73.Parent = u67
    if u47 == u7.Character and workspace:GetServerTimeNow() - u15 > 0.95 then
        u25(u48)
    end
    if not u45[u48] then
        local v105 = u48.Parent.Name
        local v106 = u54 or "None"
        local v107 = u2[v106] ~= "All" and not (u2[v106] and u2[v106][v105]) and true or false
        task.spawn(u16.SoundPlay, u48, v107, u56)
        u45[u48] = true
        task.delay(0.021, function() --[[ Line: 463 ]]
            --[[
            Upvalues:
                [1] = u45
                [2] = u48
            --]]
            u45[u48] = nil
        end)
    end
    task.spawn(function() --[[ Line: 468 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u55
            [3] = u44
            [4] = u47
            [5] = u64
            [6] = u50
            [7] = u52
            [8] = u53
        --]]
        if u48:GetAttribute("DualWield") and not u55 then
            u44.shoot({
                ["IsLeftHand"] = true,
                ["Shooter"] = u47,
                ["Handle"] = u48,
                ["ForcedOrigin"] = u48.Parent.Default.Mesh.DualWieldLeftHandMesh.LeftMuzzle.WorldPosition,
                ["AimPosition"] = u64,
                ["BeamColor"] = u50,
                ["Hit"] = u52,
                ["Range"] = u53
            })
        end
    end)
    return u64, u63, u65
end
return u44
