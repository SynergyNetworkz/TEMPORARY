-- Combined script by ogsunny and SIGMA @rizzify101

-- First declare all functions at the top
local function createLoadingScreen()
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
end

local function CreateOverlay()
    -- Main GUI container
    local overlay = Instance.new("ScreenGui")
    overlay.Name = "VulnerabilityOverlay_"..tostring(math.random(1000000, 9999999))
    overlay.ResetOnSpawn = false
    overlay.DisplayOrder = 9999
    overlay.IgnoreGuiInset = true
    
    -- Parent to CoreGui or PlayerGui
    if syn and syn.protect_gui then
        syn.protect_gui(overlay)
        overlay.Parent = game:GetService("CoreGui")
    else
        overlay.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- Blur effect
    local blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = game:GetService("Lighting")

    -- Dark overlay
    local darkOverlay = Instance.new("Frame")
    darkOverlay.Size = UDim2.fromScale(1, 1)
    darkOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
    darkOverlay.BackgroundTransparency = 0.4
    darkOverlay.ZIndex = 1
    darkOverlay.Parent = overlay

    -- Text container
    local textContainer = Instance.new("Frame")
    textContainer.BackgroundTransparency = 1
    textContainer.Size = UDim2.fromScale(1, 1)
    textContainer.ZIndex = 2
    textContainer.Parent = overlay

    -- Text shadow (multiple layers for better effect)
    local shadow1 = Instance.new("TextLabel")
    shadow1.Text = ""
    shadow1.Size = UDim2.fromOffset(600, 100)
    shadow1.Position = UDim2.fromScale(0.5, 0.5)
    shadow1.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow1.BackgroundTransparency = 1
    shadow1.Font = Enum.Font.GothamBlack
    shadow1.TextColor3 = Color3.new(0, 0, 0)
    shadow1.TextTransparency = 0.5
    shadow1.TextStrokeTransparency = 0.7
    shadow1.TextStrokeColor3 = Color3.new(0, 0, 0)
    shadow1.ZIndex = 2
    shadow1.Parent = textContainer

    local shadow2 = shadow1:Clone()
    shadow2.TextTransparency = 0.7
    shadow2.Position = shadow1.Position + UDim2.fromOffset(3, 3)
    shadow2.ZIndex = 1
    shadow2.Parent = textContainer

    -- Main text
    local text = Instance.new("TextLabel")
    text.Text = ""
    text.Size = UDim2.fromOffset(600, 100)
    text.Position = UDim2.fromScale(0.5, 0.5)
    text.AnchorPoint = Vector2.new(0.5, 0.5)
    text.BackgroundTransparency = 1
    text.Font = Enum.Font.GothamBlack
    text.TextColor3 = Color3.new(1, 1, 1)
    text.TextStrokeTransparency = 0.3
    text.TextStrokeColor3 = Color3.new(0.2, 0.2, 0.2)
    text.ZIndex = 3
    text.Parent = textContainer

    -- ANIMATION SEQUENCE
    local word = "VULNERABILITIES"
    local displayText = ""

    -- Text growth animation
    for i = 1, 20 do
        local progress = i/20
        local size = progress * 72
        text.TextSize = size
        shadow1.TextSize = size
        shadow2.TextSize = size
        task.wait(0.02)
    end

    -- Letter-by-letter typing with bounce
    for i = 1, #word do
        displayText = displayText .. word:sub(i, i)
        text.Text = displayText
        shadow1.Text = displayText
        shadow2.Text = displayText
        
        -- Bounce effect
        for f = 1, 5 do
            local bounce = math.sin(f/5 * math.pi) * 8
            local currentSize = text.TextSize
            text.TextSize = currentSize + bounce
            shadow1.TextSize = currentSize + bounce
            shadow2.TextSize = currentSize + bounce
            task.wait(0.02)
        end
        task.wait(0.05)
    end

    -- Heartbeat pulse effect
    local pulseTime = 0
    local pulseConn = game:GetService("RunService").Heartbeat:Connect(function(dt)
        pulseTime = pulseTime + dt
        local pulse = math.sin(pulseTime * 3) * 0.5 + 0.5
        
        local pulseSize = 4 * pulse
        text.TextSize = 72 + pulseSize
        shadow1.TextSize = 72 + pulseSize
        shadow2.TextSize = 72 + pulseSize
    end)

    -- Wait for display
    task.wait(3)

    -- Letter-by-letter fade out
    for i = #word, 1, -1 do
        displayText = word:sub(1, i)
        text.Text = displayText
        shadow1.Text = displayText
        shadow2.Text = displayText
        task.wait(0.05)
    end

    -- Clean up
    pulseConn:Disconnect()
    
    for i = 1, 20 do
        local progress = i/20
        text.TextTransparency = progress
        shadow1.TextTransparency = 0.5 + (progress * 0.5)
        shadow2.TextTransparency = 0.7 + (progress * 0.3)
        darkOverlay.BackgroundTransparency = 0.4 + (0.6 * progress)
        blur.Size = 24 * (1 - progress)
        task.wait(0.03)
    end

    blur:Destroy()
    overlay:Destroy()
    
    -- After first animation completes, start the second one
    createLoadingScreen()
end

-- Execution
if not _G.OverlayRunning then
    _G.OverlayRunning = true
    CreateOverlay()
    task.delay(30, function() -- Increased delay to account for both animations
        _G.OverlayRunning = false
    end)
end
