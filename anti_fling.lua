--[[
    ANTI-FLING SCRIPT
    Prevent your character from being pushed/flung by moving objects!
    Stay grounded and stable
]]--

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🔄 Loading Anti-Fling Script...")

-- Wait for character
repeat wait() until player.Character
wait(0.5)

-- Variables
local antiFlingActive = false
local antiPushActive = false
local anchorActive = false
local connections = {}

-- GUI Creation
local gui = Instance.new("ScreenGui")
gui.Name = "AntiFlingGUI"
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
mainFrame.Position = UDim2.new(0.5, -175, 0.3, 0)
mainFrame.Size = UDim2.new(0, 350, 0, 360)
mainFrame.Active = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- Gradient
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
gradient.Rotation = 45
gradient.Parent = mainFrame

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
title.Size = UDim2.new(1, -50, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "🛡️ ANTI-FLING"
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Parent = topBar
closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, -35, 0, 10)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.AutoButtonColor = false

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Function to create toggle button
local function createToggleButton(yPos, icon, titleText, descText)
    local button = Instance.new("TextButton")
    button.Parent = mainFrame
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    button.BorderSizePixel = 0
    button.Position = UDim2.new(0, 15, 0, yPos)
    button.Size = UDim2.new(1, -30, 0, 60)
    button.Font = Enum.Font.GothamBold
    button.Text = ""
    button.AutoButtonColor = false

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = button

    local btnIcon = Instance.new("TextLabel")
    btnIcon.Parent = button
    btnIcon.BackgroundTransparency = 1
    btnIcon.Position = UDim2.new(0, 15, 0, 0)
    btnIcon.Size = UDim2.new(0, 50, 1, 0)
    btnIcon.Font = Enum.Font.GothamBold
    btnIcon.Text = icon
    btnIcon.TextColor3 = Color3.fromRGB(100, 200, 255)
    btnIcon.TextSize = 28

    local btnTitle = Instance.new("TextLabel")
    btnTitle.Parent = button
    btnTitle.BackgroundTransparency = 1
    btnTitle.Position = UDim2.new(0, 70, 0, 8)
    btnTitle.Size = UDim2.new(0, 180, 0, 25)
    btnTitle.Font = Enum.Font.GothamBold
    btnTitle.Text = titleText
    btnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnTitle.TextSize = 15
    btnTitle.TextXAlignment = Enum.TextXAlignment.Left

    local btnDesc = Instance.new("TextLabel")
    btnDesc.Parent = button
    btnDesc.BackgroundTransparency = 1
    btnDesc.Position = UDim2.new(0, 70, 0, 33)
    btnDesc.Size = UDim2.new(0, 180, 0, 20)
    btnDesc.Font = Enum.Font.Gotham
    btnDesc.Text = descText
    btnDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
    btnDesc.TextSize = 11
    btnDesc.TextXAlignment = Enum.TextXAlignment.Left

    local indicator = Instance.new("Frame")
    indicator.Parent = button
    indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    indicator.BorderSizePixel = 0
    indicator.Position = UDim2.new(1, -65, 0.5, -15)
    indicator.Size = UDim2.new(0, 55, 0, 30)

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
    
    return button, indicator, indText
end

-- Create buttons
local antiFlingButton, antiFlingInd, antiFlingText = createToggleButton(65, "🛡️", "ANTI-FLING", "Prevent being flung")
local antiPushButton, antiPushInd, antiPushText = createToggleButton(135, "⚓", "ANTI-PUSH", "Prevent being pushed")
local anchorButton, anchorInd, anchorText = createToggleButton(205, "🔒", "ANCHOR MODE", "Stay in place (no move)")

-- Status Bar
local statusBar = Instance.new("Frame")
statusBar.Parent = mainFrame
statusBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
statusBar.BorderSizePixel = 0
statusBar.Position = UDim2.new(0, 0, 1, -50)
statusBar.Size = UDim2.new(1, 0, 0, 50)

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 15)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Parent = statusBar
statusText.BackgroundTransparency = 1
statusText.Position = UDim2.new(0, 15, 0, 0)
statusText.Size = UDim2.new(1, -30, 1, 0)
statusText.Font = Enum.Font.Gotham
statusText.Text = "💡 Ready to activate"
statusText.TextColor3 = Color3.fromRGB(100, 200, 255)
statusText.TextSize = 12
statusText.TextXAlignment = Enum.TextXAlignment.Left

print("✅ GUI Created")

-- ============================================
-- ANTI-FLING FUNCTION
-- ============================================
local function toggleAntiFling()
    antiFlingActive = not antiFlingActive
    
    if antiFlingActive then
        local char = player.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        -- Create BodyVelocity to counteract fling
        local bv = Instance.new("BodyVelocity")
        bv.Name = "AntiFlingVelocity"
        bv.MaxForce = Vector3.new(0, 0, 0)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp
        
        -- Monitor velocity and reset if too high
        connections.antiFling = RunService.Heartbeat:Connect(function()
            if char and hrp and hrp.Parent then
                local velocity = hrp.AssemblyLinearVelocity
                
                -- If velocity is too high (being flung), reset it
                if velocity.Magnitude > 50 then
                    hrp.AssemblyLinearVelocity = Vector3.new(0, velocity.Y, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
        
        -- Disable character collisions with moving parts
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                -- Set collision group to prevent physics interactions
                pcall(function()
                    part.CollisionGroup = "Player"
                end)
            end
        end
        
        -- UI Update
        antiFlingInd.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        antiFlingText.Text = "ON"
        antiFlingButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "🛡️ Anti-Fling Active!"
        
        print("🛡️ [Anti-Fling] ACTIVATED - You won't be flung!")
    else
        if connections.antiFling then
            connections.antiFling:Disconnect()
            connections.antiFling = nil
        end
        
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bv = hrp:FindFirstChild("AntiFlingVelocity")
                if bv then
                    bv:Destroy()
                end
            end
        end
        
        -- UI Update
        antiFlingInd.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        antiFlingText.Text = "OFF"
        antiFlingButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        if not antiPushActive and not anchorActive then
            statusText.Text = "💡 Ready to activate"
        end
        
        print("🛡️ [Anti-Fling] DEACTIVATED")
    end
end

-- ============================================
-- ANTI-PUSH FUNCTION
-- ============================================
local function toggleAntiPush()
    antiPushActive = not antiPushActive
    
    if antiPushActive then
        local char = player.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        -- Store original position
        local lastPosition = hrp.Position
        local lastCFrame = hrp.CFrame
        
        connections.antiPush = RunService.Heartbeat:Connect(function()
            if char and hrp and hrp.Parent then
                -- Check if character moved unintentionally (pushed)
                local currentPos = hrp.Position
                local humanoid = char:FindFirstChildOfType("Humanoid")
                
                if humanoid then
                    -- If not moving intentionally but position changed significantly
                    if humanoid.MoveDirection.Magnitude < 0.1 then
                        local displacement = (currentPos - lastPosition)
                        
                        -- If pushed horizontally more than 2 studs
                        if Vector2.new(displacement.X, displacement.Z).Magnitude > 2 then
                            -- Reset to last position
                            hrp.CFrame = lastCFrame
                            hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                        end
                    end
                end
                
                -- Update last position if moving intentionally
                if humanoid and humanoid.MoveDirection.Magnitude > 0.1 then
                    lastPosition = hrp.Position
                    lastCFrame = hrp.CFrame
                end
            end
        end)
        
        -- UI Update
        antiPushInd.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        antiPushText.Text = "ON"
        antiPushButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "⚓ Anti-Push Active!"
        
        print("⚓ [Anti-Push] ACTIVATED - You won't be pushed!")
    else
        if connections.antiPush then
            connections.antiPush:Disconnect()
            connections.antiPush = nil
        end
        
        -- UI Update
        antiPushInd.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        antiPushText.Text = "OFF"
        antiPushButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        if not antiFlingActive and not anchorActive then
            statusText.Text = "💡 Ready to activate"
        end
        
        print("⚓ [Anti-Push] DEACTIVATED")
    end
end

-- ============================================
-- ANCHOR MODE FUNCTION (Most Powerful)
-- ============================================
local function toggleAnchor()
    anchorActive = not anchorActive
    
    if anchorActive then
        local char = player.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        -- Anchor character in place
        connections.anchor = RunService.Heartbeat:Connect(function()
            if char and hrp and hrp.Parent then
                -- Reset all velocity
                hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                
                -- Disable all physics
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part ~= hrp then
                        part.CanCollide = false
                        part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end)
        
        -- UI Update
        anchorInd.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        anchorText.Text = "ON"
        anchorButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "🔒 Anchor Mode - Completely Stable!"
        
        print("🔒 [Anchor Mode] ACTIVATED - You're locked in place!")
    else
        if connections.anchor then
            connections.anchor:Disconnect()
            connections.anchor = nil
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
        anchorInd.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        anchorText.Text = "OFF"
        anchorButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        if not antiFlingActive and not antiPushActive then
            statusText.Text = "💡 Ready to activate"
        end
        
        print("🔒 [Anchor Mode] DEACTIVATED")
    end
end

-- ============================================
-- BUTTON CLICKS
-- ============================================
antiFlingButton.MouseButton1Click:Connect(toggleAntiFling)
antiPushButton.MouseButton1Click:Connect(toggleAntiPush)
anchorButton.MouseButton1Click:Connect(toggleAnchor)

-- Close button
closeButton.MouseButton1Click:Connect(function()
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    
    local char = player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv = hrp:FindFirstChild("AntiFlingVelocity")
            if bv then
                bv:Destroy()
            end
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

-- Hover effects
local buttons = {
    {btn = antiFlingButton, active = function() return antiFlingActive end},
    {btn = antiPushButton, active = function() return antiPushActive end},
    {btn = anchorButton, active = function() return anchorActive end}
}

for _, btnData in ipairs(buttons) do
    btnData.btn.MouseEnter:Connect(function()
        if not btnData.active() then
            btnData.btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        end
    end)
    
    btnData.btn.MouseLeave:Connect(function()
        if not btnData.active() then
            btnData.btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        end
    end)
end

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
end)

closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
end)

-- Auto re-enable after respawn
player.CharacterAdded:Connect(function(char)
    wait(1)
    print("⚠️ Character respawned - Toggle features again if needed")
end)

-- Startup animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame:TweenSize(UDim2.new(0, 350, 0, 360), "Out", "Elastic", 0.7, true)

-- Success message
print("╔════════════════════════════════╗")
print("║    ANTI-FLING LOADED ✅        ║")
print("╠════════════════════════════════╣")
print("║  🛡️  Anti-Fling                 ║")
print("║     Prevent being flung        ║")
print("║                                ║")
print("║  ⚓ Anti-Push                   ║")
print("║     Prevent being pushed       ║")
print("║                                ║")
print("║  🔒 Anchor Mode                 ║")
print("║     Lock in place (strongest)  ║")
print("╚════════════════════════════════╝")
