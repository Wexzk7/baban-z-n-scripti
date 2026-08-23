-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Toggle Değişkenleri
local Settings = {
    ESPEnabled = true,
    AutoShoot = true,
    BombJump = true,
    AutoCoin = false
}

-- 1. AÇILIP KAPANAN GÜZEL BİR MENÜ (UI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2AdvancedMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.fromOffset(40, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.Text = "MM2"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 12
ToggleButton.Parent = ScreenGui

local TB_Corner = Instance.new("UICorner")
TB_Corner.CornerRadius = UDim.new(0, 8)
TB_Corner.Parent = ToggleButton

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(220, 280)
MainFrame.Position = UDim2.new(0, 60, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "MM2 Control Panel"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

local menuVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)

local function createToggle(name, yPos, settingKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 45)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name .. ": KAPALI"
    btn.TextColor3 = Color3.fromRGB(255, 50, 50)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Settings[settingKey] = not Settings[settingKey]
        if Settings[settingKey] then
            btn.Text = name .. ": AÇIK"
            btn.TextColor3 = Color3.fromRGB(50, 255, 50)
        else
            btn.Text = name .. ": KAPALI"
            btn.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    end)
end

createToggle("ESP (Chams)", 50, "ESPEnabled")
createToggle("Auto Shoot", 105, "AutoShoot")
createToggle("Bomb Jump", 160, "BombJump")
createToggle("Auto Coin Farm", 215, "AutoCoin")

-- Başlangıçta ESP açık gelsin diye buton rengini güncelleyelim
-- (İstersen üstteki fonksiyonu varsayılan açık yapabilirsin ama şimdilik standart kapalı/açık)


-- 2. ROL TESPİTİ VE ESP
local function getRole(player)
    if not player.Character then return "Masum", Color3.fromRGB(50, 255, 50) end
    
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    
    local hasKnife = character:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
    local hasGun = character:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) or character:FindFirstChild("Revolver") or (backpack and backpack:FindFirstChild("Revolver"))
    
    if hasKnife then
        return "Katil", Color3.fromRGB(255, 50, 50)
    elseif hasGun then
        return "Şerif", Color3.fromRGB(50, 150, 255)
    else
        return "Masum", Color3.fromRGB(50, 255, 50)
    end
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local highlight = char:FindFirstChild("MM2_Highlight")
            
            if Settings.ESPEnabled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "MM2_Highlight"
                    highlight.Adornee = char
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = char
                end
                
                local _, color = getRole(player)
                highlight.FillColor = color
                highlight.OutlineColor = color
                highlight.FillTransparency = 0.4
                highlight.OutlineTransparency = 0
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end


-- 3. AUTO-SHOOT SİSTEMİ
local function autoShootCheck()
    if not Settings.AutoShoot then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local gun = char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")
    if gun then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local role, _ = getRole(player)
                if role == "Katil" and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = player.Character.HumanoidRootPart
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetRoot.Position)
                    pcall(function()
                        gun:Activate()
                    end)
                    break
                end
            end
        end
    end
end


-- 4. BOMBA JUMP
local function handleBombJump()
    if not Settings.BombJump then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    
    if humanoid and rootPart then
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            if humanoid:GetState() == Enum.HumanoidStateType.Jumping or rootPart.Velocity.Y > 0 then
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 75, rootPart.Velocity.Z)
                task.wait(0.15)
            end
        end
    end
end


-- 5. AUTO COIN FARM SİSTEMİ
local function handleAutoCoin()
    if not Settings.AutoCoin then return end
    
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart
    
    -- MM2 haritalarındaki coinlerin tutulduğu ana klasör veya objeleri tarar
    local coinContainer = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Coins")
    
    if coinContainer then
        for _, coin in ipairs(coinContainer:GetChildren()) do
            -- Coin model veya part ise pozisyonuna git
            local coinPart = coin:IsA("Model") and coin.PrimaryPart or (coin:IsA("BasePart") and coin)
            if coinPart then
                -- Karakteri coinin üstüne anlık taşı
                rootPart.CFrame = coinPart.CFrame
                task.wait(0.05) -- Çok hızlı yanmamak için minik bir gecikme
                break
            end
        end
    end
end


-- ANA DÖNGÜ
RunService.RenderStepped:Connect(function()
    pcall(function()
        updateESP()
        autoShootCheck()
        handleBombJump()
        handleAutoCoin()
    end)
end)
