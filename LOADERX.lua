-- VULN HUB WITH IMPROVED WARNING LAYOUT
-- FIXED BY SIGMA @rizzify101

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- Cleanup previous effects
for _, effect in pairs(Lighting:GetChildren()) do
    if effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") then
        effect:Destroy()
    end
end

-- Add subtle effects
local blur = Instance.new("BlurEffect")
blur.Size = 8
blur.Parent = Lighting

-- Create minimalist ScreenGui
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "SeedsLoading"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- Main container
local frame = Instance.new("Frame", gui)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Size = UDim2.new(0, 320, 0, 180)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 20, 25)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 4)

-- Thin border
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(80, 140, 200)
stroke.Thickness = 1
stroke.Transparency = 0.3

-- Title
local title = Instance.new("TextLabel", frame)
title.AnchorPoint = Vector2.new(0.5, 0)
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0.5, 0, 0, 15)
title.Text = "VULN"
title.TextColor3 = Color3.fromRGB(160, 220, 255)
title.Font = Enum.Font.GothamMedium
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Center
title.BackgroundTransparency = 1

-- Loading text
local loading = Instance.new("TextLabel", frame)
loading.AnchorPoint = Vector2.new(0.5, 0)
loading.Size = UDim2.new(1, -20, 0, 30)
loading.Position = UDim2.new(0.5, 0, 0, 65)
loading.Text = "Loading"
loading.TextColor3 = Color3.fromRGB(200, 230, 255)
loading.Font = Enum.Font.Gotham
loading.TextSize = 18
loading.TextXAlignment = Enum.TextXAlignment.Center
loading.BackgroundTransparency = 1

-- Loading bar container
local barContainer = Instance.new("Frame", frame)
barContainer.AnchorPoint = Vector2.new(0.5, 0)
barContainer.Size = UDim2.new(0.85, 0, 0, 6)
barContainer.Position = UDim2.new(0.5, 0, 0, 110)
barContainer.BackgroundColor3 = Color3.fromRGB(40, 60, 80)
barContainer.BackgroundTransparency = 0.7
barContainer.BorderSizePixel = 0
Instance.new("UICorner", barContainer).CornerRadius = UDim.new(1, 0)

-- Liquid fill with 20-second load time
local barFill = Instance.new("Frame", barContainer)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
barFill.BackgroundTransparency = 0.4
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

-- Animate fill (20 seconds)
TweenService:Create(barFill, TweenInfo.new(20, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

-- Currency display
local currency = Instance.new("TextLabel", frame)
currency.AnchorPoint = Vector2.new(0.5, 0)
currency.Size = UDim2.new(1, -20, 0, 20)
currency.Position = UDim2.new(0.5, 0, 0, 140)
currency.Text = "135,338,497,866¢"
currency.TextColor3 = Color3.fromRGB(180, 220, 255)
currency.Font = Enum.Font.Gotham
currency.TextSize = 14
currency.TextXAlignment = Enum.TextXAlignment.Center
currency.BackgroundTransparency = 1

-- Slower loading dots animation (sync with 20s load)
task.spawn(function()
    local dots = {"", ".", "..", "..."}
    local index = 1
    while loading and loading.Parent do
        loading.Text = "Loading" .. dots[index]
        index = (index % #dots) + 1
        task.wait(0.8) -- Slower dot animation
    end
end)

-- Function to create heartbeat warning with FIXED LAYOUT
local function createHeartbeatWarning()
    local notification = Instance.new("Frame", gui)
    notification.AnchorPoint = Vector2.new(0.5, 0.5)
    notification.Size = UDim2.new(0, 240, 0, 120) -- Taller for better spacing
    notification.Position = UDim2.new(0.5, 0, 0.5, 0)
    notification.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
    notification.BackgroundTransparency = 0.85
    notification.BorderSizePixel = 0
    
    Instance.new("UICorner", notification).CornerRadius = UDim.new(0, 8)
    
    -- Pulsing border
    local glow = Instance.new("UIStroke", notification)
    glow.Color = Color3.fromRGB(255, 80, 100)
    glow.Thickness = 2
    glow.Transparency = 0.5
    
    -- Warning icon with heartbeat (centered horizontally)
    local icon = Instance.new("ImageLabel", notification)
    icon.Image = "rbxassetid://3926307971"
    icon.ImageColor3 = Color3.fromRGB(255, 60, 80)
    icon.Size = UDim2.new(0, 36, 0, 36)
    icon.Position = UDim2.new(0.5, 0, 0.2, 0) -- Higher up
    icon.AnchorPoint = Vector2.new(0.5, 0)
    icon.BackgroundTransparency = 1
    
    -- Warning text (below icon, centered)
    local warningText = Instance.new("TextLabel", notification)
    warningText.Size = UDim2.new(0.9, 0, 0, 24)
    warningText.Position = UDim2.new(0.5, 0, 0.45, 0)
    warningText.AnchorPoint = Vector2.new(0.5, 0)
    warningText.Text = "WARNING"
    warningText.TextColor3 = Color3.fromRGB(255, 100, 120)
    warningText.Font = Enum.Font.GothamBold
    warningText.TextSize = 22
    warningText.TextXAlignment = Enum.TextXAlignment.Center
    warningText.BackgroundTransparency = 1
    
    -- Subtext (below warning, with proper spacing)
    local subtext = Instance.new("TextLabel", notification)
    subtext.Size = UDim2.new(0.8, 0, 0, 40)
    subtext.Position = UDim2.new(0.5, 0, 0.65, 0)
    subtext.AnchorPoint = Vector2.new(0.5, 0)
    subtext.Text = "System Traffic\nTry again later"
    subtext.TextColor3 = Color3.fromRGB(255, 150, 150)
    subtext.Font = Enum.Font.Gotham
    subtext.TextSize = 14
    subtext.TextXAlignment = Enum.TextXAlignment.Center
    subtext.TextYAlignment = Enum.TextYAlignment.Top
    subtext.BackgroundTransparency = 1
    
    -- Heartbeat pulse function
    local function pulse()
        while icon and icon.Parent do
            -- Quick beat
            TweenService:Create(icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 42, 0, 42),
                ImageColor3 = Color3.fromRGB(255, 80, 80)
            }):Play()
            TweenService:Create(warningText, TweenInfo.new(0.15), {
                TextSize = 24,
                TextColor3 = Color3.fromRGB(255, 120, 120)
            }):Play()
            task.wait(0.15)
            
            -- Return to normal
            TweenService:Create(icon, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 36, 0, 36),
                ImageColor3 = Color3.fromRGB(255, 60, 80)
            }):Play()
            TweenService:Create(warningText, TweenInfo.new(0.3), {
                TextSize = 22,
                TextColor3 = Color3.fromRGB(255, 100, 120)
            }):Play()
            
            -- Longer pause between beats
            task.wait(0.8 + math.random()*0.4)
        end
    end
    
    -- Fade in
    notification.BackgroundTransparency = 1
    glow.Transparency = 1
    icon.ImageTransparency = 1
    warningText.TextTransparency = 1
    subtext.TextTransparency = 1
    
    TweenService:Create(notification, TweenInfo.new(0.7), {
        BackgroundTransparency = 0.85
    }):Play()
    TweenService:Create(glow, TweenInfo.new(0.7), {
        Transparency = 0.5
    }):Play()
    TweenService:Create(icon, TweenInfo.new(0.7), {
        ImageTransparency = 0
    }):Play()
    TweenService:Create(warningText, TweenInfo.new(0.7), {
        TextTransparency = 0
    }):Play()
    TweenService:Create(subtext, TweenInfo.new(0.7), {
        TextTransparency = 0.2
    }):Play()
    
    -- Start heartbeat
    task.spawn(pulse)
    
    -- Auto-close after 5 seconds
    task.delay(5, function()
        TweenService:Create(notification, TweenInfo.new(1), {
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(glow, TweenInfo.new(1), {
            Transparency = 1
        }):Play()
        TweenService:Create(icon, TweenInfo.new(1), {
            ImageTransparency = 1
        }):Play()
        TweenService:Create(warningText, TweenInfo.new(1), {
            TextTransparency = 1
        }):Play()
        TweenService:Create(subtext, TweenInfo.new(1), {
            TextTransparency = 1
        }):Play()
        task.wait(1)
        notification:Destroy()
    end)
end

-- Clean fade out and show heartbeat warning
task.delay(20, function() -- 20 second delay
    -- Fade out loading screen
    TweenService:Create(frame, TweenInfo.new(1), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 340, 0, 190)
    }):Play()
    TweenService:Create(title, TweenInfo.new(1), {
        TextTransparency = 1
    }):Play()
    TweenService:Create(loading, TweenInfo.new(1), {
        TextTransparency = 1
    }):Play()
    TweenService:Create(barFill, TweenInfo.new(1), {
        BackgroundTransparency = 1
    }):Play()
    
    task.wait(1)
    
    -- Show heartbeat warning
    createHeartbeatWarning()
    
    -- Cleanup
    task.wait(6)
    gui:Destroy()
    blur:Destroy()
end)
