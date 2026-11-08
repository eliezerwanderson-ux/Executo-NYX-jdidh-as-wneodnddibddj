-- // HITBOX AZUL
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ativo = false
local gui = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 65, 0, 65); btn.Position = UDim2.new(0, 100, 0, 100)
btn.BackgroundColor3 = Color3.fromRGB(200,0,0); btn.TextColor3 = Color3.new(1,1,1)
btn.Text = "HITBOX\nOFF"; btn.Font = "GothamBold"; btn.TextScaled = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
btn.MouseButton1Click:Connect(function()
    ativo = not ativo
    btn.Text = "HITBOX\n" .. (ativo and "ON" or "OFF")
    btn.BackgroundColor3 = ativo and Color3.fromRGB(0,150,0) or Color3.fromRGB(200,0,0)
end)
RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local hb = root:FindFirstChild("HitboxAzul")
                if ativo then
                    if not hb then
                        hb = Instance.new("Part"); hb.Name = "HitboxAzul"; hb.Size = Vector3.new(12,12,12)
                        hb.Shape = Enum.PartType.Block; hb.Color = Color3.fromRGB(0,100,255)
                        hb.Material = Enum.Material.Neon; hb.Transparency = 0.5; hb.CanCollide = false; hb.Massless = true
                        hb.Parent = root
                        local w = Instance.new("Weld", hb); w.Part0 = root; w.Part1 = hb
                    end
                else
                    if hb then hb:Destroy() end
                end
            end
        end
    end
end)
