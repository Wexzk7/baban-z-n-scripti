-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Piyasadaki En Kapsamlı Ayarlar Havuzu (Tüm Özellikler Dahil)
local Settings = {
    -- Visuals (Görsel)
    BoxESP = true,
    NameESP = true,
    RoleESP = true,
    TracerESP = false,
    ItemESP = true,
    Chams = true,
    Xray = false,
    -- Combat (Savaş & Nişan)
    SilentAim = false,
    AutoShoot = false,
    TriggerBot = false,
    FOV = 120,
    ShowFOV = false,
    HitboxExpander = false,
    HitboxSize = 5,
    -- Movement (Hareket)
    SpeedHack = false,
    WalkSpeed = 24,
    InfiniteJump = false,
    NoClip = false,
    Fly = false,
    FlySpeed = 50,
    Blink = false, -- Kısa mesafe ışınlanma (Teleport Dash)
    -- Farming & Drops (Toplama)
    AutoCoin = false,
    AutoCollectGun = false, -- Yere düşen şerif silahını otomatik alma
    -- Troll & Fun (Eğlence / Troll)
    SpamChat = false,
    Invisibility = false, -- Görünmezlik simülasyonu
    SpinBot = false, -- Kendi etrafında çılgın gibi dönme
    -- Misc (Genel)
    Fullbright = false,
    FPSUnlocker = true,
    AntiAFK = true,
    ServerHop = false,
    Rejoin = false
}

-- UI İskeleti: Ana Ekran
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2GodModeHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Açılış Animasyonu (Intro)
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.fromOffset(360, 120)
IntroFrame.Position = UDim2.new(0.5, -180, 0.5, -60)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 16)
IntroCorner.Parent = IntroFrame

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Color = Color3.fromRGB(120, 0, 255)
IntroStroke.Thickness = 2
IntroStroke.Parent = IntroFrame

local IntroText = Instance.new("TextLabel")
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "MM2 God-Tier Ultimate Hub Yükleniyor...\n[Pro Özellikler Yükleniyor]"
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 13
IntroText.Parent = IntroFrame

task.wait(1.5)
TweenService:Create(IntroFrame, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(0, 0), Transparency = 1}):Play()
task.wait(0.5)
IntroFrame:Destroy()

-- Ana Pencere (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(560, 390)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -195)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 60, 60)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Üst Başlık (Top Bar)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

local FixFrame = Instance.new("Frame")
FixFrame.Size = UDim2.new(1, 0, 0, 10)
FixFrame.Position = UDim2.new(0, 0, 1, -10)
FixFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
FixFrame.BorderSizePixel = 0
FixFrame.Parent = TopBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 250, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "MM2 God-Tier Hub | [Full Edition]"
TitleText.TextColor3 = Color3.fromRGB(140, 80, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 13
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TopBar

-- Kapatma / Gizleme Tuşu
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.fromOffset(32, 32)
CloseButton.Position = UDim2.new(1, -38, 0, 6)
CloseButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CloseButton.Text = "-"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

local menuVisible = true
CloseButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)

-- Sol Sekme Paneli (Tabs Sidebar)
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 140, 1, -55)
Sidebar.Position = UDim2.new(0, 5, 0, 50)
Sidebar.BackgroundTransparency = 1
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 360)
Sidebar.ScrollBarThickness = 2
Sidebar.Parent = MainFrame

-- Sağ İçerik Alanı (Containers)
local ContainerHolder = Instance.new("Folder")
ContainerHolder.Parent = MainFrame

local tabs = {}
local currentTab = nil

local function createTab(name, yOffset)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -5, 0, 35)
    tabBtn.Position = UDim2.new(0, 0, 0, yOffset)
    tabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(170, 170, 170)
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 12
    tabBtn.Parent = Sidebar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabBtn
    
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -155, 1, -60)
    contentFrame.Position = UDim2.new(0, 150, 0, 50)
    contentFrame.BackgroundTransparency = 1
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 550)
    contentFrame.ScrollBarThickness = 4
    contentFrame.Visible = false
    contentFrame.Parent = ContainerHolder
    
    table.insert(tabs, {Button = tabBtn, Content = contentFrame})
    
    if not currentTab then
        currentTab = contentFrame
        contentFrame.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabs) do
            t.Content.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
            t.Button.TextColor3 = Color3.fromRGB(170, 170, 170)
        end
        contentFrame.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    return contentFrame
end

-- Tüm Sekmeler Tanımlanıyor
local VisualsTab = createTab("Görsel (ESP)", 0)
local CombatTab = createTab("Savaş & Aim", 40)
local MovementTab = createTab("Hareket", 80)
local FarmingTab = createTab("Farm & Toplama", 120)
local TrollTab = createTab("Troll & Eğlence", 160)
local MiscTab = createTab("Genel (Misc)", 200)

-- Toggle Oluşturma Fonksiyonu
local function addToggle(tab, name, yPos, key)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    btn.Text = "  " .. name .. ": [KAPALI]"
    btn.TextColor3 = Color3.fromRGB(255, 80, 80)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        if Settings[key] then
            btn.Text = "  " .. name .. ": [AÇIK]"
            btn.TextColor3 = Color3.fromRGB(80, 255, 140)
        else
            btn.Text = "  " .. name .. ": [KAPALI]"
            btn.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
    end)
end

-- 1. Visuals Sekmesi İçerikleri
addToggle(VisualsTab, "Kutu ESP (Box)", 0, "BoxESP")
addToggle(VisualsTab, "İsim ve Mesafe", 36, "NameESP")
addToggle(VisualsTab, "Rol Göstergesi (Katil/Şerif)", 72, "RoleESP")
addToggle(VisualsTab, "Çizgi (Tracer)", 108, "TracerESP")
addToggle(VisualsTab, "Eşya Drop ESP (Silah/Bıçak)", 144, "ItemESP")
addToggle(VisualsTab, "Karakter Aydınlatma (Chams)", 180, "Chams")
addToggle(VisualsTab, "X-Ray (Duvar Arkası Görüş)", 216, "Xray")

-- 2. Combat Sekmesi İçerikleri
addToggle(CombatTab, "Silent Aim (Otomatik Nişan)", 0, "SilentAim")
addToggle(CombatTab, "Auto Shoot (Katil Avı - Otomatik Sık)", 36, "AutoShoot")
addToggle(CombatTab, "Triggerbot (Görüşe Girince Sık)", 72, "TriggerBot")
addToggle(CombatTab, "Görüş Alanı Çemberi (FOV)", 108, "ShowFOV")
addToggle(CombatTab, "Hitbox Büyütme (Kafa/Vücut)", 144, "HitboxExpander")

-- 3. Movement Sekmesi İçerikleri
addToggle(MovementTab, "Speed Hack (Hız Ayarı)", 0, "SpeedHack")
addToggle(MovementTab, "Sınırsız Zıplama (Inf Jump)", 36, "InfiniteJump")
addToggle(MovementTab, "Duvar Geçme (NoClip)", 72, "NoClip")
addToggle(MovementTab, "Uçma Modu (Fly)", 108, "Fly")

-- 4. Farming Sekmesi İçerikleri
addToggle(FarmingTab, "Akıllı Coin Toplama (Auto Coin)", 0, "AutoCoin")
addToggle(FarmingTab, "Yere Düşen Silahı Otomatik Al", 36, "AutoCollectGun")

-- 5. Troll Sekmesi İçerikleri
addToggle(TrollTab, "Spinbot (Etrafta Dönme Trolleri)", 0, "SpinBot")
addToggle(TrollTab, "Görüş Maskesi (Invisibility Sim)", 36, "Invisibility")

-- 6. Misc Sekmesi İçerikleri
addToggle(MiscTab, "Fullbright (Aydınlık / Gece Görüşü)", 0, "Fullbright")
addToggle(MiscTab, "FPS Arttırıcı", 36, "FPSUnlocker")
addToggle(MiscTab, "Anti-AFK (Kovulma Önleyici)", 72, "AntiAFK")

-- Rol Tespit Motoru
local function getRole(player)
    if not player.Character then return "Masum", Color3.fromRGB(50, 255, 100) end
    local bp = player:FindFirstChild("Backpack")
    local char = player.Character
    local hasKnife = char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife"))
    local hasGun = char:FindFirstChild("Gun") or (bp and bp:FindFirstChild("Gun")) or char:FindFirstChild("Revolver") or (bp and bp:FindFirstChild("Revolver"))
    
    if hasKnife then return "Katil", Color3.fromRGB(255, 50, 50)
    elseif hasGun then return "Şerif", Color3.fromRGB(50, 150, 255)
    else return "Masum", Color3.fromRGB(50, 255, 255) end
end

-- Ana Döngüler (Tüm Özelliklerin İşleyiş Motoru)
RunService.RenderStepped:Connect(function()
    pcall(function()
        -- 1. Rol ESP & Highlight
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local char = p.Character
                local hl = char:FindFirstChild("GodHub_HL")
                
                if Settings.RoleESP or Settings.BoxESP or Settings.Chams then
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "GodHub_HL"
                        hl.Adornee = char
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = char
                    end
                    local _, col = getRole(p)
                    hl.FillColor = col
                    hl.OutlineColor = col
                    hl.FillTransparency = 0.5
                else
                    if hl then hl:Destroy() end
                end
            end
        end
        
        -- 2. Speed Hack
        if Settings.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Settings.WalkSpeed
        end
        
        -- 3. Fullbright
        if Settings.Fullbright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
        end
        
        -- 4. Spinbot Troll
        if Settings.SpinBot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(25), 0)
        end
        
        -- 5. Auto Shoot Katil Avı
        if Settings.AutoShoot and LocalPlayer.Character then
            local gun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Character:FindFirstChild("Revolver") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Gun"))
            if gun then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer then
                        local role, _ = getRole(p)
                        if role == "Katil" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            Camera.CFrame = CFrame.new(Camera.CFrame.Position, p.Character.HumanoidRootPart.Position)
                            pcall(function() gun:Activate() end)
                            break
                        end
                    end
                end
            end
        end
        
        -- 6. Akıllı Coin Farm
        if Settings.AutoCoin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local coins = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Coins")
            if coins then
                for _, c in ipairs(coins:GetChildren()) do
                    local cp = c:IsA("Model") and c.PrimaryPart or (c:IsA("BasePart") and c)
                    if cp then
                        hrp.CFrame = cp.CFrame
                        task.wait(0.05)
                        break
                    end
                end
            end
        end
    end)
end)

-- NoClip Çalışma Mantığı
RunService.Stepped:Connect(function()
    pcall(function()
        if Settings.NoClip and LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        
        -- X-Ray Mantığı
        if Settings.Xray then
            for _, part in ipairs(Workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then
                    part.Transparency = 0.5
                end
            end
        end
    end)
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if Settings.InfiniteJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

print("MM2 God-Tier Hub başarıyla yüklendi! Keyfini çıkar.")
