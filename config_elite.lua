-- // CONFIGURAÇÕES ELITE V015
local Elite_Config = { Speed = 16, Jump = 50, InfJump = false, Noclip = false }
local LP = game.Players.LocalPlayer
local RS = game:GetService("RunService")
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 240); Main.Position = UDim2.new(0.5, -200, 0.5, -120)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Title = Instance.new("TextLabel", Main); Title.Text = "ELITE V015"; Title.Size = UDim2.new(1, 0, 0, 40); Title.TextColor3 = Color3.new(1,1,1); Title.BackgroundTransparency = 1; Title.Font = "GothamBold"
local function C(txt, cor, pos)
    local b = Instance.new("TextButton", Main); b.Size = UDim2.new(0, 180, 0, 45); b.Position = pos; b.BackgroundColor3 = cor; b.Text = txt; b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamBold"; b.TextSize = 12; Instance.new("UICorner", b); return b
end
local JB = C("JUMP: 50", Color3.fromRGB(80,0,150), UDim2.new(0.05,0,0.2,0))
local IB = C("PULO INF: OFF", Color3.fromRGB(0,50,200), UDim2.new(0.05,0,0.4,0))
local SB = C("SPEED: 16", Color3.fromRGB(40,40,40), UDim2.new(0.05,0,0.6,0))
local NB = C("NOCLIP: OFF", Color3.fromRGB(0,100,100), UDim2.new(0.52,0,0.2,0))
local DB = C("DESLIGAR", Color3.fromRGB(180,0,0), UDim2.new(0.52,0,0.4,0))
JB.MouseButton1Click:Connect(function() Elite_Config.Jump = (Elite_Config.Jump >= 200) and 50 or Elite_Config.Jump + 25; JB.Text = "JUMP: " .. Elite_Config.Jump end)
SB.MouseButton1Click:Connect(function() Elite_Config.Speed = (Elite_Config.Speed >= 200) and 16 or Elite_Config.Speed + 20; SB.Text = "SPEED: " .. Elite_Config.Speed end)
NB.MouseButton1Click:Connect(function() Elite_Config.Noclip = not Elite_Config.Noclip; NB.Text = "NOCLIP: " .. (Elite_Config.Noclip and "ON" or "OFF") end)
IB.MouseButton1Click:Connect(function() Elite_Config.InfJump = not Elite_Config.InfJump; IB.Text = "PULO INF: " .. (Elite_Config.InfJump and "ON" or "OFF") end)
RS.Stepped:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = Elite_Config.Speed
        LP.Character.Humanoid.JumpPower = Elite_Config.Jump
        if Elite_Config.Noclip then for _, v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    end
end)
game:GetService("UserInputService").JumpRequest:Connect(function() if Elite_Config.InfJump then LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)
DB.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
