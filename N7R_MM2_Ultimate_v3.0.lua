--[[
═══════════════════════════════════════════════════════════════
    N7R | Murder Mystery 2 - ULTIMATE EDITION v3.0
    🔥 تجميع عملات | قتل تلقائي | إطلاق تلقائي | حماية كاملة
    📌 Auto Farm | Auto Win | Kill Aura | Coin Collector
    ⚡ Anti-Lag | Server Hop | Rejoin | Rainbow Theme
═══════════════════════════════════════════════════════════════
]]

-- ===== SERVICES =====
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local pg = LocalPlayer:WaitForChild("PlayerGui")
local Mouse = LocalPlayer:GetMouse()

-- ===== ANTI-KICK / ANTI-AFK PROTECTION =====
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Method = getnamecallmethod()
    local Args = {...}
    if Method == "Kick" and self == LocalPlayer then
        warn("[N7R] Kick blocked!")
        return nil
    end
    return OldNamecall(self, ...)
end)

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ===== SETTINGS =====
local ESP_ENABLED = false
local TRACER_ENABLED = false
local CHAMS_ENABLED = false
local NAME_ESP_ENABLED = false
local DISTANCE_ESP_ENABLED = false
local HEALTH_ESP_ENABLED = false
local Tracers = {}
local Chams = {}

local ROLE_COLORS = {
    KILLER = Color3.fromRGB(255, 0, 0),
    SHERIFF = Color3.fromRGB(0, 170, 255),
    INNOCENT = Color3.fromRGB(0, 255, 0),
}

local ROLE_NAMES_ESP = false

local AIMBOT_ENABLED = false
local AUTO_SHOOT_ENABLED = false
local WALL_CHECK_ENABLED = true
local AIM_SMOOTHNESS = 0.15
local AIM_FOV = 150
local AIM_TARGET_PART = "Head"
local FOV_CIRCLE_ENABLED = true
local KNIFE_REACH_ENABLED = false
local GUN_MOD_ENABLED = false

local FLY_ENABLED = false
local FLY_SPEED = 50
local INFINITE_JUMP_ENABLED = false
local NO_CLIP_ENABLED = false
local ORIGINAL_WALKSPEED = 16
local ORIGINAL_JUMPPOWER = 50

-- ===== NEW: ADVANCED FEATURES =====
local AUTO_COLLECT_COINS = false
local AUTO_GRAB_GUN = false
local KILL_AURA_ENABLED = false
local KILL_AURA_RANGE = 20
local AUTO_SHOOT_MURDERER = false
local AUTO_EQUIP_GUN = false
local AUTO_EQUIP_KNIFE = false
local ANTI_LAG_ENABLED = false
local CUSTOM_CROSSHAIR = false
local RAINBOW_THEME_ENABLED = false
local SERVER_HOP_ENABLED = false

local WINDOW_SCALE = 1

local WorldSettings = {
    FullBright = false,
    NoFog = false,
    NoShadows = false,
    AntiAFK = false,
    CustomTime = false,
    TimeValue = 12,
    LowGraphics = false,
    InfiniteZoom = false,
    Noclip = false,
    CustomGravity = false,
    GravityValue = 196.2,
    OriginalBrightness = Lighting.Brightness,
    OriginalFogStart = Lighting.FogStart,
    OriginalFogEnd = Lighting.FogEnd,
    OriginalGlobalShadows = Lighting.GlobalShadows,
    OriginalTime = Lighting.ClockTime,
    OriginalGravity = workspace.Gravity,
}

-- ===== RAINBOW / CHAMELEON THEME SYSTEM =====
local function getRainbowColor(t)
    return Color3.fromHSV((t % 5) / 5, 1, 1)
end

local function getRainbowTheme(t)
    local hue = (t % 5) / 5
    local primary = Color3.fromHSV(hue, 1, 1)
    local secondary = Color3.fromHSV((hue + 0.1) % 1, 0.8, 1)
    local accent = Color3.fromHSV((hue + 0.2) % 1, 1, 0.9)
    local accent2 = Color3.fromHSV((hue + 0.3) % 1, 0.9, 0.8)
    local dark = Color3.fromHSV(hue, 0.6, 0.2)
    local darker = Color3.fromRGB(18, 18, 26)
    return {
        Primary = primary,
        Secondary = secondary,
        Accent = accent,
        Accent2 = accent2,
        Dark = dark,
        Darker = darker,
        Stroke = Color3.fromHSV(hue, 0.5, 0.4),
        Stroke2 = Color3.fromHSV(hue, 0.4, 0.3),
        Stroke3 = Color3.fromHSV(hue, 0.6, 0.5),
        Gradient1 = Color3.fromHSV(hue, 0.3, 0.15),
        Gradient2 = Color3.fromRGB(8, 8, 14),
        CardGrad1 = Color3.fromHSV(hue, 0.2, 0.1),
        CardGrad2 = Color3.fromRGB(10, 10, 16),
        Glow = Color3.fromHSV(hue, 0.3, 1),
    }
end

-- ===== THEME SYSTEM =====
local Themes = {
    Purple = {
        Primary = Color3.fromRGB(255, 125, 255),
        Secondary = Color3.fromRGB(255, 160, 255),
        Accent = Color3.fromRGB(255, 60, 210),
        Accent2 = Color3.fromRGB(160, 60, 255),
        Dark = Color3.fromRGB(42, 14, 60),
        Darker = Color3.fromRGB(18, 18, 26),
        Stroke = Color3.fromRGB(90, 35, 120),
        Stroke2 = Color3.fromRGB(80, 25, 105),
        Stroke3 = Color3.fromRGB(105, 40, 140),
        Gradient1 = Color3.fromRGB(28, 10, 40),
        Gradient2 = Color3.fromRGB(8, 8, 14),
        CardGrad1 = Color3.fromRGB(18, 10, 28),
        CardGrad2 = Color3.fromRGB(10, 10, 16),
        Glow = Color3.fromRGB(255, 220, 255),
    },
    Green = {
        Primary = Color3.fromRGB(0, 255, 128),
        Secondary = Color3.fromRGB(0, 230, 118),
        Accent = Color3.fromRGB(0, 200, 83),
        Accent2 = Color3.fromRGB(0, 150, 60),
        Dark = Color3.fromRGB(14, 60, 30),
        Darker = Color3.fromRGB(18, 26, 20),
        Stroke = Color3.fromRGB(35, 120, 70),
        Stroke2 = Color3.fromRGB(25, 105, 60),
        Stroke3 = Color3.fromRGB(40, 140, 80),
        Gradient1 = Color3.fromRGB(10, 40, 20),
        Gradient2 = Color3.fromRGB(8, 14, 10),
        CardGrad1 = Color3.fromRGB(10, 28, 16),
        CardGrad2 = Color3.fromRGB(10, 16, 12),
        Glow = Color3.fromRGB(180, 255, 200),
    },
    Blue = {
        Primary = Color3.fromRGB(0, 176, 255),
        Secondary = Color3.fromRGB(0, 200, 255),
        Accent = Color3.fromRGB(0, 150, 255),
        Accent2 = Color3.fromRGB(0, 100, 200),
        Dark = Color3.fromRGB(14, 30, 60),
        Darker = Color3.fromRGB(18, 22, 30),
        Stroke = Color3.fromRGB(35, 70, 120),
        Stroke2 = Color3.fromRGB(25, 60, 105),
        Stroke3 = Color3.fromRGB(40, 80, 140),
        Gradient1 = Color3.fromRGB(10, 20, 40),
        Gradient2 = Color3.fromRGB(8, 10, 14),
        CardGrad1 = Color3.fromRGB(10, 16, 28),
        CardGrad2 = Color3.fromRGB(10, 12, 16),
        Glow = Color3.fromRGB(180, 220, 255),
    },
    Red = {
        Primary = Color3.fromRGB(255, 80, 80),
        Secondary = Color3.fromRGB(255, 100, 100),
        Accent = Color3.fromRGB(255, 50, 50),
        Accent2 = Color3.fromRGB(200, 30, 30),
        Dark = Color3.fromRGB(60, 14, 14),
        Darker = Color3.fromRGB(26, 18, 18),
        Stroke = Color3.fromRGB(120, 35, 35),
        Stroke2 = Color3.fromRGB(105, 25, 25),
        Stroke3 = Color3.fromRGB(140, 40, 40),
        Gradient1 = Color3.fromRGB(40, 10, 10),
        Gradient2 = Color3.fromRGB(14, 8, 8),
        CardGrad1 = Color3.fromRGB(28, 10, 10),
        CardGrad2 = Color3.fromRGB(16, 10, 10),
        Glow = Color3.fromRGB(255, 180, 180),
    },
    Orange = {
        Primary = Color3.fromRGB(255, 165, 0),
        Secondary = Color3.fromRGB(255, 180, 50),
        Accent = Color3.fromRGB(255, 140, 0),
        Accent2 = Color3.fromRGB(200, 110, 0),
        Dark = Color3.fromRGB(60, 40, 14),
        Darker = Color3.fromRGB(26, 22, 18),
        Stroke = Color3.fromRGB(120, 80, 35),
        Stroke2 = Color3.fromRGB(105, 70, 25),
        Stroke3 = Color3.fromRGB(140, 90, 40),
        Gradient1 = Color3.fromRGB(40, 25, 10),
        Gradient2 = Color3.fromRGB(14, 10, 8),
        CardGrad1 = Color3.fromRGB(28, 18, 10),
        CardGrad2 = Color3.fromRGB(16, 12, 10),
        Glow = Color3.fromRGB(255, 220, 180),
    },
    Pink = {
        Primary = Color3.fromRGB(255, 105, 180),
        Secondary = Color3.fromRGB(255, 130, 200),
        Accent = Color3.fromRGB(255, 80, 160),
        Accent2 = Color3.fromRGB(200, 50, 130),
        Dark = Color3.fromRGB(60, 20, 45),
        Darker = Color3.fromRGB(26, 18, 22),
        Stroke = Color3.fromRGB(120, 40, 90),
        Stroke2 = Color3.fromRGB(105, 30, 80),
        Stroke3 = Color3.fromRGB(140, 50, 110),
        Gradient1 = Color3.fromRGB(40, 15, 30),
        Gradient2 = Color3.fromRGB(14, 10, 12),
        CardGrad1 = Color3.fromRGB(28, 12, 22),
        CardGrad2 = Color3.fromRGB(16, 10, 14),
        Glow = Color3.fromRGB(255, 200, 230),
    },
    Rainbow = nil, -- Dynamic
}

local CurrentTheme = "Purple"
local ThemeElements = {}

-- ===== HELPERS =====
local function round(n) return math.floor(n + 0.5) end

local function makeCorner(inst, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 14)
    c.Parent = inst
    return c
end

local function makeStroke(inst, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Themes[CurrentTheme].Stroke2
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.35
    s.Parent = inst
    table.insert(ThemeElements, {Type = "Stroke", Element = s})
    return s
end

local function makeGradient(inst, c1, c2, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, c1),
        ColorSequenceKeypoint.new(1, c2),
    })
    g.Rotation = rot or 0
    g.Parent = inst
    table.insert(ThemeElements, {Type = "Gradient", Element = g, Key = "Color"})
    return g
end

local function textLabel(parent, text, size, font, color, xAlign)
    local t = Instance.new("TextLabel")
    t.BackgroundTransparency = 1
    t.Text = text or ""
    t.TextSize = size or 14
    t.Font = font or Enum.Font.Gotham
    t.TextColor3 = color or Color3.fromRGB(235,235,245)
    t.TextXAlignment = xAlign or Enum.TextXAlignment.Left
    t.TextYAlignment = Enum.TextYAlignment.Center
    t.Parent = parent
    return t
end

local function buttonBase(parent, text, size)
    local b = Instance.new("TextButton")
    b.AutoButtonColor = false
    b.Text = text or ""
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = size or 13
    b.TextColor3 = Color3.fromRGB(235,235,245)
    b.BackgroundColor3 = Themes[CurrentTheme].Darker
    b.BackgroundTransparency = 0
    b.BorderSizePixel = 0
    b.ZIndex = 10
    b.Parent = parent
    makeCorner(b, 12)
    makeStroke(b, Themes[CurrentTheme].Stroke, 1, 0.35)
    table.insert(ThemeElements, {Type = "Button", Element = b})
    return b
end

local function hoverGlow(btn)
    local normal = btn.BackgroundColor3
    local over = Themes[CurrentTheme].Dark
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = over}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = normal}):Play()
    end)
end

local function getAvatarHeadshot(plr)
    local success, content = pcall(function()
        return Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    end)
    return success and content or "rbxasset://textures/ui/GuiImagePlaceholder.png"
end

-- ===== ESP / ROLE SYSTEM =====
local function getPlayerRole(plr)
    if plr.Character then
        for _, item in pairs(plr.Character:GetChildren()) do
            if item:IsA("Tool") then
                local name = string.lower(item.Name)
                if string.find(name, "knife") or string.find(name, "blade") or string.find(name, "sword") or string.find(name, "dagger") then
                    return "KILLER", item.Name
                end
            end
        end
        for _, item in pairs(plr.Character:GetChildren()) do
            if item:IsA("Tool") then
                local name = string.lower(item.Name)
                if string.find(name, "gun") or string.find(name, "pistol") or string.find(name, "revolver") or string.find(name, "weapon") then
                    return "SHERIFF", item.Name
                end
            end
        end
    end
    if plr:FindFirstChild("Backpack") then
        for _, item in pairs(plr.Backpack:GetChildren()) do
            if item:IsA("Tool") then
                local name = string.lower(item.Name)
                if string.find(name, "knife") or string.find(name, "blade") or string.find(name, "sword") or string.find(name, "dagger") then
                    return "KILLER", item.Name
                end
            end
        end
        for _, item in pairs(plr.Backpack:GetChildren()) do
            if item:IsA("Tool") then
                local name = string.lower(item.Name)
                if string.find(name, "gun") or string.find(name, "pistol") or string.find(name, "revolver") or string.find(name, "weapon") then
                    return "SHERIFF", item.Name
                end
            end
        end
    end
    return "INNOCENT", nil
end

local function getPlayerColor(player)
    local role = getPlayerRole(player)
    if role == "KILLER" then return ROLE_COLORS.KILLER
    elseif role == "SHERIFF" then return ROLE_COLORS.SHERIFF
    else return ROLE_COLORS.INNOCENT end
end

-- ===== TRACERS =====
local function CreateTracer(player)
    local line = Drawing.new("Line")
    line.Thickness = 2
    line.Transparency = 1
    line.Color = getPlayerColor(player)
    Tracers[player] = line
end

local function RemoveTracer(player)
    if Tracers[player] then
        Tracers[player]:Remove()
        Tracers[player] = nil
    end
end

local function ClearAllTracers()
    for player, line in pairs(Tracers) do
        if line then line:Remove() end
    end
    Tracers = {}
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then CreateTracer(player) end
end
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then CreateTracer(player) end
end)
Players.PlayerRemoving:Connect(function(player)
    RemoveTracer(player)
end)

-- ===== CHAMS =====
local function CreateChams(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    if Chams[player] then
        Chams[player]:Destroy()
        Chams[player] = nil
    end
    local highlight = Instance.new("Highlight")
    highlight.Name = "XHub_Chams"
    highlight.FillTransparency = 0.55
    highlight.OutlineTransparency = 0.1
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = player.Character
    local role = getPlayerRole(player)
    if role == "KILLER" then highlight.FillColor = ROLE_COLORS.KILLER
    elseif role == "SHERIFF" then highlight.FillColor = ROLE_COLORS.SHERIFF
    else highlight.FillColor = ROLE_COLORS.INNOCENT end
    Chams[player] = highlight
end

local function RemoveChams(player)
    if Chams[player] then
        Chams[player]:Destroy()
        Chams[player] = nil
    end
end

local function ClearAllChams()
    for player, highlight in pairs(Chams) do
        if highlight then highlight:Destroy() end
    end
    Chams = {}
end

local function EnableChams()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then CreateChams(plr) end
    end
end

local function DisableChams()
    ClearAllChams()
end

local function UpdateChamsColors()
    for plr, highlight in pairs(Chams) do
        if highlight and highlight.Parent then
            local role = getPlayerRole(plr)
            if role == "KILLER" then highlight.FillColor = ROLE_COLORS.KILLER
            elseif role == "SHERIFF" then highlight.FillColor = ROLE_COLORS.SHERIFF
            else highlight.FillColor = ROLE_COLORS.INNOCENT end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer and CHAMS_ENABLED then CreateChams(player) end
end)
Players.PlayerRemoving:Connect(function(player)
    RemoveChams(player)
end)

-- ===== BOX ESP + NAME + DISTANCE + HEALTH =====
local function createESPForPlayer(plr)
    if plr == LocalPlayer then return end
    if not plr.Character then return end
    local character = plr.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    local head = character:FindFirstChild("Head")
    if not head then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Box"
    billboard.Size = UDim2.new(0, 50, 0, 80)
    billboard.Adornee = humanoidRootPart
    billboard.AlwaysOnTop = true
    billboard.Enabled = false
    billboard.Parent = head

    local boxFrame = Instance.new("Frame")
    boxFrame.Name = "BoxFrame"
    boxFrame.Size = UDim2.new(1, 0, 1, 0)
    boxFrame.BackgroundTransparency = 0.7
    boxFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    boxFrame.BorderSizePixel = 0
    boxFrame.Parent = billboard
    makeCorner(boxFrame, 2)

    local topLine = Instance.new("Frame")
    topLine.Name = "TopLine"
    topLine.Size = UDim2.new(1, 0, 0, 3)
    topLine.Position = UDim2.new(0, 0, 0, 0)
    topLine.BackgroundColor3 = getPlayerColor(plr)
    topLine.BackgroundTransparency = 0
    topLine.BorderSizePixel = 0
    topLine.Parent = boxFrame
    makeCorner(topLine, 2)

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 16)
    nameLabel.Position = UDim2.new(0, 0, 0, -20)
    nameLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.BackgroundTransparency = 0.3
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 11
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = plr.Name
    nameLabel.Parent = boxFrame
    makeCorner(nameLabel, 3)

    local roleLabel = Instance.new("TextLabel")
    roleLabel.Name = "RoleLabel"
    roleLabel.Size = UDim2.new(1, 0, 0, 14)
    roleLabel.Position = UDim2.new(0, 0, 1, 0)
    roleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    roleLabel.BackgroundTransparency = 0.4
    roleLabel.TextColor3 = getPlayerColor(plr)
    roleLabel.TextSize = 10
    roleLabel.Font = Enum.Font.GothamSemibold
    roleLabel.Parent = boxFrame
    makeCorner(roleLabel, 3)

    local weaponLabel = Instance.new("TextLabel")
    weaponLabel.Name = "WeaponLabel"
    weaponLabel.Size = UDim2.new(1, 0, 0, 12)
    weaponLabel.Position = UDim2.new(0, 0, 1, 14)
    weaponLabel.BackgroundTransparency = 1
    weaponLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    weaponLabel.TextSize = 9
    weaponLabel.Font = Enum.Font.Gotham
    weaponLabel.Text = ""
    weaponLabel.Parent = boxFrame

    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "DistanceLabel"
    distanceLabel.Size = UDim2.new(1, 0, 0, 12)
    distanceLabel.Position = UDim2.new(0, 0, 1, 26)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distanceLabel.TextSize = 9
    distanceLabel.Font = Enum.Font.GothamBold
    distanceLabel.Text = ""
    distanceLabel.Parent = boxFrame

    local healthBarBg = Instance.new("Frame")
    healthBarBg.Name = "HealthBarBg"
    healthBarBg.Size = UDim2.new(0, 4, 1, 0)
    healthBarBg.Position = UDim2.new(0, -8, 0, 0)
    healthBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    healthBarBg.BorderSizePixel = 0
    healthBarBg.Parent = boxFrame
    makeCorner(healthBarBg, 2)

    local healthBarFill = Instance.new("Frame")
    healthBarFill.Name = "HealthBarFill"
    healthBarFill.Size = UDim2.new(1, 0, 1, 0)
    healthBarFill.Position = UDim2.new(0, 0, 0, 0)
    healthBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthBarFill.BorderSizePixel = 0
    healthBarFill.Parent = healthBarBg
    makeCorner(healthBarFill, 2)

    local healthText = Instance.new("TextLabel")
    healthText.Name = "HealthText"
    healthText.Size = UDim2.new(1, 0, 0, 12)
    healthText.Position = UDim2.new(0, 0, 1, 38)
    healthText.BackgroundTransparency = 1
    healthText.TextColor3 = Color3.fromRGB(0, 255, 100)
    healthText.TextSize = 9
    healthText.Font = Enum.Font.GothamBold
    healthText.Text = ""
    healthText.Parent = boxFrame

    return billboard
end

local function enableESPFolders()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local existing = plr.Character.Head:FindFirstChild("ESP_Box")
            if not existing then
                local esp = createESPForPlayer(plr)
                if esp then esp.Enabled = true end
            else
                existing.Enabled = true
            end
        end
    end
end

local function disableESPFolders()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            local esp = plr.Character.Head:FindFirstChild("ESP_Box")
            if esp then esp.Enabled = false end
        end
    end
end

-- ===== AIMBOT =====
local FOV_Circle = Drawing.new("Circle")
FOV_Circle.Visible = false
FOV_Circle.Thickness = 1.5
FOV_Circle.Color = Color3.fromRGB(255, 255, 255)
FOV_Circle.Transparency = 0.7
FOV_Circle.Filled = false
FOV_Circle.NumSides = 64

local function isVisible(targetPart)
    if not WALL_CHECK_ENABLED then return true end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * (targetPart.Position - origin).Magnitude
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result then return result.Instance:IsDescendantOf(targetPart.Parent) end
    return true
end

local function getClosestKiller()
    local closestPlayer = nil
    local shortestDistance = AIM_FOV
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local role = getPlayerRole(player)
            if role == "KILLER" then
                local targetPart = player.Character:FindFirstChild(AIM_TARGET_PART)
                if targetPart then
                    local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if distance < shortestDistance then
                            if isVisible(targetPart) then
                                shortestDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

local function aimAt(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local targetPart = targetPlayer.Character:FindFirstChild(AIM_TARGET_PART)
    if not targetPart then return end
    local targetPos = targetPart.Position
    local currentCF = Camera.CFrame
    local targetDirection = (targetPos - currentCF.Position).Unit
    local targetCFrame = CFrame.new(currentCF.Position, currentCF.Position + targetDirection)
    Camera.CFrame = currentCF:Lerp(targetCFrame, 1 - AIM_SMOOTHNESS)
end

local function autoShoot()
    if not AUTO_SHOOT_ENABLED then return end
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool then tool:Activate() end
end

-- ===== FLY SYSTEM =====
local flyConnection = nil
local function startFly()
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    local character = LocalPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = hrp
    flyConnection = RunService.RenderStepped:Connect(function()
        if not FLY_ENABLED then
            if bodyGyro then bodyGyro:Destroy() end
            if bodyVelocity then bodyVelocity:Destroy() end
            return
        end
        local camCF = Camera.CFrame
        local moveDir = Vector3.new(0, 0, 0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        if moveDir.Magnitude > 0 then moveDir = moveDir.Unit * FLY_SPEED end
        bodyVelocity.Velocity = moveDir
        bodyGyro.CFrame = camCF
    end)
end

local function stopFly()
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    local character = LocalPlayer.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then v:Destroy() end
            end
        end
    end
end

-- ===== INFINITE JUMP =====
local infiniteJumpConnection = nil
local function startInfiniteJump()
    if infiniteJumpConnection then infiniteJumpConnection:Disconnect() end
    infiniteJumpConnection = UIS.InputBegan:Connect(function(input, gameProcessed)
        if INFINITE_JUMP_ENABLED and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
            local character = LocalPlayer.Character
            if character then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z) end
            end
        end
    end)
end

-- ===== NO CLIP =====
local noclipConnection = nil
local function startNoclip()
    if noclipConnection then noclipConnection:Disconnect() end
    noclipConnection = RunService.Stepped:Connect(function()
        if NO_CLIP_ENABLED and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end

local function stopNoclip()
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- ===== KNIFE REACH =====
local knifeReachConnection = nil
local function startKnifeReach()
    if knifeReachConnection then knifeReachConnection:Disconnect() end
    knifeReachConnection = RunService.Heartbeat:Connect(function()
        if not KNIFE_REACH_ENABLED then return end
        local character = LocalPlayer.Character
        if not character then return end
        local knife = nil
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "knife") or string.find(string.lower(tool.Name), "blade")) then
                knife = tool
                break
            end
        end
        if knife and knife:FindFirstChild("Handle") then
            knife.Handle.Size = Vector3.new(50, 50, 50)
            knife.Handle.Transparency = 0.9
        end
    end)
end

local function stopKnifeReach()
    if knifeReachConnection then knifeReachConnection:Disconnect() knifeReachConnection = nil end
    local character = LocalPlayer.Character
    if not character then return end
    local knife = nil
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "knife") or string.find(string.lower(tool.Name), "blade")) then
            knife = tool
            break
        end
    end
    if knife and knife:FindFirstChild("Handle") then
        knife.Handle.Size = Vector3.new(1, 1, 1)
        knife.Handle.Transparency = 0
    end
end

-- ===== GUN MOD =====
local gunModConnection = nil
local function startGunMod()
    if gunModConnection then gunModConnection:Disconnect() end
    gunModConnection = RunService.Heartbeat:Connect(function()
        if not GUN_MOD_ENABLED then return end
        local character = LocalPlayer.Character
        if not character then return end
        local gun = nil
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "gun") or string.find(string.lower(tool.Name), "pistol") or string.find(string.lower(tool.Name), "revolver")) then
                gun = tool
                break
            end
        end
        if gun then
            local values = gun:FindFirstChild("Values")
            if values then
                local ammo = values:FindFirstChild("Ammo")
                if ammo and ammo.Value <= 0 then ammo.Value = 6 end
            end
        end
    end)
end

-- ===== NEW: COIN COLLECTOR =====
local coinCollectorConnection = nil
local function startCoinCollector()
    if coinCollectorConnection then coinCollectorConnection:Disconnect() end
    coinCollectorConnection = RunService.Heartbeat:Connect(function()
        if not AUTO_COLLECT_COINS then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name == "Coin" or obj.Name == "Coin_Server") then
                local dist = (hrp.Position - obj.Position).Magnitude
                if dist < 50 then
                    firetouchinterest(hrp, obj, 0)
                    firetouchinterest(hrp, obj, 1)
                end
            end
        end
    end)
end

local function stopCoinCollector()
    if coinCollectorConnection then coinCollectorConnection:Disconnect() coinCollectorConnection = nil end
end

-- ===== NEW: AUTO GRAB GUN =====
local autoGrabGunConnection = nil
local function startAutoGrabGun()
    if autoGrabGunConnection then autoGrabGunConnection:Disconnect() end
    autoGrabGunConnection = RunService.Heartbeat:Connect(function()
        if not AUTO_GRAB_GUN then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local gun = workspace:FindFirstChild("GunDrop")
        if gun and gun:IsA("BasePart") then
            local dist = (hrp.Position - gun.Position).Magnitude
            if dist < 100 then
                hrp.CFrame = gun.CFrame
            end
        end
    end)
end

local function stopAutoGrabGun()
    if autoGrabGunConnection then autoGrabGunConnection:Disconnect() autoGrabGunConnection = nil end
end

-- ===== NEW: KILL AURA =====
local killAuraConnection = nil
local function startKillAura()
    if killAuraConnection then killAuraConnection:Disconnect() end
    killAuraConnection = RunService.Heartbeat:Connect(function()
        if not KILL_AURA_ENABLED then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local knife = nil
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "knife") or string.find(string.lower(tool.Name), "blade")) then
                knife = tool
                break
            end
        end

        if not knife then
            -- Auto equip knife from backpack
            if LocalPlayer:FindFirstChild("Backpack") then
                for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "knife") or string.find(string.lower(tool.Name), "blade")) then
                        tool.Parent = char
                        knife = tool
                        break
                    end
                end
            end
        end

        if knife then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local targetHRP = plr.Character:FindFirstChild("HumanoidRootPart")
                    if targetHRP then
                        local dist = (hrp.Position - targetHRP.Position).Magnitude
                        if dist < KILL_AURA_RANGE then
                            pcall(function()
                                knife:Activate()
                            end)
                        end
                    end
                end
            end
        end
    end)
end

local function stopKillAura()
    if killAuraConnection then killAuraConnection:Disconnect() killAuraConnection = nil end
end

-- ===== NEW: AUTO SHOOT MURDERER =====
local autoShootMurdererConnection = nil
local function startAutoShootMurderer()
    if autoShootMurdererConnection then autoShootMurdererConnection:Disconnect() end
    autoShootMurdererConnection = RunService.Heartbeat:Connect(function()
        if not AUTO_SHOOT_MURDERER then return end
        local char = LocalPlayer.Character
        if not char then return end

        local gun = nil
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "gun") or string.find(string.lower(tool.Name), "pistol") or string.find(string.lower(tool.Name), "revolver")) then
                gun = tool
                break
            end
        end

        if not gun then
            if LocalPlayer:FindFirstChild("Backpack") then
                for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "gun") or string.find(string.lower(tool.Name), "pistol") or string.find(string.lower(tool.Name), "revolver")) then
                        tool.Parent = char
                        gun = tool
                        break
                    end
                end
            end
        end

        if gun then
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local role = getPlayerRole(plr)
                    if role == "KILLER" then
                        local targetPart = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Head")
                        if targetPart then
                            local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                            if onScreen and isVisible(targetPart) then
                                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                                pcall(function()
                                    gun:Activate()
                                end)
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function stopAutoShootMurderer()
    if autoShootMurdererConnection then autoShootMurdererConnection:Disconnect() autoShootMurdererConnection = nil end
end

-- ===== NEW: AUTO EQUIP =====
local autoEquipConnection = nil
local function startAutoEquip()
    if autoEquipConnection then autoEquipConnection:Disconnect() end
    autoEquipConnection = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end

        if AUTO_EQUIP_KNIFE then
            local hasKnife = false
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "knife") or string.find(string.lower(tool.Name), "blade")) then
                    hasKnife = true
                    break
                end
            end
            if not hasKnife and LocalPlayer:FindFirstChild("Backpack") then
                for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "knife") or string.find(string.lower(tool.Name), "blade")) then
                        tool.Parent = char
                        break
                    end
                end
            end
        end

        if AUTO_EQUIP_GUN then
            local hasGun = false
            for _, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "gun") or string.find(string.lower(tool.Name), "pistol") or string.find(string.lower(tool.Name), "revolver")) then
                    hasGun = true
                    break
                end
            end
            if not hasGun and LocalPlayer:FindFirstChild("Backpack") then
                for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and (string.find(string.lower(tool.Name), "gun") or string.find(string.lower(tool.Name), "pistol") or string.find(string.lower(tool.Name), "revolver")) then
                        tool.Parent = char
                        break
                    end
                end
            end
        end
    end)
end

local function stopAutoEquip()
    if autoEquipConnection then autoEquipConnection:Disconnect() autoEquipConnection = nil end
end

-- ===== NEW: ANTI-LAG =====
local antiLagConnection = nil
local function startAntiLag()
    if antiLagConnection then antiLagConnection:Disconnect() end
    antiLagConnection = RunService.Heartbeat:Connect(function()
        if not ANTI_LAG_ENABLED then return end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
            end
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 999999
    end)
end

local function stopAntiLag()
    if antiLagConnection then antiLagConnection:Disconnect() antiLagConnection = nil end
end

-- ===== NEW: CUSTOM CROSSHAIR =====
local crosshairLines = {}
local function createCrosshair()
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Thickness = 2
        line.Transparency = 1
        line.Color = Color3.fromRGB(255, 255, 255)
        line.Visible = false
        table.insert(crosshairLines, line)
    end
end
createCrosshair()

local function updateCrosshair()
    if not CUSTOM_CROSSHAIR then
        for _, line in pairs(crosshairLines) do line.Visible = false end
        return
    end
    local centerX = Camera.ViewportSize.X / 2
    local centerY = Camera.ViewportSize.Y / 2
    local size = 8
    local gap = 4

    crosshairLines[1].From = Vector2.new(centerX - gap - size, centerY)
    crosshairLines[1].To = Vector2.new(centerX - gap, centerY)
    crosshairLines[2].From = Vector2.new(centerX + gap, centerY)
    crosshairLines[2].To = Vector2.new(centerX + gap + size, centerY)
    crosshairLines[3].From = Vector2.new(centerX, centerY - gap - size)
    crosshairLines[3].To = Vector2.new(centerX, centerY - gap)
    crosshairLines[4].From = Vector2.new(centerX, centerY + gap)
    crosshairLines[4].To = Vector2.new(centerX, centerY + gap + size)

    for _, line in pairs(crosshairLines) do
        line.Visible = true
        line.Color = Themes[CurrentTheme].Primary
    end
end

-- ===== NEW: SERVER HOP =====
local function serverHop()
    local success, servers = pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local response = game:HttpGet(url)
        return HttpService:JSONDecode(response)
    end)

    if success and servers and servers.data then
        for _, server in pairs(servers.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                return
            end
        end
    end
    warn("[N7R] No servers found!")
end

-- ===== NEW: REJOIN =====
local function rejoinServer()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

-- ===== RENDER LOOP =====
RunService.RenderStepped:Connect(function()
    if FOV_CIRCLE_ENABLED and AIMBOT_ENABLED then
        FOV_Circle.Visible = true
        FOV_Circle.Radius = AIM_FOV
        FOV_Circle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        FOV_Circle.Color = Themes[CurrentTheme].Primary
    else
        FOV_Circle.Visible = false
    end

    if AIMBOT_ENABLED then
        local target = getClosestKiller()
        if target then
            aimAt(target)
            if AUTO_SHOOT_ENABLED then autoShoot() end
        end
    end

    if CUSTOM_CROSSHAIR then
        updateCrosshair()
    end

    if TRACER_ENABLED then
        for player, line in pairs(Tracers) do
            local char = player.Character
            local myChar = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
                if onScreen then
                    line.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                    line.To = Vector2.new(pos.X, pos.Y)
                    line.Color = getPlayerColor(player)
                    line.Visible = true
                else
                    line.Visible = false
                end
            else
                line.Visible = false
            end
        end
    else
        for player, line in pairs(Tracers) do
            if line then line.Visible = false end
        end
    end

    if ESP_ENABLED then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local esp = plr.Character.Head:FindFirstChild("ESP_Box")
                if esp then
                    local role, weapon = getPlayerRole(plr)
                    local color = getPlayerColor(plr)
                    local boxFrame = esp.BoxFrame
                    local topLine = boxFrame:FindFirstChild("TopLine")
                    local roleLabel = boxFrame:FindFirstChild("RoleLabel")
                    local weaponLabel = boxFrame:FindFirstChild("WeaponLabel")
                    local nameLabel = boxFrame:FindFirstChild("NameLabel")
                    local distanceLabel = boxFrame:FindFirstChild("DistanceLabel")
                    local healthBarFill = boxFrame:FindFirstChild("HealthBarFill")
                    local healthText = boxFrame:FindFirstChild("HealthText")
                    local healthBarBg = boxFrame:FindFirstChild("HealthBarBg")

                    if topLine then topLine.BackgroundColor3 = color end
                    if roleLabel then
                        if role == "KILLER" then roleLabel.Text = "🔪 KILLER"
                        elseif role == "SHERIFF" then roleLabel.Text = "🔫 SHERIFF"
                        else roleLabel.Text = "👤 INNOCENT" end
                        roleLabel.TextColor3 = color
                    end
                    if weaponLabel then
                        weaponLabel.Text = weapon and "[" .. weapon .. "]" or ""
                        weaponLabel.TextColor3 = color
                    end
                    if nameLabel then
                        nameLabel.Visible = NAME_ESP_ENABLED or (ROLE_NAMES_ESP and (role == "KILLER" or role == "SHERIFF"))
                        if nameLabel.Visible then
                            local displayText = plr.DisplayName ~= plr.Name and plr.DisplayName .. " (@" .. plr.Name .. ")" or plr.Name
                            if ROLE_NAMES_ESP then
                                if role == "KILLER" then
                                    displayText = "[M] " .. displayText
                                elseif role == "SHERIFF" then
                                    displayText = "[S] " .. displayText
                                end
                            end
                            nameLabel.Text = displayText
                            nameLabel.TextColor3 = color
                        end
                    end
                    if distanceLabel then
                        distanceLabel.Visible = DISTANCE_ESP_ENABLED
                        if DISTANCE_ESP_ENABLED then
                            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local theirHRP = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                            if myHRP and theirHRP then
                                local dist = math.floor((myHRP.Position - theirHRP.Position).Magnitude)
                                distanceLabel.Text = tostring(dist) .. "m"
                                distanceLabel.TextColor3 = color
                            end
                        end
                    end
                    if healthBarBg and healthBarFill and healthText then
                        healthBarBg.Visible = HEALTH_ESP_ENABLED
                        healthBarFill.Visible = HEALTH_ESP_ENABLED
                        healthText.Visible = HEALTH_ESP_ENABLED
                        if HEALTH_ESP_ENABLED then
                            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                local hp = humanoid.Health
                                local maxHp = humanoid.MaxHealth
                                local hpPercent = hp / maxHp
                                healthBarFill.Size = UDim2.new(1, 0, hpPercent, 0)
                                healthBarFill.Position = UDim2.new(0, 0, 1 - hpPercent, 0)
                                if hpPercent > 0.6 then healthBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                elseif hpPercent > 0.3 then healthBarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                                else healthBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0) end
                                healthText.Text = math.floor(hp) .. "/" .. math.floor(maxHp)
                            end
                        end
                    end
                end
            end
        end
    end

    if CHAMS_ENABLED then UpdateChamsColors() end
end)

-- ===== RAINBOW THEME LOOP =====
task.spawn(function()
    while task.wait(0.05) do
        if RAINBOW_THEME_ENABLED then
            local rainbowTheme = getRainbowTheme(tick())
            Themes.Rainbow = rainbowTheme
            applyTheme("Rainbow")
        end
    end
end)

-- ===== GUI ROOT =====
local gui = Instance.new("ScreenGui")
gui.Name = "XHub_MM2_UI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

local bg = Instance.new("Frame")
bg.Name = "Background"
bg.Size = UDim2.fromScale(1, 1)
bg.Position = UDim2.fromScale(0, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
bg.BackgroundTransparency = 0.15
bg.BorderSizePixel = 0
bg.Parent = gui

local bgGrad = Instance.new("UIGradient")
bgGrad.Rotation = 25
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Themes[CurrentTheme].Gradient1),
    ColorSequenceKeypoint.new(1, Themes[CurrentTheme].Gradient2),
})
bgGrad.Parent = bg
table.insert(ThemeElements, {Type = "Gradient", Element = bgGrad, Key = "Color"})

local bgBlur = Instance.new("Frame")
bgBlur.Name = "Vignette"
bgBlur.Size = UDim2.fromScale(1, 1)
bgBlur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bgBlur.BackgroundTransparency = 0.55
bgBlur.BorderSizePixel = 0
bgBlur.Parent = bg

-- ===== WINDOW =====
local window = Instance.new("Frame")
window.Name = "Window"
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.Position = UDim2.fromScale(0.5, 0.5)
window.Size = UDim2.fromOffset(1020, 600)
window.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
window.Parent = gui
window.ClipsDescendants = true
makeCorner(window, 18)
makeStroke(window, Themes[CurrentTheme].Stroke2, 1, 0.25)
makeGradient(window, Themes[CurrentTheme].CardGrad1, Themes[CurrentTheme].CardGrad2, 20)

-- ===== UI SCALE =====
local uiScale = Instance.new("UIScale")
uiScale.Scale = WINDOW_SCALE
uiScale.Parent = window

-- ===== TOP BAR =====
local top = Instance.new("Frame")
top.Name = "Top"
top.Size = UDim2.new(1, -24, 0, 56)
top.Position = UDim2.fromOffset(12, 10)
top.BackgroundTransparency = 1
top.Parent = window

local dragArea = Instance.new("Frame")
dragArea.Name = "DragArea"
dragArea.Size = UDim2.new(1, -200, 1, 0)
dragArea.Position = UDim2.fromOffset(0, 0)
dragArea.BackgroundTransparency = 1
dragArea.Parent = top

local appTitle = textLabel(dragArea, "N7R | Murder Mystery 2", 15, Enum.Font.GothamSemibold, Themes[CurrentTheme].Primary)
appTitle.Position = UDim2.fromOffset(8, 0)
appTitle.Size = UDim2.new(1, -13, 1, 0)
table.insert(ThemeElements, {Type = "Text", Element = appTitle, Key = "TextColor3"})

local versionPill = Instance.new("TextLabel")
versionPill.BackgroundColor3 = Themes[CurrentTheme].Dark
versionPill.TextColor3 = Themes[CurrentTheme].Secondary
versionPill.Font = Enum.Font.GothamBold
versionPill.TextSize = 14
versionPill.Text = "v3.0"
versionPill.Size = UDim2.fromOffset(90, 23)
versionPill.Position = UDim2.fromOffset(170, 15)
versionPill.Parent = dragArea
makeCorner(versionPill, 20)
makeStroke(versionPill, Themes[CurrentTheme].Stroke3, 1, 0.35)
table.insert(ThemeElements, {Type = "Text", Element = versionPill, Key = "TextColor3"})
table.insert(ThemeElements, {Type = "Background", Element = versionPill, Key = "BackgroundColor3"})

-- ===== MINIMIZE SYSTEM =====
local isMinimized = false
local originalWindowSize = window.Size
local originalWindowPos = window.Position
local originalBgTransparency = bg.BackgroundTransparency
local originalBgBlurTransparency = bgBlur.BackgroundTransparency

local controlsFrame = Instance.new("Frame")
controlsFrame.Name = "Controls"
controlsFrame.Size = UDim2.fromOffset(100, 30)
controlsFrame.Position = UDim2.new(1, -100, 0, 13)
controlsFrame.BackgroundTransparency = 1
controlsFrame.Parent = top

local sidebar, content

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Parent = controlsFrame
minimizeBtn.Size = UDim2.fromOffset(42, 30)
minimizeBtn.Position = UDim2.fromOffset(0, 0)
minimizeBtn.BackgroundColor3 = Themes[CurrentTheme].Darker
minimizeBtn.Text = "−"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.TextColor3 = Themes[CurrentTheme].Secondary
minimizeBtn.AutoButtonColor = false
minimizeBtn.ZIndex = 15
makeCorner(minimizeBtn, 10)
makeStroke(minimizeBtn, Themes[CurrentTheme].Stroke, 1, 0.35)

minimizeBtn.MouseEnter:Connect(function()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Themes[CurrentTheme].Dark}):Play()
end)
minimizeBtn.MouseLeave:Connect(function()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Themes[CurrentTheme].Darker}):Play()
end)

local function minimizeWindow()
    isMinimized = true
    originalWindowSize = window.Size
    originalWindowPos = window.Position
    originalBgTransparency = bg.BackgroundTransparency
    originalBgBlurTransparency = bgBlur.BackgroundTransparency
    sidebar.Visible = false
    content.Visible = false
    bg.BackgroundTransparency = 1
    bgBlur.BackgroundTransparency = 1
    TweenService:Create(window, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(420, 70),
        Position = UDim2.new(0.5, -210, 0, 18)
    }):Play()
    minimizeBtn.Text = "+"
end

local function restoreWindow()
    isMinimized = false
    bg.BackgroundTransparency = originalBgTransparency
    bgBlur.BackgroundTransparency = originalBgBlurTransparency
    TweenService:Create(window, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = originalWindowSize,
        Position = originalWindowPos
    }):Play()
    task.delay(0.3, function()
        sidebar.Visible = true
        content.Visible = true
    end)
    minimizeBtn.Text = "−"
end

minimizeBtn.MouseButton1Click:Connect(function()
    if isMinimized then restoreWindow() else minimizeWindow() end
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Parent = controlsFrame
closeBtn.Size = UDim2.fromOffset(42, 30)
closeBtn.Position = UDim2.fromOffset(50, 0)
closeBtn.BackgroundColor3 = Themes[CurrentTheme].Darker
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Themes[CurrentTheme].Secondary
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 15
makeCorner(closeBtn, 10)
makeStroke(closeBtn, Themes[CurrentTheme].Stroke, 1, 0.35)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(180, 30, 30)}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {BackgroundColor3 = Themes[CurrentTheme].Darker}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {TextColor3 = Themes[CurrentTheme].Secondary}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
    pcall(ClearAllTracers)
    pcall(disableESPFolders)
    pcall(DisableChams)
    FOV_Circle:Remove()
    pcall(stopFly)
    pcall(stopNoclip)
    pcall(stopKnifeReach)
    pcall(stopCoinCollector)
    pcall(stopAutoGrabGun)
    pcall(stopKillAura)
    pcall(stopAutoShootMurderer)
    pcall(stopAutoEquip)
    pcall(stopAntiLag)
    pcall(function()
        window.Visible = false
        gui.Enabled = false
        for _,v in ipairs(gui:GetDescendants()) do
            if v:IsA("GuiObject") then v.Visible = false end
        end
    end)
    task.defer(function()
        task.wait(0.15)
        pcall(function() gui:Destroy() end)
    end)
end)

-- ===== DRAG SYSTEM =====
local dragging = false
local dragStart
local startPos

dragArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = window.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ===== SIDEBAR =====
sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.fromOffset(14, 74)
sidebar.Size = UDim2.fromOffset(232, 512)
sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
sidebar.BackgroundTransparency = 0.25
sidebar.Parent = window
makeCorner(sidebar, 20)
makeStroke(sidebar, Themes[CurrentTheme].Stroke2, 1, 0.2)

local sideList = Instance.new("UIListLayout")
sideList.Padding = UDim.new(0, 8)
sideList.SortOrder = Enum.SortOrder.LayoutOrder
sideList.Parent = sidebar

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 16)
sidePad.PaddingLeft = UDim.new(0, 14)
sidePad.PaddingRight = UDim.new(0, 14)
sidePad.PaddingBottom = UDim.new(0, 16)
sidePad.Parent = sidebar

-- ===== TAB SYSTEM =====
local Tabs = {}
local TabButtons = {}
local ActiveTab = "Main"

content = Instance.new("Frame")
content.Name = "Content"
content.BackgroundTransparency = 1
content.Position = UDim2.fromOffset(260, 74)
content.Size = UDim2.fromOffset(746, 512)
content.Parent = window

local function createTab(name)
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = name .. "_Tab"
    tabFrame.BackgroundTransparency = 1
    tabFrame.Size = UDim2.fromScale(1, 1)
    tabFrame.Visible = false
    tabFrame.Parent = content

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "Scroll"
    scroll.BackgroundTransparency = 1
    scroll.Size = UDim2.fromScale(1, 1)
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Themes[CurrentTheme].Accent
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.fromScale(0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = tabFrame

    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.fromOffset(353, 154)
    grid.CellPadding = UDim2.fromOffset(18, 18)
    grid.SortOrder = Enum.SortOrder.LayoutOrder
    grid.Parent = scroll

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingBottom = UDim.new(0, 10)
    pad.Parent = scroll

    Tabs[name] = scroll
    return scroll
end

createTab("Main")
createTab("ESP")
createTab("Player")
createTab("Combat")
createTab("World")
createTab("Misc")
createTab("Premium")
createTab("Settings")

local function switchTab(tabName)
    if not Tabs[tabName] then return end
    ActiveTab = tabName
    for name, scroll in pairs(Tabs) do
        scroll.Parent.Visible = false
    end
    Tabs[tabName].Parent.Visible = true

    for name, btn in pairs(TabButtons) do
        local label = btn:FindFirstChild("Label")
        local glow = btn:FindFirstChild("Glow")
        local stroke = btn:FindFirstChild("TabStroke")

        if name == tabName then
            TweenService:Create(btn, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.85, BackgroundColor3 = Themes[CurrentTheme].Primary}):Play()
            if label then
                TweenService:Create(label, TweenInfo.new(0.4), {TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13}):Play()
            end
            if glow then
                TweenService:Create(glow, TweenInfo.new(0.4), {ImageTransparency = 0.7}):Play()
            end
            if not stroke then
                stroke = Instance.new("UIStroke")
                stroke.Name = "TabStroke"
                stroke.Color = Themes[CurrentTheme].Primary
                stroke.Thickness = 1.5
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Transparency = 0.6
                stroke.Parent = btn
            end
        else
            TweenService:Create(btn, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
            if label then
                TweenService:Create(label, TweenInfo.new(0.4), {TextColor3 = Color3.fromRGB(160, 160, 180), TextSize = 12}):Play()
            end
            if glow then
                TweenService:Create(glow, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
            end
            if stroke then
                stroke:Destroy()
            end
        end
    end
end

local TabNames = {
    {Key = "Main",     Label = "🏠  الرئيسية",     Order = 1},
    {Key = "ESP",      Label = "👁️  الكشف",         Order = 2},
    {Key = "Player",   Label = "🎮  اللاعب",         Order = 3},
    {Key = "Combat",   Label = "⚔️  القتال",         Order = 4},
    {Key = "World",    Label = "🌍  السيرفر",         Order = 5},
    {Key = "Misc",     Label = "🔧  أدوات",          Order = 6},
    {Key = "Premium",  Label = "💎  بريميوم",        Order = 7},
    {Key = "Settings", Label = "⚙️  الإعدادات",      Order = 8},
}

local function navBtn(name, label, order)
    local b = Instance.new("TextButton")
    b.AutoButtonColor = false
    b.Text = ""
    b.BackgroundColor3 = Themes[CurrentTheme].Primary
    b.BackgroundTransparency = 1
    b.BorderSizePixel = 0
    b.ZIndex = 10
    b.Parent = sidebar
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.fromOffset(10, 0)
    b.LayoutOrder = order
    b.Name = name .. "_Btn"
    makeCorner(b, 12)

    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.BackgroundTransparency = 1
    glow.Position = UDim2.new(0, -15, 0, -15)
    glow.Size = UDim2.new(1, 30, 1, 30)
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = Themes[CurrentTheme].Primary
    glow.ImageTransparency = 1
    glow.ZIndex = 9
    glow.Parent = b

    local textLbl = Instance.new("TextLabel")
    textLbl.Name = "Label"
    textLbl.BackgroundTransparency = 1
    textLbl.Text = label or ""
    textLbl.Font = Enum.Font.GothamBold
    textLbl.TextSize = 12
    textLbl.TextColor3 = Color3.fromRGB(160, 160, 180)
    textLbl.TextXAlignment = Enum.TextXAlignment.Center
    textLbl.TextYAlignment = Enum.TextYAlignment.Center
    textLbl.Size = UDim2.new(1, 0, 1, 0)
    textLbl.Parent = b
    textLbl.ZIndex = 11

    b.MouseEnter:Connect(function()
        if ActiveTab ~= name then
            TweenService:Create(b, TweenInfo.new(0.3), {BackgroundTransparency = 0.92}):Play()
            TweenService:Create(textLbl, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end
    end)
    b.MouseLeave:Connect(function()
        if ActiveTab ~= name then
            TweenService:Create(b, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            TweenService:Create(textLbl, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(160, 160, 180)}):Play()
        end
    end)

    TabButtons[name] = b
    b.MouseButton1Click:Connect(function()
        switchTab(name)
    end)
    return b
end

for _, tabInfo in ipairs(TabNames) do
    navBtn(tabInfo.Key, tabInfo.Label, tabInfo.Order)
end

switchTab("Main")

-- ===== APPLY THEME =====
function applyTheme(themeName)
    if themeName ~= "Rainbow" and not Themes[themeName] then return end
    CurrentTheme = themeName
    local t = themeName == "Rainbow" and Themes.Rainbow or Themes[themeName]
    for _, item in pairs(ThemeElements) do
        if item.Type == "Text" and item.Element and item.Element.Parent then
            item.Element[item.Key] = t.Primary
        elseif item.Type == "Background" and item.Element and item.Element.Parent then
            item.Element[item.Key] = t.Dark
        elseif item.Type == "Stroke" and item.Element and item.Element.Parent then
            item.Element.Color = t.Stroke2
        elseif item.Type == "Gradient" and item.Element and item.Element.Parent then
            if item.Element.Parent.Name == "Background" then
                item.Element.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, t.Gradient1),
                    ColorSequenceKeypoint.new(1, t.Gradient2),
                })
            else
                item.Element.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, t.CardGrad1),
                    ColorSequenceKeypoint.new(1, t.CardGrad2),
                })
            end
        elseif item.Type == "Button" and item.Element and item.Element.Parent then
            local isActive = false
            for tabName, btn in pairs(TabButtons) do
                if btn == item.Element and tabName == ActiveTab then
                    isActive = true
                    break
                end
            end
            if not isActive then
                item.Element.BackgroundColor3 = t.Darker
            end
        end
    end
    for name, btn in pairs(TabButtons) do
        local indicator = btn:FindFirstChild("Indicator")
        local label = btn:FindFirstChild("Label")
        local bgAccent = btn:FindFirstChild("BgAccent")
        local stroke = btn:FindFirstChild("TabStroke")

        if name == ActiveTab then
            if bgAccent then
                bgAccent.BackgroundColor3 = t.Dark
                bgAccent.BackgroundTransparency = 0.55
            end
            if indicator then
                indicator.BackgroundColor3 = t.Primary
                indicator.Visible = true
            end
            if label then label.TextColor3 = t.Primary end
            if stroke then
                stroke.Color = t.Stroke3
            end
        else
            if bgAccent then bgAccent.BackgroundTransparency = 1 end
            if indicator then indicator.Visible = false end
            if label then label.TextColor3 = Color3.fromRGB(175, 175, 190) end
            if stroke then stroke:Destroy() end
        end
    end
    for _, scroll in pairs(Tabs) do
        scroll.ScrollBarImageColor3 = t.Accent
    end
    appTitle.TextColor3 = t.Primary
    versionPill.TextColor3 = t.Secondary
    versionPill.BackgroundColor3 = t.Dark
    minimizeBtn.TextColor3 = t.Secondary
    closeBtn.TextColor3 = t.Secondary
end

-- ===== CARD MAKER =====
local function makeCard(parentTab, titleText, subtitleText, order)
    local scroll = Tabs[parentTab]
    if not scroll then return nil end
    local card = Instance.new("Frame")
    card.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    card.LayoutOrder = order or 0
    card.Parent = scroll
    makeCorner(card, 16)
    makeStroke(card, Themes[CurrentTheme].Stroke2, 1, 0.35)
    makeGradient(card, Themes[CurrentTheme].CardGrad1, Themes[CurrentTheme].CardGrad2, 25)

    local t = textLabel(card, titleText, 16, Enum.Font.GothamSemibold, Themes[CurrentTheme].Primary)
    t.Position = UDim2.fromOffset(16, 12)
    t.Size = UDim2.new(1, -32, 0, 22)
    table.insert(ThemeElements, {Type = "Text", Element = t, Key = "TextColor3"})

    local sub = textLabel(card, subtitleText or "", 13, Enum.Font.Gotham, Color3.fromRGB(205,205,215))
    sub.Position = UDim2.fromOffset(16, 38)
    sub.Size = UDim2.new(1, -32, 0, 32)
    sub.TextWrapped = true
    sub.TextYAlignment = Enum.TextYAlignment.Top

    return card
end

-- ===== TOGGLE HELPER =====
local function toggleBtn(parent, label, x, y, cb)
    local b = buttonBase(parent, label, 13)
    b.Size = UDim2.fromOffset(155, 40)
    b.Position = UDim2.fromOffset(x, y)
    local on = false
    local function render()
        b.Text = on and "✓ " .. label or label
        b.TextColor3 = on and Themes[CurrentTheme].Secondary or Color3.fromRGB(235, 235, 245)
    end
    render()
    hoverGlow(b)
    b.MouseButton1Click:Connect(function()
        on = not on
        render()
        if cb then cb(on) end
    end)
    return b, function() return on end
end

-- ===== SLIDER HELPER =====
local function slider(parent, label, x, y, min, max, value, onChange)
    local lbl = textLabel(parent, label, 13, Enum.Font.GothamSemibold, Color3.fromRGB(220,220,230))
    lbl.Position = UDim2.fromOffset(x, y)
    lbl.Size = UDim2.fromOffset(140, 20)

    local val = textLabel(parent, tostring(value), 13, Enum.Font.GothamBold, Themes[CurrentTheme].Secondary, Enum.TextXAlignment.Right)
    val.Position = UDim2.fromOffset(x + 180, y)
    val.Size = UDim2.fromOffset(150, 20)
    table.insert(ThemeElements, {Type = "Text", Element = val, Key = "TextColor3"})

    local track = Instance.new("Frame")
    track.Position = UDim2.fromOffset(x, y + 26)
    track.Size = UDim2.fromOffset(330, 10)
    track.BackgroundColor3 = Color3.fromRGB(20, 16, 30)
    track.Parent = parent
    makeCorner(track, 999)
    makeStroke(track, Themes[CurrentTheme].Stroke, 1, 0.55)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((value-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Themes[CurrentTheme].Accent
    fill.Parent = track
    makeCorner(fill, 999)
    makeGradient(fill, Themes[CurrentTheme].Accent, Themes[CurrentTheme].Accent2, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(14, 14)
    knob.BackgroundColor3 = Themes[CurrentTheme].Secondary
    knob.Parent = track
    makeCorner(knob, 999)
    makeStroke(knob, Themes[CurrentTheme].Glow, 1, 0.25)

    local function setFromAlpha(a)
        a = math.clamp(a, 0, 1)
        local v = min + (max - min) * a
        v = round(v)
        val.Text = tostring(v)
        fill.Size = UDim2.new(a, 0, 1, 0)
        knob.Position = UDim2.new(a, -7, 0.5, -7)
        if onChange then onChange(v) end
    end
    setFromAlpha((value-min)/(max-min))

    local dragging = false
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local a = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            setFromAlpha(a)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local a = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
            setFromAlpha(a)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    return setFromAlpha
end

-- ============================================================
-- ==================== TAB: MAIN =============================
-- ============================================================

local devCard = makeCard("Main", "", "", 1)
devCard.Size = UDim2.new(1, -32, 0, 85)
devCard.BackgroundColor3 = Themes[CurrentTheme].Dark
makeStroke(devCard, Themes[CurrentTheme].Stroke3, 1.5, 0.2)

local devImg = Instance.new("ImageLabel")
devImg.Name = "DevAvatar"
devImg.BackgroundTransparency = 1
devImg.Size = UDim2.fromOffset(60, 60)
devImg.Position = UDim2.fromOffset(14, 12.5)
devImg.Image = "rbxassetid://129193732952067"
devImg.Parent = devCard
makeCorner(devImg, 14)
makeStroke(devImg, Themes[CurrentTheme].Accent, 1, 0.2)

local devName = textLabel(devCard, "2ecf", 19, Enum.Font.GothamBold, Themes[CurrentTheme].Primary)
devName.Position = UDim2.fromOffset(88, 0)
devName.Size = UDim2.new(0, 120, 1, 0)
table.insert(ThemeElements, {Type = "Text", Element = devName, Key = "TextColor3"})

local devTag = Instance.new("Frame")
devTag.Size = UDim2.fromOffset(145, 34)
devTag.Position = UDim2.new(1, -159, 0.5, -17)
devTag.BackgroundColor3 = Themes[CurrentTheme].Darker
devTag.BackgroundTransparency = 0.3
devTag.Parent = devCard
makeCorner(devTag, 10)
makeStroke(devTag, Themes[CurrentTheme].Stroke2, 1, 0.4)

local devTagText = textLabel(devTag, "المطور سكربت", 11, Enum.Font.GothamBold, Themes[CurrentTheme].Secondary, Enum.TextXAlignment.Center)
devTagText.Size = UDim2.new(1, 0, 1, 0)
table.insert(ThemeElements, {Type = "Text", Element = devTagText, Key = "TextColor3"})

local keyCard = makeCard("Main", "الحماية", "", 90)
local barBack = Instance.new("Frame")
barBack.Size = UDim2.new(1, -32, 0, 14)
barBack.Position = UDim2.fromOffset(16, 78)
barBack.BackgroundColor3 = Color3.fromRGB(20, 16, 30)
barBack.Parent = keyCard
makeCorner(barBack, 999)
makeStroke(barBack, Themes[CurrentTheme].Stroke, 1, 0.5)
local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(1, 0, 1, 0)
barFill.BackgroundColor3 = Themes[CurrentTheme].Accent
barFill.Parent = barBack
makeCorner(barFill, 999)
makeGradient(barFill, Themes[CurrentTheme].Accent, Themes[CurrentTheme].Accent2, 0)
local restore = buttonBase(keyCard, "اضغط للتجديد للحماية ", 13)
restore.Size = UDim2.fromOffset(150, 36)
restore.Position = UDim2.fromOffset(16, 104)
restore.TextColor3 = Themes[CurrentTheme].Secondary
hoverGlow(restore)

local profile = makeCard("Main", "👤 البروفايل", "معلومات حسابك", 3)
profile.Size = UDim2.new(1, -32, 0, 185)
local img = Instance.new("ImageLabel")
img.Name = "Avatar"
img.BackgroundTransparency = 1
img.Size = UDim2.fromOffset(78, 78)
img.Position = UDim2.fromOffset(16, 56)
img.Image = getAvatarHeadshot(LocalPlayer)
img.Parent = profile
makeCorner(img, 18)
makeStroke(img, Themes[CurrentTheme].Secondary, 1, 0.25)
local dn = Instance.new("TextLabel")
dn.BackgroundTransparency = 1
dn.Position = UDim2.fromOffset(106, 56)
dn.Size = UDim2.new(1, -122, 0, 22)
dn.Font = Enum.Font.GothamSemibold
dn.TextSize = 16
dn.TextXAlignment = Enum.TextXAlignment.Left
dn.TextColor3 = Themes[CurrentTheme].Primary
dn.Text = LocalPlayer.DisplayName
dn.Parent = profile
table.insert(ThemeElements, {Type = "Text", Element = dn, Key = "TextColor3"})
local un = Instance.new("TextLabel")
un.BackgroundTransparency = 1
un.Position = UDim2.fromOffset(106, 78)
un.Size = UDim2.new(1, -122, 0, 18)
un.Font = Enum.Font.Gotham
un.TextSize = 13
un.TextXAlignment = Enum.TextXAlignment.Left
un.TextColor3 = Color3.fromRGB(200, 200, 210)
un.Text = "@" .. LocalPlayer.Name
un.Parent = profile
local id = Instance.new("TextLabel")
id.BackgroundTransparency = 1
id.Position = UDim2.fromOffset(106, 98)
id.Size = UDim2.new(1, -122, 0, 18)
id.Font = Enum.Font.Gotham
id.TextSize = 12
id.TextXAlignment = Enum.TextXAlignment.Left
id.TextColor3 = Color3.fromRGB(180, 180, 195)
id.Text = "المعرف: " .. tostring(LocalPlayer.UserId)
id.Parent = profile

local executor = (identifyexecutor and identifyexecutor()) or "Unknown"
local exec = Instance.new("TextLabel")
exec.BackgroundTransparency = 1
exec.Position = UDim2.fromOffset(106, 118)
exec.Size = UDim2.new(1, -122, 0, 18)
exec.Font = Enum.Font.GothamBold
exec.TextSize = 12
exec.TextXAlignment = Enum.TextXAlignment.Left
exec.TextColor3 = Themes[CurrentTheme].Secondary
exec.Text = "الهاك المستخدم: " .. executor
exec.Parent = profile
table.insert(ThemeElements, {Type = "Text", Element = exec, Key = "TextColor3"})

local successMap, mapInfo = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId) end)
local mapName = successMap and mapInfo.Name or "Unknown"
local mapLbl = Instance.new("TextLabel")
mapLbl.BackgroundTransparency = 1
mapLbl.Position = UDim2.fromOffset(106, 138)
mapLbl.Size = UDim2.new(1, -122, 0, 18)
mapLbl.Font = Enum.Font.GothamBold
mapLbl.TextSize = 12
mapLbl.TextXAlignment = Enum.TextXAlignment.Left
mapLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
mapLbl.Text = "الماب الحالي: " .. mapName
mapLbl.Parent = profile
table.insert(ThemeElements, {Type = "Text", Element = mapLbl, Key = "TextColor3"})

local dc = makeCard("Main", "💬 انضم لديسكورد!", "!للدخول الى سيرفر تواصل مع هذا المطور !", 3)
local join = buttonBase(dc, "🔗 2ecf", 13)
join.Size = UDim2.fromOffset(220, 40)
join.Position = UDim2.fromOffset(16, 98)
join.TextColor3 = Themes[CurrentTheme].Secondary
hoverGlow(join)

-- ============================================================
-- ==================== TAB: ESP ==============================
-- ============================================================

local roleCard = makeCard("ESP", "🎭 كشف الأدوار المبكر", "القاتل والشرطي", 1)
roleCard.Size = UDim2.new(1, -32, 0, 130)

local function createRoleFrame(parent, roleName, xPos, color)
    local f = Instance.new("Frame")
    f.Size = UDim2.fromOffset(160, 100)
    f.Position = UDim2.fromOffset(xPos, 20)
    f.BackgroundTransparency = 1
    f.Parent = parent

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.fromOffset(60, 60)
    img.Position = UDim2.fromOffset(50, 0)
    img.BackgroundTransparency = 0.9
    img.BackgroundColor3 = color
    img.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    img.Parent = f
    makeCorner(img, 12)
    makeStroke(img, color, 1.5, 0.3)

    local lbl = textLabel(f, roleName, 13, Enum.Font.GothamBold, color, Enum.TextXAlignment.Center)
    lbl.Position = UDim2.fromOffset(0, 65)
    lbl.Size = UDim2.new(1, 0, 0, 18)

    local nameLbl = textLabel(f, "جاري البحث...", 11, Enum.Font.Gotham, Color3.fromRGB(200,200,200), Enum.TextXAlignment.Center)
    nameLbl.Position = UDim2.fromOffset(0, 82)
    nameLbl.Size = UDim2.new(1, 0, 0, 15)

    return img, nameLbl
end

local mImg, mName = createRoleFrame(roleCard, "القاتل (Murderer)", 10, ROLE_COLORS.KILLER)
local sImg, sName = createRoleFrame(roleCard, "الشرطي (Sheriff)", 180, ROLE_COLORS.SHERIFF)

toggleBtn(roleCard, "👤 كشف أسماء الأدوار", 16, 115, function(on)
    ROLE_NAMES_ESP = on
end)
roleCard.Size = UDim2.new(1, -32, 0, 170)

task.spawn(function()
    while task.wait(1) do
        local murderer, sheriff = nil, nil
        for _, p in pairs(Players:GetPlayers()) do
            local role = getPlayerRole(p)
            if role == "KILLER" then murderer = p
            elseif role == "SHERIFF" then sheriff = p end
        end

        if murderer then
            mImg.Image = getAvatarHeadshot(murderer)
            mName.Text = murderer.DisplayName
        else
            mImg.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            mName.Text = "جاري البحث..."
        end

        if sheriff then
            sImg.Image = getAvatarHeadshot(sheriff)
            sName.Text = sheriff.DisplayName
        else
            sImg.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            sName.Text = "جاري البحث..."
        end
    end
end)

local espCard = makeCard("ESP", "👁️ كشف اللاعبين", "الكشف", 2)
toggleBtn(espCard, "📦 صندوق الكشف", 16, 58, function(on)
    ESP_ENABLED = on
    if on then enableESPFolders() else disableESPFolders() end
end)
toggleBtn(espCard, "📍 خطوط التتبع", 186, 58, function(on)
    TRACER_ENABLED = on
end)
toggleBtn(espCard, "✨ كشف الأجسام", 16, 106, function(on)
    CHAMS_ENABLED = on
    if on then EnableChams() else DisableChams() end
end)
local espDesc = textLabel(espCard, "Box: إطار | خط: تتبع | Chams: أجسام ملونة", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
espDesc.Position = UDim2.fromOffset(16, 152)
espDesc.Size = UDim2.new(1, -32, 0, 20)

local espExtraCard = makeCard("ESP", "🔍 كشف إضافي", "أسماء + مسافة + صحة", 2)
toggleBtn(espExtraCard, "🏷️ كشف الأسماء", 16, 58, function(on)
    NAME_ESP_ENABLED = on
end)
toggleBtn(espExtraCard, "📏 كشف المسافة", 186, 58, function(on)
    DISTANCE_ESP_ENABLED = on
end)
toggleBtn(espExtraCard, "❤️ كشف الصحة", 16, 106, function(on)
    HEALTH_ESP_ENABLED = on
end)
local espExtraDesc = textLabel(espExtraCard, "يعرض اسم اللاعب والمسافة والصحة", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
espExtraDesc.Position = UDim2.fromOffset(16, 152)
espExtraDesc.Size = UDim2.new(1, -32, 0, 20)

local legendCard = makeCard("ESP", "🎨 ألوان الكشف", "ألوان كشف اللاعبين", 3)
local killerInd = Instance.new("Frame")
killerInd.Size = UDim2.fromOffset(16, 16)
killerInd.Position = UDim2.fromOffset(16, 58)
killerInd.BackgroundColor3 = ROLE_COLORS.KILLER
killerInd.Parent = legendCard
makeCorner(killerInd, 4)
local killerText = textLabel(legendCard, "🔪 القاتل (سكين) - أحمر", 12, Enum.Font.Gotham, ROLE_COLORS.KILLER)
killerText.Position = UDim2.fromOffset(38, 58)
killerText.Size = UDim2.new(1, -54, 0, 16)
killerText.TextXAlignment = Enum.TextXAlignment.Left

local sheriffInd = Instance.new("Frame")
sheriffInd.Size = UDim2.fromOffset(16, 16)
sheriffInd.Position = UDim2.fromOffset(16, 80)
sheriffInd.BackgroundColor3 = ROLE_COLORS.SHERIFF
sheriffInd.Parent = legendCard
makeCorner(sheriffInd, 4)
local sheriffText = textLabel(legendCard, "🔫 الشريف (مسدس) - أزرق", 12, Enum.Font.Gotham, ROLE_COLORS.SHERIFF)
sheriffText.Position = UDim2.fromOffset(38, 80)
sheriffText.Size = UDim2.new(1, -54, 0, 16)
sheriffText.TextXAlignment = Enum.TextXAlignment.Left

local innocentInd = Instance.new("Frame")
innocentInd.Size = UDim2.fromOffset(16, 16)
innocentInd.Position = UDim2.fromOffset(16, 102)
innocentInd.BackgroundColor3 = ROLE_COLORS.INNOCENT
innocentInd.Parent = legendCard
makeCorner(innocentInd, 4)
local innocentText = textLabel(legendCard, "👤 البريء - أخضر", 12, Enum.Font.Gotham, ROLE_COLORS.INNOCENT)
innocentText.Position = UDim2.fromOffset(38, 102)
innocentText.Size = UDim2.new(1, -54, 0, 16)
innocentText.TextXAlignment = Enum.TextXAlignment.Left

-- ===== TELEPORT TO ROLES CARD =====
local teleportCard = makeCard("ESP", "🚀 انتقال سريع", "انتقل للشريف أو القاتل فوراً", 4)

local function teleportToRole(roleName)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local role, weapon = getPlayerRole(plr)
            if role == roleName then
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                end
                return true
            end
        end
    end
    return false
end

local function updateTeleportButtons()
    local hasSheriff = false
    local hasKiller = false
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local role = getPlayerRole(plr)
            if role == "SHERIFF" then hasSheriff = true end
            if role == "KILLER" then hasKiller = true end
        end
    end
    return hasSheriff, hasKiller
end

local tpSheriffBtn = buttonBase(teleportCard, "🔫 انتقال للشريف", 13)
tpSheriffBtn.Size = UDim2.fromOffset(155, 40)
tpSheriffBtn.Position = UDim2.fromOffset(16, 58)
tpSheriffBtn.TextColor3 = ROLE_COLORS.SHERIFF
hoverGlow(tpSheriffBtn)
tpSheriffBtn.MouseButton1Click:Connect(function()
    if not teleportToRole("SHERIFF") then
        tpSheriffBtn.Text = "❌ لا يوجد شريف"
        task.wait(1.5)
        tpSheriffBtn.Text = "🔫 انتقال للشريف"
    end
end)

local tpKillerBtn = buttonBase(teleportCard, "🔪 انتقال للقاتل", 13)
tpKillerBtn.Size = UDim2.fromOffset(155, 40)
tpKillerBtn.Position = UDim2.fromOffset(186, 58)
tpKillerBtn.TextColor3 = ROLE_COLORS.KILLER
hoverGlow(tpKillerBtn)
tpKillerBtn.MouseButton1Click:Connect(function()
    if not teleportToRole("KILLER") then
        tpKillerBtn.Text = "❌ لا يوجد قاتل"
        task.wait(1.5)
        tpKillerBtn.Text = "🔪 انتقال للقاتل"
    end
end)

Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    local hasSheriff, hasKiller = updateTeleportButtons()
    tpSheriffBtn.TextColor3 = hasSheriff and ROLE_COLORS.SHERIFF or Color3.fromRGB(100, 100, 100)
    tpKillerBtn.TextColor3 = hasKiller and ROLE_COLORS.KILLER or Color3.fromRGB(100, 100, 100)
end)
Players.PlayerRemoving:Connect(function()
    task.wait(0.3)
    local hasSheriff, hasKiller = updateTeleportButtons()
    tpSheriffBtn.TextColor3 = hasSheriff and ROLE_COLORS.SHERIFF or Color3.fromRGB(100, 100, 100)
    tpKillerBtn.TextColor3 = hasKiller and ROLE_COLORS.KILLER or Color3.fromRGB(100, 100, 100)
end)

task.delay(1, function()
    local hasSheriff, hasKiller = updateTeleportButtons()
    tpSheriffBtn.TextColor3 = hasSheriff and ROLE_COLORS.SHERIFF or Color3.fromRGB(100, 100, 100)
    tpKillerBtn.TextColor3 = hasKiller and ROLE_COLORS.KILLER or Color3.fromRGB(100, 100, 100)
end)

-- ===== GRAB GUN CARD =====
local grabGunCard = makeCard("ESP", "🔫 جلب السلاح", "الانتقال للسلاح الساقط", 5)
local grabBtn = buttonBase(grabGunCard, "انتقال للسلاح ⚡", 13)
grabBtn.Size = UDim2.fromOffset(200, 40)
grabBtn.Position = UDim2.fromOffset(16, 75)
grabBtn.TextColor3 = Themes[CurrentTheme].Secondary
hoverGlow(grabBtn)

grabBtn.MouseButton1Click:Connect(function()
    local gun = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Gun")
    if not gun then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and (v.Name == "GunDrop" or v.Name == "Gun") then
                gun = v
                break
            end
        end
    end

    if gun and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = gun:IsA("Model") and gun:GetModelCFrame() or gun.CFrame
        LocalPlayer.Character.HumanoidRootPart.CFrame = targetPos
    end
end)

-- ============================================================
-- ==================== TAB: PLAYER ===========================
-- ============================================================

local stats = makeCard("Player", "📊 إحصائيات اللاعب", "سرعة مشي + قفز + مجال رؤية", 1)
slider(stats, "🏃 سرعة المشي", 16, 56, 1, 100, 16, function(v)
    ORIGINAL_WALKSPEED = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)
slider(stats, "🦘 قوة القفز", 16, 96, 1, 200, 50, function(v)
    ORIGINAL_JUMPPOWER = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = v
    end
end)
slider(stats, "👁️ مجال الرؤية", 16, 136, 40, 120, 70, function(v)
    Camera.FieldOfView = v
end)

local moveCard = makeCard("Player", "🚀 حركة إضافية", "طيران + قفز لا نهائي + تجاوز", 2)
toggleBtn(moveCard, "✈️ طيران", 16, 58, function(on)
    FLY_ENABLED = on
    if on then startFly() else stopFly() end
end)
toggleBtn(moveCard, "⬆️ قفز لا نهائي", 186, 58, function(on)
    INFINITE_JUMP_ENABLED = on
    if on then startInfiniteJump() end
end)
toggleBtn(moveCard, "🚫 تجاوز الجدران", 16, 106, function(on)
    NO_CLIP_ENABLED = on
    if on then startNoclip() else stopNoclip() end
end)
local moveDesc = textLabel(moveCard, "WASD للطيران | Space/Shift للأعلى/الأسفل", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
moveDesc.Position = UDim2.fromOffset(16, 152)
moveDesc.Size = UDim2.new(1, -32, 0, 20)

-- ============================================================
-- ==================== TAB: COMBAT ===========================
-- ============================================================

local aimbotCard = makeCard("Combat", "🎯 القوى", "قفل تلقائي على القاتل", 1)
toggleBtn(aimbotCard, "🎯 تفعيل الايم استت", 16, 58, function(on)
    AIMBOT_ENABLED = on
end)
toggleBtn(aimbotCard, "🔫 إطلاق تلقائي", 186, 58, function(on)
    AUTO_SHOOT_ENABLED = on
end)
toggleBtn(aimbotCard, "🧱 فحص الجدران", 16, 106, function(on)
    WALL_CHECK_ENABLED = on
end)
toggleBtn(aimbotCard, "⭕ دائرة الايم اسست ", 186, 106, function(on)
    FOV_CIRCLE_ENABLED = on
end)
local aimbotDesc = textLabel(aimbotCard, "يقفل على القاتل تلقائياً داخل نطاق FOV", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
aimbotDesc.Position = UDim2.fromOffset(16, 152)
aimbotDesc.Size = UDim2.new(1, -32, 0, 20)

local combatExtraCard = makeCard("Combat", "⚔️ ميزات قتالية", "Knife Reach + Gun Mod", 2)
toggleBtn(combatExtraCard, "🔪 القتل الجميع  ", 16, 58, function(on)
    KNIFE_REACH_ENABLED = on
    if on then startKnifeReach() else stopKnifeReach() end
end)
toggleBtn(combatExtraCard, "🔫  اطلاق على القاتل", 186, 58, function(on)
    GUN_MOD_ENABLED = on
    if on then startGunMod() end
end)
local combatExtraDesc = textLabel(combatExtraCard, "Knife Reach: مد السكين | Gun Mod: ذخيرة لا نهائية", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
combatExtraDesc.Position = UDim2.fromOffset(16, 152)
combatExtraDesc.Size = UDim2.new(1, -32, 0, 20)

local aimSettingsCard = makeCard("Combat", "⚙️ إعدادات Aimbot", "تخصيص أداء الـ Aimbot", 3)
slider(aimSettingsCard, "🎚️ سلاسة التقفيل", 16, 56, 0, 100, 15, function(v)
    AIM_SMOOTHNESS = v / 100
end)
slider(aimSettingsCard, "📐 نطاق FOV", 16, 96, 50, 400, 150, function(v)
    AIM_FOV = v
end)
local targetPartLabel = textLabel(aimSettingsCard, "🎯 الهدف:", 13, Enum.Font.GothamSemibold, Color3.fromRGB(220,220,230))
targetPartLabel.Position = UDim2.fromOffset(16, 136)
targetPartLabel.Size = UDim2.fromOffset(60, 20)
local targetParts = {"Head", "HumanoidRootPart", "Torso"}
local targetPartBtns = {}
local tpStartX = 80
for i, partName in ipairs(targetParts) do
    local btn = Instance.new("TextButton")
    btn.Name = partName .. "_Btn"
    btn.Parent = aimSettingsCard
    btn.Size = UDim2.fromOffset(90, 28)
    btn.Position = UDim2.fromOffset(tpStartX + (i-1) * 100, 136)
    btn.BackgroundColor3 = (partName == AIM_TARGET_PART) and Themes[CurrentTheme].Accent or Themes[CurrentTheme].Darker
    btn.Text = partName == "Head" and "رأس" or partName == "HumanoidRootPart" and "مركز" or "جذع"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false
    makeCorner(btn, 8)
    btn.MouseButton1Click:Connect(function()
        AIM_TARGET_PART = partName
        for _, b in pairs(targetPartBtns) do
            b.BackgroundColor3 = Themes[CurrentTheme].Darker
        end
        btn.BackgroundColor3 = Themes[CurrentTheme].Accent
    end)
    table.insert(targetPartBtns, btn)
end

-- ===== NEW: KILL AURA CARD =====
local killAuraCard = makeCard("Combat", "💀 Kill Aura", "قتل جميع اللاعبين تلقائياً", 4)
toggleBtn(killAuraCard, "💀 تفعيل Kill Aura", 16, 58, function(on)
    KILL_AURA_ENABLED = on
    if on then startKillAura() else stopKillAura() end
end)
toggleBtn(killAuraCard, "🔪 تجهيز السكين تلقائي", 186, 58, function(on)
    AUTO_EQUIP_KNIFE = on
    if on then startAutoEquip() end
end)
slider(killAuraCard, "📏 نطاق القتل", 16, 106, 5, 50, 20, function(v)
    KILL_AURA_RANGE = v
end)

-- ===== NEW: AUTO SHOOT MURDERER CARD =====
local autoShootCard = makeCard("Combat", "🔫 Auto Shoot", "إطلاق تلقائي على القاتل", 5)
toggleBtn(autoShootCard, "🔫 تفعيل Auto Shoot", 16, 58, function(on)
    AUTO_SHOOT_MURDERER = on
    if on then startAutoShootMurderer() else stopAutoShootMurderer() end
end)
toggleBtn(autoShootCard, "🔫 تجهيز المسدس تلقائي", 186, 58, function(on)
    AUTO_EQUIP_GUN = on
    if on then startAutoEquip() end
end)

-- ============================================================
-- ==================== TAB: WORLD ============================
-- ============================================================

local lightCard = makeCard("World", "💡 إضاءة العالم", "تحكم كامل بالإضاءة والظلال", 1)
toggleBtn(lightCard, "☀️ إضاءة كاملة", 16, 58, function(on)
    WorldSettings.FullBright = on
    if on then
        Lighting.Brightness = 10
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = WorldSettings.OriginalBrightness
        Lighting.GlobalShadows = WorldSettings.OriginalGlobalShadows
    end
end)
toggleBtn(lightCard, "🌫️ إزالة الضباب", 186, 58, function(on)
    WorldSettings.NoFog = on
    if on then
        Lighting.FogStart = 0
        Lighting.FogEnd = 999999
    else
        Lighting.FogStart = WorldSettings.OriginalFogStart
        Lighting.FogEnd = WorldSettings.OriginalFogEnd
    end
end)
toggleBtn(lightCard, "🌑 إزالة الظلال", 16, 106, function(on)
    WorldSettings.NoShadows = on
    Lighting.GlobalShadows = not on
end)
local worldDesc = textLabel(lightCard, "تحكم كامل بالبيئة", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
worldDesc.Position = UDim2.fromOffset(16, 152)
worldDesc.Size = UDim2.new(1, -32, 0, 20)

local worldExtraCard = makeCard("World", "🌍 إعدادات العالم", "جاذبية + وقت + رسومات", 2)
slider(worldExtraCard, "🌍 الجاذبية", 16, 56, 0, 500, 196, function(v)
    workspace.Gravity = v
end)
slider(worldExtraCard, "🕐 وقت اللعبة", 16, 96, 0, 24, 12, function(v)
    Lighting.ClockTime = v
end)
toggleBtn(worldExtraCard, "📉 رسومات منخفضة", 16, 136, function(on)
    WorldSettings.LowGraphics = on
    if on then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end)

-- ===== SERVER PLAYERS LIST =====
local playersCard = makeCard("World", "👥 لاعبو السيرفر", "جميع اللاعبين المتصلين حالياً", 3)

local playersScroll = Instance.new("ScrollingFrame")
playersScroll.Name = "PlayersScroll"
playersScroll.Size = UDim2.new(1, -32, 0, 100)
playersScroll.Position = UDim2.fromOffset(16, 58)
playersScroll.BackgroundTransparency = 1
playersScroll.ScrollBarThickness = 4
playersScroll.ScrollBarImageColor3 = Themes[CurrentTheme].Accent
playersScroll.BorderSizePixel = 0
playersScroll.Parent = playersCard

local playersListLayout = Instance.new("UIListLayout")
playersListLayout.Padding = UDim.new(0, 6)
playersListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playersListLayout.Parent = playersScroll

local function createPlayerRow(plr)
    local row = Instance.new("Frame")
    row.Name = plr.Name .. "_Row"
    row.Size = UDim2.new(1, 0, 0, 50)
    row.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.Parent = playersScroll
    makeCorner(row, 10)
    makeStroke(row, Themes[CurrentTheme].Stroke2, 1, 0.3)

    local avatar = Instance.new("ImageLabel")
    avatar.Name = "Avatar"
    avatar.BackgroundTransparency = 1
    avatar.Size = UDim2.fromOffset(40, 40)
    avatar.Position = UDim2.fromOffset(5, 5)
    avatar.Image = getAvatarHeadshot(plr)
    avatar.Parent = row
    makeCorner(avatar, 10)
    makeStroke(avatar, Themes[CurrentTheme].Stroke, 1, 0.3)

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Name"
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.fromOffset(52, 5)
    nameLabel.Size = UDim2.new(1, -60, 0, 20)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 13
    nameLabel.TextColor3 = Themes[CurrentTheme].Primary
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Text = plr.DisplayName ~= plr.Name and plr.DisplayName .. " (@" .. plr.Name .. ")" or plr.Name
    nameLabel.Parent = row

    local idLabel = Instance.new("TextLabel")
    idLabel.Name = "UserId"
    idLabel.BackgroundTransparency = 1
    idLabel.Position = UDim2.fromOffset(52, 26)
    idLabel.Size = UDim2.new(1, -60, 0, 18)
    idLabel.Font = Enum.Font.Gotham
    idLabel.TextSize = 11
    idLabel.TextColor3 = Color3.fromRGB(180, 180, 195)
    idLabel.TextXAlignment = Enum.TextXAlignment.Left
    idLabel.Text = "ID: " .. tostring(plr.UserId)
    idLabel.Parent = row

    local roleDot = Instance.new("Frame")
    roleDot.Name = "RoleDot"
    roleDot.Size = UDim2.fromOffset(8, 8)
    roleDot.Position = UDim2.new(1, -18, 0, 8)
    roleDot.BackgroundColor3 = getPlayerColor(plr)
    roleDot.BorderSizePixel = 0
    roleDot.Parent = row
    makeCorner(roleDot, 999)

    return row
end

local function refreshPlayersList()
    for _, child in pairs(playersScroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    for _, plr in pairs(Players:GetPlayers()) do
        createPlayerRow(plr)
    end
    playersScroll.CanvasSize = UDim2.new(0, 0, 0, playersListLayout.AbsoluteContentSize.Y + 10)
end

refreshPlayersList()
Players.PlayerAdded:Connect(function(plr)
    task.wait(0.3)
    refreshPlayersList()
end)
Players.PlayerRemoving:Connect(function(plr)
    refreshPlayersList()
end)

-- ===== SERVER STATS CARD =====
local serverStatsCard = makeCard("World", "📊 إحصائيات السيرفر", "معلومات عن السيرفر الحالي", 4)

local serverCountLabel = textLabel(serverStatsCard, "👥 عدد اللاعبين: " .. tostring(#Players:GetPlayers()), 14, Enum.Font.GothamBold, Color3.fromRGB(220,220,230))
serverCountLabel.Position = UDim2.fromOffset(16, 58)
serverCountLabel.Size = UDim2.new(1, -32, 0, 22)
serverCountLabel.TextXAlignment = Enum.TextXAlignment.Left

local serverMaxLabel = textLabel(serverStatsCard, "📊 الحد الأقصى: " .. tostring(Players.MaxPlayers), 13, Enum.Font.Gotham, Color3.fromRGB(200,200,210))
serverMaxLabel.Position = UDim2.fromOffset(16, 82)
serverMaxLabel.Size = UDim2.new(1, -32, 0, 20)
serverMaxLabel.TextXAlignment = Enum.TextXAlignment.Left

local serverPlaceLabel = textLabel(serverStatsCard, "🆔 معرف المكان: " .. tostring(game.PlaceId), 13, Enum.Font.Gotham, Color3.fromRGB(200,200,210))
serverPlaceLabel.Position = UDim2.fromOffset(16, 104)
serverPlaceLabel.Size = UDim2.new(1, -32, 0, 20)
serverPlaceLabel.TextXAlignment = Enum.TextXAlignment.Left

local serverJobLabel = textLabel(serverStatsCard, "🔗 معرف السيرفر: " .. string.sub(game.JobId, 1, 12) .. "...", 12, Enum.Font.Gotham, Color3.fromRGB(180,180,195))
serverJobLabel.Position = UDim2.fromOffset(16, 126)
serverJobLabel.Size = UDim2.new(1, -32, 0, 18)
serverJobLabel.TextXAlignment = Enum.TextXAlignment.Left

local function updateServerStats()
    serverCountLabel.Text = "👥 عدد اللاعبين: " .. tostring(#Players:GetPlayers())
end
Players.PlayerAdded:Connect(updateServerStats)
Players.PlayerRemoving:Connect(updateServerStats)

-- ============================================================
-- ==================== TAB: MISC =============================
-- ============================================================

local miscCard = makeCard("Misc", "🔧 أدوات متنوعة", "ميزات مساعدة", 1)
toggleBtn(miscCard, "😴 مكافحة الخمول", 16, 58, function(on)
    WorldSettings.AntiAFK = on
    if on then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            if WorldSettings.AntiAFK then
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
        end)
    end
end)
toggleBtn(miscCard, "🔍 تكبير لانهائي", 186, 58, function(on)
    WorldSettings.InfiniteZoom = on
    LocalPlayer.CameraMaxZoomDistance = on and 9999 or 128
end)

-- ===== NEW: COIN COLLECTOR CARD =====
local coinCard = makeCard("Misc", "🪙 تجميع العملات", "تجميع عملات MM2 تلقائياً", 2)
toggleBtn(coinCard, "🪙 تفعيل التجميع", 16, 58, function(on)
    AUTO_COLLECT_COINS = on
    if on then startCoinCollector() else stopCoinCollector() end
end)
toggleBtn(coinCard, "🔫 جلب السلاح تلقائي", 186, 58, function(on)
    AUTO_GRAB_GUN = on
    if on then startAutoGrabGun() else stopAutoGrabGun() end
end)
local coinDesc = textLabel(coinCard, "يجمع العملات ويجلب السلاح الساقط تلقائياً", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
coinDesc.Position = UDim2.fromOffset(16, 106)
coinDesc.Size = UDim2.new(1, -32, 0, 20)

-- ===== NEW: ANTI-LAG CARD =====
local antiLagCard = makeCard("Misc", "🚀 تقليل اللاق", "تحسين الأداء", 3)
toggleBtn(antiLagCard, "🚀 تفعيل Anti-Lag", 16, 58, function(on)
    ANTI_LAG_ENABLED = on
    if on then startAntiLag() else stopAntiLag() end
end)
toggleBtn(antiLagCard, "🎯 Crosshair مخصص", 186, 58, function(on)
    CUSTOM_CROSSHAIR = on
end)
local antiLagDesc = textLabel(antiLagCard, "يقلل اللاق ويضيف crosshair احترافي", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
antiLagDesc.Position = UDim2.fromOffset(16, 106)
antiLagDesc.Size = UDim2.new(1, -32, 0, 20)

local tpCard = makeCard("Misc", "🚀 انتقال سريع", "انتقل لأي لاعب", 4)
local tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.new(1, -32, 0, 80)
tpScroll.Position = UDim2.fromOffset(16, 58)
tpScroll.BackgroundTransparency = 1
tpScroll.ScrollBarThickness = 4
tpScroll.ScrollBarImageColor3 = Themes[CurrentTheme].Accent
tpScroll.Parent = tpCard
local tpList = Instance.new("UIListLayout")
tpList.Padding = UDim.new(0, 6)
tpList.SortOrder = Enum.SortOrder.LayoutOrder
tpList.Parent = tpScroll

local function refreshTeleportList()
    for _, child in pairs(tpScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local btn = buttonBase(tpScroll, plr.DisplayName, 12)
            btn.Size = UDim2.new(1, 0, 0, 32)
            btn.TextColor3 = Themes[CurrentTheme].Secondary
            hoverGlow(btn)
            btn.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                end
            end)
        end
    end
end
refreshTeleportList()
Players.PlayerAdded:Connect(refreshTeleportList)
Players.PlayerRemoving:Connect(refreshTeleportList)
local tpDesc = textLabel(tpCard, "انقر على اسم اللاعب للانتقال إليه", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
tpDesc.Position = UDim2.fromOffset(16, 142)
tpDesc.Size = UDim2.new(1, -32, 0, 20)

-- ============================================================
-- ==================== TAB: PREMIUM ==========================
-- ============================================================

local premiumCard = makeCard("Premium", "💎 ميزات بريميوم", "ميزات حصرية متقدمة", 1)
toggleBtn(premiumCard, "🌈 Rainbow Theme", 16, 58, function(on)
    RAINBOW_THEME_ENABLED = on
    if not on then applyTheme("Purple") end
end)
toggleBtn(premiumCard, "🔄 Server Hop", 186, 58, function(on)
    SERVER_HOP_ENABLED = on
    if on then serverHop() end
end)
local rejoinBtn = buttonBase(premiumCard, "🔄 إعادة الدخول", 13)
rejoinBtn.Size = UDim2.fromOffset(155, 40)
rejoinBtn.Position = UDim2.fromOffset(16, 106)
rejoinBtn.TextColor3 = Themes[CurrentTheme].Secondary
hoverGlow(rejoinBtn)
rejoinBtn.MouseButton1Click:Connect(function()
    rejoinServer()
end)
local premiumDesc = textLabel(premiumCard, "ميزات حصرية للمستخدمين المميزين", 11, Enum.Font.Gotham, Color3.fromRGB(180,180,180))
premiumDesc.Position = UDim2.fromOffset(16, 152)
premiumDesc.Size = UDim2.new(1, -32, 0, 20)

-- ============================================================
-- ==================== TAB: SETTINGS =========================
-- ============================================================

local themeCard = makeCard("Settings", "🎨 تغيير الألوان", "اختر لون السكربت", 1)

local function createThemeButton(name, x, y)
    local btn = buttonBase(themeCard, name, 13)
    btn.Size = UDim2.fromOffset(140, 36)
    btn.Position = UDim2.fromOffset(x, y)
    hoverGlow(btn)
    btn.MouseButton1Click:Connect(function()
        RAINBOW_THEME_ENABLED = false
        applyTheme(name)
    end)
end

createThemeButton("Purple", 10, 60)
createThemeButton("Green", 160, 60)
createThemeButton("Blue", 10, 110)
createThemeButton("Red", 160, 110)
createThemeButton("Orange", 10, 160)
createThemeButton("Pink", 160, 160)

-- Rainbow button
local rainbowBtn = buttonBase(themeCard, "🌈 Rainbow", 13)
rainbowBtn.Size = UDim2.fromOffset(290, 36)
rainbowBtn.Position = UDim2.fromOffset(10, 210)
rainbowBtn.TextColor3 = Color3.fromRGB(255, 0, 255)
hoverGlow(rainbowBtn)
rainbowBtn.MouseButton1Click:Connect(function()
    RAINBOW_THEME_ENABLED = true
end)

-- ===== UI SCALE CARD =====
local scaleCard = makeCard("Settings", "📐 حجم السكربت", "اختر الحجم المناسب", 2)

local smallBtn = buttonBase(scaleCard, "📱 صغير", 13)
smallBtn.Size = UDim2.fromOffset(120, 36)
smallBtn.Position = UDim2.fromOffset(10, 60)
smallBtn.MouseButton1Click:Connect(function()
    WINDOW_SCALE = 0.7
    uiScale.Scale = 0.7
end)

local normalBtn = buttonBase(scaleCard, "💻 افتراضي", 13)
normalBtn.Size = UDim2.fromOffset(120, 36)
normalBtn.Position = UDim2.fromOffset(140, 60)
normalBtn.MouseButton1Click:Connect(function()
    WINDOW_SCALE = 1
    uiScale.Scale = 1
end)

local bigBtn = buttonBase(scaleCard, "🖥️ كبير", 13)
bigBtn.Size = UDim2.fromOffset(120, 36)
bigBtn.Position = UDim2.fromOffset(270, 60)
bigBtn.MouseButton1Click:Connect(function()
    WINDOW_SCALE = 1.4
    uiScale.Scale = 1.4
end)

-- ===== RIGHTSHIFT TOGGLE =====
local uiVisible = true
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        uiVisible = not uiVisible
        gui.Enabled = uiVisible
    end
end)

print("✅ N7R | MM2 v3.0 ULTIMATE Loaded Successfully!")
print("🔥 Features: Coin Collector | Kill Aura | Auto Shoot | Auto Grab Gun | Rainbow Theme | Server Hop | Anti-Lag | Custom Crosshair")
