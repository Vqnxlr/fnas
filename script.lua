local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpectralESPGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0, 320, 0, 180)
infoFrame.Position = UDim2.new(1, -340, 1, -200)
infoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
infoFrame.BackgroundTransparency = 0.5
infoFrame.BorderSizePixel = 0
infoFrame.Parent = screenGui

local UICorner = Instance.new("UICorner", infoFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -20, 0, 70)
infoText.Position = UDim2.new(0, 10, 0, 10)
infoText.BackgroundTransparency = 1
infoText.TextColor3 = Color3.fromRGB(255, 255, 255)
infoText.Font = Enum.Font.SourceSans
infoText.TextSize = 18
infoText.TextWrapped = true
infoText.TextXAlignment = Enum.TextXAlignment.Center
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Text = ""
infoText.Parent = infoFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 90)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.TextSize = 16
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.TextYAlignment = Enum.TextYAlignment.Top
statusLabel.Text = ""
statusLabel.Parent = infoFrame

local madeByText = Instance.new("TextLabel")
madeByText.Size = UDim2.new(1, -20, 0, 30)
madeByText.Position = UDim2.new(0.5, -150, 1, -35)
madeByText.BackgroundTransparency = 1
madeByText.TextColor3 = Color3.fromRGB(255, 0, 0)
madeByText.Font = Enum.Font.SourceSansBold
madeByText.TextSize = 20
madeByText.TextXAlignment = Enum.TextXAlignment.Center
madeByText.TextYAlignment = Enum.TextYAlignment.Bottom
madeByText.Text = "Made by Spectral"
madeByText.TextStrokeTransparency = 0
madeByText.TextStrokeColor3 = Color3.new(0, 0, 0)
madeByText.Parent = infoFrame

local purchaseText = Instance.new("TextLabel")
purchaseText.Size = UDim2.new(0, 400, 0, 30)
purchaseText.Position = UDim2.new(0, 10, 1, -35)
purchaseText.BackgroundTransparency = 1
purchaseText.Font = Enum.Font.SourceSansBold
purchaseText.TextSize = 20
purchaseText.TextXAlignment = Enum.TextXAlignment.Left
purchaseText.TextYAlignment = Enum.TextYAlignment.Bottom
purchaseText.Text = "To buy the full version, DM rtwoh"
purchaseText.TextColor3 = Color3.fromRGB(255, 255, 0)
purchaseText.TextStrokeTransparency = 0
purchaseText.TextStrokeColor3 = Color3.new(0, 0, 0) 
purchaseText.Parent = screenGui

local hotkeys = {
    ToggleESP = Enum.KeyCode.Home,
    ToggleFullBright = Enum.KeyCode.F8,
    Unload = Enum.KeyCode.F6
}

local function updateInfoText()
    infoText.Text =
        "Press \"" .. hotkeys.ToggleESP.Name .. "\" to Toggle ESP\n" ..
        "Press \"" .. hotkeys.ToggleFullBright.Name .. "\" to Toggle Full Bright\n" ..
        "Press \"" .. hotkeys.Unload.Name .. "\" to Unload"
end
updateInfoText()

local function showStatusMessage(message, color)
    statusLabel.Text = message
    statusLabel.TextColor3 = color
    task.delay(2, function()
        if statusLabel then
            statusLabel.Text = ""
        end
    end)
end

local espEnabled = false
local highlights = {}

local function createESP(model)
    local head = model:FindFirstChild("Head")
    if not head then return end

    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = head

    local displayName = model.Name:gsub("NPC$", "")

    local nameLabel = Instance.new("TextLabel", billboardGui)
    nameLabel.Text = displayName
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 18
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)

    local distanceLabel = Instance.new("TextLabel", billboardGui)
    distanceLabel.Text = "Distance: 0"
    distanceLabel.Font = Enum.Font.SourceSans
    distanceLabel.TextSize = 14
    distanceLabel.TextColor3 = Color3.new(1, 1, 1)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)

    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not head or not head.Parent or not distanceLabel then
            conn:Disconnect()
            return
        end
        local dist = (workspace.CurrentCamera.CFrame.Position - head.Position).Magnitude
        distanceLabel.Text = "Distance: " .. math.floor(dist) .. " studs"
    end)

    local highlight = Instance.new("Highlight")
    highlight.Parent = model
    highlight.FillColor = Color3.fromRGB(0, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(0, 255, 255)
    highlights[model] = {highlight = highlight, gui = billboardGui}
end

local function toggleESP()
    if espEnabled then
        for model, data in pairs(highlights) do
            if data.highlight then data.highlight:Destroy() end
            if data.gui then data.gui:Destroy() end
        end
        highlights = {}
        espEnabled = false
        showStatusMessage("ESP Disabled", Color3.fromRGB(255, 0, 0))
    else
        local anims = Workspace:FindFirstChild("Animatronics")
        if not anims then warn("Animatronics folder not found.") return end

        for _, folder in ipairs(anims:GetChildren()) do
            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model") then
                    createESP(model)
                end
            end
        end
        espEnabled = true
        showStatusMessage("ESP Enabled", Color3.fromRGB(0, 255, 0))
    end
end

local fullbrightEnabled = false
local originalLighting = {
    Ambient = game.Lighting.Ambient,
    OutdoorAmbient = game.Lighting.OutdoorAmbient,
    Brightness = game.Lighting.Brightness,
    ShadowSoftness = game.Lighting.ShadowSoftness
}

local function toggleFullbright()
    if fullbrightEnabled then
        for prop, val in pairs(originalLighting) do
            game.Lighting[prop] = val
        end
        fullbrightEnabled = false
        showStatusMessage("Fullbright Disabled", Color3.fromRGB(255, 0, 0))
    else
        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        game.Lighting.Brightness = 2
        game.Lighting.ShadowSoftness = 0
        fullbrightEnabled = true
        showStatusMessage("Fullbright Enabled", Color3.fromRGB(0, 255, 0))
    end
end

local function unloadScript()
    if espEnabled then toggleESP() end
    if fullbrightEnabled then toggleFullbright() end
    screenGui:Destroy()
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == hotkeys.ToggleESP then
        toggleESP()
    elseif input.KeyCode == hotkeys.ToggleFullBright then
        toggleFullbright()
    elseif input.KeyCode == hotkeys.Unload then
        unloadScript()
    end
end)

UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
UserInputService.MouseIconEnabled = false
