-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

-- Global Settings
getgenv().DelayInSeconds = 4
getgenv().Enabled = false
getgenv().SelectedStands = {}
getgenv().Webhook = ""    -- optional webhook URL

-- Notification Utility
local function Notification(Title, Text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = Title, Text = Text, Duration = 5})
    end)
end

-- Equip Tool Utility (unchanged)
function equipToolByName(name)
    local Backpack = Players.LocalPlayer:WaitForChild("Backpack")
    local Char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
    local tool = workspace:FindFirstChild(name) or Backpack:FindFirstChild(name)
    if tool and tool:IsA("Tool") then
        Char:FindFirstChild("Humanoid"):EquipTool(tool)
    end
end

-- Stand List with display names mapping
local StandsList = {
    {gameName = "Anubis", displayName = "Anubis"},
    {gameName = "D4C", displayName = "D4C"},
    {gameName = "OMT", displayName = "One More Time"},
    {gameName = "CrazyDiamond", displayName = "Crazy Diamond"},
    {gameName = "DoppioKingCrimson", displayName = "Doppio King Crimson"},
    {gameName = "KillerQueen", displayName = "Killer Queen"},
    {gameName = "GoldExperience", displayName = "Gold Experience"},
    {gameName = "StarPlatinum", displayName = "Star Platinum"},
    {gameName = "StarPlatinumTW", displayName = "Star Platinum: Stone Ocean"},
    {gameName = "TheWorld", displayName = "The World"},
    {gameName = "HierophantGreen", displayName = "Hierophant Green"},
    {gameName = "Whitesnake", displayName = "Whitesnake"},
    {gameName = "TheWorldAlternateUniverse", displayName = "The World Alternate Universe"},
    {gameName = "WhitesnakeAU", displayName = "Whitesnake: Alternate Universe"},
    {gameName = "KingCrimsonAU", displayName = "King Crimson: Alternate Universe"},
    {gameName = "SoftAndWetShiny", displayName = "Soft And Wet Shiny"},
    {gameName = "StarPlatinumOVA", displayName = "Star Platinum OVA"},
    {gameName = "TheWorldOVA", displayName = "The World OVA"},
    {gameName = "NTWAU", displayName = "Neo The World: Alternate Universe"},
    {gameName = "CreeperQueen", displayName = "Creeper Queen"},
    {gameName = "SPTW", displayName = "Star Platinum: The World"},
    {gameName = "StickyFingers", displayName = "Sticky Fingers"},
    {gameName = "SoftAndWet", displayName = "Soft And Wet"}
}

-- Create lookup tables for easy conversion
local gameNameToDisplay = {}
local displayNameToGame = {}
for _, stand in ipairs(StandsList) do
    gameNameToDisplay[stand.gameName] = stand.displayName
    displayNameToGame[stand.displayName] = stand.gameName
end

-- Anti-AFK (unchanged)
Players.LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- GUI Setup: restore original dark look
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StandFarmGui"
ScreenGui.ResetOnSpawn = false  -- persist GUI through death
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 540)
Frame.Position = UDim2.new(0.5, -150, 0.5, -270)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Stand Autofarm"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22

local StatusLabel = Instance.new("TextLabel", Frame)
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 40)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.new(0.8,0.8,1)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 18

local Scrolling = Instance.new("ScrollingFrame", Frame)
Scrolling.Position = UDim2.new(0, 10, 0, 80)
Scrolling.Size = UDim2.new(1, -20, 0, 300)
Scrolling.CanvasSize = UDim2.new(0, 0, 0, #StandsList * 30)
Scrolling.ScrollBarThickness = 6

local function toggleStand(stand, btn)
    local gameName = displayNameToGame[stand]
    local idx = table.find(getgenv().SelectedStands, gameName)
    if idx then
        table.remove(getgenv().SelectedStands, idx)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    else
        table.insert(getgenv().SelectedStands, gameName)
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end

for i, stand in ipairs(StandsList) do
    local btn = Instance.new("TextButton", Scrolling)
    btn.Size = UDim2.new(1,0,0,30)
    btn.Position = UDim2.new(0,0,0,(i-1)*30)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.Text = stand.displayName
    btn.MouseButton1Click:Connect(function() toggleStand(stand.displayName, btn) end)
end

local Warn = Instance.new("TextLabel", Frame)
Warn.Size = UDim2.new(1,-20,0,20)
Warn.Position = UDim2.new(0,10,1,-100)
Warn.BackgroundTransparency = 1
Warn.Text = "Made by DeedsForCheap, Revised by Spectral"
Warn.TextColor3 = Color3.new(1,0.4,0.4)
Warn.Font = Enum.Font.SourceSansItalic
Warn.TextSize = 16

local RunBtn = Instance.new("TextButton", Frame)
RunBtn.Size = UDim2.new(1,-20,0,30)
RunBtn.Position = UDim2.new(0,10,1,-70)
RunBtn.BackgroundColor3 = Color3.fromRGB(50,150,50)
RunBtn.Text = "START FARM"
RunBtn.Font = Enum.Font.SourceSansBold
RunBtn.TextSize = 20

local StopBtn = Instance.new("TextButton", Frame)
StopBtn.Size = UDim2.new(1,-20,0,30)
StopBtn.Position = UDim2.new(0,10,1,-30)
StopBtn.BackgroundColor3 = Color3.fromRGB(150,50,50)
StopBtn.Text = "STOP FARM"
StopBtn.Font = Enum.Font.SourceSansBold
StopBtn.TextSize = 20

-- Current Stand GUI (unchanged)
local CurrentGui = Instance.new("Frame", ScreenGui)
CurrentGui.Visible = false
CurrentGui.Size = UDim2.new(0, 200, 0, 60)
CurrentGui.Position = UDim2.new(0.5, -100, 0.1, 0)
CurrentGui.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CurrentGui.BorderSizePixel = 0

local CurrentLabel = Instance.new("TextLabel", CurrentGui)
CurrentLabel.Size = UDim2.new(1,0,1,0)
CurrentLabel.BackgroundTransparency = 1
CurrentLabel.Font = Enum.Font.SourceSansBold
CurrentLabel.TextSize = 20
CurrentLabel.TextColor3 = Color3.new(1,1,1)
CurrentLabel.Text = "Current: None"

local CurrentBtn = Instance.new("TextButton", Frame)
CurrentBtn.Size = UDim2.new(1,-20,0,30)
CurrentBtn.Position = UDim2.new(0,10,1,-140)
CurrentBtn.BackgroundColor3 = Color3.fromRGB(70,70,200)
CurrentBtn.Text = "Show Current"
CurrentBtn.Font = Enum.Font.SourceSansBold
CurrentBtn.TextSize = 18
CurrentBtn.MouseButton1Click:Connect(function()
    CurrentGui.Visible = not CurrentGui.Visible
end)

-- Farming Logic: unchanged detection
RunBtn.MouseButton1Click:Connect(function()
    if getgenv().Enabled then
        Notification("Already Running", "Stop the farm before running it again.")
        return
    end
    if #getgenv().SelectedStands == 0 then
        Notification("No Targets", "Select at least one stand.")
        return
    end
    getgenv().Enabled = true
    
    -- Convert game names to display names for notification
    local displayNames = {}
    for _, gameName in ipairs(getgenv().SelectedStands) do
        table.insert(displayNames, gameNameToDisplay[gameName] or gameName)
    end
    
    Notification("Farm Started", "Targeting: " .. table.concat(displayNames, ", "))
    StatusLabel.Text = "Status: Farming..."

    coroutine.wrap(function()
        local waitTime = getgenv().DelayInSeconds / 4
        while getgenv().Enabled do
            equipToolByName("Arrow")
            pcall(function()
                ReplicatedStorage.ItemEvents.Arrow:FireServer()
                ReplicatedStorage.Main.Input:FireServer("Alternate","Dodge")
            end)
            task.wait(waitTime)

            for _, stand in ipairs(getgenv().SelectedStands) do
                local found = Players.LocalPlayer.Backpack:FindFirstChild(stand, true)
                local eq = Players.LocalPlayer.Backpack:FindFirstChild("Stand")
                if found or (eq and eq.Value:lower() == stand:lower()) then
                    local displayName = gameNameToDisplay[stand] or stand
                    Notification("Acquired", "Got stand: " .. displayName)
                    StatusLabel.Text = "Status: Got " .. displayName
                    CurrentLabel.Text = "Current: " .. displayName
                    getgenv().Enabled = false
                    break
                end
            end

            if not getgenv().Enabled then break end

            equipToolByName("Rokakaka Fruit")
            pcall(function()
                ReplicatedStorage.ItemEvents.Roka:FireServer()
            end)
            task.wait(waitTime)
        end
        StatusLabel.Text = "Status: Stopped"
    end)()
end)

StopBtn.MouseButton1Click:Connect(function()
    getgenv().Enabled = false
    StatusLabel.Text = "Status: Stopped"
    Notification("Farm Stopped", "Stopped by user.")
end)
