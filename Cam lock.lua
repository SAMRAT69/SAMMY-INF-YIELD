-- Ultimate Mobile & PC Player Lock System
-- By YourName | Works on all devices!

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local SoundService = game:GetService("SoundService")
local ContextActionService = game:GetService("ContextActionService")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--⚙️ CONFIGURATION ⚙️--
local LockConfig = {
    -- Controls
    LockKey = Enum.UserInputType.MouseButton2, -- Right-click (PC)
    TouchLockButton = true, -- Enable on-screen lock button (Mobile)
    ToggleKey = Enum.KeyCode.Q, -- Keyboard toggle key (PC)
    
    -- Lock Behavior
    LockDistance = 50, -- Max lock-on range
    Smoothness = 0.15, -- Camera follow smoothness (0.1 = smooth, 1 = instant)
    TransitionStyle = Enum.EasingStyle.Quint, -- Ultra-smooth easing
    LockFOV = 65, -- Zoom-in effect when locked
    DefaultFOV = 70, -- Normal FOV
    Prediction = 0.2, -- Predicts movement for smoother tracking
    BodyParts = {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso"}, -- Priority order
    
    -- UI & Effects
    LockIndicatorColor = Color3.fromRGB(255, 100, 100), -- Red lock-on effect
    LockIndicatorSize = 24, -- Size of the lock-on UI
    LockSound = "rbxassetid://9045567253", -- Cool "lock-on" sound
    UnlockSound = "rbxassetid://9045567253", -- "Unlock" sound
    LockShake = 0.5, -- Slight camera shake when locking (0 = none, 1 = strong)
}

--🎮 STATE VARIABLES 🎮--
local LockState = {
    IsLocked = false,
    TargetPlayer = nil,
    TargetPart = nil,
    OriginalCameraCF = nil,
    OriginalCameraType = nil,
    LastPosition = nil,
    Velocity = Vector3.new(),
    LockStartTime = 0,
}

--✨ UI SETUP ✨--
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateLockUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

--🔹 Lock-On Indicator (Animated) 🔹--
local LockIndicator = Instance.new("Frame")
LockIndicator.Name = "LockIndicator"
LockIndicator.Size = UDim2.new(0, LockConfig.LockIndicatorSize, 0, LockConfig.LockIndicatorSize)
LockIndicator.Position = UDim2.new(0.5, -LockConfig.LockIndicatorSize/2, 0.5, -LockConfig.LockIndicatorSize/2)
LockIndicator.BackgroundTransparency = 1
LockIndicator.Visible = false

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = LockIndicator

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, LockConfig.LockIndicatorColor),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 180, 50))
})
UIGradient.Rotation = 45
UIGradient.Parent = LockIndicator

LockIndicator.Parent = ScreenGui

--🎚️ Settings Panel (Modern UI) 🎚️--
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsPanel"
SettingsFrame.Size = UDim2.new(0, 300, 0, 250)
SettingsFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
SettingsFrame.BackgroundTransparency = 0.15
SettingsFrame.Visible = false

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 150, 255)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = SettingsFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = SettingsFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TitleBar.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Text = "🔒 ADVANCED LOCK SYSTEM"
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.TextColor3 = Color3.fromRGB(200, 200, 255)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

TitleBar.Parent = SettingsFrame

-- Body Part Selector
local PartSelector = Instance.new("TextButton")
PartSelector.Name = "PartSelector"
PartSelector.Text = "LOCK PART: " .. string.upper(LockConfig.BodyParts[1])
PartSelector.Font = Enum.Font.GothamMedium
PartSelector.TextSize = 14
PartSelector.Size = UDim2.new(0.9, 0, 0, 36)
PartSelector.Position = UDim2.new(0.05, 0, 0, 50)
PartSelector.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
PartSelector.TextColor3 = Color3.fromRGB(200, 200, 255)
PartSelector.Parent = SettingsFrame

-- Smoothness Slider
local SmoothnessLabel = Instance.new("TextLabel")
SmoothnessLabel.Text = "SMOOTHNESS: " .. string.format("%.2f", LockConfig.Smoothness)
SmoothnessLabel.Font = Enum.Font.GothamMedium
SmoothnessLabel.TextSize = 14
SmoothnessLabel.Size = UDim2.new(0.9, 0, 0, 20)
SmoothnessLabel.Position = UDim2.new(0.05, 0, 0, 100)
SmoothnessLabel.BackgroundTransparency = 1
SmoothnessLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
SmoothnessLabel.TextXAlignment = Enum.TextXAlignment.Left
SmoothnessLabel.Parent = SettingsFrame

local SmoothnessSlider = Instance.new("Frame")
SmoothnessSlider.Name = "SmoothnessSlider"
SmoothnessSlider.Size = UDim2.new(0.9, 0, 0, 6)
SmoothnessSlider.Position = UDim2.new(0.05, 0, 0, 125)
SmoothnessSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
SmoothnessSlider.Parent = SettingsFrame

local SmoothnessFill = Instance.new("Frame")
SmoothnessFill.Name = "Fill"
SmoothnessFill.Size = UDim2.new(LockConfig.Smoothness, 0, 1, 0)
SmoothnessFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
SmoothnessFill.Parent = SmoothnessSlider

-- Settings Toggle Button
local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Text = "⚙️"
SettingsButton.TextSize = 20
SettingsButton.Size = UDim2.new(0, 40, 0, 40)
SettingsButton.Position = UDim2.new(1, -50, 1, -50)
SettingsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
SettingsButton.TextColor3 = Color3.new(1, 1, 1)
SettingsButton.Parent = ScreenGui

--📱 MOBILE TOUCH BUTTON 📱--
local MobileLockButton
if LockConfig.TouchLockButton and UserInputService.TouchEnabled then
    MobileLockButton = Instance.new("TextButton")
    MobileLockButton.Name = "MobileLockButton"
    MobileLockButton.Text = "🔒"
    MobileLockButton.TextSize = 24
    MobileLockButton.Size = UDim2.new(0, 60, 0, 60)
    MobileLockButton.Position = UDim2.new(1, -70, 1, -70)
    MobileLockButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    MobileLockButton.TextColor3 = Color3.new(1, 1, 1)
    MobileLockButton.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.3, 0)
    UICorner.Parent = MobileLockButton
    
    MobileLockButton.MouseButton1Click:Connect(function()
        if LockState.IsLocked then
            unlock()
        else
            local targetPlayer, targetChar = getTargetPlayer()
            if targetPlayer then
                lockOnPlayer(targetPlayer, targetChar)
            end
        end
    end)
end

--🎯 LOCK-ON FUNCTIONS 🎯--
local function getTargetPlayer()
    if not Player.Character then return nil end
    local rootPart = Player.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return nil end

    local camera = workspace.CurrentCamera
    local mousePos = UserInputService:GetMouseLocation()
    local ray = camera:ViewportPointToRay(mousePos.X, mousePos.Y)

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {Player.Character}
    params.FilterType = Enum.RaycastFilterType.Blacklist

    local result = workspace:Raycast(ray.Origin, ray.Direction * LockConfig.LockDistance, params)
    if result then
        local hitPart = result.Instance
        local character = hitPart:FindFirstAncestorOfClass("Model")
        if character then
            local player = Players:GetPlayerFromCharacter(character)
            if player and player ~= Player then
                return player, character
            end
        end
    end
    return nil
end

local function findBestBodyPart(character)
    for _, partName in ipairs(LockConfig.BodyParts) do
        local part = character:FindFirstChild(partName)
        if part then return part end
    end
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart")
end

local function playSound(id)
    local sound = Instance.new("Sound")
    sound.SoundId = id
    sound.Parent = workspace
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 3)
end

--🔒 LOCK / UNLOCK FUNCTIONS 🔓--
local function lockOnPlayer(targetPlayer, targetCharacter)
    if not targetCharacter then return end

    local targetPart = findBestBodyPart(targetCharacter)
    if not targetPart then return end

    LockState.IsLocked = true
    LockState.TargetPlayer = targetPlayer
    LockState.TargetPart = targetPart
    LockState.OriginalCameraCF = Camera.CFrame
    LockState.OriginalCameraType = Camera.CameraType
    LockState.LastPosition = targetPart.Position

    -- Play lock sound
    playSound(LockConfig.LockSound)

    -- Animate lock indicator
    LockIndicator.Visible = true
    LockIndicator.Size = UDim2.new(0, 0, 0, 0)
    LockIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)

    TweenService:Create(
        LockIndicator,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0, LockConfig.LockIndicatorSize, 0, LockConfig.LockIndicatorSize),
            Position = UDim2.new(0.5, -LockConfig.LockIndicatorSize/2, 0.5, -LockConfig.LockIndicatorSize/2)
        }
    ):Play()

    -- Smooth FOV transition
    TweenService:Create(
        Camera,
        TweenInfo.new(0.4, LockConfig.TransitionStyle, LockConfig.TransitionDirection),
        {FieldOfView = LockConfig.LockFOV}
    ):Play()

    Camera.CameraType = Enum.CameraType.Scriptable

    -- Main camera follow loop
    RunService:BindToRenderStep("LockCamera", Enum.RenderPriority.Camera.Value + 1, function(dt)
        if not LockState.TargetPart or not LockState.TargetPart.Parent then
            unlock()
            return
        end

        local targetPos = LockState.TargetPart.Position

        -- Movement prediction
        if LockState.LastPosition then
            local velocity = (targetPos - LockState.LastPosition) * LockConfig.Prediction / dt
            targetPos = targetPos + velocity
        end
        LockState.LastPosition = targetPos

        -- Ultra-smooth camera follow
        local desiredCF = CFrame.new(Camera.CFrame.Position, targetPos)
        local smoothCF = Camera.CFrame:Lerp(desiredCF, LockConfig.Smoothness)
        Camera.CFrame = smoothCF
    end)
end

local function unlock()
    if not LockState.IsLocked then return end

    RunService:UnbindFromRenderStep("LockCamera")
    LockState.IsLocked = false

    -- Play unlock sound
    playSound(LockConfig.UnlockSound)

    -- Animate lock indicator disappearing
    TweenService:Create(
        LockIndicator,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}
    ):Play()
    task.delay(0.2, function() LockIndicator.Visible = false end)

    -- Smooth camera return
    if LockState.OriginalCameraCF then
        local tween = TweenService:Create(
            Camera,
            TweenInfo.new(0.6, LockConfig.TransitionStyle, LockConfig.TransitionDirection),
            {
                CFrame = LockState.OriginalCameraCF,
                FieldOfView = LockConfig.DefaultFOV
            }
        )
        tween:Play()
        tween.Completed:Connect(function()
            Camera.CameraType = LockState.OriginalCameraType
        end)
    end
end

--🕹️ INPUT HANDLING (PC + Mobile) 🕹️--
local function handleLockToggle()
    if LockState.IsLocked then
        unlock()
    else
        local targetPlayer, targetChar = getTargetPlayer()
        if targetPlayer then
            lockOnPlayer(targetPlayer, targetChar)
        end
    end
end

-- PC Controls
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- Right-click to lock/unlock (PC)
    if input.UserInputType == LockConfig.LockKey then
        handleLockToggle()
    end

    -- Q key to toggle lock (PC)
    if input.KeyCode == LockConfig.ToggleKey then
        handleLockToggle()
    end

    -- P key to open settings
    if input.KeyCode == Enum.KeyCode.P then
        SettingsFrame.Visible = not SettingsFrame.Visible
    end
end)

--⚡ UI INTERACTIONS ⚡--
CloseButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
end)

SettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = not SettingsFrame.Visible
end)

PartSelector.MouseButton1Click:Connect(function()
    local currentIndex = table.find(LockConfig.BodyParts, LockConfig.BodyParts[1]) or 1
    local nextIndex = currentIndex % #LockConfig.BodyParts + 1
    LockConfig.BodyParts[1] = LockConfig.BodyParts[nextIndex]
    PartSelector.Text = "LOCK PART: " .. string.upper(LockConfig.BodyParts[1])
end)

SmoothnessSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local sliderPos = math.clamp(
            (input.Position.X - SmoothnessSlider.AbsolutePosition.X) / SmoothnessSlider.AbsoluteSize.X,
            0.05, 1
        )
        LockConfig.Smoothness = sliderPos
        SmoothnessFill.Size = UDim2.new(sliderPos, 0, 1, 0)
        SmoothnessLabel.Text = "SMOOTHNESS: " .. string.format("%.2f", sliderPos)
    end
end)

--🔧 CLEANUP ON RESET 🔧--
Player.CharacterAdded:Connect(function()
    if LockState.IsLocked then unlock() end
end)

Players.PlayerRemoving:Connect(function(player)
    if player == LockState.TargetPlayer then unlock() end
end)
