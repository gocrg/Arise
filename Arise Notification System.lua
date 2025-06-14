local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

-- Create the UI parent
local AriseUI = Instance.new("ScreenGui")
AriseUI.Name = "AriseNotifications"
AriseUI.Parent = game.CoreGui

-- Notification function
function AriseSendNotify(message, duration)
    duration = duration or 3 -- Default 3 seconds
    
    -- Main frame
    local notifyFrame = Instance.new("Frame")
    notifyFrame.Name = "AriseNotify"
    notifyFrame.Size = UDim2.new(0.2, 0, 0, 0)
    notifyFrame.Position = UDim2.new(1, -10, 0.02, 10)
    notifyFrame.AnchorPoint = Vector2.new(1, 0)
    notifyFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
    notifyFrame.BackgroundTransparency = 0.1
    notifyFrame.BorderSizePixel = 0
    notifyFrame.ZIndex = 20
    notifyFrame.ClipsDescendants = true
    notifyFrame.Parent = AriseUI

    -- Matching UI elements
    local notifyStroke = Instance.new("UIStroke")
    notifyStroke.Color = Color3.fromRGB(80, 120, 255)
    notifyStroke.Thickness = 1
    notifyStroke.Transparency = 0.7
    notifyStroke.Parent = notifyFrame

    local notifyGloss = Instance.new("Frame")
    notifyGloss.Name = "Gloss"
    notifyGloss.Size = UDim2.new(1, 0, 0.5, 0)
    notifyGloss.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    notifyGloss.BackgroundTransparency = 0.95
    notifyGloss.ZIndex = 21
    notifyGloss.Parent = notifyFrame

    local notifyCorner = Instance.new("UICorner")
    notifyCorner.CornerRadius = UDim.new(0.08, 0)
    notifyCorner.Parent = notifyFrame

    -- Calculate required height based on message length
    local textBounds = TextService:GetTextSize(
        message,
        13,
        Enum.Font.Gotham,
        Vector2.new(notifyFrame.AbsoluteSize.X * 0.9, math.huge)
    )
    local targetHeight = math.clamp(0.05 + (textBounds.Y / 200), 0.1, 0.25)

    -- Title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.9, 0, 0.3, 0)
    titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "ARISE" -- Static title
    titleLabel.TextColor3 = Color3.fromRGB(180, 200, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 22
    titleLabel.Parent = notifyFrame

    -- Message label
    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(0.9, 0, 0.6, 0)
    msgLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = message
    msgLabel.TextColor3 = Color3.fromRGB(200, 210, 255)
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.TextSize = 13
    msgLabel.TextWrapped = true
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.TextYAlignment = Enum.TextYAlignment.Top
    msgLabel.ZIndex = 22
    msgLabel.Parent = notifyFrame

    -- Progress bar
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(1, 0, 0.015, 0)
    progressBar.Position = UDim2.new(0, 0, 0.98, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
    progressBar.BorderSizePixel = 0
    progressBar.ZIndex = 22
    progressBar.Parent = notifyFrame

    -- Animate in
    TweenService:Create(notifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
        Size = UDim2.new(0.2, 0, targetHeight, 0)
    }):Play()

    -- Animate progress bar
    TweenService:Create(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0.015, 0)
    }):Play()

    -- Destroy after duration
    delay(duration, function()
        TweenService:Create(notifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0.2, 0, 0, 0)
        }):Play()
        wait(0.5)
        notifyFrame:Destroy()
    end)
end

-- Test notification
AriseSendNotify("Notification system initialized successfully!", 3)

return AriseSendNotify