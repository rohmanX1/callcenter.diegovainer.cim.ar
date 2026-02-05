local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local flyActive = false
local noclipActive = false
local flySpeed = 150
local connections = {}
local isMobile = UserInputService.TouchEnabled

-- GUI Creation
local gui = Instance.new("ScreenGui")
gui.Name = "FlyWallhackMobile"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)
if gui.Parent ~= game:GetService("CoreGui") then
    gui.Parent = player:WaitForChild("PlayerGui")
end

-- Main Frame
local frame = Instance.new("Frame")
frame.Parent = gui
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.5, -160, 0, 20)
frame.Size = UDim2.new(0, 320, 0, 240)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

-- Gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
gradient.Rotation = 45
gradient.Parent = frame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Parent = frame
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
topBar.BorderSizePixel = 0
topBar.Size = UDim2.new(1, 0, 0, 45)

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 15)
topCorner.Parent = topBar

-- Title
local title = Instance.new("TextLabel")
title.Parent = topBar
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 12, 0, 0)
title.Size = UDim2.new(1, -50, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "✈️ FLY + WALLHACK"
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Parent = topBar
closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, -35, 0, 7)
closeButton.Size = UDim2.new(0, 28, 0, 28)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.AutoButtonColor = false

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- FLY Button
local flyButton = Instance.new("TextButton")
flyButton.Parent = frame
flyButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
flyButton.BorderSizePixel = 0
flyButton.Position = UDim2.new(0, 10, 0, 55)
flyButton.Size = UDim2.new(1, -20, 0, 50)
flyButton.Font = Enum.Font.GothamBold
flyButton.Text = ""
flyButton.AutoButtonColor = false

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 12)
flyCorner.Parent = flyButton

local flyIcon = Instance.new("TextLabel")
flyIcon.Parent = flyButton
flyIcon.BackgroundTransparency = 1
flyIcon.Position = UDim2.new(0, 12, 0, 0)
flyIcon.Size = UDim2.new(0, 40, 1, 0)
flyIcon.Font = Enum.Font.GothamBold
flyIcon.Text = "✈️"
flyIcon.TextColor3 = Color3.fromRGB(100, 200, 255)
flyIcon.TextSize = 24

local flyTitle = Instance.new("TextLabel")
flyTitle.Parent = flyButton
flyTitle.BackgroundTransparency = 1
flyTitle.Position = UDim2.new(0, 55, 0, 6)
flyTitle.Size = UDim2.new(0, 150, 0, 22)
flyTitle.Font = Enum.Font.GothamBold
flyTitle.Text = "FLY MODE"
flyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyTitle.TextSize = 14
flyTitle.TextXAlignment = Enum.TextXAlignment.Left

local flyDesc = Instance.new("TextLabel")
flyDesc.Parent = flyButton
flyDesc.BackgroundTransparency = 1
flyDesc.Position = UDim2.new(0, 55, 0, 28)
flyDesc.Size = UDim2.new(0, 150, 0, 18)
flyDesc.Font = Enum.Font.Gotham
flyDesc.Text = "Use joystick to fly"
flyDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
flyDesc.TextSize = 10
flyDesc.TextXAlignment = Enum.TextXAlignment.Left

local flyIndicator = Instance.new("Frame")
flyIndicator.Parent = flyButton
flyIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
flyIndicator.BorderSizePixel = 0
flyIndicator.Position = UDim2.new(1, -60, 0.5, -12)
flyIndicator.Size = UDim2.new(0, 50, 0, 24)

local flyIndCorner = Instance.new("UICorner")
flyIndCorner.CornerRadius = UDim.new(1, 0)
flyIndCorner.Parent = flyIndicator

local flyIndText = Instance.new("TextLabel")
flyIndText.Parent = flyIndicator
flyIndText.BackgroundTransparency = 1
flyIndText.Size = UDim2.new(1, 0, 1, 0)
flyIndText.Font = Enum.Font.GothamBold
flyIndText.Text = "OFF"
flyIndText.TextColor3 = Color3.fromRGB(255, 255, 255)
flyIndText.TextSize = 11

-- WALLHACK Button
local wallButton = Instance.new("TextButton")
wallButton.Parent = frame
wallButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
wallButton.BorderSizePixel = 0
wallButton.Position = UDim2.new(0, 10, 0, 115)
wallButton.Size = UDim2.new(1, -20, 0, 50)
wallButton.Font = Enum.Font.GothamBold
wallButton.Text = ""
wallButton.AutoButtonColor = false

local wallCorner = Instance.new("UICorner")
wallCorner.CornerRadius = UDim.new(0, 12)
wallCorner.Parent = wallButton

local wallIcon = Instance.new("TextLabel")
wallIcon.Parent = wallButton
wallIcon.BackgroundTransparency = 1
wallIcon.Position = UDim2.new(0, 12, 0, 0)
wallIcon.Size = UDim2.new(0, 40, 1, 0)
wallIcon.Font = Enum.Font.GothamBold
wallIcon.Text = "👻"
wallIcon.TextColor3 = Color3.fromRGB(100, 200, 255)
wallIcon.TextSize = 24

local wallTitle = Instance.new("TextLabel")
wallTitle.Parent = wallButton
wallTitle.BackgroundTransparency = 1
wallTitle.Position = UDim2.new(0, 55, 0, 6)
wallTitle.Size = UDim2.new(0, 150, 0, 22)
wallTitle.Font = Enum.Font.GothamBold
wallTitle.Text = "WALLHACK"
wallTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
wallTitle.TextSize = 14
wallTitle.TextXAlignment = Enum.TextXAlignment.Left

local wallDesc = Instance.new("TextLabel")
wallDesc.Parent = wallButton
wallDesc.BackgroundTransparency = 1
wallDesc.Position = UDim2.new(0, 55, 0, 28)
wallDesc.Size = UDim2.new(0, 150, 0, 18)
wallDesc.Font = Enum.Font.Gotham
wallDesc.Text = "Walk through walls"
wallDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
wallDesc.TextSize = 10
wallDesc.TextXAlignment = Enum.TextXAlignment.Left

local wallIndicator = Instance.new("Frame")
wallIndicator.Parent = wallButton
wallIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
wallIndicator.BorderSizePixel = 0
wallIndicator.Position = UDim2.new(1, -60, 0.5, -12)
wallIndicator.Size = UDim2.new(0, 50, 0, 24)

local wallIndCorner = Instance.new("UICorner")
wallIndCorner.CornerRadius = UDim.new(1, 0)
wallIndCorner.Parent = wallIndicator

local wallIndText = Instance.new("TextLabel")
wallIndText.Parent = wallIndicator
wallIndText.BackgroundTransparency = 1
wallIndText.Size = UDim2.new(1, 0, 1, 0)
wallIndText.Font = Enum.Font.GothamBold
wallIndText.Text = "OFF"
wallIndText.TextColor3 = Color3.fromRGB(255, 255, 255)
wallIndText.TextSize = 11

-- Status Bar
local statusBar = Instance.new("Frame")
statusBar.Parent = frame
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
statusText.Position = UDim2.new(0, 12, 0, 0)
statusText.Size = UDim2.new(1, -24, 1, 0)
statusText.Font = Enum.Font.Gotham
statusText.Text = "📱 Mobile Mode Ready"
statusText.TextColor3 = Color3.fromRGB(100, 200, 255)
statusText.TextSize = 11
statusText.TextXAlignment = Enum.TextXAlignment.Left

-- ============================================
-- MOBILE JOYSTICK (untuk Fly)
-- ============================================
local joystickFrame = Instance.new("Frame")
joystickFrame.Parent = gui
joystickFrame.BackgroundTransparency = 1
joystickFrame.Position = UDim2.new(0, 50, 1, -200)
joystickFrame.Size = UDim2.new(0, 150, 0, 150)
joystickFrame.Visible = false
joystickFrame.ZIndex = 10

local joystickOuter = Instance.new("Frame")
joystickOuter.Parent = joystickFrame
joystickOuter.AnchorPoint = Vector2.new(0.5, 0.5)
joystickOuter.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
joystickOuter.BackgroundTransparency = 0.3
joystickOuter.Position = UDim2.new(0.5, 0, 0.5, 0)
joystickOuter.Size = UDim2.new(0, 120, 0, 120)
joystickOuter.ZIndex = 10

local joystickOuterCorner = Instance.new("UICorner")
joystickOuterCorner.CornerRadius = UDim.new(1, 0)
joystickOuterCorner.Parent = joystickOuter

local joystickInner = Instance.new("Frame")
joystickInner.Parent = joystickOuter
joystickInner.AnchorPoint = Vector2.new(0.5, 0.5)
joystickInner.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
joystickInner.BackgroundTransparency = 0.2
joystickInner.Position = UDim2.new(0.5, 0, 0.5, 0)
joystickInner.Size = UDim2.new(0, 50, 0, 50)
joystickInner.ZIndex = 11

local joystickInnerCorner = Instance.new("UICorner")
joystickInnerCorner.CornerRadius = UDim.new(1, 0)
joystickInnerCorner.Parent = joystickInner

-- Up/Down Buttons
local upButton = Instance.new("TextButton")
upButton.Parent = gui
upButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
upButton.BackgroundTransparency = 0.2
upButton.BorderSizePixel = 0
upButton.Position = UDim2.new(1, -130, 1, -200)
upButton.Size = UDim2.new(0, 60, 0, 60)
upButton.Font = Enum.Font.GothamBold
upButton.Text = "⬆"
upButton.TextColor3 = Color3.fromRGB(255, 255, 255)
upButton.TextSize = 28
upButton.Visible = false
upButton.ZIndex = 10

local upCorner = Instance.new("UICorner")
upCorner.CornerRadius = UDim.new(1, 0)
upCorner.Parent = upButton

local downButton = Instance.new("TextButton")
downButton.Parent = gui
downButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
downButton.BackgroundTransparency = 0.2
downButton.BorderSizePixel = 0
downButton.Position = UDim2.new(1, -130, 1, -130)
downButton.Size = UDim2.new(0, 60, 0, 60)
downButton.Font = Enum.Font.GothamBold
downButton.Text = "⬇"
downButton.TextColor3 = Color3.fromRGB(255, 255, 255)
downButton.TextSize = 28
downButton.Visible = false
downButton.ZIndex = 10

local downCorner = Instance.new("UICorner")
downCorner.CornerRadius = UDim.new(1, 0)
downCorner.Parent = downButton

-- Joystick Variables
local joystickActive = false
local joystickInput = Vector2.new(0, 0)
local upPressed = false
local downPressed = false

-- ============================================
-- FLY FUNCTION (Mobile optimized)
-- ============================================
local function toggleFly()
    flyActive = not flyActive
    
    if flyActive then
        local char = player.Character
        if not char then 
            warn("[Fly] Character not found!")
            flyActive = false
            return 
        end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then 
            warn("[Fly] HumanoidRootPart not found!")
            flyActive = false
            return 
        end
        
        local humanoid = char:FindFirstChildOfType("Humanoid")
        if humanoid then
            humanoid.PlatformStand = true
        end
        
        -- Create BodyVelocity for smooth movement
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.P = 1250
        bv.Parent = hrp
        
        -- Create BodyGyro for rotation
        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 9e4
        bg.D = 500
        bg.CFrame = hrp.CFrame
        bg.Parent = hrp
        
        -- Show joystick
        joystickFrame.Visible = true
        upButton.Visible = true
        downButton.Visible = true
        
        -- Fly loop
        connections.fly = RunService.Heartbeat:Connect(function()
            if not flyActive or not hrp or not hrp.Parent then return end
            
            local cam = workspace.CurrentCamera
            if not cam then return end
            
            -- Calculate direction based on joystick and camera
            local moveDirection = Vector3.new(0, 0, 0)
            
            -- Horizontal movement (joystick)
            if joystickInput.Magnitude > 0.1 then
                local camCFrame = cam.CFrame
                local forwardVector = (camCFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                local rightVector = (camCFrame.RightVector * Vector3.new(1, 0, 1)).Unit
                
                moveDirection = moveDirection + (forwardVector * joystickInput.Y)
                moveDirection = moveDirection + (rightVector * joystickInput.X)
            end
            
            -- Vertical movement (buttons)
            if upPressed then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if downPressed then
                moveDirection = moveDirection + Vector3.new(0, -1, 0)
            end
            
            -- Normalize and apply speed
            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit
            end
            
            bv.Velocity = moveDirection * flySpeed
            
            -- Update rotation to face movement direction or camera
            if moveDirection.Magnitude > 0.1 then
                local lookDirection = (moveDirection * Vector3.new(1, 0, 1)).Unit
                if lookDirection.Magnitude > 0.1 then
                    bg.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + lookDirection)
                end
            else
                bg.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)
            end
        end)
        
        -- Update UI
        flyIndicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        flyIndText.Text = "ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "✈️ Flying! Use joystick + ⬆⬇"
        
        print("✈️ [Fly Mode] ACTIVATED (Mobile)")
    else
        -- Disconnect connections
        if connections.fly then 
            connections.fly:Disconnect() 
            connections.fly = nil 
        end
        
        -- Hide joystick
        joystickFrame.Visible = false
        upButton.Visible = false
        downButton.Visible = false
        joystickInput = Vector2.new(0, 0)
        upPressed = false
        downPressed = false
        
        -- Remove physics objects
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in pairs(hrp:GetChildren()) do
                    if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                        obj:Destroy()
                    end
                end
            end
            
            local humanoid = char:FindFirstChildOfType("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
        
        -- Update UI
        flyIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        flyIndText.Text = "OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        if not noclipActive then
            statusText.Text = "📱 Mobile Mode Ready"
        end
        
        print("✈️ [Fly Mode] DEACTIVATED")
    end
end

-- ============================================
-- JOYSTICK TOUCH HANDLING
-- ============================================
local joystickConnection
joystickOuter.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        joystickActive = true
        
        if joystickConnection then
            joystickConnection:Disconnect()
        end
        
        joystickConnection = RunService.RenderStepped:Connect(function()
            if not joystickActive then return end
            
            local mousePos = UserInputService:GetMouseLocation()
            local joystickCenter = joystickOuter.AbsolutePosition + joystickOuter.AbsoluteSize / 2
            
            local delta = Vector2.new(mousePos.X - joystickCenter.X, mousePos.Y - joystickCenter.Y)
            local distance = math.min(delta.Magnitude, 35)
            local direction = delta.Unit
            
            if delta.Magnitude > 0.1 then
                joystickInner.Position = UDim2.new(0.5, direction.X * distance, 0.5, direction.Y * distance)
                joystickInput = Vector2.new(direction.X, -direction.Y) * (distance / 35)
            else
                joystickInner.Position = UDim2.new(0.5, 0, 0.5, 0)
                joystickInput = Vector2.new(0, 0)
            end
        end)
    end
end)

joystickOuter.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        joystickActive = false
        joystickInput = Vector2.new(0, 0)
        joystickInner.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        if joystickConnection then
            joystickConnection:Disconnect()
            joystickConnection = nil
        end
    end
end)

-- Up/Down button handling
upButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        upPressed = true
        upButton.BackgroundTransparency = 0
    end
end)

upButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        upPressed = false
        upButton.BackgroundTransparency = 0.2
    end
end)

downButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        downPressed = true
        downButton.BackgroundTransparency = 0
    end
end)

downButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        downPressed = false
        downButton.BackgroundTransparency = 0.2
    end
end)

-- ============================================
-- WALLHACK FUNCTION
-- ============================================
local function toggleWallhack()
    noclipActive = not noclipActive
    
    if noclipActive then
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
        
        -- Update UI
        wallIndicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        wallIndText.Text = "ON"
        wallButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "👻 Wallhack active!"
        
        print("👻 [Wallhack] ACTIVATED")
    else
        if connections.noclip then
            connections.noclip:Disconnect()
            connections.noclip = nil
        end
        
        -- Re-enable collision
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
        
        -- Update UI
        wallIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        wallIndText.Text = "OF"
wallButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        if not flyActive then
            statusText.Text = "📱 Mobile Mode Ready"
        end
        
        print("👻 [Wallhack] DEACTIVATED")
    end
end

-- ============================================
-- BUTTON CLICKS
-- ============================================
flyButton.MouseButton1Click:Connect(toggleFly)
wallButton.MouseButton1Click:Connect(toggleWallhack)

-- Close button
closeButton.MouseButton1Click:Connect(function()
    flyActive = false
    noclipActive = false
    
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    
    if joystickConnection then
        joystickConnection:Disconnect()
    end
    
    local char = player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, obj in pairs(hrp:GetChildren()) do
                if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                    obj:Destroy()
                end
            end
        end
        
        local humanoid = char:FindFirstChildOfType("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
    
    gui:Destroy()
    print("Script closed!")
end)

-- Hover/Touch effects
flyButton.MouseEnter:Connect(function()
    if not flyActive then
        flyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    end
end)

flyButton.MouseLeave:Connect(function()
    if not flyActive then
        flyButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    end
end)

wallButton.MouseEnter:Connect(function()
    if not noclipActive then
        wallButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    end
end)

wallButton.MouseLeave:Connect(function()
    if not noclipActive then
        wallButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    end
end)

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
end)

closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
end)

-- Auto re-enable after respawn
player.CharacterAdded:Connect(function(char)
    wait(0.5)
    
    if flyActive or noclipActive then
        print("⚠️ Character respawned - Features still active")
    end
end)

-- Startup animation
frame.Size = UDim2.new(0, 0, 0, 0)
frame:TweenSize(UDim2.new(0, 320, 0, 240), "Out", "Elastic", 0.7, true)

-- Success message
print("╔═══════════════════════════════╗")
print("║ FLY + WALLHACK MOBILE ✅      ║")
print("╠═══════════════════════════════╣")
print("║ ✈️  Fly: Virtual Joystick     ║")
print("║ 👻 Wallhack: Walk through     ║")
print("║ 📱 Optimized for Mobile       ║")
print("╚═══════════════════════════════╝")
