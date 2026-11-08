-- // PUXAR PLAYERS
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local puxarAtivo = false
local gui = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 65, 0, 65); btn.Position = UDim2.new(0, 100, 0, 100)
btn.BackgroundColor3 = Color3.fromRGB(200,0,0); btn.TextColor3 = Color3.new(1,1,1)
btn.Text = "PUXAR\nOFF"; btn.Font = "GothamBold"; btn.TextScaled = true
Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
btn.MouseButton1Click:Connect(function()
    puxarAtivo = not puxarAtivo
    btn.Text = "PUXAR\n" .. (puxarAtivo and "ON" or "OFF")
    btn.BackgroundColor3 = puxarAtivo and Color3.fromRGB(0,150,0) or Color3.fromRGB(200,0,0)
end)
RunService.Heartbeat:Connect(function()
    if not puxarAtivo then return end
    local char = LP.Character
    local meuRoot = char and char:FindFirstChild("HumanoidRootPart")
    if not meuRoot then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if root then
                pcall(function()
                    root.CFrame = meuRoot.CFrame * CFrame.new(0, 3, -5)
                    root.Velocity = Vector3.zero
                end)
            end
        end
    end
end)
