--[[
    LEGEND OF SPEED - ULTIMATE SCRIPT
    Super Brutal Edition with Full Menu
    All Features Unlocked
]]--

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

print("🔄 Loading Legend of Speed Ultimate Script...")

-- Wait for character
repeat wait() until player.Character
wait(1)

-- Variables
local scriptActive = {
    speedBoost = false,
    autoFarm = false,
    autoRebirth = false,
    flyMode = false,
    noclip = false,
    infiniteJump = false,
    autoCollectPets = false,
    teleportFarm = false,
    esp = false
}

local connections = {}
local normalSpeed = 16
local normalJumpPower = 50

-- GUI Creation
local gui = Instance.new("ScreenGui")
gui.Name = "LegendSpeedUltimate"
gui.ResetOnSpawn = false

pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)
if gui.Parent ~= game:GetService("CoreGui") then
    gui.Parent = player:WaitForChild("PlayerGui")
end

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Parent = gui
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- Gradient Background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
gradient.Rotation = 45
gradient.Parent = mainFrame

-- Shadow Effect
local shadow = Instance.new("ImageLabel")
shadow.Parent = mainFrame
shadow.BackgroundTransparency = 1
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.ZIndex = -1
shadow.Image = "rbxassetid://6014261993"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Parent = mainFrame
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
topBar.BorderSizePixel = 0
topBar.Size = UDim2.new(1, 0, 0, 50)

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 15)
topCorner.Parent = topBar

-- Title
local title = Instance.new("TextLabel")
title.Parent = topBar
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 15, 0, 0)
title.Size = UDim2.new(0, 300, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "⚡ LEGEND OF SPEED - ULTIMATE"
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

-- Version
local version = Instance.new("TextLabel")
version.Parent = topBar
version.BackgroundTransparency = 1
version.Position = UDim2.new(0, 15, 0, 25)
version.Size = UDim2.new(0, 200, 0, 20)
version.Font = Enum.Font.Gotham
version.Text = "v2.0 | Super Brutal Edition"
version.TextColor3 = Color3.fromRGB(150, 150, 150)
version.TextSize = 10
version.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Parent = topBar
closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.AutoButtonColor = false

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = topBar
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
minimizeButton.BorderSizePixel = 0
minimizeButton.Position = UDim2.new(1, -75, 0, 10)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 20
minimizeButton.AutoButtonColor = false

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeButton

-- Scroll Frame for buttons
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Parent = mainFrame
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.Position = UDim2.new(0, 10, 0, 60)
scrollFrame.Size = UDim2.new(1, -20, 1, -110)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)

-- Status Bar at bottom
local statusBar = Instance.new("Frame")
statusBar.Parent = mainFrame
statusBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
statusBar.BorderSizePixel = 0
statusBar.Position = UDim2.new(0, 0, 1, -40)
statusBar.Size = UDim2.new(1, 0, 0, 40)

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 15)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Parent = statusBar
statusText.BackgroundTransparency = 1
statusText.Position = UDim2.new(0, 15, 0, 0)
statusText.Size = UDim2.new(1, -30, 1, 0)
statusText.Font = Enum.Font.Gotham
statusText.Text = "Status: Ready | Active Features: 0"
statusText.TextColor3 = Color3.fromRGB(100, 200, 255)
statusText.TextSize = 12
statusText.TextXAlignment = Enum.TextXAlignment.Left

-- Function to create toggle button
local buttonCount = 0
local function createToggleButton(name, description, icon)
    local button = Instance.new("TextButton")
    button.Parent = scrollFrame
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    button.BorderSizePixel = 0
    button.Position = UDim2.new(0, 5, 0, buttonCount * 75 + 5)
    button.Size = UDim2.new(1, -10, 0, 65)
    button.AutoButtonColor = false
    button.Text = ""
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = button
    
    -- Icon
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Parent = button
    iconLabel.BackgroundTransparency = 1
    iconLabel.Position = UDim2.new(0, 15, 0, 0)
    iconLabel.Size = UDim2.new(0, 40, 1, 0)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    iconLabel.TextSize = 24
    
    -- Title
    local btnTitle = Instance.new("TextLabel")
    btnTitle.Parent = button
    btnTitle.BackgroundTransparency = 1
    btnTitle.Position = UDim2.new(0, 65, 0, 8)
    btnTitle.Size = UDim2.new(0, 200, 0, 25)
    btnTitle.Font = Enum.Font.GothamBold
    btnTitle.Text = name
    btnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnTitle.TextSize = 14
    btnTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Description
    local btnDesc = Instance.new("TextLabel")
    btnDesc.Parent = button
    btnDesc.BackgroundTransparency = 1
    btnDesc.Position = UDim2.new(0, 65, 0, 35)
    btnDesc.Size = UDim2.new(0, 200, 0, 20)
    btnDesc.Font = Enum.Font.Gotham
    btnDesc.Text = description
    btnDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
    btnDesc.TextSize = 11
    btnDesc.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Toggle indicator
    local indicator = Instance.new("Frame")
    indicator.Parent = button
    indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    indicator.BorderSizePixel = 0
    indicator.Position = UDim2.new(1, -60, 0.5, -15)
    indicator.Size = UDim2.new(0, 50, 0, 30)
    
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1, 0)
    indCorner.Parent = indicator
    
    local indText = Instance.new("TextLabel")
    indText.Parent = indicator
    indText.BackgroundTransparency = 1
    indText.Size = UDim2.new(1, 0, 1, 0)
    indText.Font = Enum.Font.GothamBold
    indText.Text = "OFF"
    indText.TextColor3 = Color3.fromRGB(255, 255, 255)
    indText.TextSize = 12
    
    buttonCount = buttonCount + 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, buttonCount * 75 + 10)
    
    return button, indicator, indText
end

-- Update status function
local function updateStatus()
    local activeCount = 0
    for _, active in pairs(scriptActive) do
        if active then activeCount = activeCount + 1 end
    end
    statusText.Text = "Status: Running | Active Features: " .. activeCount
end

-- Buttons Data
local buttons = {
    {name = "Speed Boost", desc = "Ultra fast speed", icon = "🚀", key = "speedBoost"},
    {name = "Auto Farm Orbs", desc = "Collect orbs automatically", icon = "💎", key = "autoFarm"},
    {name = "Auto Rebirth", desc = "Auto rebirth when available", icon = "🔄", key = "autoRebirth"},
    {name = "Fly Mode", desc = "Fly around the map", icon = "✈️", key = "flyMode"},
    {name = "Noclip", desc = "Walk through walls", icon = "👻", key = "noclip"},
    {name = "Infinite Jump", desc = "Jump infinitely", icon = "⬆️", key = "infiniteJump"},
    {name = "Auto Collect Pets", desc = "Auto collect pet orbs", icon = "🐾", key = "autoCollectPets"},
    {name = "Teleport Farm", desc = "TP to orbs instantly", icon = "⚡", key = "teleportFarm"},
    {name = "ESP Orbs", desc = "See all orbs through walls", icon = "👁️", key = "esp"}
}

-- Create all buttons
local buttonObjects = {}
for _, btnData in ipairs(buttons) do
    local btn, ind, indTxt = createToggleButton(btnData.name, btnData.desc, btnData.icon)
    buttonObjects[btnData.key] = {button = btn, indicator = ind, text = indTxt}
end

print("✅ GUI Created Successfully")

-- ============================================
-- FEATURE FUNCTIONS
-- ============================================

-- 1. SPEED BOOST
local function toggleSpeedBoost()
    scriptActive.speedBoost = not scriptActive.speedBoost
    
    if scriptActive.speedBoost then
        if connections.speed then connections.speed:Disconnect() end
        
        connections.speed = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char then
                local humanoid = char:FindFirstChildOfType("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 500
                end
            end
        end)
        
        buttonObjects.speedBoost.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.speedBoost.text.Text = "ON"
        print("[Speed Boost] Activated - Speed: 500")
    else
        if connections.speed then
            connections.speed:Disconnect()
            connections.speed = nil
        end
        
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChildOfType("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = normalSpeed
            end
        end
        
        buttonObjects.speedBoost.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.speedBoost.text.Text = "OFF"
        print("[Speed Boost] Deactivated")
    end
    updateStatus()
end

-- 2. AUTO FARM ORBS
local function toggleAutoFarm()
    scriptActive.autoFarm = not scriptActive.autoFarm
    
    if scriptActive.autoFarm then
        if connections.farm then connections.farm:Disconnect() end
        
        connections.farm = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                
                for _, orb in pairs(workspace:GetDescendants()) do
                    if orb:IsA("BasePart") and (orb.Name == "Orb" or orb.Name:find("Gem") or orb.Name:find("Coin")) then
                        if (orb.Position - hrp.Position).Magnitude < 150 then
                            pcall(function()
                                orb.CFrame = hrp.CFrame
                            end)
                        end
                    end
                end
            end
        end)
        
        buttonObjects.autoFarm.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.autoFarm.text.Text = "ON"
        print("[Auto Farm] Activated - Collecting orbs...")
    else
        if connections.farm then
            connections.farm:Disconnect()
            connections.farm = nil
        end
        
        buttonObjects.autoFarm.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.autoFarm.text.Text = "OFF"
        print("[Auto Farm] Deactivated")
    end
    updateStatus()
end

-- 3. AUTO REBIRTH
local function toggleAutoRebirth()
    scriptActive.autoRebirth = not scriptActive.autoRebirth
    
    if scriptActive.autoRebirth then
        if connections.rebirth then connections.rebirth:Disconnect() end
        
        connections.rebirth = RunService.Heartbeat:Connect(function()
            pcall(function()
                local rebirthEvent = game:GetService("ReplicatedStorage"):FindFirstChild("RebirthEvent")
                if rebirthEvent then
                    rebirthEvent:FireServer()
                end
            end)
        end)
        
        buttonObjects.autoRebirth.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.autoRebirth.text.Text = "ON"
        print("[Auto Rebirth] Activated")
    else
        if connections.rebirth then
            connections.rebirth:Disconnect()
            connections.rebirth = nil
        end
        
        buttonObjects.autoRebirth.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.autoRebirth.text.Text = "OFF"
        print("[Auto Rebirth] Deactivated")
    end
    updateStatus()
end

-- 4. FLY MODE
local flying = false
local flySpeed = 100
local flyKeys = {W = false, S = false, A = false, D = false, Space = false, LeftShift = false}

local function toggleFlyMode()
    scriptActive.flyMode = not scriptActive.flyMode
    flying = scriptActive.flyMode
    
    if scriptActive.flyMode then
        local char = player.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local bg = Instance.new("BodyGyro")
        bg.P = 9e4
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = hrp.CFrame
        bg.Parent = hrp
        
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = hrp
        
        connections.fly = RunService.Heartbeat:Connect(function()
            if not flying then return end
            
            local cam = workspace.CurrentCamera
            local direction = Vector3.new(0, 0, 0)
            
            if flyKeys.W then direction = direction + (cam.CFrame.LookVector) end
            if flyKeys.S then direction = direction - (cam.CFrame.LookVector) end
            if flyKeys.A then direction = direction - (cam.CFrame.RightVector) end
            if flyKeys.D then direction = direction + (cam.CFrame.RightVector) end
            if flyKeys.Space then direction = direction + Vector3.new(0, 1, 0) end
            if flyKeys.LeftShift then direction = direction - Vector3.new(0, 1, 0) end
            
            if direction.Magnitude > 0 then
                direction = direction.Unit
            end
            
            bv.Velocity = direction * flySpeed
            bg.CFrame = cam.CFrame
        end)
        
        connections.flyInput = game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then flyKeys.W = true end
            if input.KeyCode == Enum.KeyCode.S then flyKeys.S = true end
            if input.KeyCode == Enum.KeyCode.A then flyKeys.A = true end
            if input.KeyCode == Enum.KeyCode.D then flyKeys.D = true end
            if input.KeyCode == Enum.KeyCode.Space then flyKeys.Space = true end
            if input.KeyCode == Enum.KeyCode.LeftShift then flyKeys.LeftShift = true end
        end)
        
        connections.flyInputEnd = game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then flyKeys.W = false end
            if input.KeyCode == Enum.KeyCode.S then flyKeys.S = false end
            if input.KeyCode == Enum.KeyCode.A then flyKeys.A = false end
            if input.KeyCode == Enum.KeyCode.D then flyKeys.D = false end
            if input.KeyCode == Enum.KeyCode.Space then flyKeys.Space = false end
            if input.KeyCode == Enum.KeyCode.LeftShift then flyKeys.LeftShift = false end
        end)
        
        buttonObjects.flyMode.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.flyMode.text.Text = "ON"
        print("[Fly Mode] Activated - WASD to fly, Space/Shift for up/down")
    else
        flying = false
        
        if connections.fly then connections.fly:Disconnect() connections.fly = nil end
        if connections.flyInput then connections.flyInput:Disconnect() connections.flyInput = nil end
        if connections.flyInputEnd then connections.flyInputEnd:Disconnect() connections.flyInputEnd = nil end
        
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            for _, obj in pairs(hrp:GetChildren()) do
                if obj:IsA("BodyGyro") or obj:IsA("BodyVelocity") then
                    obj:Destroy()
                end
            end
        end
        
        buttonObjects.flyMode.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.flyMode.text.Text = "OFF"
        print("[Fly Mode] Deactivated")
    end
    updateStatus()
end

-- 5. NOCLIP
local function toggleNoclip()
    scriptActive.noclip = not scriptActive.noclip
    
    if scriptActive.noclip then
        if connections.noclip then connections.noclip:Disconnect() end
        
        connections.noclip = RunService.Stepped:Connect(function()
            local char = player.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
        buttonObjects.noclip.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.noclip.text.Text = "ON"
        print("[Noclip] Activated - Walk through walls!")
    else
        if connections.noclip then
            connections.noclip:Disconnect()
            connections.noclip = nil
        end
        
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
        
        buttonObjects.noclip.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.noclip.text.Text = "OFF"
        print("[Noclip] Deactivated")
    end
    updateStatus()
end

-- 6. INFINITE JUMP
local function toggleInfiniteJump()
    scriptActive.infiniteJump = not scriptActive.infiniteJump
    
    if scriptActive.infiniteJump then
        if connections.infiniteJump then connections.infiniteJump:Disconnect() end
        
        connections.infiniteJump = game:GetService("UserInputService").JumpRequest:Connect(function()
            local char = player.Character
            if char then
                local humanoid = char:FindFirstChildOfType("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
        
        buttonObjects.infiniteJump.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.infiniteJump.text.Text = "ON"
        print("[Infinite Jump] Activated")
    else
        if connections.infiniteJump then
            connections.infiniteJump:Disconnect()
            connections.infiniteJump = nil
        end
        
        buttonObjects.infiniteJump.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.infiniteJump.text.Text = "OFF"
        print("[Infinite Jump] Deactivated")
    end
    updateStatus()
end

-- 7. AUTO COLLECT PETS
local function toggleAutoCollectPets()
    scriptActive.autoCollectPets = not scriptActive.autoCollectPets
    
    if scriptActive.autoCollectPets then
        if connections.pets then connections.pets:Disconnect() end
        
        connections.pets = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                
                for _, pet in pairs(workspace:GetDescendants()) do
                    if pet.Name:find("Pet") and pet:IsA("BasePart") then
                        if (pet.Position - hrp.Position).Magnitude < 100 then
                            pcall(function()
                                pet.CFrame = hrp.CFrame
                            end)
                        end
                    end
                end
            end
        end)
        
        buttonObjects.autoCollectPets.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.autoCollectPets.text.Text = "ON"
        print("[Auto Collect Pets] Activated")
    else
        if connections.pets then
            connections.pets:Disconnect()
            connections.pets = nil
        end
        
        buttonObjects.autoCollectPets.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.autoCollectPets.text.Text = "OFF"
        print("[Auto Collect Pets] Deactivated")
    end
    updateStatus()
end

-- 8. TELEPORT FARM
local function toggleTeleportFarm()
    scriptActive.teleportFarm = not scriptActive.teleportFarm
    
    if scriptActive.teleportFarm then
        if connections.tpFarm then connections.tpFarm:Disconnect() end
        
        connections.tpFarm = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                
                local nearestOrb = nil
                local nearestDistance = math.huge
                
                for _, orb in pairs(workspace:GetDescendants()) do
                    if orb:IsA("BasePart") and (orb.Name == "Orb" or orb.Name:find("Gem")) then
                        local distance = (orb.Position - hrp.Position).Magnitude
                        if distance < nearestDistance and distance < 300 then
                            nearestDistance = distance
                            nearestOrb = orb
                        end
                    end
                end
                
                if nearestOrb then
                    pcall(function()
                        hrp.CFrame = nearestOrb.CFrame
                    end)
                end
            end
        end)
        
        buttonObjects.teleportFarm.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.teleportFarm.text.Text = "ON"
        print("[Teleport Farm] Activated - Ultra fast farming!")
    else
        if connections.tpFarm then
            connections.tpFarm:Disconnect()
            connections.tpFarm = nil
        end
        
        buttonObjects.teleportFarm.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.teleportFarm.text.Text = "OFF"
        print("[Teleport Farm] Deactivated")
    end
    updateStatus()
end

-- 9. ESP ORBS
local espObjects = {}
local function toggleESP()
    scriptActive.esp = not scriptActive.esp
    
    if scriptActive.esp then
        if connections.esp then connections.esp:Disconnect() end
        
        connections.esp = RunService.Heartbeat:Connect(function()
            -- Clear old ESP
            for _, obj in pairs(espObjects) do
                pcall(function() obj:Destroy() end)
            end
            espObjects = {}
            
            -- Create new ESP
            for _, orb in pairs(workspace:GetDescendants()) do
                if orb:IsA("BasePart") and (orb.Name == "Orb" or orb.Name:find("Gem")) then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 255, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 200, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = orb
                    highlight.Adornee = orb
                    table.insert(espObjects, highlight)
                    
                    local billboard = Instance.new("BillboardGui")
                    billboard.Size = UDim2.new(0, 100, 0, 30)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = orb
                    billboard.Adornee = orb
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = orb.Name
                    label.TextColor3 = Color3.fromRGB(255, 255, 0)
                    label.TextStrokeTransparency = 0.5
                    label.Font = Enum.Font.GothamBold
                    label.TextSize = 14
                    label.Parent = billboard
                    
                    table.insert(espObjects, billboard)
                end
            end
        end)
        
        buttonObjects.esp.indicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        buttonObjects.esp.text.Text = "ON"
        print("[ESP] Activated - See all orbs!")
    else
        if connections.esp then
            connections.esp:Disconnect()
            connections.esp = nil
        end
        
        for _, obj in pairs(espObjects) do
            pcall(function() obj:Destroy() end)
        end
        espObjects = {}
        
        buttonObjects.esp.indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        buttonObjects.esp.text.Text = "OFF"
        print("[ESP] Deactivated")
    end
    updateStatus()
end

-- Connect buttons to functions
buttonObjects.speedBoost.button.MouseButton1Click:Connect(toggleSpeedBoost)
buttonObjects.autoFarm.button.MouseButton1Click:Connect(toggleAutoFarm)
buttonObjects.autoRebirth.button.MouseButton1Click:Connect(toggleAutoRebirth)
buttonObjects.flyMode.button.MouseButton1Click:Connect(toggleFlyMode)
buttonObjects.noclip.button.MouseButton1Click:Connect(toggleNoclip)
buttonObjects.infiniteJump.button.MouseButton1Click:Connect(toggleInfiniteJump)
buttonObjects.autoCollectPets.button.MouseButton1Click:Connect(toggleAutoCollectPets)
buttonObjects.teleportFarm.button.MouseButton1Click:Connect(toggleTeleportFarm)
buttonObjects.esp.button.MouseButton1Click:Connect(toggleESP)

-- Hover effects
for _, btnObj in pairs(buttonObjects) do
    btnObj.button.MouseEnter:Connect(function()
        btnObj.button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    end)
    
    btnObj.button.MouseLeave:Connect(function()
        btnObj.button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    end)
end

-- Close button
closeButton.MouseButton1Click:Connect(function()
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    
    for _, obj in pairs(espObjects) do
        pcall(function() obj:Destroy() end)
    end
    
    gui:Destroy()
    print("Script terminated!")
end)

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
end)

closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
end)

-- Minimize functionality
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        mainFrame:TweenSize(UDim2.new(0, 400, 0, 50), "Out", "Quad", 0.3, true)
        minimizeButton.Text = "+"
        scrollFrame.Visible = false
        statusBar.Visible = false
    else
        mainFrame:TweenSize(UDim2.new(0, 400, 0, 500), "Out", "Quad", 0.3, true)
        minimizeButton.Text = "-"
        scrollFrame.Visible = true
        statusBar.Visible = true
    end
end)

minimizeButton.MouseEnter:Connect(function()
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 190, 20)
end)

minimizeButton.MouseLeave:Connect(function()
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
end)

-- Auto re-enable after respawn
player.CharacterAdded:Connect(function(char)
    wait(1)
    
    -- Re-enable active features
    if scriptActive.speedBoost then
        local humanoid = char:FindFirstChildOfType("Humanoid")
        if humanoid then
            normalSpeed = humanoid.WalkSpeed
        end
    end
    
    -- Notify user
    print("[System] Character respawned - Active features maintained")
end)

-- Startup animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame:TweenSize(UDim2.new(0, 400, 0, 500), "Out", "Elastic", 0.8, true)

-- Success message
print("╔═══════════════════════════════════════╗")
print("║  LEGEND OF SPEED - ULTIMATE SCRIPT   ║")
print("║       Super Brutal Edition v2.0      ║")
print("╠═══════════════════════════════════════╣")
print("║  ✓ 9 Premium Features Loaded          ║")
print("║  ✓ Modern GUI Interface               ║")
print("║  ✓ All Systems Operational            ║")
print("╚═══════════════════════════════════════╝")
print("")
print("Features:")
print("  🚀 Speed Boost (500 speed)")
print("  💎 Auto Farm Orbs")
print("  🔄 Auto Rebirth")
print("  ✈️  Fly Mode (WASD controls)")
print("  👻 Noclip")
print("  ⬆️  Infinite Jump")
print("  🐾 Auto Collect Pets")
print("  ⚡ Teleport Farm (instant)")
print("  👁️  ESP Orbs")
print("")
print("Ready to dominate! Toggle features ON/OFF")
