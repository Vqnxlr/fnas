wait(1)
game.UserInputService.InputBegan:Connect(function(ip, gpe)
    if not gpe then
        if ip.KeyCode == Enum.KeyCode.F then
        for i = 1,50 do
            local args = {
             [1] = "Alternate",
             [2] = "EmeraldProjectile2",
             [3] = false,
            [4] = game.Players.LocalPlayer:GetMouse().Hit
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Main"):WaitForChild("Input"):FireServer(unpack(args))
        end
        end
    end
end)
