-- // SOUL MOBILE PREMIUM
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Velocidade = 2
local Ativo = false
local Alma = nil
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0,60,0,60); ToggleBtn.Position = UDim2.new(0,10,0.5,0)
ToggleBtn.Text = "SOUL"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(0,150,255); ToggleBtn.TextColor3 = Color3.new(1,1,1); ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)
ToggleBtn.MouseButton1Click:Connect(function()
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    Ativo = not Ativo
    if Ativo then
        ToggleBtn.Text = "REAL"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
        Alma = Instance.new("Part"); Alma.Size = Vector3.new(2,2,2); Alma.CFrame = hrp.CFrame
        Alma.Anchored = true; Alma.CanCollide = false; Alma.Transparency = 0.5
        Alma.Material = Enum.Material.Neon; Alma.Color = Color3.fromRGB(0,255,255); Alma.Parent = workspace
        hrp.CFrame = CFrame.new(0,-500,0); hrp.Anchored = true
        Camera.CameraSubject = Alma
    else
        ToggleBtn.Text = "SOUL"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(0,150,255)
        if Alma then hrp.Anchored = false; hrp.CFrame = Alma.CFrame; Alma:Destroy(); Alma = nil end
        Camera.CameraSubject = char:FindFirstChild("Humanoid")
    end
end)
RunService.RenderStepped:Connect(function()
    if not Ativo or not Alma then return end
    local char = LP.Character
    if not char or not char:FindFirstChild("Humanoid") then return end
    local move = char.Humanoid.MoveDirection
    if move.Magnitude > 0 then Alma.CFrame += move.Unit * Velocidade end
end)
