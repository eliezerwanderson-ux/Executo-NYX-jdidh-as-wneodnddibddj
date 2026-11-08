-- ADMIN HAMMER V2 (DELETA JOGADORES E MAPA)
local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

local function CriarMarteloAdm()
    local Tool = Instance.new("Tool")
    Tool.Name = "🔨 ADMIN HAMMER (MAP DELETE)"
    Tool.RequiresHandle = true
    Tool.Parent = LP.Backpack

    -- VISUAL DO MARTELO
    local Handle = Instance.new("Part")
    Handle.Name = "Handle"
    Handle.Size = Vector3.new(0.5, 4, 0.5)
    Handle.BrickColor = BrickColor.new("Dark stone grey") -- Cor de ferro
    Handle.Parent = Tool

    local Head = Instance.new("Part")
    Head.Name = "Head"
    Head.Size = Vector3.new(2.5, 1.5, 1.5)
    Head.BrickColor = BrickColor.new("Really black") -- Cabeça preta imponente
    Head.Material = Enum.Material.Neon -- Brilha um pouco para parecer especial
    Head.Parent = Tool
    
    local Weld = Instance.new("Weld")
    Weld.Part0 = Handle
    Weld.Part1 = Head
    Weld.C0 = CFrame.new(0, 2, 0)
    Weld.Parent = Head

    -- FUNÇÃO DE DELETAR TUDO
    Tool.Activated:Connect(function()
        -- Animação de Batida
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://204328711"
            hum:LoadAnimation(anim):Play()
        end

        -- Detectar o que foi tocado no Mobile
        local mousePos = UIS:GetMouseLocation()
        local ray = workspace.CurrentCamera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local target = workspace:FindPartOnRay(Ray.new(ray.Origin, ray.Direction * 200))

        if target and target.Parent then
            -- 1. Efeito de "Explosão de Admin"
            local exp = Instance.new("Explosion")
            exp.Position = target.Position
            exp.BlastRadius = 0 
            exp.Visible = true
            exp.Parent = workspace

            -- 2. Identificar se é Jogador ou Mapa
            local char = target.Parent:FindFirstChildOfClass("Humanoid") and target.Parent
            
            if char and char.Name ~= LP.Name then
                -- Se for Jogador: Manda mensagem e deleta
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("BANIDO! 🔨", "All")
                char:BreakJoints()
                char:Destroy()
            else
                -- Se for o Mapa ou Objeto: Deleta na hora
                print("Objeto do mapa deletado: " .. target.Name)
                target:Destroy()
            end
        end
    end)
end

CriarMarteloAdm()
LP.CharacterAdded:Connect(CriarMarteloAdm)

print("🔨 MARTELO DE ADM CARREGADO! Cuidado, ele deleta o mapa inteiro se você clicar nele.")
