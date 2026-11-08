-- // ELITE HUB V38 ULTRA (MIRA)
local Config = { ModoMira = "OFF", HitboxAtiva = true, HeadSize = 10, Predict = 0.12, EliteSmooth = 1.5, ForcaManual = 0.5 }
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 200); Main.Position = UDim2.new(0.5, -180, 0.5, -100)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)
local bE = Instance.new("TextButton", Main); bE.Size = UDim2.new(0,165,0,45); bE.Position = UDim2.new(0.05,0,0.3,0); bE.Text = "MIRA: ELITE"; bE.BackgroundColor3 = Color3.fromRGB(40,40,40); bE.TextColor3 = Color3.new(1,1,1); bE.Font = "GothamBold"
local bO = Instance.new("TextButton", Main); bO.Size = UDim2.new(0,165,0,45); bO.Position = UDim2.new(0.52,0,0.3,0); bO.Text = "MIRA: OFF"; bO.BackgroundColor3 = Color3.fromRGB(150,0,0); bO.TextColor3 = Color3.new(1,1,1); bO.Font = "GothamBold"
local bH = Instance.new("TextButton", Main); bH.Size = UDim2.new(0,165,0,45); bH.Position = UDim2.new(0.05,0,0.65,0); bH.Text = "HITBOX: ON"; bH.BackgroundColor3 = Color3.fromRGB(180,0,0); bH.TextColor3 = Color3.new(1,1,1); bH.Font = "GothamBold"
bE.MouseButton1Click:Connect(function() Config.ModoMira = "ELITE" end)
bO.MouseButton1Click:Connect(function() Config.ModoMira = "OFF" end)
bH.MouseButton1Click:Connect(function() Config.HitboxAtiva = not Config.HitboxAtiva; bH.Text = "HITBOX: " .. (Config.HitboxAtiva and "ON" or "OFF") end)
RunService.RenderStepped:Connect(function()
    local alvo = nil; local menorDist = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local head = p.Character.Head
            if Config.HitboxAtiva then
                local vh = head:FindFirstChild("VisualHead") or Instance.new("Part", head)
                if vh.Name ~= "VisualHead" then
                    vh.Name = "VisualHead"; vh.Shape = "Ball"; vh.CanCollide = false; vh.Transparency = 0.8
                    vh.Color = Color3.new(1,0,0); vh.Material = "Neon"
                    local w = Instance.new("Weld", vh); w.Part0 = vh; w.Part1 = head
                end
                vh.Size = Vector3.new(Config.HeadSize, Config.HeadSize, Config.HeadSize)
            end
            local _, vis = Camera:WorldToViewportPoint(head.Position)
            if vis then
                local d = (head.Position - Camera.CFrame.Position).Magnitude
                if d < menorDist then menorDist = d; alvo = head end
            end
        end
    end
    local clicando = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UIS:IsMouseButtonPressed(Enum.UserInputType.Touch)
    if Config.ModoMira == "ELITE" and clicando and alvo then
        local pPos = alvo.Position + Vector3.new(0, 0.25, 0) + (alvo.Parent.HumanoidRootPart.Velocity * Config.Predict)
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, pPos), 1/Config.EliteSmooth)
    end
end)
