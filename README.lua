-- [[ SCRIPT ANTI-AFK DENGAN TOGGLE DAN AUTO-RECONNECT ]]

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

-- Tempat ID Awal (digunakan untuk reconnect)
local OriginalPlaceId = game.PlaceId
local IsActive = true -- Status awal: Aktif

-- [1] Setup GUI (Gunakan penamaan yang lebih rapi)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

local HeaderLabel = Instance.new("TextLabel")
HeaderLabel.Parent = ScreenGui;
HeaderLabel.Active = true
HeaderLabel.Draggable = true
HeaderLabel.BackgroundColor3 = Color3.new(0.176471,0.176471,0.176471)
HeaderLabel.Position = UDim2.new(0.698610067,0,0.098096624,0)
HeaderLabel.Size = UDim2.new(0,370,0,52)
HeaderLabel.Font = Enum.Font.SourceSansSemibold
HeaderLabel.Text = "Anti Afk"
HeaderLabel.TextColor3 = Color3.new(0,1,1)
HeaderLabel.TextSize = 22

local MainFrame = Instance.new("Frame")
MainFrame.Parent = HeaderLabel
MainFrame.BackgroundColor3 = Color3.new(0.196078,0.196078,0.196078)
MainFrame.Position = UDim2.new(0,0,1.0192306,0)
MainFrame.Size = UDim2.new(0,370,0,167) -- Diperbesar sedikit untuk Reconnect Status

local FooterLabel = Instance.new("TextLabel")
FooterLabel.Parent = MainFrame
FooterLabel.BackgroundColor3 = Color3.new(0.176471,0.176471,0.176471)
FooterLabel.Position = UDim2.new(0,0,0.88,0)
FooterLabel.Size = UDim2.new(0,370,0,21)
FooterLabel.Font = Enum.Font.Arial
FooterLabel.Text = "Made by luca#5432"
FooterLabel.TextColor3 = Color3.new(0,1,1)
FooterLabel.TextSize = 20

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundColor3 = Color3.new(0.176471,0.176471,0.176471)
StatusLabel.Position = UDim2.new(0,0,0.60,0)
StatusLabel.Size = UDim2.new(0,370,0,30)
StatusLabel.Font = Enum.Font.ArialBold
StatusLabel.Text = "Status: Active" 
StatusLabel.TextColor3 = Color3.new(0,1,1)
StatusLabel.TextSize = 20

local ReconnectStatusLabel = Instance.new("TextLabel")
ReconnectStatusLabel.Parent = MainFrame
ReconnectStatusLabel.BackgroundColor3 = Color3.new(0.196078,0.196078,0.196078)
ReconnectStatusLabel.Position = UDim2.new(0,0,0.35,0)
ReconnectStatusLabel.Size = UDim2.new(0,370,0,20)
ReconnectStatusLabel.Font = Enum.Font.SourceSans
ReconnectStatusLabel.Text = "Auto Reconnect: ON"
ReconnectStatusLabel.TextColor3 = Color3.new(0, 1, 0) -- Hijau
ReconnectStatusLabel.TextSize = 16

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.new(0, 0.5, 0) -- Hijau (Active)
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0) 
ToggleButton.Size = UDim2.new(0, 296, 0, 30) 
ToggleButton.Font = Enum.Font.ArialBold
ToggleButton.Text = "CLICK TO DISABLE ANTI-AFK"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 20

-- [2] Logika Toggle
local VirtualUser = game:service'VirtualUser'

ToggleButton.MouseButton1Click:Connect(function()
    IsActive = not IsActive 

    if IsActive then
        ToggleButton.Text = "CLICK TO DISABLE ANTI-AFK"
        ToggleButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
        StatusLabel.Text = "Status: Active"
    else
        ToggleButton.Text = "CLICK TO ENABLE ANTI-AFK"
        ToggleButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
        StatusLabel.Text = "Status: Inactive"
    end
end)

-- Menghubungkan Event 'Idled' (Anti-AFK utama)
Players.LocalPlayer.Idled:Connect(function()
    if IsActive then 
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        
        StatusLabel.Text = "Roblox tried kicking you but I didn't let them!"
        wait(2)
        StatusLabel.Text = "Status : Active"
    end
end)

-- [3] Fungsi Auto Reconnect
local function AttemptReconnect(teleportState)
    -- TeleportState yang menunjukkan pemutusan koneksi atau kick adalah Failure dan Cancel
    if IsActive and (teleportState == Enum.TeleportState.Failure or teleportState == Enum.TeleportState.Cancelled) then
        ReconnectStatusLabel.Text = "Auto Reconnect: Kicked/Disconnected! Reconnecting..."
        ReconnectStatusLabel.TextColor3 = Color3.new(1, 0.5, 0) -- Oranye
        
        -- Tunggu sebentar sebelum mencoba menyambung ulang
        wait(5) 
        
        -- Coba Teleport ke Tempat ID saat ini
        local success, result = pcall(function()
            TeleportService:Teleport(OriginalPlaceId, Players.LocalPlayer)
        end)
        
        if success then
            ReconnectStatusLabel.Text = "Auto Reconnect: Teleporting..."
            ReconnectStatusLabel.TextColor3 = Color3.new(0, 1, 1) -- Biru Muda
        else
            ReconnectStatusLabel.Text = "Auto Reconnect: Failed to Teleport! Error: " .. tostring(result)
            ReconnectStatusLabel.TextColor3 = Color3.new(1, 0, 0) -- Merah
        end
    end
end

-- Menghubungkan fungsi Auto Reconnect
TeleportService.LocalPlayerTeleport:Connect(AttemptReconnect)

