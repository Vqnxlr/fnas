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

Tab2Section:NewButton("No Sword Cooldown", "No sword animation cooldown (Use with No Boss Attacks!)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/itsyouranya/free/main/Anya%20Stands%20Awakening%20Helper.lua", true))()
end)

Tab2Section:NewButton("No Boss Attacks", "Removes the boss attacks. (Some still works, Always hit the boss from its edges!) ", function()
    getgenv().WaitTime = 420
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sunexn/standsawakening/main/uncanny.lua", true))() -- open source
end)

Tab3Section:NewButton("Infinite Yield", "Tip: Use Inf Jump to pass the boss obby", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source", true))()
end)
