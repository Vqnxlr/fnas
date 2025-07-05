-- UI STAND PICKER (runs first)
local Stands = {
    "Anubis", "D4C", "OMT", "CrazyDiamond", "DoppioKingCrimson", "KillerQueen",
    "GoldExperience", "StarPlatinum", "StarPlatinumTW", "TheWorld", "HierophantGreen",
    "Whitesnake", "TheWorldAlternateUniverse", "WhitesnakeAU", "KingCrimsonAU",
    "SoftAndWetShiny", "StarPlatinumOVA", "TheWorldOVA", "NTWAU", "CreeperQueen",
    "SPTW", "StickyFingers", "SoftAndWet"
}

pcall(function() game.CoreGui:FindFirstChild("StandFarmUI"):Destroy() end)

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "StandFarmUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 340)
frame.Position = UDim2.new(0.5, -200, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Text = "Select Wanted Stand"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Size = UDim2.new(1, 0, 0, 30)
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local dropdownBtn = Instance.new("TextButton", frame)
dropdownBtn.Size = UDim2.new(0.9, 0, 0, 35)
dropdownBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
dropdownBtn.TextColor3 = Color3.new(1,1,1)
dropdownBtn.Text = "Click to Choose"
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.TextSize = 14
Instance.new("UICorner", dropdownBtn)

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0.05, 0, 0.35, 0)
scroll.Size = UDim2.new(0.9, 0, 0.4, 0)
scroll.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scroll.Visible = false
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, #Stands * 32)
scroll.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)

for _, stand in ipairs(Stands) do
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = stand
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.MouseButton1Click:Connect(function()
        getgenv().WantedStand = stand
        dropdownBtn.Text = "Selected: " .. stand
        scroll.Visible = false
    end)
end

dropdownBtn.MouseButton1Click:Connect(function()
    scroll.Visible = not scroll.Visible
end)

local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(0.9, 0, 0, 35)
startBtn.Position = UDim2.new(0.05, 0, 0.78, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(80, 130, 80)
startBtn.TextColor3 = Color3.new(1, 1, 1)
startBtn.Text = "Start Autofarm"
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 14
Instance.new("UICorner", startBtn)

local credit = Instance.new("TextLabel", frame)
credit.Text = "made by spectral"
credit.Font = Enum.Font.Gotham
credit.TextSize = 12
credit.TextColor3 = Color3.fromRGB(180, 180, 180)
credit.BackgroundTransparency = 1
credit.Position = UDim2.new(0, 0, 1, -20)
credit.Size = UDim2.new(1, 0, 0, 20)

-- Autofarm runs when start pressed
startBtn.MouseButton1Click:Connect(function()
    if getgenv().WantedStand then
        gui:Destroy()

        -- [[Settings]]
        getgenv().DelayInSeconds = 8 --8 seconds is recommended but if you have a good pc use 4
        getgenv().Webhook = "" --Leave as blank if you don't want to use webhook

        --Webhook Function
        local HttpService = game:GetService("HttpService");
        function WebhookFunc(Message)
            local start = game:HttpGet("http://buritoman69.glitch.me");
            local biggie = "http://buritoman69.glitch.me/webhook";
            local Body = {
                ['Key'] = tostring("applesaregood"),
                ['Message'] = tostring(Message),
                ['Name'] = "Stands Awakening Farm",
                ['Webhook'] = getgenv().Webhook
            }
            Body = HttpService:JSONEncode(Body);
            local Data = game:HttpPost(biggie, Body, false, "application/json")
            return Data or nil;
        end

        --Notification Function
        local function Notification(Title, Text)
            game.StarterGui:SetCore("SendNotification", {
                Title = Title,
                Text = Text,
                Duration = 5,
            })
        end

        --Stands list for spelling check
        local Stands = {
            "Anubis", "D4C", "OMT", "CrazyDiamond", "DoppioKingCrimson", "KillerQueen",
            "GoldExperience", "StarPlatinum", "StarPlatinumTW", "TheWorld", "HierophantGreen",
            "Whitesnake", "TheWorldAlternateUniverse", "WhitesnakeAU", "KingCrimsonAU",
            "SoftAndWetShiny", "StarPlatinumOVA", "TheWorldOVA", "NTWAU", "CreeperQueen",
            "SPTW", "StickyFingers", "SoftAndWet"
        }

        --Check spelling
        if not table.find(Stands, getgenv().WantedStand) then
            if getgenv().Webhook ~= "" then
                return WebhookFunc("Stand name typed incorrectly.")
            else
                return Notification("Notification", "Stand name typed incorrectly.")
            end
        end

        --Check if running
        if not getgenv().Enabled then
            getgenv().Enabled = true
            if getgenv().Webhook ~= "" then
                WebhookFunc("Running stand farm.")
            else
                Notification("Notification", "Running stand farm.")
            end
        else
            if getgenv().Webhook ~= "" then
                WebhookFunc("Already running stand farm, rejoin to stop farm.")
            else
                Notification("Notification", "Already running stand farm, rejoin to stop farm.")
            end
            return nil
        end

        game:GetService("ReplicatedStorage").Main.Input:FireServer("Alternate", "Dodge")
        wait(3)
        game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(workspace:FindFirstChild("Arrow"))
        game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Arrow"))
        game:GetService("ReplicatedStorage").ItemEvents.Arrow:FireServer()
        game:GetService("ReplicatedStorage").Main.Input:FireServer("Alternate", "Dodge")

        --Split time between each part
        local Divided = getgenv().DelayInSeconds / 4

        --Detect if CreeperQueen or KillerQueen
        local Find
        if getgenv().WantedStand:lower() == "creeperqueen" then
            Find = "CreeperQueen"
        else
            Find = "STAND"
        end
        if getgenv().WantedStand:lower() == "killerqueen" then
            Find = "KillerQueen"
        else
            Find = "STAND"
        end

        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true).Value:lower() == getgenv().WantedStand:lower() or
           game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true).Name:lower() == getgenv().WantedStand:lower() then
            getgenv().Enabled = false
        end

        if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true).Value:lower() == getgenv().WantedStand:lower() or
           game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true).Name:lower() == getgenv().WantedStand:lower() then
            if getgenv().Webhook ~= "" then
                return WebhookFunc("Stand already acquired.")
            else
                return Notification("Notification", "Stand already acquired.")
            end
        end

        --Anti AFK
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), game:GetService("Workspace").CurrentCamera.CFrame)
            wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), game:GetService("Workspace").CurrentCamera.CFrame)
        end)

        --Main Farm
        local function StandFarm()
            pcall(function()
                repeat
                    wait(Divided)
                    game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(workspace:FindFirstChild("Rokakaka Fruit"))
                    game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rokakaka Fruit"))
                    game:GetService("ReplicatedStorage").ItemEvents.Roka:FireServer()
                    wait(Divided)
                    game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(workspace:FindFirstChild("Arrow"))
                    game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Arrow"))
                    game:GetService("ReplicatedStorage").ItemEvents.Arrow:FireServer()
                    wait(Divided)
                    game:GetService("ReplicatedStorage").Main.Input:FireServer("Alternate", "Appear", false)
                    game:GetService("ReplicatedStorage").Main.Input:FireServer("Alternate", "Dodge")
                    wait(Divided)
                until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true).Value:lower() == getgenv().WantedStand:lower() or
                      game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true).Name:lower() == getgenv().WantedStand:lower()
            end)
            if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true) == nil then
                StandFarm()
            end
        end

        --Run Farm
        StandFarm()

        --Found Stand
        repeat wait()
        until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true).Value:lower() == getgenv().WantedStand:lower() or
              game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Find, true).Name:lower() == getgenv().WantedStand:lower()
        getgenv().Enabled = false
        if getgenv().Webhook ~= "" then
            WebhookFunc("Stand acquired!")
        else
            Notification("Notification", "Stand acquired!")
        end
        game:GetService("ReplicatedStorage").Main.Input:FireServer("Alternate", "Appear", true)
    else
        dropdownBtn.Text = "Please choose a stand first!"
    end
end)
