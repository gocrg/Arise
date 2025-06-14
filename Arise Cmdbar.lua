-- Arise Command Bar
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")

-- Create UI
local AriseUI = Instance.new("ScreenGui")
AriseUI.Name = "AriseUI"
AriseUI.Parent = game.CoreGui

-- Command Bar Frame
local CmdBar = Instance.new("Frame")
CmdBar.Name = "CmdBar"
CmdBar.Size = UDim2.new(0.4, 0, 0.05, 0)
CmdBar.Position = UDim2.new(0.5, 0, 0.5, 0)
CmdBar.AnchorPoint = Vector2.new(0.5, 0.5)
CmdBar.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
CmdBar.BackgroundTransparency = 0
CmdBar.BorderSizePixel = 0
CmdBar.ZIndex = 10
CmdBar.ClipsDescendants = true
CmdBar.Visible = false -- Start hidden
CmdBar.Parent = AriseUI

-- UI Elements
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 120, 255)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.7
UIStroke.Parent = CmdBar

local Gloss = Instance.new("Frame")
Gloss.Name = "Gloss"
Gloss.Size = UDim2.new(1, 0, 0.5, 0)
Gloss.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Gloss.BackgroundTransparency = 0.9
Gloss.ZIndex = 12
Gloss.Parent = CmdBar

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.15, 0)
UICorner.Parent = CmdBar

-- Command TextBox
local CommandBox = Instance.new("TextBox")
CommandBox.Name = "CommandBox"
CommandBox.Size = UDim2.new(0.9, 0, 0.7, 0)
CommandBox.Position = UDim2.new(0.05, 0, 0.15, 0)
CommandBox.BackgroundTransparency = 1
CommandBox.TextColor3 = Color3.fromRGB(240, 245, 255)
CommandBox.PlaceholderColor3 = Color3.fromRGB(180, 190, 220)
CommandBox.PlaceholderText = "Enter command..."
CommandBox.Font = Enum.Font.GothamSemibold
CommandBox.TextSize = 18
CommandBox.TextXAlignment = Enum.TextXAlignment.Left
CommandBox.ZIndex = 13
CommandBox.ClearTextOnFocus = false
CommandBox.Parent = CmdBar

-- Prevent quote key from being typed
CommandBox:GetPropertyChangedSignal("Text"):Connect(function()
    if string.sub(CommandBox.Text, -1) == "'" then
        CommandBox.Text = string.sub(CommandBox.Text, 1, -2)
    end
end)

-- Text Protection
local function isTextFitting()
    local textBounds = TextService:GetTextSize(
        CommandBox.Text,
        CommandBox.TextSize,
        CommandBox.Font,
        Vector2.new(CmdBar.AbsoluteSize.X * 0.9, math.huge)
    )
    return textBounds.X <= (CmdBar.AbsoluteSize.X * 0.9 - 20)
end

CommandBox:GetPropertyChangedSignal("Text"):Connect(function()
    if not isTextFitting() then
        CommandBox.Text = string.sub(CommandBox.Text, 1, #CommandBox.Text - 1)
    end
end)

-- Animation Functions
local function animateOpen()
    CmdBar.Visible = true
    CommandBox.Text = ""
    CommandBox:CaptureFocus()
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint)
    
    TweenService:Create(CmdBar, tweenInfo, {
        Size = UDim2.new(0.5, 0, 0.06, 0),
        BackgroundColor3 = Color3.fromRGB(30, 35, 60)
    }):Play()
    
    TweenService:Create(Gloss, tweenInfo, {
        BackgroundTransparency = 0.85,
        Size = UDim2.new(1, 0, 0.6, 0)
    }):Play()
    
    TweenService:Create(UIStroke, tweenInfo, {
        Transparency = 0.3,
        Thickness = 2
    }):Play()
end

local function animateClose(instant)
    if instant then
        -- Instant hide for command execution
        CmdBar.Visible = false
        CommandBox:ReleaseFocus()
        
        -- Reset to default state
        CmdBar.Size = UDim2.new(0.4, 0, 0.05, 0)
        CmdBar.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
        Gloss.BackgroundTransparency = 0.9
        Gloss.Size = UDim2.new(1, 0, 0.5, 0)
        UIStroke.Transparency = 0.7
        UIStroke.Thickness = 1.5
    else
        -- Smooth close for manual toggle
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint)
        
        TweenService:Create(CmdBar, tweenInfo, {
            Size = UDim2.new(0.4, 0, 0.05, 0),
            BackgroundColor3 = Color3.fromRGB(20, 25, 40)
        }):Play()
        
        TweenService:Create(Gloss, tweenInfo, {
            BackgroundTransparency = 0.9,
            Size = UDim2.new(1, 0, 0.5, 0)
        }):Play()
        
        TweenService:Create(UIStroke, tweenInfo, {
            Transparency = 0.7,
            Thickness = 1.5
        }):Play()
        
        -- Hide after animation completes
        delay(0.3, function()
            if not isFocused then
                CmdBar.Visible = false
                CommandBox:ReleaseFocus()
            end
        end)
    end
end

-- Command Processing
local function processCommand(cmd)
    -- Your command logic here
    print("Executed command:", cmd)
    CommandBox.Text = ""
    animateClose(true) -- Instant hide after command
end

-- Input Handling
CommandBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and CommandBox.Text ~= "" then
        processCommand(CommandBox.Text)
    end
end)

local isFocused = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Quote then
        if CmdBar.Visible then
            isFocused = false
            animateClose()
        else
            isFocused = true
            animateOpen()
        end
    end
end)

-- Pulse Animation (when not focused)
local pulseConn
local function startPulse()
    pulseConn = RunService.Heartbeat:Connect(function()
        if CmdBar.Visible then return end
        UIStroke.Transparency = 0.7 + (math.sin(tick() * 2) * 0.1)
        Gloss.BackgroundTransparency = 0.9 + (math.sin(tick() * 1.5) * 0.05)
    end)
end

startPulse()
print("Arise Command Bar ready! Press ' to toggle.")