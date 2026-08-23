-- Wexzk-Premium MM2 Hub (Delta Uyumlu & Güncel)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Wexzk-Premium | MM2", "DarkTheme")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local Tab = Window:NewTab("Ana Menü")
local Section = Tab:NewSection("Özellikler")

-- ==========================================
-- ÖZELLİK 1: SADECE RENKLİ PARILDAYAN ESP (İsimsiz)
-- ==========================================
Section:NewToggle("Renkli Parıldama (ESP)", "Katil kırmızı, Şerif mavi, Masum yeşil parlar", function(state)
    _G.WexzkESP = state
    
    spawn(function()
        while _G.WexzkESP do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local char = player.Character
                    local highlight = char:FindFirstChild("WexzkHighlight")
                    
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "WexzkHighlight"
                        highlight.Parent = char
                        highlight.Adornee = char
                        highlight.FillTransparency = 0.4
                        highlight.OutlineTransparency = 0
                    end
                    
                    -- Rol tespiti
                    local bp = player.Backpack
                    if bp:FindFirstChild("Gun") or char:FindFirstChild("Gun") then
                        highlight.FillColor = Color3.fromRGB(0, 170, 255) -- Şerif: Mavi
                        highlight.OutlineColor = Color3.fromRGB(0, 100, 200)
                    elseif bp:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Katil: Kırmızı
                        highlight.OutlineColor = Color3.fromRGB(150, 0, 0)
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Masum: Yeşil
                        highlight.OutlineColor = Color3.fromRGB(0, 150, 0)
                    end
                end
            end
            task.wait(1)
        end
        
        -- ESP kapatıldığında temizle
        if not _G.WexzkESP then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("WexzkHighlight") then
                    player.Character.WexzkHighlight:Destroy()
                end
            end
        end
    end)
end)

-- ==========================================
-- ÖZELLİK 2: ALTINDA PLAKA ÇIKARAK AUTO COIN FARM
-- ==========================================
Section:NewToggle("Auto Coin Farm (Plakalı)", "Altında plaka belirir ve coinlere uçar", function(state)
    _G.WexzkCoinFarm = state
    
    -- Plaka (Platform) oluşturma
    local platform = Workspace:FindFirstChild("WexzkPlatform")
    if state and not platform then
        platform = Instance.new("Part")
        platform.Name = "WexzkPlatform"
        platform.Size = Vector3.new(5, 1, 5)
        platform.Anchored = true
        platform.Transparency = 0.5
        platform.BrickColor = BrickColor.new("Bright blue")
        platform.Parent = Workspace
    elseif not state and platform then
        platform:Destroy()
    end
    
    spawn(function()
        while _G.WexzkCoinFarm do
            pcall(function()
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- Plakayı oyuncunun hemen altına sabitle
                    if platform then
                        platform.CFrame = hrp.CFrame - Vector3.new(0, 3.5, 0)
                    end
                    
                    -- Coinleri bul ve git
                    for _, v in pairs(Workspace:GetChildren()) do
                        if _G.WexzkCoinFarm and (v.Name == "Coin_Server" or v.Name == "CoinDrop") then
                            hrp.CFrame = v.CFrame
                            task.wait(0.2)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
        if platform then platform:Destroy() end
    end)
end)

-- ==========================================
-- ÖZELLİK 3: EKRANA BUTON GETİREN MANUEL KATİL VURMA
-- ==========================================
Section:NewToggle("Manuel Katil Vurma Butonu", "Ekrana ateş etme butonu getirir", function(state)
    _G.AutoShotButton = state
    
    local screenGui = CoreGui:FindFirstChild("WexzkShotGui")
    
    if state then
        if not screenGui then
            screenGui = Instance.new("ScreenGui")
            screenGui.Name = "WexzkShotGui"
            screenGui.Parent = CoreGui
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 140, 0, 50)
            btn.Position = UDim2.new(0.8, 0, 0.5, 0)
            btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 16
            btn.Font = Enum.Font.SourceSansBold
            btn.Text = "ATEŞ ET (MURDER)"
            btn.Parent = screenGui
            
            -- Yuvarlak tasarım
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 10)
            corner.Parent = btn
            
            -- Butona basınca katili bulup vurma mantığı
            btn.MouseButton1Click:Connect(function()
                pcall(function()
                    local gun = LocalPlayer.Backpack:FindFirstChild("Gun") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Gun"))
                    if gun then
                        LocalPlayer.Character.Humanoid:EquipTool(gun)
                    end
                    
                    -- Katili tespit et ve yönel/ateş et
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local bp = player.Backpack
                            local char = player.Character
                            if bp:FindFirstChild("Knife") or char:FindFirstChild("Knife") then
                                local enemyHRP = char:FindFirstChild("HumanoidRootPart")
                                local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if enemyHRP and myHRP then
                                    -- Katile bak ve RemoteEvent tetikle
                                    myHRP.CFrame = CFrame.new(myHRP.Position, enemyHRP.Position)
                                    local shootEvent = ReplicatedStorage:FindFirstChild("ShootGun", true)
                                    if shootEvent then
                                        shootEvent:FireServer(enemyHRP.Position)
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
        end
    else
        if screenGui then screenGui:Destroy() end
    end)
end)

-- ==========================================
-- ÖZELLİK 4: OTOMATİK BOMB / DOUBLE JUMP
-- ==========================================
Section:NewToggle("Otomatik Bomb (Double Jump)", "Satın alınan bombayı otomatik tetikler", function(state)
    _G.WexzkBomb = state
    
    spawn(function()
        while _G.WexzkBomb do
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    -- Boşluk tuşuna basıldığında veya zıplama anında bombayı patlatarak ekstra zıplama sağla
                    if char.Humanoid.Jump and not char:FindFirstChild("WexzkDoubleJumped") then
                        local tag = Instance.new("BoolValue")
                        tag.Name = "WexzkDoubleJumped"
                        tag.Parent = char
                        
                        char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X, 55, char.HumanoidRootPart.Velocity.Z)
                        
                        -- Bomb remote tetikleme (MM2 Bomb eşyası simülasyonu)
                        local bombRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Bomb", true) or game:GetService("ReplicatedStorage"):FindFirstChild("UseBomb", true)
                        if bombRemote then
                            bombRemote:FireServer()
                        end
                        
                        task.wait(0.5)
                        tag:Destroy()
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)
