local kavoUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local window = kavoUi.CreateLib("Spectral's GUI", "DarkTheme")

local Tab1 = window:NewTab("Stands Awakening")
local Tab1Section = Tab1:NewSection("Main")
local Tab2 = window:NewTab("Mr. Incredible")
local Tab2Section = Tab2:NewSection("Boss Tools")
local Tab3 = window:NewTab("Local Player")
local Tab3Section = Tab3:NewSection("Admin Scripts")
local Tab4 = window:NewTab("Credits")
local Tab4Section = Tab4:NewSection("Discord: rtwoh")

Tab1Section:NewButton("BeboScript", "Gives You an OP gui", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"))()
end)

Tab2Section:NewButton("Teleport to Boss Lobby", "TP to the Boss Lobby (No keys required)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vqnxlr/fnas/refs/heads/main/tptoboss.lua", true))()
end)

Tab2Section:NewButton("No Sword Cooldown", "No sword animation cooldown (Use with No Boss Attacks!)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/itsyouranya/free/main/Anya%20Stands%20Awakening%20Helper.lua", true))()
end)

Tab2Section:NewButton("No Boss Attacks", "Removes the boss attacks. (Some still works, Always hit the boss from its edges!) ", function()
    getgenv().WaitTime = 420
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sunexn/standsawakening/main/uncanny.lua", true))() -- open source
end)

Tab3Section:NewButton("Infinite Jump", "Allows you to jump without limiting", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vqnxlr/fnas/refs/heads/main/infj.lua", true))()
end)

Tab3Section:NewButton("Full Bright", "Removes vision blockers", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vqnxlr/fnas/refs/heads/main/fb.lua", true))()
end)

Tab3Section:NewButton("No Fog", "Removes the fog", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vqnxlr/fnas/refs/heads/main/nf.lua", true))()
end)
