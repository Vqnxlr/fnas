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

-- Run the scan immediately on execution
removeBanRemotes()

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

-- Send a notification to the player that Anti-Ban is active
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "Anti-Ban";
    Text = "Anti-Ban is activated!";
    Duration = 5;
})
