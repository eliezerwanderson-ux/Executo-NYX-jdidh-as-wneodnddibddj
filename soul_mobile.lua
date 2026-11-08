local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// CONFIG
local Velocidade = 2

--// Estado
local EspectadorAtivo = false
local Alma = nil

--// GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- BOTÃO BOLINHA
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0,60,0,60)
ToggleBtn.Position = UDim2.new(0,10,0.5,0)
ToggleBtn.Text = "SOUL"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0,150,255)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.TextScaled = true
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)

-- FRAME CONTROLES
local ControlsFrame = Instance.new("Frame", ScreenGui)
ControlsFrame.Size = UDim2.new(0,120,0,180)
ControlsFrame.Position = UDim2.new(1,-140,0.6,0)
ControlsFrame.BackgroundTransparency = 1
ControlsFrame.Visible = false
ControlsFrame.Active = true
ControlsFrame.Draggable = false

-- FUNÇÃO BOTÃO
local function criarBotao(texto, posY)
	local btn = Instance.new("TextButton", ControlsFrame)
	btn.Size = UDim2.new(1,0,0,40)
	btn.Position = UDim2.new(0,0,0,posY)
	btn.Text = texto
	btn.BackgroundColor3 = Color3.fromRGB(0,170,255)
	btn.TextScaled = true
	btn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
	return btn
end

-- BOTÕES
local UpBtn = criarBotao("⬆", 0)
local DownBtn = criarBotao("⬇", 45)
local SpeedUp = criarBotao("+", 90)
local SpeedDown = criarBotao("-", 135)

-- BOTÃO EDIT
local EditBtn = Instance.new("TextButton", ScreenGui)
EditBtn.Size = UDim2.new(0,60,0,40)
EditBtn.Position = UDim2.new(1,-70,0.5,0)
EditBtn.Text = "EDIT"
EditBtn.BackgroundColor3 = Color3.fromRGB(255,170,0)

local editMode = false

EditBtn.MouseButton1Click:Connect(function()
	editMode = not editMode
	ControlsFrame.Draggable = editMode
	
	if editMode then
		EditBtn.Text = "LOCK"
	else
		EditBtn.Text = "EDIT"
	end
end)

-- CONTROLE SUBIR/DESCER
local Subir = false
local Descer = false

UpBtn.MouseButton1Down:Connect(function() Subir = true end)
UpBtn.MouseButton1Up:Connect(function() Subir = false end)

DownBtn.MouseButton1Down:Connect(function() Descer = true end)
DownBtn.MouseButton1Up:Connect(function() Descer = false end)

-- VELOCIDADE
SpeedUp.MouseButton1Click:Connect(function()
	Velocidade += 0.5
end)

SpeedDown.MouseButton1Click:Connect(function()
	Velocidade = math.max(0.5, Velocidade - 0.5)
end)

-- TOGGLE SOUL
local function ToggleEspectador()
	local char = LP.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	
	local hrp = char.HumanoidRootPart
	local hum = char:FindFirstChild("Humanoid")

	EspectadorAtivo = not EspectadorAtivo

	if EspectadorAtivo then
		ToggleBtn.Text = "REAL"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
		ControlsFrame.Visible = true

		-- CRIAR ALMA
		Alma = Instance.new("Part")
		Alma.Size = Vector3.new(2,2,2)
		Alma.CFrame = hrp.CFrame
		Alma.Anchored = true
		Alma.CanCollide = false
		Alma.Transparency = 0.5
		Alma.Material = Enum.Material.Neon
		Alma.Color = Color3.fromRGB(0,255,255)
		Alma.Parent = workspace

		-- ESCONDER CORPO
		hrp.CFrame = CFrame.new(0,-500,0)
		hrp.Anchored = true

		Camera.CameraSubject = Alma
	else
		ToggleBtn.Text = "SOUL"
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(0,150,255)
		ControlsFrame.Visible = false

		if Alma then
			hrp.Anchored = false
			hrp.CFrame = Alma.CFrame
			Alma:Destroy()
			Alma = nil
		end

		if hum then
			Camera.CameraSubject = hum
		end
	end
end

-- MOVIMENTO (MOBILE + PC)
RunService.RenderStepped:Connect(function()
	if not EspectadorAtivo or not Alma then return end
	
	local char = LP.Character
	if not char or not char:FindFirstChild("Humanoid") then return end
	
	local hum = char.Humanoid
	local camCF = Camera.CFrame
	
	local move = hum.MoveDirection

	if Subir then
		move += camCF.UpVector
	end
	
	if Descer then
		move -= camCF.UpVector
	end

	if move.Magnitude > 0 then
		Alma.CFrame += move.Unit * Velocidade
	end
end)

-- SEGURANÇA
LP.CharacterAdded:Connect(function()
	EspectadorAtivo = false
	if Alma then
		Alma:Destroy()
		Alma = nil
	end
end)

-- CLICK
ToggleBtn.MouseButton1Click:Connect(ToggleEspectador)

print("SOUL MOBILE PREMIUM ATIVO")
