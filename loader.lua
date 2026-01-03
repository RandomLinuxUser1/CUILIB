-- Loader for CUILIB

local runService = game:GetService("RunService")

local args = {...}

local function getThemePalette()
    -- default palette matches the library's default theme
    local palette = {
        primary = Color3.fromRGB(38, 233, 195),
        secondary = Color3.fromRGB(233, 38, 115),
        window2 = Color3.fromRGB(20, 20, 25),
        window3 = Color3.fromRGB(25, 25, 30),
        text = Color3.fromRGB(164, 164, 164),
    }

    local settings = args[1]
    local themeName = (type(settings) == "table") and settings.theme or nil

    if typeof(themeName) ~= "string" then
        return palette
    end

    if themeName == "cherry" then
        palette.primary = Color3.fromRGB(249, 22, 52)
        palette.secondary = Color3.fromRGB(247, 22, 149)
        palette.window2 = Color3.fromRGB(5, 5, 5)
        palette.window3 = Color3.fromRGB(8, 8, 8)
        palette.text = Color3.fromRGB(164, 164, 164)
    elseif themeName == "orange" then
        palette.primary = Color3.fromRGB(244, 148, 22)
        palette.secondary = Color3.fromRGB(247, 37, 22)
        palette.window2 = Color3.fromRGB(10, 10, 12)
        palette.window3 = Color3.fromRGB(15, 15, 17)
        palette.text = Color3.fromRGB(192, 192, 192)
    elseif themeName == "lemon" then
        palette.primary = Color3.fromRGB(220, 255, 66)
        palette.secondary = Color3.fromRGB(232, 173, 25)
        palette.window2 = Color3.fromRGB(20, 20, 20)
        palette.window3 = Color3.fromRGB(25, 25, 25)
        palette.text = Color3.fromRGB(192, 192, 192)
    elseif themeName == "lime" then
        palette.primary = Color3.fromRGB(33, 255, 120)
        palette.secondary = Color3.fromRGB(120, 255, 33)
        palette.window2 = Color3.fromRGB(24, 24, 26)
        palette.window3 = Color3.fromRGB(28, 28, 30)
        palette.text = Color3.fromRGB(192, 192, 192)
    elseif themeName == "raspberry" then
        palette.primary = Color3.fromRGB(0, 190, 255)
        palette.secondary = Color3.fromRGB(0, 255, 190)
        palette.window2 = Color3.fromRGB(19, 19, 21)
        palette.window3 = Color3.fromRGB(23, 23, 25)
        palette.text = Color3.fromRGB(192, 192, 192)
    elseif themeName == "blueberry" then
        palette.primary = Color3.fromRGB(91, 77, 249)
        palette.secondary = Color3.fromRGB(130, 76, 247)
        palette.window2 = Color3.fromRGB(12, 12, 15)
        palette.window3 = Color3.fromRGB(15, 15, 18)
        palette.text = Color3.fromRGB(168, 168, 168)
    elseif themeName == "grape" then
        palette.primary = Color3.fromRGB(134, 53, 255)
        palette.secondary = Color3.fromRGB(211, 53, 255)
        palette.window2 = Color3.fromRGB(10, 10, 10)
        palette.window3 = Color3.fromRGB(15, 15, 15)
        palette.text = Color3.fromRGB(74, 42, 122)
    elseif themeName == "midnight" then
        palette.primary = Color3.fromRGB(100, 180, 255)
        palette.secondary = Color3.fromRGB(180, 120, 255)
        palette.window2 = Color3.fromRGB(4, 4, 12)
        palette.window3 = Color3.fromRGB(6, 6, 15)
        palette.text = Color3.fromRGB(140, 140, 170)
    elseif themeName == "emerald" then
        palette.primary = Color3.fromRGB(46, 204, 113)
        palette.secondary = Color3.fromRGB(39, 174, 96)
        palette.window2 = Color3.fromRGB(10, 16, 14)
        palette.window3 = Color3.fromRGB(13, 20, 18)
        palette.text = Color3.fromRGB(160, 190, 175)
    elseif themeName == "coral" then
        palette.primary = Color3.fromRGB(255, 99, 132)
        palette.secondary = Color3.fromRGB(255, 159, 64)
        palette.window2 = Color3.fromRGB(20, 12, 16)
        palette.window3 = Color3.fromRGB(24, 15, 19)
        palette.text = Color3.fromRGB(200, 170, 180)
    elseif themeName == "void" then
        palette.primary = Color3.fromRGB(0, 255, 255)
        palette.secondary = Color3.fromRGB(255, 0, 255)
        palette.window2 = Color3.fromRGB(2, 2, 3)
        palette.window3 = Color3.fromRGB(3, 3, 4)
        palette.text = Color3.fromRGB(120, 120, 140)
    elseif themeName == "lavender" then
        palette.primary = Color3.fromRGB(173, 127, 255)
        palette.secondary = Color3.fromRGB(140, 90, 230)
        palette.window2 = Color3.fromRGB(18, 16, 26)
        palette.window3 = Color3.fromRGB(21, 19, 30)
        palette.text = Color3.fromRGB(170, 160, 200)
    end

    return palette
end

local function createLoadingGui()
    local palette = getThemePalette()

    local uiScreen = Instance.new("ScreenGui")
    uiScreen.IgnoreGuiInset = true
    uiScreen.DisplayOrder = 9e9
    uiScreen.ZIndexBehavior = Enum.ZIndexBehavior.Global

    uiScreen.Name = "CUILIB_Loader_" .. tostring(math.random(1, 1e9))
    if gethui then
        uiScreen.Parent = gethui()
    else
        uiScreen.Parent = game:GetService("CoreGui")
    end

    local overlay = Instance.new("Frame")
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 1 -- fully transparent; no screen tint
    overlay.BorderSizePixel = 0
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.ZIndex = 9000
    overlay.Parent = uiScreen

    local center = Instance.new("Frame")
    center.AnchorPoint = Vector2.new(0.5, 0.5)
    center.BackgroundColor3 = palette.window2
    center.BorderColor3 = palette.window3
    center.BorderMode = Enum.BorderMode.Inset
    center.BorderSizePixel = 1
    center.Position = UDim2.fromScale(0.5, 0.5)
    center.Size = UDim2.fromOffset(420, 200)
    center.ZIndex = 9001
    center.Parent = overlay

    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(0, 6)
    round.Parent = center

    local logo = Instance.new("TextLabel")
    logo.AnchorPoint = Vector2.new(0.5, 0)
    logo.BackgroundTransparency = 1
    logo.BorderSizePixel = 0
    logo.Font = Enum.Font.RobotoCondensed
    logo.Position = UDim2.fromScale(0.5, 0)
    logo.Size = UDim2.fromOffset(140, 100)
    logo.Text = "V"
    logo.TextColor3 = palette.primary
    logo.TextSize = 90
    logo.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    logo.TextStrokeTransparency = 0.4
    logo.ZIndex = 9002
    logo.Parent = center

    local barBackground = Instance.new("Frame")
    barBackground.AnchorPoint = Vector2.new(0.5, 0)
    barBackground.BackgroundColor3 = palette.window3
    barBackground.BorderColor3 = palette.window2
    barBackground.BorderMode = Enum.BorderMode.Inset
    barBackground.BorderSizePixel = 1
    barBackground.Position = UDim2.fromScale(0.5, 0.6)
    barBackground.Size = UDim2.fromOffset(360, 18)
    barBackground.ZIndex = 9002
    barBackground.Parent = center

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 3)
    barCorner.Parent = barBackground

    local barFill = Instance.new("Frame")
    barFill.BackgroundColor3 = palette.primary
    barFill.BorderSizePixel = 0
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.ZIndex = 9003
    barFill.Parent = barBackground

    local barFillCorner = Instance.new("UICorner")
    barFillCorner.CornerRadius = UDim.new(0, 3)
    barFillCorner.Parent = barFill

    local statusText = Instance.new("TextLabel")
    statusText.AnchorPoint = Vector2.new(0.5, 0)
    statusText.BackgroundTransparency = 1
    statusText.BorderSizePixel = 0
    statusText.Font = Enum.Font.SourceSans
    statusText.Position = UDim2.fromScale(0.5, 0.72)
    statusText.Size = UDim2.fromOffset(360, 26)
    statusText.Text = "Loading UI..."
    statusText.TextColor3 = palette.text
    statusText.TextSize = 18
    statusText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    statusText.TextStrokeTransparency = 0.85
    statusText.TextWrapped = true
    statusText.TextXAlignment = Enum.TextXAlignment.Center
    statusText.TextYAlignment = Enum.TextYAlignment.Center
    statusText.ZIndex = 9002
    statusText.Parent = center

    return {
        screen = uiScreen,
        overlay = overlay,
        barFill = barFill,
        statusText = statusText,
    }
end

local function playLoadingAnimation(instances)
    local barFill = instances.barFill
    local statusText = instances.statusText

    local statuses = {
        "Loading themes...",
        "Loading UI...",
        "Initializing Animations...",
        "Starting keybind service...",
        "Finalizing...",
    }

    local running = true

    -- bar fill loop
    task.spawn(function()
        while running and barFill do
            barFill.Size = UDim2.new(0, 0, 1, 0)
            local t0 = tick()
            local duration = 1.8
            while running and tick() - t0 < duration do
                local alpha = (tick() - t0) / duration
                barFill.Size = UDim2.new(alpha, 0, 1, 0)
                runService.RenderStepped:Wait()
            end
            barFill.Size = UDim2.new(1, 0, 1, 0)
            task.wait(0.15)
        end
    end)

    -- status text loop
    task.spawn(function()
        local i = 0
        while running and statusText do
            i = (i % #statuses) + 1
            statusText.Text = statuses[i]
            task.wait(1)
        end
    end)

    return function()
        running = false
    end
end

local function fadeOutAndDestroy(instances, stopAnim)
    local overlay = instances.overlay
    if not overlay then
        if stopAnim then stopAnim() end
        return
    end

    local extraDelay = math.random(25, 60) / 10 -- 2.5s - 6.0s
    task.wait(extraDelay)

    local con
    con = runService.RenderStepped:Connect(function(dt)
        dt = dt * 3
        if overlay.BackgroundTransparency < 1 then
            overlay.BackgroundTransparency = math.min(1, overlay.BackgroundTransparency + dt)
        else
            con:Disconnect()
            if instances.screen then
                instances.screen:Destroy()
            end
            if stopAnim then
                stopAnim()
            end
        end
    end)
end

local function loadMainUi()
    local uiUrl = "https://raw.githubusercontent.com/RandomLinuxUser1/CUILIB/refs/heads/main/ui.lua"

    local fn = loadstring(game:HttpGet(uiUrl))
    return fn(unpack(args))
end

return function(...)
    -- allow passing args either via outer varargs or directly when calling the returned function
    if select("#", ...) > 0 then
        args = {...}
    end

    local instances = createLoadingGui()
    local stopAnim = playLoadingAnimation(instances)

    local ui
    local loadDone = false

    task.spawn(function()
        ui = loadMainUi()
        loadDone = true
    end)

    while not loadDone do
        task.wait()
    end

    -- keep the status text + bar animating during the extra random delay and
    -- fade-out; stopAnim is called from inside fadeOutAndDestroy once the
    -- overlay is gone.
    fadeOutAndDestroy(instances, stopAnim)

    return ui
end
