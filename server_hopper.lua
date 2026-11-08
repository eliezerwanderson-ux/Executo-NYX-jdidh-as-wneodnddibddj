local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local PlaceId = game.PlaceId
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 250, 0, 120); Main.Position = UDim2.new(0.5, -125, 0.5, -60)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Title = Instance.new("TextLabel", Main); Title.Text = "SERVER HOPPER"; Title.Size = UDim2.new(1, 0, 0, 30); Title.TextColor3 = Color3.fromRGB(0, 150, 255); Title.BackgroundTransparency = 1; Title.Font = "GothamBold"
local HopBtn = Instance.new("TextButton", Main); HopBtn.Size = UDim2.new(1, -20, 0, 40); HopBtn.Position = UDim2.new(0, 10, 0, 50); HopBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200); HopBtn.Text = "TROCAR DE SERVIDOR"; HopBtn.TextColor3 = Color3.new(1,1,1); HopBtn.Font = "GothamBold"
Instance.new("UICorner", HopBtn).CornerRadius = UDim.new(0, 6)
HopBtn.MouseButton1Click:Connect(function()
    local success, serversData = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    if success and serversData and serversData.data then
        for _, server in ipairs(serversData.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                pcall(function() TeleportService:TeleportToPlaceInstance(PlaceId, server.id, Players.LocalPlayer) end)
                break
            end
        end
    else
        TeleportService:Teleport(PlaceId)
    end
end)
