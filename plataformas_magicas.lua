-- // PLATAFORMAS MÁGICAS
local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local WS = workspace
local ativo = false
local plats = {}
local gui = Instance.new("ScreenGui", game.CoreGui)
local botao = Instance.new("TextButton", gui)
botao.Size = UDim2.new(0, 65, 0, 65); botao.Position = UDim2.new(0, 100, 0, 100)
botao.BackgroundColor3 = Color3.fromRGB(120, 0, 200); botao.TextColor3 = Color3.new(1,1,1)
botao.Text = "SUBIR\nOFF"; botao.Font = Enum.Font.GothamBold; botao.TextScaled = true
Instance.new("UICorner", botao).CornerRadius = UDim.new(1, 0)
local drag, ds, sp
botao.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true; ds = i.Position; sp = botao.Position end end)
UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - ds; botao.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function() drag = false end)
botao.MouseButton1Click:Connect(function()
    ativo = not ativo
    botao.Text = "SUBIR\n" .. (ativo and "ON" or "OFF")
    botao.BackgroundColor3 = ativo and Color3.fromRGB(180,0,255) or Color3.fromRGB(120,0,200)
end)
RunService.Heartbeat:Connect(function()
    if ativo then
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local p = Instance.new("Part")
            p.Size = Vector3.new(5, 0.5, 5); p.Anchored = true; p.CanCollide = true
            p.BrickColor = BrickColor.new("Deep purple"); p.Material = Enum.Material.Neon; p.Transparency = 0.2
            p.Position = root.Position - Vector3.new(0, 3, 0); p.Parent = WS
            table.insert(plats, p)
            while #plats > 5 do local old = table.remove(plats, 1); if old then old:Destroy() end end
        end
    end
end)
