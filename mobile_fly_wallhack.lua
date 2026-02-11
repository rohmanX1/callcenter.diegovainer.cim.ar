--[[
    FLY + WALLHACK MOBILE
    Optimized for Mobile with Virtual Joystick
    Simple & Easy to Use
]]--

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

print("🔄 Loading Mobile Fly + Wallhack...")

-- Wait for character
repeat wait() until player.Character
wait(0.5)

-- Variables
local flyActive = false
local noclipActive = false
local flySpeed = 120
local connections = {}
local joystickInput = Vector2.new(0, 0)
local upPressed = false
local downPressed = false
local touching = false

-- GUI Creation
local gui = Instance.new("ScreenGui")
gui.Name = "MobileFlyHack"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)
if gui.Parent ~= game:GetService("CoreGui") then
    gui.Parent = player:WaitForChild("PlayerGui")
end

-- Main Control Panel
local controlPanel = Instance.new("Frame")
controlPanel.Parent = gui
controlPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
controlPanel.BorderSizePixel = 0
controlPanel.Position = UDim2.new(0.5, -150, 0, 20)
controlPanel.Size = UDim2.new(0, 300, 0, 180)
controlPanel.Active = true
controlPanel.Draggable = true

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 15)
panelCorner.Parent = controlPanel

-- Gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
gradient.Rotation = 45
gradient.Parent = controlPanel

-- Title
local title = Instance.new("TextLabel")
title.Parent = controlPanel
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 0, 0, 10)
title.Size = UDim2.new(1, 0, 0, 30)
title.Font = Enum.Font.GothamBold
title.Text = "✈️ FLY + WALLHACK"
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.TextSize = 16

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Parent = controlPanel
closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, -30, 0, 10)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.AutoButtonColor = false

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 8)
closeBtnCorner.Parent = closeButton

-- Fly Button
local flyButton = Instance.new("TextButton")
flyButton.Parent = controlPanel
flyButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
flyButton.BorderSizePixel = 0
flyButton.Position = UDim2.new(0, 10, 0, 50)
flyButton.Size = UDim2.new(1, -20, 0, 50)
flyButton.Font = Enum.Font.GothamBold
flyButton.Text = ""
flyButton.AutoButtonColor = false

local flyBtnCorner = Instance.new("UICorner")
flyBtnCorner.CornerRadius = UDim.new(0, 10)
flyBtnCorner.Parent = flyButton

local flyLabel = Instance.new("TextLabel")
flyLabel.Parent = flyButton
flyLabel.BackgroundTransparency = 1
flyLabel.Position = UDim2.new(0, 15, 0, 0)
flyLabel.Size = UDim2.new(0, 200, 1, 0)
flyLabel.Font = Enum.Font.GothamBold
flyLabel.Text = "✈️ FLY MODE"
flyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
flyLabel.TextSize = 15
flyLabel.TextXAlignment = Enum.TextXAlignment.Left

local flyStatus = Instance.new("Frame")
flyStatus.Parent = flyButton
flyStatus.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
flyStatus.BorderSizePixel = 0
flyStatus.Position = UDim2.new(1, -60, 0.5, -12)
flyStatus.Size = UDim2.new(0, 50, 0, 24)

local flyStatusCorner = Instance.new("UICorner")
flyStatusCorner.CornerRadius = UDim.new(1, 0)
flyStatusCorner.Parent = flyStatus

local flyStatusText = Instance.new("TextLabel")
flyStatusText.Parent = flyStatus
flyStatusText.BackgroundTransparency = 1
flyStatusText.Size = UDim2.new(1, 0, 1, 0)
flyStatusText.Font = Enum.Font.GothamBold
flyStatusText.Text = "OFF"
flyStatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
flyStatusText.TextSize = 11

-- Wallhack Button
local wallButton = Instance.new("TextButton")
wallButton.Parent = controlPanel
wallButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
wallButton.BorderSizePixel = 0
wallButton.Position = UDim2.new(0, 10, 0, 110)
wallButton.Size = UDim2.new(1, -20, 0, 50)
wallButton.Font = Enum.Font.GothamBold
wallButton.Text = ""
wallButton.AutoButtonColor = false

local wallBtnCorner = Instance.new("UICorner")
wallBtnCorner.CornerRadius = UDim.new(0, 10)
wallBtnCorner.Parent = wallButton

local wallLabel = Instance.new("TextLabel")
wallLabel.Parent = wallButton
wallLabel.BackgroundTransparency = 1
wallLabel.Position = UDim2.new(0, 15, 0, 0)
wallLabel.Size = UDim2.new(0, 200, 1, 0)
wallLabel.Font = Enum.Font.GothamBold
wallLabel.Text = "👻 WALLHACK"
wallLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
wallLabel.TextSize = 15
wallLabel.TextXAlignment = Enum.TextXAlignment.Left

local wallStatus = Instance.new("Frame")
wallStatus.Parent = wallButton
wallStatus.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
wallStatus.BorderSizePixel = 0
wallStatus.Position = UDim2.new(1, -60, 0.5, -12)
wallStatus.Size = UDim2.new(0, 50, 0, 24)

local wallStatusCorner = Instance.new("UICorner")
wallStatusCorner.CornerRadius = UDim.new(1, 0)
wallStatusCorner.Parent = wallStatus

local wallStatusText = Instance.new("TextLabel")
wallStatusText.Parent = wallStatus
wallStatusText.BackgroundTransparency = 1
wallStatusText.Size = UDim2.new(1, 0, 1, 0)
wallStatusText.Font = Enum.Font.GothamBold
wallStatusText.Text = "OFF"
wallStatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
wallStatusText.TextSize = 11

print("✅ Control Panel Created")

-- ============================================
-- VIRTUAL JOYSTICK
-- ============================================
local joystickFrame = Instance.new("Frame")
joystickFrame.Parent = gui
joystickFrame.BackgroundTransparency = 1
joystickFrame.Position = UDim2.new(0, 30, 1, -170)
joystickFrame.Size = UDim2.new(0, 120, 0, 120)
joystickFrame.Visible = false
joystickFrame.ZIndex = 10

local joystickBase = Instance.new("Frame")
joystickBase.Parent = joystickFrame
joystickBase.AnchorPoint = Vector2.new(0.5, 0.5)
joystickBase.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
joystickBase.BackgroundTransparency = 0.4
joystickBase.Position = UDim2.new(0.5, 0, 0.5, 0)
joystickBase.Size = UDim2.new(0, 100, 0, 100)
joystickBase.ZIndex = 10

local joystickBaseCorner = Instance.new("UICorner")
joystickBaseCorner.CornerRadius = UDim.new(1, 0)
joystickBaseCorner.Parent = joystickBase

local joystickStick = Instance.new("Frame")
joystickStick.Parent = joystickBase
joystickStick.AnchorPoint = Vector2.new(0.5, 0.5)
joystickStick.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
joystickStick.Position = UDim2.new(0.5, 0, 0.5, 0)
joystickStick.Size = UDim2.new(0, 40, 0, 40)
joystickStick.ZIndex = 11

local joystickStickCorner = Instance.new("UICorner")
joystickStickCorner.CornerRadius = UDim.new(1, 0)
joystickStickCorner.Parent = joystickStick

-- Up/Down Buttons
local upButton = Instance.new("TextButton")
upButton.Parent = gui
upButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
upButton.BackgroundTransparency = 0.2
upButton.BorderSizePixel = 0
upButton.Position = UDim2.new(1, -90, 1, -170)
upButton.Size = UDim2.new(0, 60, 0, 60)
upButton.Font = Enum.Font.GothamBold
upButton.Text = "⬆"
upButton.TextColor3 = Color3.fromRGB(255, 255, 255)
upButton.TextSize = 24
upButton.Visible = false
upButton.ZIndex = 10

local upBtnCorner = Instance.new("UICorner")
upBtnCorner.CornerRadius = UDim.new(1, 0)
upBtnCorner.Parent = upButton

local downButton = Instance.new("TextButton")
downButton.Parent = gui
downButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
downButton.BackgroundTransparency = 0.2
downButton.BorderSizePixel = 0
downButton.Position = UDim2.new(1, -90, 1, -100)
downButton.Size = UDim2.new(0, 60, 0, 60)
downButton.Font = Enum.Font.GothamBold
downButton.Text = "⬇"
downButton.TextColor3 = Color3.fromRGB(255, 255, 255)
downButton.TextSize = 24
downButton.Visible = false
downButton.ZIndex = 10

local downBtnCorner = Instance.new("UICorner")
downBtnCorner.CornerRadius = UDim.new(1, 0)
downBtnCorner.Parent = downButton

-- Speed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = gui
speedLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
speedLabel.BackgroundTransparency = 0.3
speedLabel.BorderSizePixel = 0
speedLabel.Position = UDim2.new(0.5, -60, 1, -40)
speedLabel.Size = UDim2.new(0, 120, 0, 30)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Text = "Speed: 120"
speedLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
speedLabel.TextSize = 14
speedLabel.Visible = false
speedLabel.ZIndex = 10

local speedLabelCorner = Instance.new("UICorner")
speedLabelCorner.CornerRadius = UDim.new(0, 10)
speedLabelCorner.Parent = speedLabel

print("✅ Joystick Created")

-- ============================================
-- FLY FUNCTION
-- ============================================
local function toggleFly()
    flyActive = not flyActive
    
    if flyActive then
        local char = player.Character
        if not char then 
            flyActive = false
            return 
        end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then 
            flyActive = false
            return 
        end
        
        local hum = char:FindFirstChildOfType("Humanoid")
        if hum then
            hum.PlatformStand = true
        end
        
        -- Create physics objects
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.P = 1250
        bv.Parent = hrp
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 9e4
        bg.D = 500
        bg.CFrame = hrp.CFrame
        bg.Parent = hrp
        
        -- Show controls
        joystickFrame.Visible = true
        upButton.Visible = true
        downButton.Visible = true
        speedLabel.Visible = true
        
        -- Fly loop
        connections.fly = RunService.Heartbeat:Connect(function()
            if not flyActive or not hrp or not hrp.Parent then return end
            
            local cam = workspace.CurrentCamera
            if not cam then return end
            
            local moveDir = Vector3.new(0, 0, 0)
            
            -- Joystick horizontal movement
            if joystickInput.Magnitude > 0.1 then
                local camCFrame = cam.CFrame
                local forward = (camCFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                local right = (camCFrame.RightVector * Vector3.new(1, 0, 1)).Unit
                
                moveDir = moveDir + (forward * joystickInput.Y)
                moveDir = moveDir + (right * joystickInput.X)
            end
            
            -- Vertical movement
            if upPressed then
                moveDir = moveDir + Vector3.new(0, 1, 0)
            end
            if downPressed then
                moveDir = moveDir - Vector3.new(0, 1, 0)
            end
            
            -- Apply movement
            if moveDir.Magnitude > 0 then
                moveDir = moveDir.Unit
            end
            
            bv.Velocity = moveDir * flySpeed
            
            -- Update rotation
            if moveDir.Magnitude > 0.1 then
                local lookDir = (moveDir * Vector3.new(1, 0, 1)).Unit
                if lookDir.Magnitude > 0.1 then
                    bg.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + lookDir)
                end
            end
        end)
        
        -- UI Update
        flyStatus.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        flyStatusText.Text = "ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        
        print("✈️ [Fly] ON - Use joystick to fly!")
    else
        -- Stop fly
        if connections.fly then
            connections.fly:Disconnect()
            connections.fly = nil
        end
        
        -- Hide controls
        joystickFrame.Visible = false
        upButton.Visible = false
        downButton.Visible = false
        speedLabel.Visible = false
        joystickInput = Vector2.new(0, 0)
        upPressed = false
        downPressed = false
        
        -- Remove physics
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(hrp:GetChildren()) do
                    if obj.Name == "FlyVelocity" or obj.Name == "FlyGyro" then
                        obj:Destroy()
                    end
                end
            end
            
            local hum = char:FindFirstChildOfType("Humanoid")
            if hum then
                hum.PlatformStand = false
            end
        end
        
        -- UI Update
        flyStatus.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        flyStatusText.Text = "OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        print("✈️ [Fly] OFF")
    end
end

-- ============================================
-- WALLHACK FUNCTION
-- ============================================
local function toggleWallhack()
    noclipActive = not noclipActive
    
    if noclipActive then
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
        
        -- UI Update
        wallStatus.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        wallStatusText.Text = "ON"
        wallButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        
        print("👻 [Wallhack] ON - Walk through walls!")
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
        
        -- UI Update
        wallStatus.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        wallStatusText.Text = "OFF"
        wallButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        print("👻 [Wallhack] OFF")
    end
end

-- ============================================
-- JOYSTICK CONTROLS
-- ============================================
joystickBase.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        touching = true
        
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if not touching then 
                connection:Disconnect()
                return 
            end
            
            local mouse = UserInputService:GetMouseLocation()
            local center = joystickBase.AbsolutePosition + joystickBase.AbsoluteSize / 2
            local delta = Vector2.new(mouse.X - center.X, mouse.Y - center.Y)
            local dist = math.min(delta.Magnitude, 30)
            local dir = delta.Unit
            
            if delta.Magnitude > 0.1 then
                joystickStick.Position = UDim2.new(0.5, dir.X * dist, 0.5, dir.Y * dist)
                joystickInput = Vector2.new(dir.X, -dir.Y) * (dist / 30)
            else
                joystickStick.Position = UDim2.new(0.5, 0, 0.5, 0)
                joystickInput = Vector2.new(0, 0)
            end
        end)
    end
end)

joystickBase.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        touching = false
        joystickInput = Vector2.new(0, 0)
        joystickStick.Position = UDim2.new(0.5, 0, 0.5, 0)
    end
end)

-- Up/Down buttons
upButton.InputBegan:Connect(function()
    upPressed = true
    upButton.BackgroundTransparency = 0
end)

upButton.InputEnded:Connect(function()
    upPressed = false
    upButton.BackgroundTransparency = 0.2
end)

downButton.InputBegan:Connect(function()
    downPressed = true
    downButton.BackgroundTransparency = 0
end)

downButton.InputEnded:Connect(function()
    downPressed = false
    downButton.BackgroundTransparency = 0.2
end)

-- Speed adjustment (tap speed label to cycle speeds)
local speeds = {60, 120, 200, 300}
local currentSpeedIndex = 2

speedLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        currentSpeedIndex = currentSpeedIndex + 1
        if currentSpeedIndex > #speeds then
            currentSpeedIndex = 1
        end
        flySpeed = speeds[currentSpeedIndex]
        speedLabel.Text = "Speed: " .. flySpeed
    end
end)

-- ============================================
-- BUTTON CLICKS
-- ============================================
flyButton.MouseButton1Click:Connect(toggleFly)
wallButton.MouseButton1Click:Connect(toggleWallhack)

closeButton.MouseButton1Click:Connect(function()
    flyActive = false
    noclipActive = false
    
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    
    local char = player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, obj in pairs(hrp:GetChildren()) do
                if obj.Name == "FlyVelocity" or obj.Name == "FlyGyro" then
                    obj:Destroy()
                end
            end
        end
        
        local hum = char:FindFirstChildOfType("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
        
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
    
    gui:Destroy()
    print("Script closed!")
end)

-- Startup animation
controlPanel.Size = UDim2.new(0, 0, 0, 0)
controlPanel:TweenSize(UDim2.new(0, 300, 0, 180), "Out", "Elastic", 0.6, true)

-- Success message
print("╔════════════════════════════════╗")
print("║  MOBILE FLY + WALLHACK ✅      ║")
print("╠════════════════════════════════╣")
print("║  ✈️  Fly: Virtual Joystick     ║")
print("║      Tap speed to change       ║")
print("║  👻 Wallhack: Walk through     ║")
print("║  📱 Optimized for Mobile       ║")
print("╚════════════════════════════════╝")
