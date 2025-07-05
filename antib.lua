-- Anti-Kick Hook
local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then
        warn("[Anti-Kick] Kick attempt blocked.")
        return
    end
    return oldNamecall(self, ...)
end)

-- Anti-Ban Remote Remover
local function removeBanRemotes()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            if string.find(v.Name:lower(), "ban") or string.find(v.Name:lower(), "kick") then
                v:Destroy()
                warn("[Anti-Ban] Removed: " .. v.Name)
            end
        end
    end
end

-- Real-Time Remote Protection
game.DescendantAdded:Connect(function(obj)
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        if string.find(obj.Name:lower(), "ban") or string.find(obj.Name:lower(), "kick") then
            obj:Destroy()
            warn("[Anti-Ban] Removed on creation: " .. obj.Name)
        end
    end
end)

-- Disable print/warn/error (anti-debug logs)
hookfunction(print, function(...) end)
hookfunction(warn, function(...) end)
hookfunction(error, function(...) end)

-- GUI Setup
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiBanGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 200, 0, 140)
Frame.Position = UDim2.new(0.05, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "Anti-Ban Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Parent = Frame

local Button1 = Instance.new("TextButton")
Button1.Name = "ReinforceButton"
Button1.Size = UDim2.new(0.8, 0, 0.3, 0)
Button1.Position = UDim2.new(0.1, 0, 0.5, 0)
Button1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Button1.Font = Enum.Font.Gotham
Button1.Text = "🔒 Reinforce Anti-Ban"
Button1.TextColor3 = Color3.fromRGB(255, 255, 255)
Button1.TextSize = 14
Button1.Parent = Frame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = Button1

-- Button Functionality
Button1.MouseButton1Click:Connect(function()
    removeBanRemotes()
    warn("[GUI] Protections manually reinforced.")
end)
