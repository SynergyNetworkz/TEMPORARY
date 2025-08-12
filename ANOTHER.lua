local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local TweenService = game:GetService("TweenService")

-- Create ScreenGui with Liquid Hub styling
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PetAgeLeveller"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame with Liquid Hub design
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 320, 0, 220) -- Larger size
frame.Position = UDim2.new(0.5, -160, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(15, 20, 25)
frame.BackgroundTransparency = 0.15
frame.Active = true
frame.Draggable = true
frame.Name = "PetAgeFrame"

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(80, 140, 200)
stroke.Thickness = 1
stroke.Transparency = 0.3

-- Title with Liquid Hub styling
local title = Instance.new("TextLabel", frame)
title.Text = "PET AGE LEVELER"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(160, 220, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.TextXAlignment = Enum.TextXAlignment.Center

-- Close Button (styled to match)
local closeButton = Instance.new("TextButton", frame)
closeButton.Text = "✕"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(255, 120, 120)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 15, 20)
closeButton.BackgroundTransparency = 0.7
closeButton.Size = UDim2.new(0, 28, 0, 28)
closeButton.Position = UDim2.new(1, -34, 0, 6)
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

-- Equipped Pet Label (styled)
local petInfo = Instance.new("TextLabel", frame)
petInfo.Text = "Equipped Pet: [None]"
petInfo.Font = Enum.Font.Gotham
petInfo.TextSize = 16
petInfo.TextColor3 = Color3.fromRGB(200, 230, 255)
petInfo.BackgroundTransparency = 1
petInfo.Position = UDim2.new(0, 20, 0, 60)
petInfo.Size = UDim2.new(1, -40, 0, 24)
petInfo.TextXAlignment = Enum.TextXAlignment.Left

-- Buttons with Liquid styling
local function createLiquidButton(text, positionY)
    local button = Instance.new("TextButton", frame)
    button.Text = text
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 16
    button.TextColor3 = Color3.fromRGB(40, 40, 40)
    button.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
    button.BackgroundTransparency = 0.4
    button.Size = UDim2.new(0, 240, 0, 36)
    button.Position = UDim2.new(0.5, -120, 0, positionY)
    
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", button)
    stroke.Color = Color3.fromRGB(150, 200, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    
    return button
end

-- "Set Age to 50" Button
local button = createLiquidButton("Set Age to 50", 100)

-- "Add +1 Age" Button
local addAgeButton = createLiquidButton("Add +1 Age", 150)

-- Function to get equipped pet tool
local function getEquippedPetTool()
    character = player.Character or player.CharacterAdded:Wait()
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Tool") and child.Name:find("Age") then
            return child
        end
    end
    return nil
end

-- Update GUI pet name
local function updateGUI()
    local pet = getEquippedPetTool()
    if pet then
        petInfo.Text = "Equipped Pet: " .. pet.Name
    else
        petInfo.Text = "Equipped Pet: [None]"
    end
end

-- Set Age to 50 Button Logic (with 20s countdown)
button.MouseButton1Click:Connect(function()
    local tool = getEquippedPetTool()
    if tool then
        local originalText = button.Text
        for i = 20, 1, -1 do
            button.Text = "Changing Age in " .. i .. "..."
            task.wait(1)
        end
        local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age 50]")
        tool.Name = newName
        petInfo.Text = "Equipped Pet: " .. tool.Name
        button.Text = originalText
    else
        local originalText = button.Text
        button.Text = "No Pet Equipped!"
        task.wait(2)
        button.Text = originalText
    end
end)

-- Add +1 Age Button Logic (with 5s countdown, up to 100)
addAgeButton.MouseButton1Click:Connect(function()
    local tool = getEquippedPetTool()
    if tool then
        local currentAge = tonumber(tool.Name:match("%[Age%s(%d+)%]"))
        if currentAge and currentAge < 100 then
            local originalText = addAgeButton.Text
            for i = 5, 1, -1 do
                addAgeButton.Text = "Adding +1 in " .. i .. "..."
                task.wait(1)
            end
            local newAge = currentAge + 1
            local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age " .. newAge .. "]")
            tool.Name = newName
            petInfo.Text = "Equipped Pet: " .. tool.Name
            addAgeButton.Text = originalText
        elseif currentAge and currentAge >= 100 then
            local originalText = addAgeButton.Text
            addAgeButton.Text = "Max Age is 100!"
            task.wait(2)
            addAgeButton.Text = originalText
        else
            local originalText = addAgeButton.Text
            addAgeButton.Text = "Invalid Age Format!"
            task.wait(2)
            addAgeButton.Text = originalText
        end
    else
        local originalText = addAgeButton.Text
        addAgeButton.Text = "No Pet Equipped!"
        task.wait(2)
        addAgeButton.Text = originalText
    end
end)

-- Auto refresh equipped pet display
task.spawn(function()
    while true do
        updateGUI()
        task.wait(1)
    end
end)
