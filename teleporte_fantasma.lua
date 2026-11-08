-- // TELEPORTE FANTASMA
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerList = {}
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 320); Main.Position = UDim2.new(0.1, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)
local TopBar = Instance.new("Frame", Main); TopBar.Size = UDim2.new(1,0,0,40); TopBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
local Close = Instance.new("TextButton", TopBar); Close.Size = UDim2.new(0,40,1,0); Close.Position = UDim2.new(1,-40,0,0); Close.Text = "X"; Close.BackgroundColor3 = Color3.fromRGB(150,50,50)
local Scroll = Instance.new("ScrollingFrame", Main); Scroll.Size = UDim2.new(1,0,1,-40); Scroll.Position = UDim2.new(0,0,0,40)
local Layout = Instance.new("UIListLayout", Scroll)

local function refresh()
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local btn = Instance.new("TextButton", Scroll)
            btn.Size = UDim2.new(1,0,0,40); btn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            btn.BackgroundColor3 = Color3.fromRGB(40,40,40); btn.TextColor3 = Color3.new(1,1,1)
            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character:MoveTo(p.Character.HumanoidRootPart.Position)
                end
            end)
        end
    end
    task.wait()
    Scroll.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y)
end
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
refresh()
Players.PlayerAdded:Connect(refresh)
Players.PlayerRemoving:Connect(refresh)
