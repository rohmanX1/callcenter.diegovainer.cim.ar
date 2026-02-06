--[[
    INSTANT PICKUP SCRIPT
    Ambil barang langsung tanpa delay!
    Works for most Roblox games
]]--

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🔄 Loading Instant Pickup Script...")

-- Wait for character
repeat wait() until player.Character
wait(0.5)

-- Variables
local instantPickupActive = false
local autoCollectActive = false
local connections = {}
local pickupRange = 50

-- GUI Creation
local gui = Instance.new("ScreenGui")
gui.Name = "InstantPickupGUI"
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
mainFrame.Size = UDim2.new(0, 350, 0, 320)
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
title.Text = "⚡ INSTANT PICKUP"
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

-- Instant Pickup Button
local instantButton = Instance.new("TextButton")
instantButton.Parent = mainFrame
instantButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
instantButton.BorderSizePixel = 0
instantButton.Position = UDim2.new(0, 15, 0, 65)
instantButton.Size = UDim2.new(1, -30, 0, 60)
instantButton.Font = Enum.Font.GothamBold
instantButton.Text = ""
instantButton.AutoButtonColor = false

local instantCorner = Instance.new("UICorner")
instantCorner.CornerRadius = UDim.new(0, 12)
instantCorner.Parent = instantButton

local instantIcon = Instance.new("TextLabel")
instantIcon.Parent = instantButton
instantIcon.BackgroundTransparency = 1
instantIcon.Position = UDim2.new(0, 15, 0, 0)
instantIcon.Size = UDim2.new(0, 50, 1, 0)
instantIcon.Font = Enum.Font.GothamBold
instantIcon.Text = "⚡"
instantIcon.TextColor3 = Color3.fromRGB(100, 200, 255)
instantIcon.TextSize = 28

local instantTitle = Instance.new("TextLabel")
instantTitle.Parent = instantButton
instantTitle.BackgroundTransparency = 1
instantTitle.Position = UDim2.new(0, 70, 0, 8)
instantTitle.Size = UDim2.new(0, 180, 0, 25)
instantTitle.Font = Enum.Font.GothamBold
instantTitle.Text = "INSTANT PICKUP"
instantTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
instantTitle.TextSize = 15
instantTitle.TextXAlignment = Enum.TextXAlignment.Left

local instantDesc = Instance.new("TextLabel")
instantDesc.Parent = instantButton
instantDesc.BackgroundTransparency = 1
instantDesc.Position = UDim2.new(0, 70, 0, 33)
instantDesc.Size = UDim2.new(0, 180, 0, 20)
instantDesc.Font = Enum.Font.Gotham
instantDesc.Text = "Remove pickup delay"
instantDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
instantDesc.TextSize = 11
instantDesc.TextXAlignment = Enum.TextXAlignment.Left

local instantIndicator = Instance.new("Frame")
instantIndicator.Parent = instantButton
instantIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
instantIndicator.BorderSizePixel = 0
instantIndicator.Position = UDim2.new(1, -65, 0.5, -15)
instantIndicator.Size = UDim2.new(0, 55, 0, 30)

local instantIndCorner = Instance.new("UICorner")
instantIndCorner.CornerRadius = UDim.new(1, 0)
instantIndCorner.Parent = instantIndicator

local instantIndText = Instance.new("TextLabel")
instantIndText.Parent = instantIndicator
instantIndText.BackgroundTransparency = 1
instantIndText.Size = UDim2.new(1, 0, 1, 0)
instantIndText.Font = Enum.Font.GothamBold
instantIndText.Text = "OFF"
instantIndText.TextColor3 = Color3.fromRGB(255, 255, 255)
instantIndText.TextSize = 12

-- Auto Collect Button
local autoButton = Instance.new("TextButton")
autoButton.Parent = mainFrame
autoButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
autoButton.BorderSizePixel = 0
autoButton.Position = UDim2.new(0, 15, 0, 135)
autoButton.Size = UDim2.new(1, -30, 0, 60)
autoButton.Font = Enum.Font.GothamBold
autoButton.Text = ""
autoButton.AutoButtonColor = false

local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 12)
autoCorner.Parent = autoButton

local autoIcon = Instance.new("TextLabel")
autoIcon.Parent = autoButton
autoIcon.BackgroundTransparency = 1
autoIcon.Position = UDim2.new(0, 15, 0, 0)
autoIcon.Size = UDim2.new(0, 50, 1, 0)
autoIcon.Font = Enum.Font.GothamBold
autoIcon.Text = "🧲"
autoIcon.TextColor3 = Color3.fromRGB(100, 200, 255)
autoIcon.TextSize = 28

local autoTitle = Instance.new("TextLabel")
autoTitle.Parent = autoButton
autoTitle.BackgroundTransparency = 1
autoTitle.Position = UDim2.new(0, 70, 0, 8)
autoTitle.Size = UDim2.new(0, 180, 0, 25)
autoTitle.Font = Enum.Font.GothamBold
autoTitle.Text = "AUTO COLLECT"
autoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoTitle.TextSize = 15
autoTitle.TextXAlignment = Enum.TextXAlignment.Left

local autoDesc = Instance.new("TextLabel")
autoDesc.Parent = autoButton
autoDesc.BackgroundTransparency = 1
autoDesc.Position = UDim2.new(0, 70, 0, 33)
autoDesc.Size = UDim2.new(0, 180, 0, 20)
autoDesc.Font = Enum.Font.Gotham
autoDesc.Text = "Auto pickup nearby items"
autoDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
autoDesc.TextSize = 11
autoDesc.TextXAlignment = Enum.TextXAlignment.Left

local autoIndicator = Instance.new("Frame")
autoIndicator.Parent = autoButton
autoIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
autoIndicator.BorderSizePixel = 0
autoIndicator.Position = UDim2.new(1, -65, 0.5, -15)
autoIndicator.Size = UDim2.new(0, 55, 0, 30)

local autoIndCorner = Instance.new("UICorner")
autoIndCorner.CornerRadius = UDim.new(1, 0)
autoIndCorner.Parent = autoIndicator

local autoIndText = Instance.new("TextLabel")
autoIndText.Parent = autoIndicator
autoIndText.BackgroundTransparency = 1
autoIndText.Size = UDim2.new(1, 0, 1, 0)
autoIndText.Font = Enum.Font.GothamBold
autoIndText.Text = "OFF"
autoIndText.TextColor3 = Color3.fromRGB(255, 255, 255)
autoIndText.TextSize = 12

-- Range Slider
local rangeLabel = Instance.new("TextLabel")
rangeLabel.Parent = mainFrame
rangeLabel.BackgroundTransparency = 1
rangeLabel.Position = UDim2.new(0, 15, 0, 205)
rangeLabel.Size = UDim2.new(1, -30, 0, 20)
rangeLabel.Font = Enum.Font.GothamBold
rangeLabel.Text = "Pickup Range: 50 studs"
rangeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
rangeLabel.TextSize = 13
rangeLabel.TextXAlignment = Enum.TextXAlignment.Left

local rangeSlider = Instance.new("TextButton")
rangeSlider.Parent = mainFrame
rangeSlider.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
rangeSlider.BorderSizePixel = 0
rangeSlider.Position = UDim2.new(0, 15, 0, 230)
rangeSlider.Size = UDim2.new(1, -30, 0, 10)
rangeSlider.Text = ""
rangeSlider.AutoButtonColor = false

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(1, 0)
sliderCorner.Parent = rangeSlider

local sliderFill = Instance.new("Frame")
sliderFill.Parent = rangeSlider
sliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
sliderFill.BorderSizePixel = 0
sliderFill.Size = UDim2.new(0.5, 0, 1, 0)

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = sliderFill

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
-- INSTANT PICKUP FUNCTION
-- ============================================
local function toggleInstantPickup()
    instantPickupActive = not instantPickupActive
    
    if instantPickupActive then
        -- Remove ProximityPrompt delays
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                obj.HoldDuration = 0
                obj.MaxActivationDistance = pickupRange
            end
        end
        
        -- Monitor new ProximityPrompts
        connections.promptAdded = workspace.DescendantAdded:Connect(function(obj)
            if obj:IsA("ProximityPrompt") then
                obj.HoldDuration = 0
                obj.MaxActivationDistance = pickupRange
            end
        end)
        
        -- Remove ClickDetector delays
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") then
                obj.MaxActivationDistance = pickupRange
            end
        end
        
        connections.clickAdded = workspace.DescendantAdded:Connect(function(obj)
            if obj:IsA("ClickDetector") then
                obj.MaxActivationDistance = pickupRange
            end
        end)
        
        -- UI Update
        instantIndicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        instantIndText.Text = "ON"
        instantButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "⚡ Instant Pickup Active!"
        
        print("⚡ [Instant Pickup] ACTIVATED - No more delays!")
    else
        -- Disconnect connections
        if connections.promptAdded then
            connections.promptAdded:Disconnect()
            connections.promptAdded = nil
        end
        if connections.clickAdded then
            connections.clickAdded:Disconnect()
            connections.clickAdded = nil
        end
        
        -- UI Update
        instantIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        instantIndText.Text = "OFF"
        instantButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        if not autoCollectActive then
            statusText.Text = "💡 Ready to activate"
        end
        
        print("⚡ [Instant Pickup] DEACTIVATED")
    end
end

-- ============================================
-- AUTO COLLECT FUNCTION
-- ============================================
local function toggleAutoCollect()
    autoCollectActive = not autoCollectActive
    
    if autoCollectActive then
        connections.autoCollect = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            local hrp = char.HumanoidRootPart
            
            -- Auto trigger ProximityPrompts
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") and obj.Enabled then
                    local parent = obj.Parent
                    if parent and (parent.Position - hrp.Position).Magnitude <= pickupRange then
                        pcall(function()
                            fireproximityprompt(obj)
                        end)
                    end
                end
            end
            
            -- Auto collect items (common item names)
            for _, item in pairs(workspace:GetDescendants()) do
                if item:IsA("BasePart") then
                    local itemName = item.Name:lower()
                    
                    -- Common collectible names
                    if itemName:find("coin") or itemName:find("cash") or 
                       itemName:find("money") or itemName:find("gem") or
                       itemName:find("orb") or itemName:find("collect") or
                       itemName:find("pickup") or itemName:find("reward") or
                       itemName:find("loot") or itemName:find("drop") then
                        
                        if (item.Position - hrp.Position).Magnitude <= pickupRange then
                            pcall(function()
                                item.CFrame = hrp.CFrame
                            end)
                        end
                    end
                end
            end
        end)
        
        -- UI Update
        autoIndicator.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
        autoIndText.Text = "ON"
        autoButton.BackgroundColor3 = Color3.fromRGB(40, 50, 65)
        statusText.Text = "🧲 Auto Collecting Items..."
        
        print("🧲 [Auto Collect] ACTIVATED - Range: " .. pickupRange)
    else
        if connections.autoCollect then
            connections.autoCollect:Disconnect()
            connections.autoCollect = nil
        end
        
        -- UI Update
        autoIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        autoIndText.Text = "OFF"
        autoButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        
        if not instantPickupActive then
            statusText.Text = "💡 Ready to activate"
        end
        
        print("🧲 [Auto Collect] DEACTIVATED")
    end
end

-- ============================================
-- RANGE SLIDER
-- ============================================
local dragging = false

rangeSlider.MouseButton1Down:Connect(function()
    dragging = true
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local mouse = player:GetMouse()
        local relativeX = math.clamp(mouse.X - rangeSlider.AbsolutePosition.X, 0, rangeSlider.AbsoluteSize.X)
        local percentage = relativeX / rangeSlider.AbsoluteSize.X
        
        pickupRange = math.floor(10 + (percentage * 190)) -- 10 to 200
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        rangeLabel.Text = "Pickup Range: " .. pickupRange .. " studs"
    end
end)

-- ============================================
-- BUTTON CLICKS
-- ============================================
instantButton.MouseButton1Click:Connect(toggleInstantPickup)
autoButton.MouseButton1Click:Connect(toggleAutoCollect)

-- Close button
closeButton.MouseButton1Click:Connect(function()
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    
    gui:Destroy()
    print("Script closed!")
end)

-- Hover effects
instantButton.MouseEnter:Connect(function()
    if not instantPickupActive then
        instantButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    end
end)

instantButton.MouseLeave:Connect(function()
    if not instantPickupActive then
        instantButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    end
end)

autoButton.MouseEnter:Connect(function()
    if not autoCollectActive then
        autoButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    end
end)

autoButton.MouseLeave:Connect(function()
    if not autoCollectActive then
        autoButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    end
end)

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
end)

closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
end)

-- Startup animation
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame:TweenSize(UDim2.new(0, 350, 0, 320), "Out", "Elastic", 0.7, true)

-- Success message
print("╔════════════════════════════════╗")
print("║   INSTANT PICKUP LOADED ✅     ║")
print("╠════════════════════════════════╣")
print("║  ⚡ Instant Pickup              ║")
print("║     Remove pickup delays       ║")
print("║                                ║")
print("║  🧲 Auto Collect                ║")
print("║     Auto pickup nearby items   ║")
print("║                                ║")
print("║  📏 Adjustable Range            ║")
print("║     10-200 studs               ║")
print("╚════════════════════════════════╝")
