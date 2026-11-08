local Config = { ModoMira = "OFF", HitboxAtiva = true, ESP = true, Predict = 0.12, EliteSmooth = 1.05, ForcaManual = 2.5, HeadSize = 12 }
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 280); Main.Position = UDim2.new(0.5, -190, 0.4, -140)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)
local Grid = Instance.new("Frame", Main); Grid.Position = UDim2.new(0, 10, 0, 50); Grid.Size = UDim2.new(1, -20, 1, -60); Grid.BackgroundTransparency = 1
local Layout = Instance.new("UIGridLayout", Grid); Layout.CellSize = UDim2.new(0, 170, 0, 45); Layout.CellPadding = UDim2.new(0, 10, 0, 10)
local function NewBtn(text, color)
    local b = Instance.new("TextButton", Grid); b.Text = text; b.BackgroundColor3 = color; b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamBold"; Instance.new("UICorner", b); return b
end
local bE = NewBtn("MIRA: ELITE", Color3.fromRGB(60,0,150))
local bH = NewBtn("HITBOX: ON", Color3.fromRGB(180,0,0))
local bEs = NewBtn("ESP: ON", Color3.fromRGB(0,100,200))
bE.MouseButton1Click:Connect(function() Config.ModoMira = (Config.ModoMira == "OFF") and "ELITE" or "OFF"; bE.Text = "MIRA: " .. Config.ModoMira end)
bH.MouseButton1Click:Connect(function() Config.HitboxAtiva = not Config.HitboxAtiva; bH.Text = Config.HitboxAtiva and "HITBOX: ON" or "HITBOX: OFF" end)
bEs.MouseButton1Click:Connect(function() Config.ESP = not Config.ESP end)
RunService.RenderStepped:Connect(function()
    local alvo = nil; local menorDist = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local head = p.Character.Head
            local hl = p.Character:FindFirstChild("SombraESP") or Instance.new("Highlight", p.Character)
            hl.Name = "SombraESP"; hl.Enabled = Config.ESP; hl.FillColor = Color3.fromRGB(0,120,255)
            local vHead = head:FindFirstChild("VisualHead")
            if Config.HitboxAtiva then
                if not vHead then
                    vHead = Instance.new("Part", head); vHead.Name = "VisualHead"; vHead.Shape = "Ball"
                    vHead.CanCollide = false; vHead.Transparency = 0.8; vHead.Color = Color3.new(1,0,0); vHead.Material = "Neon"
                    local w = Instance.new("Weld", vHead); w.Part0 = vHead; w.Part1 = head
                end
                vHead.Size = Vector3.new(Config.HeadSize, Config.HeadSize, Config.HeadSize)
            elseif vHead then vHead:Destroy() end
            local _, vis = Camera:WorldToViewportPoint(head.Position)
            if vis then
                local d = (head.Position - Camera.CFrame.Position).Magnitude
                if d < menorDist then menorDist = d; alvo = head end
            end
        end
    end
    local clicando = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UIS:IsMouseButtonPressed(Enum.UserInputType.Touch)
    if Config.ModoMira == "ELITE" and clicando and alvo then
        local pPos = alvo.Position + Vector3.new(0, 0.2, 0) + (alvo.Parent.HumanoidRootPart.Velocity * Config.Predict)
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, pPos), 1/Config.EliteSmooth)
    end
end)
