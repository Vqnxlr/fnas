game:GetService("Lighting").Changed:Connect(function()
    game:GetService("Lighting").Brightness = 2
    game:GetService("Lighting").ClockTime = 12
    game:GetService("Lighting").FogEnd = 100000
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
end)

local lighting = game:GetService("Lighting")
lighting.Brightness = 2
lighting.ClockTime = 12
lighting.FogEnd = 100000
lighting.GlobalShadows = false
lighting.Ambient = Color3.new(1, 1, 1)
