-- Loader for CUILIB

local runService = game:GetService("RunService")

local args = {...}

-- simple key gate config; replace URLs with your own
local KEY_ENABLED = true
local KEY_PASTE_URL = "https://pastebin.com/raw/yKrNDGpc" -- paste contains one key per line
local KEY_DISCORD_URL = "https://discord.gg/sfgQ7ybhhA"     -- invite copied by Get Key button

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

    -- loading status (hidden until after key is accepted)
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
    statusText.Visible = false
    statusText.Parent = center

    -- key gate UI (shown first if KEY_ENABLED)
    local keyContainer = Instance.new("Frame")
    keyContainer.BackgroundTransparency = 1
    keyContainer.BorderSizePixel = 0
    keyContainer.Size = UDim2.fromOffset(360, 70)
    keyContainer.Position = UDim2.fromScale(0.5, 0.6)
    keyContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    keyContainer.ZIndex = 9002
    keyContainer.Parent = center

    local keyBox = Instance.new("TextBox")
    keyBox.BackgroundColor3 = palette.window3
    keyBox.BorderColor3 = palette.window2
    keyBox.BorderMode = Enum.BorderMode.Inset
    keyBox.BorderSizePixel = 1
    keyBox.ClearTextOnFocus = false
    keyBox.Font = Enum.Font.SourceSans
    keyBox.PlaceholderText = "Enter key here..."
    keyBox.Position = UDim2.fromOffset(0, 0)
    keyBox.Size = UDim2.fromOffset(360, 26)
    keyBox.Text = ""
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.TextSize = 16
    keyBox.ZIndex = 9003
    keyBox.Parent = keyContainer

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.BackgroundColor3 = palette.window3
    getKeyBtn.BorderColor3 = palette.window2
    getKeyBtn.BorderMode = Enum.BorderMode.Inset
    getKeyBtn.BorderSizePixel = 1
    getKeyBtn.Font = Enum.Font.SourceSans
    getKeyBtn.Position = UDim2.fromOffset(0, 32)
    getKeyBtn.Size = UDim2.fromOffset(120, 24)
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyBtn.TextSize = 16
    getKeyBtn.ZIndex = 9003
    getKeyBtn.Parent = keyContainer

    local enterBtn = Instance.new("TextButton")
    enterBtn.BackgroundColor3 = palette.primary
    enterBtn.BorderSizePixel = 0
    enterBtn.Font = Enum.Font.SourceSans
    enterBtn.Position = UDim2.fromOffset(130, 32)
    enterBtn.Size = UDim2.fromOffset(230, 24)
    enterBtn.Text = "Enter!"
    enterBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    enterBtn.TextSize = 16
    enterBtn.ZIndex = 9003
    enterBtn.Parent = keyContainer

    local infoLabel = Instance.new("TextLabel")
    infoLabel.AnchorPoint = Vector2.new(0.5, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.BorderSizePixel = 0
    infoLabel.Font = Enum.Font.SourceSans
    -- centered under the buttons
    infoLabel.Position = UDim2.new(0.5, 0, 0, 58)
    infoLabel.Size = UDim2.fromOffset(360, 18)
    infoLabel.Text = "Enter your key to continue."
    infoLabel.TextColor3 = palette.text
    infoLabel.TextSize = 14
    infoLabel.TextWrapped = true
    infoLabel.TextXAlignment = Enum.TextXAlignment.Center
    infoLabel.TextYAlignment = Enum.TextYAlignment.Center
    infoLabel.ZIndex = 9003
    infoLabel.Parent = keyContainer

    -- hide bar until after key is accepted
    barBackground.Visible = false
    barFill.Visible = false

    return {
        screen = uiScreen,
        overlay = overlay,
        barBackground = barBackground,
        barFill = barFill,
        statusText = statusText,
        keyContainer = keyContainer,
        keyBox = keyBox,
        infoLabel = infoLabel,
        getKeyBtn = getKeyBtn,
        enterBtn = enterBtn,
    }
end

local function playLoadingAnimation(instances)
    local barFill = instances.barFill
    local statusText = instances.statusText

    local statuses = {
        "Loading themes...",
        "Loading UI...",
        "Initializing animations...",
        "Starting keybind service...",
        "Finalizing...",
    }

    local running = true

    -- bar fill: single smooth pass from 0 -> 100%
    task.spawn(function()
        local duration = 4 -- seconds for full bar
        local t0 = tick()
        while running and barFill do
            local elapsed = tick() - t0
            local alpha = math.clamp(elapsed / duration, 0, 1)
            barFill.Size = UDim2.new(alpha, 0, 1, 0)
            if alpha >= 1 then
                break
            end
            runService.RenderStepped:Wait()
        end
        -- when loop exits, bar stays at its last size (usually full)
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

local function checkKey(inputKey)
    if not KEY_ENABLED then
        return true
    end

    local trimmed = inputKey:match("^%s*(.-)%s*$") or ""
    if trimmed == "" then
        return false, "Please enter a key."
    end

    local ok, body = pcall(function()
        return game:HttpGet(KEY_PASTE_URL)
    end)

    if not ok then
        return false, "Key server error."
    end

    body = body:gsub("\r", "")
    for line in body:gmatch("[^\n]+") do
        line = line:match("^%s*(.-)%s*$")
        if line ~= "" and line == trimmed then
            return true
        end
    end

    return false, "Invalid key."
end

local function waitForValidKey(instances)
    if not KEY_ENABLED then
        return
    end

    local keyBox = instances.keyBox
    local infoLabel = instances.infoLabel
    local getKeyBtn = instances.getKeyBtn
    local enterBtn = instances.enterBtn
    local keyContainer = instances.keyContainer

    if not (keyBox and infoLabel and getKeyBtn and enterBtn and keyContainer) then
        return
    end

    local authorized = false

    local function attempt()
        local ok, msg = checkKey(keyBox.Text)
        if ok then
            authorized = true
            infoLabel.Text = "Key accepted!"
        else
            infoLabel.Text = msg or "Invalid key."
        end
    end

    getKeyBtn.MouseButton1Click:Connect(function()
        if typeof(setclipboard) == "function" then
            setclipboard(KEY_DISCORD_URL)
            infoLabel.Text = "Invite copied to clipboard!"
        else
            infoLabel.Text = "Join server: " .. KEY_DISCORD_URL
        end
    end)

    enterBtn.MouseButton1Click:Connect(attempt)
    keyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            attempt()
        end
    end)

    while not authorized do
        task.wait()
    end

    keyContainer.Visible = false
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

    -- wait for key entry (if enabled) before doing any network loading
    waitForValidKey(instances)

    -- show bar + status and start animation
    if instances.barBackground then instances.barBackground.Visible = true end
    if instances.barFill then instances.barFill.Visible = true end
    if instances.statusText then instances.statusText.Visible = true end

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

    -- jump bar to full once load completes (in case the duration hasn't elapsed yet)
    if instances.barFill then
        instances.barFill.Size = UDim2.new(1, 0, 1, 0)
    end

    -- keep the status text + (now-full) bar animating during the extra random
    -- delay and fade-out; stopAnim is called from inside fadeOutAndDestroy once
    -- the overlay is gone.
    fadeOutAndDestroy(instances, stopAnim)

    return ui
end
