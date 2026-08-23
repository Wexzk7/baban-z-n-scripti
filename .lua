-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Ayarlar / Toggle Değişkenleri
local Settings = {
    ESPEnabled = true,
    AutoShoot = true,
    BombJump = true
}

-- 1. ROL ESP SİSTEMİ (Katil, Şerif, Masum Tespiti)
local function getRole(player)
    if not player.Character then return "Masum", Color3.fromRGB(255, 255, 255) end
    
    -- Karakter üstündeki eşyaları kontrol et (Bıçak = Katil, Silah = Şerif)
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    
    local hasKnife = character:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
    local hasGun = character:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) or character:FindFirstChild("Revolver") or (backpack and backpack:FindFirstChild("Revolver"))
    
    if hasKnife then
        return "Katil", Color3.fromRGB(255, 50, 50) -- Kırmızı
    elseif hasGun then
        return "Şerif", Color3.fromRGB(50, 150, 255) -- Mavi
    else
        return "Masum", Color3.fromRGB(50, 255, 50) -- Yeşil
    end
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") then
                local head = char.Head
                local billboard = head:FindFirstChild("MM2_ESP")
                
                if Settings.ESPEnabled then
                    if not billboard then
                        billboard = Instance.new("BillboardGui")
                        billboard.Name = "MM2_ESP"
                        billboard.Size = UDim2.fromOffset(120, 30)
                        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                        billboard.AlwaysOnTop = true
                        
                        local txt = Instance.new("TextLabel")
                        txt.Name = "RoleText"
                        txt.Size = UDim2.fromScale(1, 1)
                        txt.BackgroundTransparency = 1
                        txt.TextScaled = true
                        txt.Font = Enum.Font.GothamBold
                        txt.Parent = billboard
                        
                        billboard.Parent = head
                    end
                    
                    local role, color = getRole(player)
                    local textLabel = billboard:FindFirstChild("RoleText")
                    if textLabel then
                        textLabel.Text = player.Name .. " [" .. role .. "]"
                        textLabel.TextColor3 = color
                    end
                else
                    if billboard then billboard:Destroy() end
                end
            end
        end
    end
end

-- 2. AUTO-SHOOT SİSTEMİ (Şerif veya Silah Yerdeyken Katili Vurma)
local function autoShootCheck()
    if not Settings.AutoShoot then return end
    
    -- Eğer elinde silah varsa (Şerifsen)
    local char = LocalPlayer.Character
    if not char then return end
    
    local gun = char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")
    if gun then
        -- Haritadaki Katili bul
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local role, _ = getRole(player)
                if role == "Katil" and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = player.Character.HumanoidRootPart
                    
                    -- Katile nişan al ve ateş et (Ateş etme tetikleyicisi oyunun tool event'ine bağlıdır)
                    gun:Activate()
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetRoot.Position)
                    break
                end
            end
        end
    end
end

-- 3. BOMBA JUMP / DOUBLE JUMP OTOMASYONU
local function handleBombJump()
    if not Settings.BombJump then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        -- Boşluk tuşuna veya zıplama isteğine basıldığında ekstra ivme kazandır
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) or humanoid:GetState() == Enum.HumanoidStateType.Jumping then
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart.Velocity.Y > 0 then
                -- Yukarı doğru ek bir zıplama kuvveti (Double Jump / Bomb Jump etkisi)
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 55, rootPart.Velocity.Z)
                task.wait(0.2) -- Sürekli tetiklenmemesi için kısa bir bekleme
            end
        end
    end
end

-- Ana Döngü (Her karede çalışır)
RunService.RenderStepped:Connect(function()
    pcall(function()
        updateESP()
        autoShootCheck()
        handleBombJump()
    end)
end)

print("MM2 Özel Script Başarıyla Yüklendi!")

