-- // MESTRE DA VISÃO V2 (R6 + R15)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local cfg = { esp = true, hp = true }
local gui = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 240, 0, 140); main.Position = UDim2.new(0.5, -120, 0.4, -70)
main.BackgroundColor3 = Color3.fromRGB(0,0,0); main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Color = Color3.fromRGB(0,255,255)
local T = Instance.new("TextLabel", main); T.Text = "MESTRE DA VISÃO"; T.Size = UDim2.new(1,-35,0,30); T.Position = UDim2.new(0,10,0,5); T.BackgroundTransparency = 1; T.TextColor3 = Color3.new(1,1,1); T.Font = "GothamBold"; T.TextXAlignment = Enum.TextXAlignment.Left
local eb = Instance.new("TextButton", main); eb.Size = UDim2.new(1,-20,0,32); eb.Position = UDim2.new(0,10,0,45); eb.BackgroundColor3 = Color3.fromRGB(0,150,0); eb.Text = "ESP: ON"; eb.TextColor3 = Color3.new(1,1,1); eb.Font = "GothamBold"
local hb = Instance.new("TextButton", main); hb.Size = UDim2.new(1,-20,0,32); hb.Position = UDim2.new(0,10,0,85); hb.BackgroundColor3 = Color3.fromRGB(0,150,0); hb.Text = "HP: ON"; hb.TextColor3 = Color3.new(1,1,1); hb.Font = "GothamBold"
eb.MouseButton1Click:Connect(function() cfg.esp = not cfg.esp; eb.Text = "ESP: " .. (cfg.esp and "ON" or "OFF"); eb.BackgroundColor3 = cfg.esp and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0) end)
hb.MouseButton1Click:Connect(function() cfg.hp = not cfg.hp; hb.Text = "HP: " .. (cfg.hp and "ON" or "OFF"); hb.BackgroundColor3 = cfg.hp and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0) end)
local conns15 = {{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
local conns6 = {{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}}
local lines = {}
for i = 1, 300 do local l = Drawing.new("Line"); l.Visible = false; l.Color = Color3.fromRGB(255,0,0); l.Thickness = 1.5; table.insert(lines, l) end
RunService.RenderStepped:Connect(function()
    local idx = 1
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local char = p.Character
            local conns = char:FindFirstChild("UpperTorso") and conns15 or (char:FindFirstChild("Torso") and conns6)
            if cfg.esp and conns then
                for _, c in ipairs(conns) do
                    local a = char:FindFirstChild(c[1]); local b = char:FindFirstChild(c[2])
                    if a and b and idx <= #lines then
                        local pa, va = Camera:WorldToViewportPoint(a.Position)
                        local pb, vb = Camera:WorldToViewportPoint(b.Position)
                        local l = lines[idx]
                        if va and vb then l.Visible = true; l.From = Vector2.new(pa.X, pa.Y); l.To = Vector2.new(pb.X, pb.Y)
                        else l.Visible = false end
                        idx = idx + 1
                    end
                end
            end
        end
    end
    for i = idx, #lines do lines[i].Visible = false end
end)
