-- Loader for CUILIB
print("Loading ts")
local runService = game:GetService("RunService")

local args = {...}

local function createLoadingGui()
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
    center.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
    center.BorderColor3 = Color3.fromRGB(40, 40, 60)
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
    logo.TextColor3 = Color3.fromRGB(100, 220, 255)
    logo.TextSize = 90
    logo.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    logo.TextStrokeTransparency = 0.4
    logo.ZIndex = 9002
    logo.Parent = center

    local barBackground = Instance.new("Frame")
    barBackground.AnchorPoint = Vector2.new(0.5, 0)
    barBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    barBackground.BorderColor3 = Color3.fromRGB(50, 50, 70)
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
    barFill.BackgroundColor3 = Color3.fromRGB(100, 220, 255)
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
    statusText.TextColor3 = Color3.fromRGB(180, 180, 200)
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
