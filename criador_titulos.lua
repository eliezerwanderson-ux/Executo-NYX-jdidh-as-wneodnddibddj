local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local cfg = { texto = "Nyx", cor = Color3.fromRGB(255,255,255), tamanho = 18 }
local billboard = nil
local gui = Instance.new("ScreenGui", game.CoreGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 260, 0, 220); main.Position = UDim2.new(0.5, -130, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20); main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Color = Color3.fromRGB(255, 150, 0)
local title = Instance.new("TextLabel", main); title.Text = "🏷️ CRIADOR DE TÍTULOS"; title.Size = UDim2.new(1, 0, 0, 30); title.BackgroundTransparency = 1; title.TextColor3 = Color3.fromRGB(255, 150, 0); title.Font = "GothamBold"
local inp = Instance.new("TextBox", main); inp.Size = UDim2.new(1, -20, 0, 30); inp.Position = UDim2.new(0, 10, 0, 45); inp.BackgroundColor3 = Color3.fromRGB(10,10,12); inp.TextColor3 = Color3.new(1,1,1); inp.Text = "Nyx"; inp.PlaceholderText = "Digite o texto..."; inp.Font = Enum.Font.SourceSans
Instance.new("UICorner", inp).CornerRadius = UDim.new(0, 6)
local cores = {Color3.fromRGB(255,255,255), Color3.fromRGB(255,50,50), Color3.fromRGB(50,255,50), Color3.fromRGB(50,50,255), Color3.fromRGB(255,255,0), Color3.fromRGB(255,0,255)}
for i, c in ipairs(cores) do
    local cb = Instance.new("TextButton", main); cb.Size = UDim2.new(0, 36, 0, 30); cb.Position = UDim2.new(0, 10 + (i-1)*40, 0, 85); cb.BackgroundColor3 = c; cb.Text = ""
    Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 4)
    cb.MouseButton1Click:Connect(function() cfg.cor = c; if billboard then billboard:Destroy() end end)
end
local function aplicar()
    local char = LP.Character
    if not char or not char:FindFirstChild("Head") then return end
    if billboard then billboard:Destroy() end
    billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 250, 0, 40); billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true; billboard.MaxDistance = 500; billboard.Parent = char.Head
    local lbl = Instance.new("TextLabel", billboard)
    lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1
    lbl.TextColor3 = cfg.cor; lbl.Text = cfg.texto; lbl.Font = "GothamBold"; lbl.TextSize = cfg.tamanho; lbl.TextStrokeTransparency = 0.5
end
local ab = Instance.new("TextButton", main); ab.Size = UDim2.new(1,-20,0,32); ab.Position = UDim2.new(0,10,0,125); ab.BackgroundColor3 = Color3.fromRGB(255,150,0); ab.TextColor3 = Color3.new(1,1,1); ab.Text = "✅ APLICAR"; ab.Font = "GothamBold"
Instance.new("UICorner", ab).CornerRadius = UDim.new(0, 6)
ab.MouseButton1Click:Connect(function() cfg.texto = inp.Text; aplicar() end)
local tmBtn = Instance.new("TextButton", main); tmBtn.Size = UDim2.new(1,-20,0,25); tmBtn.Position = UDim2.new(0,10,0,165); tmBtn.BackgroundColor3 = Color3.fromRGB(40,40,45); tmBtn.TextColor3 = Color3.new(1,1,1); tmBtn.Text = "TAMANHO: 18 (clique)"; tmBtn.Font = "GothamBold"; tmBtn.TextSize = 11
tmBtn.MouseButton1Click:Connect(function() cfg.tamanho = (cfg.tamanho >= 48) and 8 or cfg.tamanho + 2; tmBtn.Text = "TAMANHO: " .. cfg.tamanho; aplicar() end)
