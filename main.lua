--==================================================
-- VENKOO HUB v1.0 | DARK RED
-- Roblox Studio LocalScript
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("VenkooHub")
if old then old:Destroy() end

local C = {
    Background = Color3.fromRGB(13, 10, 12),
    Panel = Color3.fromRGB(25, 20, 23),
    Panel2 = Color3.fromRGB(36, 26, 30),
    Red = Color3.fromRGB(220, 20, 45),
    DarkRed = Color3.fromRGB(105, 10, 25),
    White = Color3.fromRGB(245, 240, 242),
    Gray = Color3.fromRGB(165, 150, 160)
}

local themeColor = C.Red

local gui = Instance.new("ScreenGui")
gui.Name = "VenkooHub"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local uiScale = Instance.new("UIScale")
uiScale.Scale = 1
uiScale.Parent = gui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(650, 450)
main.Position = UDim2.new(0.5, -325, 0.5, -225)
main.BackgroundColor3 = C.Background
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = themeColor
mainStroke.Thickness = 2
mainStroke.Parent = main

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = C.DarkRed
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -130, 1, 0)
title.Position = UDim2.fromOffset(16, 0)
title.BackgroundTransparency = 1
title.Text = "VENKOO HUB"
title.TextColor3 = C.White
title.Font = Enum.Font.GothamBold
title.TextSize = 23
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local version = Instance.new("TextLabel")
version.Size = UDim2.fromOffset(100, 20)
version.Position = UDim2.new(1, -205, 0, 17)
version.BackgroundTransparency = 1
version.Text = "v1.0"
version.TextColor3 = C.White
version.Font = Enum.Font.Gotham
version.TextSize = 13
version.Parent = header

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(35, 32)
minimize.Position = UDim2.new(1, -83, 0, 11)
minimize.BackgroundColor3 = C.Panel2
minimize.Text = "-"
minimize.TextColor3 = C.White
minimize.TextSize = 22
minimize.Font = Enum.Font.GothamBold
minimize.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(35, 32)
close.Position = UDim2.new(1, -42, 0, 11)
close.BackgroundColor3 = C.Red
close.Text = "X"
close.TextColor3 = C.White
close.TextSize = 17
close.Font = Enum.Font.GothamBold
close.Parent = header

-- Drag support (mouse and touch)
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(0, 55)
sidebar.Size = UDim2.new(0, 145, 1, -55)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 14, 17)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 9)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 18)
sidePadding.Parent = sidebar

-- Main content
local content = Instance.new("ScrollingFrame")
content.Position = UDim2.fromOffset(155, 65)
content.Size = UDim2.new(1, -165, 1, -75)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = themeColor
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new()
content.Parent = main

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 10)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local function section(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -5, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = themeColor
    label.TextSize = 17
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
    return label
end

local function button(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 39)
    b.BackgroundColor3 = C.Panel
    b.Text = text
    b.TextColor3 = C.White
    b.TextSize = 14
    b.Font = Enum.Font.GothamMedium
    b.AutoButtonColor = true
    b.Parent = content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = b

    b.MouseButton1Click:Connect(callback)
    return b
end

local function info(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -5, 0, 35)
    label.BackgroundColor3 = C.Panel
    label.Text = text
    label.TextColor3 = C.White
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.Parent = content
    return label
end

-- Performance monitor
section("PERFORMANCE MONITOR")

local fpsLabel = info("FPS: Calculating...")
local pingLabel = info("PING: Calculating...")
local memoryLabel = info("MEMORY: Calculating...")

local monitorEnabled = true
local frames = 0
local elapsed = 0

local renderConnection = RunService.RenderStepped:Connect(function(dt)
    if not monitorEnabled then return end

    frames += 1
    elapsed += dt

    if elapsed >= 1 then
        fpsLabel.Text = "FPS: " .. math.floor(frames / elapsed)
        memoryLabel.Text = string.format(
            "MEMORY: %.1f MB",
            Stats:GetTotalMemoryUsageMb()
        )

        local success, ping = pcall(function()
            return Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
        end)

        pingLabel.Text = success and ("PING: " .. ping) or "PING: N/A"
        frames = 0
        elapsed = 0
    end
end)

button("Toggle Performance Monitor", function()
    monitorEnabled = not monitorEnabled
    fpsLabel.Visible = monitorEnabled
    pingLabel.Visible = monitorEnabled
    memoryLabel.Visible = monitorEnabled
end)

-- ESP: only highlights objects explicitly marked as belonging to this player
section("OWN OBJECT ESP")

local espEnabled = false
local highlights = {}

local function clearESP()
    for object, highlight in pairs(highlights) do
        if highlight then highlight:Destroy() end
        highlights[object] = nil
    end
end

local function isOwned(object)
    return object:GetAttribute("OwnerUserId") == player.UserId
        or CollectionService:HasTag(object, "Owner_" .. player.UserId)
end

local function updateESP()
    clearESP()
    if not espEnabled then return end

    for _, object in ipairs(workspace:GetDescendants()) do
        if (object:IsA("Model") or object:IsA("BasePart")) and isOwned(object) then
            local highlight = Instance.new("Highlight")
            highlight.Name = "VenkooOwnedESP"
            highlight.Adornee = object
            highlight.FillColor = themeColor
            highlight.OutlineColor = C.White
            highlight.FillTransparency = 0.65
            highlight.DepthMode = Enum.HighlightDepthMode.Occluded
            highlight.Parent = gui
            highlights[object] = highlight
        end
    end
end

button("ESP: OFF / ON", function()
    espEnabled = not espEnabled
    updateESP()
end)

button("Refresh Owned ESP", updateESP)

-- UI customization
section("UI CUSTOMIZATION")

button("Theme: Dark Red", function()
    themeColor = C.Red
    mainStroke.Color = themeColor
    content.ScrollBarImageColor3 = themeColor
end)

button("Theme: Crimson", function()
    themeColor = Color3.fromRGB(255, 65, 65)
    mainStroke.Color = themeColor
    content.ScrollBarImageColor3 = themeColor
end)

button("UI Scale: Small", function()
    uiScale.Scale = 0.8
end)

button("UI Scale: Medium", function()
    uiScale.Scale = 1
end)

button("UI Scale: Large", function()
    uiScale.Scale = 1.15
end)

button("Transparency: 0%", function()
    main.BackgroundTransparency = 0
end)

button("Transparency: 15%", function()
    main.BackgroundTransparency = 0.15
end)

button("Transparency: 30%", function()
    main.BackgroundTransparency = 0.3
end)

-- Navigation buttons
local function navigation(name, order)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 42)
    b.BackgroundColor3 = C.Panel
    b.Text = name
    b.TextColor3 = C.White
    b.TextSize = 14
    b.Font = Enum.Font.GothamBold
    b.LayoutOrder = order
    b.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = b

    b.MouseButton1Click:Connect(function()
        if name == "HOME" or name == "PERFORMANCE" then
            content.CanvasPosition = Vector2.zero
        elseif name == "ESP" then
            content.CanvasPosition = Vector2.new(0, 180)
        elseif name == "UI SETTINGS" then
            content.CanvasPosition = Vector2.new(0, 500)
        end
    end)
end

navigation("HOME", 1)
navigation("ESP", 2)
navigation("PERFORMANCE", 3)
navigation("UI SETTINGS", 4)

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -5, 0, 25)
footer.BackgroundTransparency = 1
footer.Text = "VENKOO HUB | Universal GUI"
footer.TextColor3 = C.Gray
footer.TextSize = 11
footer.Font = Enum.Font.Gotham
footer.Parent = content

-- Minimize and close
local minimized = false

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    sidebar.Visible = not minimized
    content.Visible = not minimized
    main.Size = minimized
        and UDim2.fromOffset(250, 55)
        or UDim2.fromOffset(650, 450)
    minimize.Text = minimized and "+" or "-"
end)

close.MouseButton1Click:Connect(function()
    if renderConnection then renderConnection:Disconnect() end
    clearESP()
    gui:Destroy()
end)

print("VENKOO HUB v1.0 LOADED")
