-- // WALL JUMPER + GRAVIDADE
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local cfg = { wall = false, grav = false, vel = 50 }
local gui = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 200, 0, 160); main.Position = UDim2.new(0.5, -100, 0.5, -80)
main.BackgroundColor3 = Color3.fromRGB(0,0,0); main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", main).Color = Color3.fromRGB(0,255,200); Instance.new("UIStroke", main).Thickness = 2
local t = Instance.new("TextLabel", main); t.Text = "WALL JUMPER"; t.Size = UDim2.new(1,0,0,25); t.BackgroundTransparency = 1; t.TextColor3 = Color3.fromRGB(0,255,200); t.Font = "GothamBold"
local b1 = Instance.new("TextButton", main); b1.Size = UDim2.new(1,-10,0,35); b1.Position = UDim2.new(0,5,0,35); b1.BackgroundColor3 = Color3.fromRGB(200,0,0); b1.Text = "WALL: OFF"; b1.TextColor3 = Color3.new(1,1,1); b1.Font = "GothamBold"
local b2 = Instance.new("TextButton", main); b2.Size = UDim2.new(1,-10,0,35); b2.Position = UDim2.new(0,5,0,78); b2.BackgroundColor3 = Color3.fromRGB(200,0,0); b2.Text = "GRAV: OFF"; b2.TextColor3 = Color3.new(1,1,1); b2.Font = "GothamBold"
local b3 = Instance.new("TextButton", main); b3.Size = UDim2.new(1,-10,0,30); b3.Position = UDim2.new(0,5,0,120); b3.BackgroundColor3 = Color3.fromRGB(50,50,50); b3.Text = "VEL: 50"; b3.TextColor3 = Color3.new(1,1,1)
b1.MouseButton1Click:Connect(function() cfg.wall = not cfg.wall; b1.Text = "WALL: " .. (cfg.wall and "ON" or "OFF"); b1.BackgroundColor3 = cfg.wall and Color3.fromRGB(0,180,0) or Color3.fromRGB(200,0,0) end)
b2.MouseButton1Click:Connect(function() cfg.grav = not cfg.grav; b2.Text = "GRAV: " .. (cfg.grav and "ON" or "OFF"); b2.BackgroundColor3 = cfg.grav and Color3.fromRGB(0,180,0) or Color3.fromRGB(200,0,0) end)
b3.MouseButton1Click:Connect(function() cfg.vel = cfg.vel >= 200 and 10 or cfg.vel + 10; b3.Text = "VEL: " .. cfg.vel end)
RunService.Heartbeat:Connect(function()
    local char = LP.Character; local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if cfg.wall then
        local dirs = {root.CFrame.RightVector, -root.CFrame.RightVector, root.CFrame.LookVector, -root.CFrame.LookVector}
        for _, d in pairs(dirs) do
            if workspace:FindPartOnRay(Ray.new(root.Position, d * 3), char) then
                root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z); break
            end
        end
    end
    if cfg.grav then
        local bv = root:FindFirstChild("GravUp") or Instance.new("BodyVelocity", root)
        bv.Name = "GravUp"; bv.MaxForce = Vector3.new(0, math.huge, 0); bv.Velocity = Vector3.new(0, cfg.vel, 0)
    else
        local bv = root:FindFirstChild("GravUp"); if bv then bv:Destroy() end
    end
end)
