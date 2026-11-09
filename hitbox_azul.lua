local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local puxarAtivo = false

local gui = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 200, 0, 120); main.Position = UDim2.new(0.5, -100, 0.5, -60)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Color = Color3.fromRGB(255, 50, 50)

local t = Instance.new("TextLabel", main); t.Text = "PUXAR PLAYERS"; t.Size = UDim2.new(1, -30, 0, 30); t.Position = UDim2.new(0, 10, 0, 5); t.BackgroundTransparency = 1; t.TextColor3 = Color3.fromRGB(255, 50, 50); t.Font = "GothamBold"; t.TextXAlignment = Enum.TextXAlignment.Left

local x = Instance.new("TextButton", main); x.Size = UDim2.new(0, 24, 0, 24); x.Position = UDim2.new(1, -28, 0, 5); x.BackgroundColor3 = Color3.fromRGB(200, 50, 50); x.TextColor3 = Color3.new(1,1,1); x.Text = "✕"
Instance.new("UICorner", x).CornerRadius = UDim.new(1, 0)

local b = Instance.new("TextButton", main); b.Size = UDim2.new(1, -20, 0, 35); b.Position = UDim2.new(0, 10, 0, 45); b.BackgroundColor3 = Color3.fromRGB(200, 0, 0); b.TextColor3 = Color3.new(1,1,1); b.Text = "PUXAR: OFF"; b.Font = "GothamBold"
Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

local bol = Instance.new("TextButton", gui); bol.Size = UDim2.new(0, 44, 0, 44); bol.Position = UDim2.new(0, 10, 0.1, 0); bol.BackgroundColor3 = Color3.fromRGB(15, 15, 20); bol.TextColor3 = Color3.fromRGB(255, 50, 50); bol.Text = "P"; bol.Font = "GothamBold"; bol.Visible = false
Instance.new("UICorner", bol).CornerRadius = UDim.new(1, 0)

b.MouseButton1Click:Connect(function() 
    puxarAtivo = not puxarAtivo
    b.Text = "PUXAR: " .. (puxarAtivo and "ON" or "OFF")
    b.BackgroundColor3 = puxarAtivo and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(200, 0, 0)
end)

x.MouseButton1Click:Connect(function() main.Visible = false; bol.Visible = true end)
bol.MouseButton1Click:Connect(function() main.Visible = true; bol.Visible = false end)

local function drag(o)
    local d, s, p
    o.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true; s = i.Position; p = o.Position end end)
    UIS.InputChanged:Connect(function(i) if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local dl = i.Position - s; o.Position = UDim2.new(p.X.Scale, p.X.Offset + dl.X, p.Y.Scale, p.Y.Offset + dl.Y) end end)
    UIS.InputEnded:Connect(function() d = false end)
end
drag(main); drag(bol)

RunService.Heartbeat:Connect(function()
    if not puxarAtivo then return end
    local char = LP.Character
    local mR = char and char:FindFirstChild("HumanoidRootPart")
    if not mR then return end
    for _, p in pairs(Players:GetPlayers()) do 
        if p ~= LP and p.Character then 
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if r then 
                pcall(function() 
                    r.CFrame = mR.CFrame * CFrame.new(0,3,-5)
                    r.Velocity = Vector3.zero 
                end) 
            end 
        end 
    end
end)
