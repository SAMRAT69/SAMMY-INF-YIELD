-- Sammy Hub - Infinite Yield with Cool UI
-- Version 1.0

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create main GUI
local SammyHub = Instance.new("ScreenGui")
SammyHub.Name = "SammyHub"
SammyHub.Parent = CoreGui
SammyHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Loading Screen
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.Position = UDim2.new(0, 0, 0, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = SammyHub

local LoadingBarBackground = Instance.new("Frame")
LoadingBarBackground.Name = "LoadingBarBackground"
LoadingBarBackground.Size = UDim2.new(0.4, 0, 0.02, 0)
LoadingBarBackground.Position = UDim2.new(0.3, 0, 0.5, 0)
LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
LoadingBarBackground.BorderSizePixel = 0
LoadingBarBackground.Parent = LoadingFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Name = "LoadingBar"
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.Position = UDim2.new(0, 0, 0, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
LoadingBar.BorderSizePixel = 0
LoadingBar.Parent = LoadingBarBackground

local LoadingText = Instance.new("TextLabel")
LoadingText.Name = "LoadingText"
LoadingText.Size = UDim2.new(0.4, 0, 0.1, 0)
LoadingText.Position = UDim2.new(0.3, 0, 0.45, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Sammy Hub - Loading..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextSize = 24
LoadingText.Font = Enum.Font.GothamBold
LoadingText.Parent = LoadingFrame

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0.2, 0, 0.2, 0)
Logo.Position = UDim2.new(0.4, 0, 0.3, 0)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://1234567890" -- Replace with your logo image ID
Logo.Parent = LoadingFrame

-- Animate loading bar
for i = 1, 100 do
    LoadingBar.Size = UDim2.new(i/100, 0, 1, 0)
    LoadingText.Text = "Sammy Hub - Loading... " .. i .. "%"
    wait(0.02)
end

wait(0.5)
LoadingFrame:Destroy()

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.35, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.325, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = SammyHub

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0.1, 0)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0.2, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SAMMY HUB"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 1, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

CloseButton.MouseButton1Click:Connect(function()
    SammyHub:Destroy()
end)

-- Tab System
local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Name = "TabButtonsFrame"
TabButtonsFrame.Size = UDim2.new(1, 0, 0.1, 0)
TabButtonsFrame.Position = UDim2.new(0, 0, 0.1, 0)
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.Parent = MainFrame

local HomeTabButton = Instance.new("TextButton")
HomeTabButton.Name = "HomeTabButton"
HomeTabButton.Size = UDim2.new(0.33, 0, 1, 0)
HomeTabButton.Position = UDim2.new(0, 0, 0, 0)
HomeTabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
HomeTabButton.Text = "Home"
HomeTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeTabButton.TextSize = 16
HomeTabButton.Font = Enum.Font.GothamBold
HomeTabButton.Parent = TabButtonsFrame

local CommandsTabButton = Instance.new("TextButton")
CommandsTabButton.Name = "CommandsTabButton"
CommandsTabButton.Size = UDim2.new(0.33, 0, 1, 0)
CommandsTabButton.Position = UDim2.new(0.33, 0, 0, 0)
CommandsTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CommandsTabButton.Text = "Commands"
CommandsTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandsTabButton.TextSize = 16
CommandsTabButton.Font = Enum.Font.GothamBold
CommandsTabButton.Parent = TabButtonsFrame

local SettingsTabButton = Instance.new("TextButton")
SettingsTabButton.Name = "SettingsTabButton"
SettingsTabButton.Size = UDim2.new(0.34, 0, 1, 0)
SettingsTabButton.Position = UDim2.new(0.66, 0, 0, 0)
SettingsTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SettingsTabButton.Text = "Settings"
SettingsTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTabButton.TextSize = 16
SettingsTabButton.Font = Enum.Font.GothamBold
SettingsTabButton.Parent = TabButtonsFrame

-- Tabs Container
local TabsContainer = Instance.new("Frame")
TabsContainer.Name = "TabsContainer"
TabsContainer.Size = UDim2.new(1, 0, 0.8, 0)
TabsContainer.Position = UDim2.new(0, 0, 0.2, 0)
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = MainFrame

-- Home Tab
local HomeTab = Instance.new("Frame")
HomeTab.Name = "HomeTab"
HomeTab.Size = UDim2.new(1, 0, 1, 0)
HomeTab.Position = UDim2.new(0, 0, 0, 0)
HomeTab.BackgroundTransparency = 1
HomeTab.Visible = true
HomeTab.Parent = TabsContainer

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Name = "WelcomeLabel"
WelcomeLabel.Size = UDim2.new(1, 0, 0.2, 0)
WelcomeLabel.Position = UDim2.new(0, 0, 0, 0)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "Welcome to Sammy Hub!"
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.TextSize = 24
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.Parent = HomeTab

local DescriptionLabel = Instance.new("TextLabel")
DescriptionLabel.Name = "DescriptionLabel"
DescriptionLabel.Size = UDim2.new(0.9, 0, 0.4, 0)
DescriptionLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
DescriptionLabel.BackgroundTransparency = 1
DescriptionLabel.Text = "The best Infinite Yield script with a cool UI!\n\nFeatures:\n- All Infinite Yield commands\n- Custom UI\n- Smooth animations\n- Easy to use"
DescriptionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DescriptionLabel.TextSize = 16
DescriptionLabel.TextWrapped = true
DescriptionLabel.Font = Enum.Font.Gotham
DescriptionLabel.Parent = HomeTab

-- Commands Tab
local CommandsTab = Instance.new("Frame")
CommandsTab.Name = "CommandsTab"
CommandsTab.Size = UDim2.new(1, 0, 1, 0)
CommandsTab.Position = UDim2.new(0, 0, 0, 0)
CommandsTab.BackgroundTransparency = 1
CommandsTab.Visible = false
CommandsTab.Parent = TabsContainer

local CommandsList = Instance.new("ScrollingFrame")
CommandsList.Name = "CommandsList"
CommandsList.Size = UDim2.new(1, 0, 1, 0)
CommandsList.Position = UDim2.new(0, 0, 0, 0)
CommandsList.BackgroundTransparency = 1
CommandsList.ScrollBarThickness = 5
CommandsList.CanvasSize = UDim2.new(0, 0, 3, 0)
CommandsList.Parent = CommandsTab

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = CommandsList
UIListLayout.Padding = UDim.new(0, 5)

-- Infinite Yield Commands
local commands = {
    {name = "Fly", desc = "Makes you fly", cmd = "fly"},
    {name = "Noclip", desc = "Walk through walls", cmd = "noclip"},
    {name = "Godmode", desc = "Makes you invincible", cmd = "god"},
    {name = "Speed", desc = "Change your walkspeed", cmd = "speed [number]"},
    {name = "Jump", desc = "Change your jump power", cmd = "jump [number]"},
    {name = "Teleport to Player", desc = "Teleport to another player", cmd = "tp [player]"},
    {name = "Invisible", desc = "Makes you invisible", cmd = "invis"},
    {name = "Server Hop", desc = "Join a different server", cmd = "serverhop"},
    {name = "Rejoin", desc = "Rejoin the same server", cmd = "rejoin"},
    {name = "Kill Player", desc = "Kill another player", cmd = "kill [player]"},
    {name = "Kick Player", desc = "Kick another player", cmd = "kick [player]"},
    {name = "Freeze Player", desc = "Freeze another player", cmd = "freeze [player]"},
    {name = "Thaw Player", desc = "Unfreeze another player", cmd = "thaw [player]"},
    {name = "Bring Player", desc = "Bring player to you", cmd = "bring [player]"},
    {name = "ESP", desc = "See players through walls", cmd = "esp [player]"},
    {name = "Unesp", desc = "Remove ESP", cmd = "unesp [player]"},
    {name = "Admin", desc = "Get admin commands", cmd = "admin [player]"},
    {name = "Tools", desc = "Gives you all tools", cmd = "tools"},
    {name = "Refresh", desc = "Refresh character", cmd = "refresh"},
    {name = "Reset", desc = "Reset character", cmd = "reset"},
    {name = "Gravitate", desc = "Change gravity", cmd = "grav [number]"},
    {name = "Time", desc = "Change game time", cmd = "time [number]"},
    {name = "FPS Cap", desc = "Change FPS cap", cmd = "fpscap [number]"},
    {name = "Chat Spoofer", desc = "Spoof chat messages", cmd = "chat [message]"},
    {name = "Annoy Player", desc = "Annoy another player", cmd = "annoy [player]"},
    {name = "Unannoy", desc = "Stop annoying player", cmd = "unannoy"},
    {name = "Loop Teleport", desc = "Loop teleport to player", cmd = "looptp [player]"},
    {name = "Unloop Teleport", desc = "Stop loop teleport", cmd = "unlooptp"},
    {name = "Lag Server", desc = "Lag the server", cmd = "lag"},
    {name = "Unlag Server", desc = "Stop lagging the server", cmd = "unlag"},
    {name = "Btools", desc = "Gives you building tools", cmd = "btools"},
    {name = "Click Teleport", desc = "Teleport where you click", cmd = "clicktp"},
    {name = "Unclick Teleport", desc = "Disable click teleport", cmd = "unclicktp"},
    {name = "View Player", desc = "View another player", cmd = "view [player]"},
    {name = "Unview", desc = "Stop viewing player", cmd = "unview"},
    {name = "Clear Effects", desc = "Remove all effects", cmd = "cleareffects"},
    {name = "Clear Decals", desc = "Remove all decals", cmd = "cleardecals"},
    {name = "Clear Guis", desc = "Remove all guis", cmd = "clearguis"},
    {name = "Clear All", desc = "Remove everything", cmd = "clearall"},
    {name = "Help", desc = "Show all commands", cmd = "help"}
}

for i, command in ipairs(commands) do
    local CommandFrame = Instance.new("Frame")
    CommandFrame.Name = "CommandFrame"
    CommandFrame.Size = UDim2.new(0.95, 0, 0, 70)
    CommandFrame.Position = UDim2.new(0.025, 0, 0, 0)
    CommandFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    CommandFrame.Parent = CommandsList
    
    local CommandCorner = Instance.new("UICorner")
    CommandCorner.CornerRadius = UDim.new(0, 5)
    CommandCorner.Parent = CommandFrame
    
    local CommandName = Instance.new("TextLabel")
    CommandName.Name = "CommandName"
    CommandName.Size = UDim2.new(0.7, 0, 0.4, 0)
    CommandName.Position = UDim2.new(0.05, 0, 0.1, 0)
    CommandName.BackgroundTransparency = 1
    CommandName.Text = command.name
    CommandName.TextColor3 = Color3.fromRGB(0, 170, 255)
    CommandName.TextSize = 18
    CommandName.TextXAlignment = Enum.TextXAlignment.Left
    CommandName.Font = Enum.Font.GothamBold
    CommandName.Parent = CommandFrame
    
    local CommandDesc = Instance.new("TextLabel")
    CommandDesc.Name = "CommandDesc"
    CommandDesc.Size = UDim2.new(0.7, 0, 0.3, 0)
    CommandDesc.Position = UDim2.new(0.05, 0, 0.5, 0)
    CommandDesc.BackgroundTransparency = 1
    CommandDesc.Text = command.desc
    CommandDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
    CommandDesc.TextSize = 14
    CommandDesc.TextXAlignment = Enum.TextXAlignment.Left
    CommandDesc.Font = Enum.Font.Gotham
    CommandDesc.Parent = CommandFrame
    
    local ExecuteButton = Instance.new("TextButton")
    ExecuteButton.Name = "ExecuteButton"
    ExecuteButton.Size = UDim2.new(0.2, 0, 0.6, 0)
    ExecuteButton.Position = UDim2.new(0.75, 0, 0.2, 0)
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ExecuteButton.Text = "Execute"
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.TextSize = 14
    ExecuteButton.Font = Enum.Font.GothamBold
    ExecuteButton.Parent = CommandFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 5)
    ButtonCorner.Parent = ExecuteButton
    
    ExecuteButton.MouseButton1Click:Connect(function()
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/" .. command.cmd, "All")
    end)
end

-- Settings Tab
local SettingsTab = Instance.new("Frame")
SettingsTab.Name = "SettingsTab"
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.Position = UDim2.new(0, 0, 0, 0)
SettingsTab.BackgroundTransparency = 1
SettingsTab.Visible = false
SettingsTab.Parent = TabsContainer

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Name = "SettingsTitle"
SettingsTitle.Size = UDim2.new(1, 0, 0.1, 0)
SettingsTitle.Position = UDim2.new(0, 0, 0, 0)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.TextSize = 24
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Parent = SettingsTab

local ThemeLabel = Instance.new("TextLabel")
ThemeLabel.Name = "ThemeLabel"
ThemeLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
ThemeLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Text = "Theme Color"
ThemeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeLabel.TextSize = 18
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
ThemeLabel.Font = Enum.Font.GothamBold
ThemeLabel.Parent = SettingsTab

local ThemeColor = Instance.new("TextBox")
ThemeColor.Name = "ThemeColor"
ThemeColor.Size = UDim2.new(0.3, 0, 0.08, 0)
ThemeColor.Position = UDim2.new(0.6, 0, 0.16, 0)
ThemeColor.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ThemeColor.Text = "0, 170, 255"
ThemeColor.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeColor.TextSize = 14
ThemeColor.Font = Enum.Font.Gotham
ThemeColor.Parent = SettingsTab

local ApplyButton = Instance.new("TextButton")
ApplyButton.Name = "ApplyButton"
ApplyButton.Size = UDim2.new(0.3, 0, 0.08, 0)
ApplyButton.Position = UDim2.new(0.35, 0, 0.3, 0)
ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ApplyButton.Text = "Apply Theme"
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.TextSize = 16
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.Parent = SettingsTab

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 5)
ButtonCorner.Parent = ApplyButton

ApplyButton.MouseButton1Click:Connect(function()
    local r, g, b = ThemeColor.Text:match("(%d+),%s*(%d+),%s*(%d+)")
    if r and g and b then
        local color = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
        for _, obj in pairs(MainFrame:GetDescendants()) do
            if obj:IsA("TextButton") and obj.BackgroundColor3 == Color3.fromRGB(0, 170, 255) then
                obj.BackgroundColor3 = color
            elseif obj:IsA("TextLabel") and obj.TextColor3 == Color3.fromRGB(0, 170, 255) then
                obj.TextColor3 = color
            end
        end
    end
end)

-- Tab Switching
HomeTabButton.MouseButton1Click:Connect(function()
    HomeTab.Visible = true
    CommandsTab.Visible = false
    SettingsTab.Visible = false
    HomeTabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    CommandsTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SettingsTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
end)

CommandsTabButton.MouseButton1Click:Connect(function()
    HomeTab.Visible = false
    CommandsTab.Visible = true
    SettingsTab.Visible = false
    HomeTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    CommandsTabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    SettingsTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
end)

SettingsTabButton.MouseButton1Click:Connect(function()
    HomeTab.Visible = false
    CommandsTab.Visible = false
    SettingsTab.Visible = true
    HomeTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    CommandsTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SettingsTabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)

-- Draggable window
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Keybind to toggle UI
local UIVisible = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightControl then
        UIVisible = not UIVisible
        MainFrame.Visible = UIVisible
    end
end)

-- Notification function
