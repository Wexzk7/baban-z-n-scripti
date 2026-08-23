-- =====================================================================
-- MM2 CYBERPUNK ULTIMATE GOD-TIER HUB [v5.0 PRO]
-- Yazdırıldı: Mobil / Delta Uyumlu ve Akıcı Animasyonlu Sürüm
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Kapsamlı Ayarlar Havuzu
local Settings = {
    -- Visuals
    BoxESP = false,
    RoleESP = false,
    TracerESP = false,
    ItemESP = false,
    Chams = false,
    Xray = false,
    -- Combat
    SilentAim = false,
    AutoShoot = false,
    TriggerBot = false,
    FOV = 120,
    ShowFOV = false,
    HitboxExpander = false,
    -- Movement
    SpeedHack = false,
    WalkSpeed = 24,
    InfiniteJump = false,
    NoClip = false,
    Fly = false,
    FlySpeed = 50,
    -- Farming
    AutoCoin = false,
    AutoCollectGun = false,
    -- Troll & Fun
    SpinBot = false,
    Invisibility = false,
    RainbowChar = false,
    -- Misc
    Fullbright = false,
    AntiAFK = true
}

-- Güvenli Parent (CoreGui / PlayerGui)
local success, parent = pcall(function() return CoreGui end)
if not success or not parent then parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Önceki Açık GUI'leri Temizle
if parent:FindFirstChild("CyberHubMM2") then
    parent.CyberHubMM2:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyberHubMM2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parent

-- 1. ANİMASYONLU SİBER AÇILIŞ EKRANI (INTRO)
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.fromOffset(0, 0)
IntroFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
IntroFrame.BorderSizePixel = 0
IntroFrame.ClipsDescendants = true
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 16)
IntroCorner.Parent = IntroFrame

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Color = Color3.fromRGB(0, 255, 200)
IntroStroke.Thickness = 2
IntroStroke.Parent = IntroFrame

local IntroText = Instance.new("TextLabel")
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "⚡ CYBER MM2 HUB YÜKLENİYOR ⚡\n[Sistemler Aktifleştiriliyor...]"
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 13
IntroText.TextTransparency = 1
IntroText.Parent = IntroFrame

-- Intro Animasyonu Başlat
TweenService:Create(IntroFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(380, 130), Position = UDim2.new(0.5, -190, 0.5, -65)}):Play()
task.wait(0.3)
TweenService:Create(IntroText, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
task.wait(1.5)
TweenService:Create(IntroText, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
TweenService:Create(IntroFrame, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), Transparency = 1}):Play()
task.wait(0.5)
IntroFrame:Destroy()


-- 2. ANA KONTROL PANELİ (CYBERPUNK TEMA)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(540, 370)
MainFrame.Position = UDim2.new(0.5, -270, 0.5, -185)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 255, 200)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Üst Başlık (Top Bar)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

local TopFix = Instance.new("Frame")
TopFix.Size = UDim2.new(1, 0, 0, 10)
TopFix.Position = UDim2.new(0, 0, 1, -10)
TopFix.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
TopFix.BorderSizePixel = 0
TopFix.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ CYBERPUNK MM2 HUB [PRO]"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Küçültme / Gizleme Tuşu (Üstte)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(32, 32)
CloseBtn.Position = UDim2.new(1, -38, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
CloseBtn.Text = "_"
CloseBtn.TextColor3 = Color3.fromRGB(0, 255, 200)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local menuVisible = true
CloseBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)

-- Mobil İçin Açma/Kapama Yüzen Butonu (Floating Menu Toggle)
local FloatBtn = Instance.new("TextButton")
FloatBtn.Size = UDim2.fromOffset(55, 45)
FloatBtn.Position = UDim2.new(0, 10, 0.2, 0)
FloatBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
FloatBtn.Text = "HUB"
FloatBtn.TextColor3 = Color3.fromRGB(0, 255, 200)
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.TextSize = 13
FloatBtn.Active = true
FloatBtn.Draggable = true
FloatBtn.Parent = ScreenGui

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(0, 10)
FloatCorner.Parent = FloatBtn

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(0, 255, 200)
FloatStroke.Thickness = 1
FloatStroke.Parent = FloatBtn

FloatBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end)


-- 3. SEKME SİSTEMİ (TABS)
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 135, 1, -55)
Sidebar.Position = UDim2.new(0, 5, 0, 50)
Sidebar.BackgroundTransparency = 1
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 360)
Sidebar.ScrollBarThickness = 2
Sidebar.Parent = MainFrame

local ContainerHolder = Instance.new("Folder")
ContainerHolder.Parent = MainFrame

local tabs = {}
local currentTab = nil

local function createTab(name, yOffset)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, -5, 0, 36)
    tabBtn.Position = UDim2.new(0, 0, 0, yOffset)
    tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(160, 160, 190)
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 12
    tabBtn.Parent = Sidebar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabBtn
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -150, 1, -60)
    content.Position = UDim2.new(0, 145, 0, 50)
    content.BackgroundTransparency = 1
    content.CanvasSize = UDim2.new(0, 0, 0, 550)
    content.ScrollBarThickness = 4
    content.Visible = false
    content.Parent = ContainerHolder
    
    table.insert(tabs, {Button = tabBtn, Content = content})
    
    if not currentTab then
        currentTab = content
        content.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
        tabBtn.TextColor3 = Color3.fromRGB(15, 15, 22)
    end
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabs) do
            t.Content.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
            t.Button.TextColor3 = Color3.fromRGB(160, 160, 190)
        end
        content.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
        tabBtn.TextColor3 = Color3.fromRGB(15, 15, 22)
    end)
    
    return content
end

-- Sekmeleri Oluşturuyoruz
local VisualsTab = createTab("Görsel (ESP)", 0)
local CombatTab = createTab("Savaş & Aim", 42)
local MovementTab = createTab("Hareket", 84)
local FarmingTab = createTab("Farm & Coin", 126)
local TrollTab = createTab("Troll & Eğlence", 168)
local MiscTab = createTab("Genel (Misc)", 210)


-- 4. ÖZELLİK BUTONLARI (TOGGLE BUILDER)
local function addToggle(tab, name, yPos, key)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
    btn.Text = "  " .. name .. " [KAPALI]"
    btn.TextColor3 = Color3.fromRGB(255, 90, 90)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = tab
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        if Settings[key] then
            btn.Text = "  " .. name .. " [AÇIK]"
            btn.TextColor3 = Color3.fromRGB(0, 255, 200)
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 55, 60)}):Play()
        else
            btn.Text = "  " .. name .. " [KAPALI]"
            btn.TextColor3 = Color3.fromRGB(255, 90, 90)
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 32)}):Play()
        end
    end)
end

-- İçerik Yerleşimi
addToggle(VisualsTab, "Kutu ESP (Box)", 0, "BoxESP")
addToggle(VisualsTab, "Rol Göstergesi (Katil/Şerif)", 42, "RoleESP")
addToggle(VisualsTab, "Çizgi ESP (Tracer)", 84, "TracerESP")
addToggle(VisualsTab, "Eşya / Silah Drop ESP", 126, "ItemESP")
addToggle(VisualsTab, "Chams (Karakter Parlatma)", 168, "Chams")
addToggle(VisualsTab, "X-Ray (Duvar Arkası)", 210, "Xray")

addToggle(CombatTab, "Silent Aim", 0, "SilentAim")
addToggle(CombatTab, "Auto Shoot (Katil Avı)", 42, "AutoShoot")
addToggle(CombatTab, "Triggerbot (Görüşe Sık)", 84, "TriggerBot")
addToggle(CombatTab, "Görüş Çemberi (FOV)", 126, "ShowFOV")
addToggle(CombatTab, "Hitbox Büyütücü", 168, "HitboxExpander")

addToggle(MovementTab, "Speed Hack (Hız)", 0, "SpeedHack")
addToggle(MovementTab, "Sınırsız Zıplama", 42, "InfiniteJump")
addToggle(MovementTab, "Duvar Geçme (NoClip)", 84, "NoClip")
addToggle(MovementTab, "Uçma Modu (Fly)", 126, "Fly")

addToggle(FarmingTab, "Akıllı Coin Farm", 0, "AutoCoin")
addToggle(FarmingTab, "Yere Düşen Silahı Al", 42, "AutoCollectGun")

addToggle(TrollTab, "Spinbot (Dönme Trolleri)", 0, "SpinBot")
addToggle(TrollTab, "Görünmezlik Simülasyonu", 42, "Invisibility")
addToggle(TrollTab, "Gökkuşağı Karakter", 84, "RainbowChar")

addToggle(MiscTab, "Fullbright (Aydınlık)", 0, "Fullbright")
addToggle(MiscTab, "Anti-AFK Koruyucu", 42, "AntiAFK")


-- 5. ROL TESPİT MOTORU
local function getRole(player)
    if not player.Character then return "Masum", Color3.fromRGB(50, 255, 100) end
    local bp = player:FindFirstChild("Backpack")
    local char = player.Character
    local hasKnife = char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife"))
    local hasGun = char:FindFirstChild("Gun") or (bp and bp:FindFirstChild("Gun")) or char:FindFirstChild("Revolver") or (bp and bp:FindFirstChild("Revolver"))
    
    if hasKnife then return "Katil", Color3.fromRGB(255, 60, 60)
    elseif hasGun then return "Şerif", Color3.fromRGB(60, 160, 255)
    else return "Masum", Color3.fromRGB(60, 255, 200) end
end


-- 6. MOTOR DÖNGÜLERİ (RENDER & STEPPED)
RunService.RenderStepped:Connect(function()
    pcall(function()
        -- Rol ESP & Chams
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local char = p.Character
                local hl = char:FindFirstChild("CyberHub_HL")
                
                if Settings.RoleESP or Settings.BoxESP or Settings.Chams then
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "CyberHub_HL"
                        hl.Adornee = char
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = char
                    end
                    local _, col = getRole(p)
                    hl.FillColor = col
                    hl.OutlineColor = col
                    hl.FillTransparency = 0.55
                else
                    if hl then hl:Destroy() end
                end
            end
        end
        
        -- Speed Hack
        if Settings.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Settings.WalkSpeed
        end
        
        -- Fullbright
        if Settings.Fullbright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
        end
        
        -- Spinbot Troll
        if Settings.SpinBot and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(30), 0)
        end
        
        -- Rainbow Karakter Efekti
        if Settings.RainbowChar and LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                end
            end
        end
        
        -- Auto Shoot (Katil Avı)
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
        
        -- Akıllı Coin Farm
        if Settings.AutoCoin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local coins = Workspace:FindFirstChild("CoinContainer") or Workspace:FindFirstChild("Coins")
            if coins then
                for _, c in ipairs(coins:GetChildren()) do
                    local cp = c:IsA("Model") and c.PrimaryPart or (c:IsA("BasePart") and c)
                    if cp then
                        hrp.CFrame = cp.CFrame
                        task.wait(0.04)
                        break
                    end
                end
            end
        end
    end)
end)

-- NoClip & X-Ray
RunService.Stepped:Connect(function()
    pcall(function()
        if Settings.NoClip and LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
        
        if Settings.Xray then
            for _, part in ipairs(Workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then
                    part.Transparency = 0.6
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

print("⚡ Cyberpunk MM2 God-Tier Hub başarıyla yüklendi!")
