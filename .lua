-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Ayarlar Havuzu
local Settings = {
    ESP = true,
    RoleESP = true,
    AutoShoot = false,
    SilentAim = false,
    BombJump = false,
    AutoCoin = false,
    SpeedHack = false,
    WalkSpeed = 22,
    NoClip = false,
    InfiniteJump = false
}

-- 1. ANİMASYONLU YÜKLEME EKRANI (Açılış Kapağı)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2ProHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.fromOffset(300, 100)
IntroFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 12)
IntroCorner.Parent = IntroFrame

local IntroText = Instance.new("TextLabel")
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "MM2 Ultimate Hub Yükleniyor..."
IntroText.TextColor3 = Color3.fromRGB(0, 255, 150)
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 14
IntroText.Parent = IntroFrame

-- Yüklenme Animasyonu Efekti
task.wait(1.5)
TweenService:Create(IntroFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(0, 0), Transparency = 1}):Play()
IntroText.Visible = false
task.wait(0.5)
IntroFrame:Destroy()


-- 2. ANA KONTROL PANELİ (MENÜ)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(260, 380)
MainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "MM2 Pro Hub [v2.5]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.Parent = MainFrame

-- Küçültme/Gizleme Tuşu
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.fromOffset(40, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.2, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Text = "MENU"
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 11
ToggleButton.Parent = ScreenGui

local TB_Corner = Instance.new("UICorner")
TB_Corner.CornerRadius = UDim.new(0, 8)
TB_Corner.Parent = ToggleButton

local menuVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)

-- Özellik Kaydırma Alanı
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -50)
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 440)
Scroll.ScrollBarThickness = 4
Scroll.Parent = MainFrame

local function createToggle(name, yPos, key)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = name .. ": KAPALI"
    btn.TextColor3 = Color3.fromRGB(255, 60, 60)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.Parent = Scroll
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        if Settings[key] then
            btn.Text = name .. ": AÇIK"
            btn.TextColor3 = Color3.fromRGB(50, 255, 100)
        else
            btn.Text = name .. ": KAPALI"
            btn.TextColor3 = Color3.fromRGB(255, 60, 60)
        end
    end)
end

-- Butonların Yerleşimi
createToggle("Highlight ESP", 0, "ESP")
createToggle("Role Text ESP", 43, "RoleESP")
createToggle("Auto Shoot (Katil Avı)", 86, "AutoShoot")
createToggle("Silent Aim", 129, "SilentAim")
createToggle("Bomb / Double Jump", 172, "BombJump")
createToggle("Auto Coin Farm", 215, "AutoCoin")
createToggle("Speed Hack (Hız)", 258, "SpeedHack")
createToggle("NoClip (Duvar Geçme)", 301, "NoClip")
createToggle("Infinite Jump", 344, "InfiniteJump")


-- 3. ROL TESPİT MOTORU
local function getRole(player)
    if not player.Character then return "Masum", Color3.fromRGB(50, 255, 100) end
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    
    local hasKnife = char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
    local hasGun = char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) or char:FindFirstChild("Revolver") or (backpack and backpack:FindFirstChild("Revolver"))
    
    if hasKnife then
        return "Katil", Color3.fromRGB(255, 50, 50)
    elseif hasGun then
        return "Şerif", Color3.fromRGB(50, 150, 255)
    else
        return "Masum", Color3.fromRGB(50, 255, 255)
    end
end


-- 4. GÖRSEL ÖZELLİKLER (ESP)
local function runVisuals()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local head = char:FindFirstChild("Head")
            
            -- Çerçeve (Highlight)
            local hl = char:FindFirstChild("Hub_HL")
            if Settings.ESP then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "Hub_HL"
                    hl.Adornee = char
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = char
                end
                local _, col = getRole(player)
                hl.FillColor = col
                hl.OutlineColor = col
                hl.FillTransparency = 0.5
            else
                if hl then hl:Destroy() end
            end
            
            -- Rol Yazısı
            local tag = head and head:FindFirstChild("Hub_Tag")
            if Settings.RoleESP and head then
                if not tag then
                    tag = Instance.new("BillboardGui")
                    tag.Name = "Hub_Tag"
                    tag.Size = UDim2.fromOffset(90, 25)
                    tag.StudsOffset = Vector3.new(0, 2.3, 0)
                    tag.AlwaysOnTop = true
                    
                    local txt = Instance.new("TextLabel")
                    txt.Name = "T"
                    txt.Size = UDim2.fromScale(1, 1)
                    txt.BackgroundTransparency = 1
                    txt.TextScaled = true
                    txt.Font = Enum.Font.GothamBold
                    txt.Parent = tag
                    tag.Parent = head
                end
                local role, col = getRole(player)
                local t = tag:FindFirstChild("T")
                if t then
                    t.Text = role
                    t.TextColor3 = col
                end
            else
                if tag then tag:Destroy() end
            end
        end
    end
end


-- 5. COMBAT (AUTO-SHOOT & SILENT AIM)
local function runCombat()
    local char = LocalPlayer.Character
    if not char then return end
    local gun = char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")
    
    if gun and Settings.AutoShoot then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local role, _ = getRole(player)
                if role == "Katil" and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local root = player.Character.HumanoidRootPart
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, root.Position)
                    pcall(function() gun:Activate() end)
                    break
                end
            end
        end
    end
end


-- 6. HAREKET (BOMB JUMP, SPEED, NOCLIP)
local function runMovement()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    
    if humanoid and rootPart then
        -- Bomb / Double Jump
        if Settings.BombJump and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            if humanoid:GetState() == Enum.HumanoidStateType.Jumping or rootPart.Velocity.Y > 0 then
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 80, rootPart.Velocity.Z)
                task.wait(0.15)
            end
        end
        
        -- Speed Hack
        if Settings.SpeedHack then
            humanoid.WalkSpeed = Settings.WalkSpeed
        end
    end
end


-- 7. FARM (AUTO COIN)
local function runFarm()
    if not Settings.AutoCoin then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    
    local coins = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Coins")
    if coins then
        for _, c in ipairs(coins:GetChildren()) do
            local cp = c:IsA("Model") and c.PrimaryPart or (c:IsA("BasePart") and c)
            if cp then
                root.CFrame = cp.CFrame
                task.wait(0.04)
                break
            end
        end
    end
end


-- NoClip ve Infinite Jump
RunService.Stepped:Connect(function()
    pcall(function()
        if Settings.NoClip and LocalPlayer.Character then
            for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end)
end)

UserInputService.JumpRequest:Connect(function()
    if Settings.InfiniteJump and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)


-- ANA DÖNGÜ
RunService.RenderStepped:Connect(function()
    pcall(function()
        runVisuals()
        runCombat()
        runMovement()
        runFarm()
    end)
end)
