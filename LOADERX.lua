-- SEEDS-STYLE LIQUID HUB WITH TRY AGAIN NOTIFICATION
-- MODIFIED BY SIGMA @rizzify101

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

-- Liquid fill
local barFill = Instance.new("Frame", barContainer)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
barFill.BackgroundTransparency = 0.4
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

-- Animate fill
TweenService:Create(barFill, TweenInfo.new(3, Enum.EasingStyle.Linear), {
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

-- Loading dots animation
task.spawn(function()
    local dots = {"", ".", "..", "..."}
    local index = 1
    while loading and loading.Parent do
        loading.Text = "Loading" .. dots[index]
        index = (index % #dots) + 1
        task.wait(0.4)
    end
end)

-- Function to create TRY AGAIN notification
local function createTryAgainNotification()
    local notification = Instance.new("Frame", gui)
    notification.AnchorPoint = Vector2.new(0.5, 0.5)
    notification.Size = UDim2.new(0, 200, 0, 80)
    notification.Position = UDim2.new(0.5, 0, 0.5, 0)
    notification.BackgroundColor3 = Color3.fromRGB(20, 25, 30)
    notification.BackgroundTransparency = 0.9
    notification.BorderSizePixel = 0
    
    Instance.new("UICorner", notification).CornerRadius = UDim.new(0, 6)
    
    local glow = Instance.new("UIStroke", notification)
    glow.Color = Color3.fromRGB(100, 180, 255)
    glow.Thickness = 1
    glow.Transparency = 0.7
    
    local text = Instance.new("TextLabel", notification)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.Text = "TRY AGAIN"
    text.TextColor3 = Color3.fromRGB(255, 120, 120) -- Red accent
    text.Font = Enum.Font.GothamBold
    text.TextSize = 20
    text.TextXAlignment = Enum.TextXAlignment.Center
    text.TextYAlignment = Enum.TextYAlignment.Center
    text.BackgroundTransparency = 1
    
    -- Pulsing animation
    task.spawn(function()
        while text and text.Parent do
            TweenService:Create(text, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
                TextTransparency = 0.2
            }):Play()
            task.wait(0.8)
            TweenService:Create(text, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
                TextTransparency = 0.5
            }):Play()
            task.wait(0.8)
        end
    end)
    
    -- Fade in
    notification.BackgroundTransparency = 1
    glow.Transparency = 1
    text.TextTransparency = 1
    
    TweenService:Create(notification, TweenInfo.new(0.5), {
        BackgroundTransparency = 0.9
    }):Play()
    TweenService:Create(glow, TweenInfo.new(0.5), {
        Transparency = 0.7
    }):Play()
    TweenService:Create(text, TweenInfo.new(0.5), {
        TextTransparency = 0.2
    }):Play()
    
    -- Auto-close after 3 seconds
    task.delay(3, function()
        TweenService:Create(notification, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(glow, TweenInfo.new(0.5), {
            Transparency = 1
        }):Play()
        TweenService:Create(text, TweenInfo.new(0.5), {
            TextTransparency = 1
        }):Play()
        task.wait(0.5)
        notification:Destroy()
    end)
end

-- Clean fade out and show notification
task.delay(3, function()
    -- Fade out loading screen
    TweenService:Create(frame, TweenInfo.new(0.5), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 340, 0, 190)
    }):Play()
    TweenService:Create(title, TweenInfo.new(0.5), {
        TextTransparency = 1
    }):Play()
    TweenService:Create(loading, TweenInfo.new(0.5), {
        TextTransparency = 1
    }):Play()
    TweenService:Create(barFill, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()
    
    task.wait(0.5) -- Wait for fade out to complete
    
    -- Show notification
    createTryAgainNotification()
    
    -- Cleanup
    task.wait(3.5) -- Wait for notification to disappear
    gui:Destroy()
    blur:Destroy()
end)
