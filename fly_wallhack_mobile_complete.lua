-- FLY + WALLHACK MOBILE (COMPLETE & WORKING)
-- By: Script Fix Team

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

print("🔄 Loading script...")

-- Wait for character
repeat wait() until player.Character
wait(1)

-- Variables
local flyActive = false
local noclipActive = false
local flySpeed = 150
local connections = {}

-- GUI Creation
local gui = Instance.new("ScreenGui")
gui.Name = "FlyWallhackMobile"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true

local success = pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)
if not success then
    gui.Parent = player:WaitForChild("PlayerGui")
end

print("✅ GUI Parent set")

-- Main Frame
local frame = Instance.new("Frame")
frame.Parent = gui
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.5, -160, 0, 50)
frame.Size = UDim2.new(0, 320, 0, 240)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

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
title.Text = "FLY + WALLHACK"
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
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
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

local flyTitle = Instance.new("TextLabel")
flyTitle.Parent = flyButton
flyTitle.BackgroundTransparency = 1
flyTitle.Position = UDim2.new(0, 15, 0, 8)
flyTitle.Size = UDim2.new(0, 200, 0, 20)
flyTitle.Font = Enum.Font.GothamBold
flyTitle.Text = "FLY MODE"
flyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyTitle.TextSize = 14
flyTitle.TextXAlignment = Enum.TextXAlignment.Left

local flyDesc = Instance.new("TextLabel")
flyDesc.Parent = flyButton
flyDesc.BackgroundTransparency = 1
flyDesc.Position = UDim2.new(0, 15, 0, 28)
flyDesc.Size = UDim2.new(0, 200, 0, 18)
flyDesc.Font = Enum.Font.Gotham
flyDesc.Text = "Use joystick to fly"
flyDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
flyDesc.TextSize = 11
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

local wallTitle = Instance.new("TextLabel")
wallTitle.Parent = wallButton
wallTitle.BackgroundTransparency = 1
wallTitle.Position = UDim2.new(0, 15, 0, 8)
wallTitle.Size = UDim2.new(0, 200, 0, 20)
wallTitle.Font = Enum.Font.GothamBold
wallTitle.Text = "WALLHACK"
wallTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
wallTitle.TextSize = 14
wallTitle.TextXAlignment = Enum.TextXAlignment.Left

local wallDesc = Instance.new("TextLabel")
wallDesc.Parent = wallButton
wallDesc.BackgroundTransparency = 1
wallDesc.Position = UDim2.new(0, 15, 0, 28)
wallDesc.Size = UDim2.new(0, 200, 0, 18)
wallDesc.Font = Enum.Font.Gotham
wallDesc.Text = "Walk through walls"
wallDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
wallDesc.TextSize = 11
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
statusText.Text = "Mobile Mode Ready"
statusText.TextColor3 = Color3.fromRGB(100, 200, 255)
statusText.TextSize = 11
statusText.TextXAlignment = Enum.TextXAlignment.Left

print("✅ GUI created")

-- Joystick for Mobile
local joystickFrame = Instance.new("Frame")
joystickFrame.Parent = gui
joystickFrame.BackgroundTransparency = 1
joystickFrame.Position = UDim2.new(0, 40, 1, -190)
joystickFrame.Size = UDim2.new(0, 140, 0, 140)
joystickFrame.Visible = false

local joystickBase = Instance.new("Frame")
joystickBase.Parent = joystickFrame
joystickBase.AnchorPoint = Vector2.new(0.5, 0.5)
joystickBase.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
joystickBase.BackgroundTransparency = 0.5
joystickBase.Position = UDim2.new(0.5, 0, 0.5, 0)
joystickBase.Size = UDim2.new(0, 100, 0, 100)

local joystickBaseCorner = Instance.new("UICorner")
joystickBaseCorner.CornerRadius = UDim.new(1, 0)
joystickBaseCorner.Parent = joystickBase

local joystickStick = Instance.new("Frame")
joystickStick.Parent = joystickBase
joystickStick.AnchorPoint = Vector2.new(0.5, 0.5)
joystickStick.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
joystickStick.Position = UDim2.new(0.5, 0, 0.5, 0)
joystickStick.Size = UDim2.new(0, 40, 0, 40)

local joystickStickCorner = Instance.new("UICorner")
joystickStickCorner.CornerRadius = UDim.new(1, 0)
joystickStickCorner.Parent = joystickStick

-- Up/Down buttons
local upButton = Instance.new("TextButton")
upButton.Parent = gui
upButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
upButton.BackgroundTransparency = 0.3
upButton.BorderSizePixel = 0
upButton.Position = UDim2.new(1, -100, 1, -190)
upButton.Size = UDim2.new(0, 55, 0, 55)
upButton.Font = Enum.Font.GothamBold
upButton.Text = "UP"
upButton.TextColor3 = Color3.fromRGB(255, 255, 255)
upButton.TextSize = 16
upButton.Visible = false

local upCorner = Instance.new("UICorner")
upCorner.CornerRadius = UDim.new(1, 0)
upCorner.Parent = upButton

local downButton = Instance.new("TextButton")
downButton.Parent = gui
downButton.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
downButton.BackgroundTransparency = 0.3
downButton.BorderSizePixel = 0
downButton.Position = UDim2.new(1, -100, 1, -125)
downButton.Size = UDim2.new(0, 55, 0, 55)
downButton.Font = Enum.Font.GothamBold
downButton.Text = "DOWN"
downButton.TextColor3 = Color3.fromRGB(255, 255, 255)
downButton.TextSize = 14
downButton.Visible = false

local downCorner = Instance.new("UICorner")
downCorner.CornerRadius = UDim.new(1, 0)
downCorner.Parent = downButton

-- Joystick variables
local joystickInput = Vector2.new(0, 0)
local upPressed = false
local downPressed = false
local touching = false

-- FLY FUNCTION
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
        
        -- Physics
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = hrp
        
        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 9e4
        bg.CFrame = hrp.CFrame
        bg.Parent = hrp
        
        -- Show controls
        joystickFrame.Visible = true
        upButton.Visible = true
        downButton.Visible = true
        
        -- Fly loop
        connections.fly = RunService.Heartbeat:Connect(function()
            if not flyActive or not hrp or not hrp.Parent then return end
            
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.new(0, 0, 0)
            
            -- Joystick movement
            if joystickInput.Magnitude > 0.1 then
                local forward = (cam.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                local right = (cam.CFrame.RightVector * Vector3.new(1, 0, 1)).Unit
                moveDir = moveDir + (forward * joystickInput.Y) + (right * joystickInput.X)
            end
            
            -- Vertical movement
            if upPressed then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if downPressed then moveDir = moveDir - Vector3.new(0, 1, 0) end
            
            if moveDir.Magnitude > 0 then
                moveDir = moveDir.Unit
            end
            
            bv.Velocity = moveDir * flySpeed
            
            if moveDir.Magnitude > 0.1 then
                local lookDir = (moveDir * Vector3.new(1, 0, 1)).Unit
                if lookDir.Magnitude > 0.1 then
                    bg.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + lookDir)
                end
            end
        end)
        
        -- UI update
        flyIndicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        flyIndText.Text = "ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "Flying! Use joystick"
        
        print("✈️ Fly Mode: ON")
    else
        -- Stop fly
        if connections.fly then 
            connections.fly:Disconnect()
            connections.fly = nil
        end
        
        joystickFrame.Visible = false
        upButton.Visible = false
        downButton.Visible = false
        joystickInput = Vector2.new(0, 0)
        upPressed = false
        downPressed = false
        
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
            
            local hum = char:FindFirstChildOfType("Humanoid")
            if hum then
                hum.PlatformStand = false
            end
        end
        
        flyIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        flyIndText.Text = "OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        statusText.Text = "Mobile Mode Ready"
        
        print("✈️ Fly Mode: OFF")
    end
end

-- WALLHACK FUNCTION
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
        
        wallIndicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        wallIndText.Text = "ON"
        wallButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "Wallhack active!"
        
        print("👻 Wallhack: ON")
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
        
        wallIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        wallIndText.Text = "OFF"
        wallButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        statusText.Text = "Mobile Mode Ready"
        
        print("👻 Wallhack: OFF")
    end
end

-- JOYSTICK CONTROLS
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

upButton.InputBegan:Connect(function()
    upPressed = true
    upButton.BackgroundTransparency = 0
end)

upButton.InputEnded:Connect(function()
    upPressed = false
    upButton.BackgroundTransparency = 0.3
end)

downButton.InputBegan:Connect(function()
    downPressed = true
    downButton.BackgroundTransparency = 0
end)

downButton.InputEnded:Connect(function()
    downPressed = false
    downButton.BackgroundTransparency = 0.3
end)

-- BUTTON CLICKS
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
                if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                    obj:Destroy()
                end
            end
        end
        
        local hum = char:FindFirstChildOfType("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
    end
    
    gui:Destroy()
    print("Script closed")
end)

-- Startup
frame.Size = UDim2.new(0, 0, 0, 0)
frame:TweenSize(UDim2.new(0, 320, 0, 240), "Out", "Elastic", 0.6, true)

print("╔════════════════════════════╗")
print("║  FLY + WALLHACK LOADED ✅  ║")
print("╠════════════════════════════╣")
print("║  Click buttons to activate ║")
print("╚════════════════════════════╝")
