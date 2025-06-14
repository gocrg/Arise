-- Arise UI System
-- Made By 2y/Rukuu Discord: goc2v

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")

-- Create main UI container
local AriseUI = Instance.new("ScreenGui")
AriseUI.Name = "AriseUI"
AriseUI.Parent = game.CoreGui

--[[
    NOTIFICATION SYSTEM (Updated Version)
--]]
function AriseSendNotify(message, duration)
    duration = duration or 3 -- Default 3 seconds
    
    -- Main frame
    local notifyFrame = Instance.new("Frame")
    notifyFrame.Name = "AriseNotify_"..tostring(tick())
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

    -- Title label (now just shows "ARISE")
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

--[[
    COMMAND BAR
--]]
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

--[[
    COMMAND LIST
--]]
local CmdList = Instance.new("Frame")
CmdList.Name = "CmdList"
CmdList.Size = UDim2.new(0.35, 0, 0.5, 0)
CmdList.Position = UDim2.new(0.5, 0, 0.3, 0)
CmdList.AnchorPoint = Vector2.new(0.5, 0)
CmdList.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
CmdList.BackgroundTransparency = 0
CmdList.BorderSizePixel = 0
CmdList.ZIndex = 10
CmdList.ClipsDescendants = true
CmdList.Visible = false -- Start hidden
CmdList.Parent = AriseUI

-- Matching UIStroke
local ListUIStroke = Instance.new("UIStroke")
ListUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ListUIStroke.Color = Color3.fromRGB(80, 120, 255)
ListUIStroke.Thickness = 1.5
ListUIStroke.Transparency = 0.7
ListUIStroke.Parent = CmdList

-- Glossy overlay
local ListGloss = Instance.new("Frame")
ListGloss.Name = "Gloss"
ListGloss.Size = UDim2.new(1, 0, 0.5, 0)
ListGloss.Position = UDim2.new(0, 0, 0, 0)
ListGloss.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ListGloss.BackgroundTransparency = 0.9
ListGloss.BorderSizePixel = 0
ListGloss.ZIndex = 12
ListGloss.Parent = CmdList

-- Matching corner rounding
local ListUICorner = Instance.new("UICorner")
ListUICorner.CornerRadius = UDim.new(0.05, 0)
ListUICorner.Parent = CmdList

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0.1, 0)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 35, 60)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 13
TitleBar.Parent = CmdList

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ARISE COMMANDS"
TitleLabel.TextColor3 = Color3.fromRGB(200, 210, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 14
TitleLabel.Parent = TitleBar

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 1, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(200, 210, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.ZIndex = 14
CloseButton.Parent = TitleBar

-- Command list scrolling frame
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "CommandScroller"
ScrollingFrame.Size = UDim2.new(1, -10, 0.9, -10)
ScrollingFrame.Position = UDim2.new(0, 5, 0.1, 5)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 120, 255)
ScrollingFrame.ZIndex = 13
ScrollingFrame.Parent = CmdList

-- UIListLayout for commands
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollingFrame

-- Sample commands
local commands = {
    {name = "fly", description = "Toggles flight mode"},
    {name = "noclip", description = "Toggles noclip mode"},
    {name = "speed [value]", description = "Sets walk speed"},
    {name = "jumppower [value]", description = "Sets jump power"},
    {name = "god", description = "Toggles god mode"},
    {name = "invisible", description = "Makes you invisible"},
    {name = "esp [player]", description = "Highlights a player"},
    {name = "tp [player]", description = "Teleports to a player"},
    {name = "bring [player]", description = "Brings a player to you"},
    {name = "kill [player]", description = "Kills a player"},
    {name = "tools", description = "Gives you all tools"},
    {name = "clear", description = "Clears the command output"},
    {name = "cmds", description = "Shows this command list"}
}

-- Create command entries
for i, cmd in ipairs(commands) do
    local cmdFrame = Instance.new("Frame")
    cmdFrame.Name = "Cmd_"..cmd.name
    cmdFrame.Size = UDim2.new(1, -10, 0, 30)
    cmdFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 60)
    cmdFrame.BackgroundTransparency = 0.5
    cmdFrame.BorderSizePixel = 0
    cmdFrame.ZIndex = 14
    cmdFrame.LayoutOrder = i
    cmdFrame.Parent = ScrollingFrame
    
    local cmdCorner = Instance.new("UICorner")
    cmdCorner.CornerRadius = UDim.new(0.1, 0)
    cmdCorner.Parent = cmdFrame
    
    local cmdName = Instance.new("TextLabel")
    cmdName.Name = "Name"
    cmdName.Size = UDim2.new(0.4, -5, 1, 0)
    cmdName.Position = UDim2.new(0, 5, 0, 0)
    cmdName.BackgroundTransparency = 1
    cmdName.Text = cmd.name
    cmdName.TextColor3 = Color3.fromRGB(180, 200, 255)
    cmdName.Font = Enum.Font.GothamSemibold
    cmdName.TextSize = 16
    cmdName.TextXAlignment = Enum.TextXAlignment.Left
    cmdName.ZIndex = 15
    cmdName.Parent = cmdFrame
    
    local cmdDesc = Instance.new("TextLabel")
    cmdDesc.Name = "Description"
    cmdDesc.Size = UDim2.new(0.6, -5, 1, 0)
    cmdDesc.Position = UDim2.new(0.4, 5, 0, 0)
    cmdDesc.BackgroundTransparency = 1
    cmdDesc.Text = cmd.description
    cmdDesc.TextColor3 = Color3.fromRGB(150, 170, 220)
    cmdDesc.Font = Enum.Font.Gotham
    cmdDesc.TextSize = 14
    cmdDesc.TextXAlignment = Enum.TextXAlignment.Left
    cmdDesc.ZIndex = 15
    cmdDesc.Parent = cmdFrame
end

-- Update scrolling frame canvas size
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Toggle command list visibility
local function toggleCmdList()
    CmdList.Visible = not CmdList.Visible
    
    if CmdList.Visible then
        CmdList.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(CmdList, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0.35, 0, 0.5, 0)
        }):Play()
        
        TweenService:Create(ListUIStroke, TweenInfo.new(0.3), {
            Transparency = 0.3,
            Thickness = 2
        }):Play()
    else
        TweenService:Create(CmdList, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
    end
end

-- Connect close button
CloseButton.MouseButton1Click:Connect(toggleCmdList)

--[[
    COMMAND PROCESSING
--]]
local function processCommand(cmd)
    cmd = string.lower(cmd)
    local args = {}
    for arg in cmd:gmatch("%S+") do
        table.insert(args, arg)
    end
    
    -- Handle commands
    if cmd == "cmds" then
        toggleCmdList()
        AriseSendNotify("Command list opened")
    elseif cmd == "fly" then
        -- Implement fly functionality
        AriseSendNotify("Flight mode toggled")
    elseif cmd == "noclip" then
        -- Implement noclip functionality
        AriseSendNotify("Noclip mode toggled")
    elseif args[1] == "speed" and args[2] then
        -- Implement speed functionality
        AriseSendNotify("Walk speed set to "..args[2])
    elseif args[1] == "jumppower" and args[2] then
        -- Implement jumppower functionality
        AriseSendNotify("Jump power set to "..args[2])
    elseif cmd == "god" then
        -- Implement god mode functionality
        AriseSendNotify("God mode toggled")
    elseif cmd == "invisible" then
        -- Implement invisibility functionality
        AriseSendNotify("Invisibility toggled")
    elseif args[1] == "esp" and args[2] then
        -- Implement ESP functionality
        AriseSendNotify("ESP enabled for "..args[2])
    elseif args[1] == "tp" and args[2] then
        -- Implement teleport functionality
        AriseSendNotify("Teleporting to "..args[2])
    elseif args[1] == "bring" and args[2] then
        -- Implement bring functionality
        AriseSendNotify("Bringing "..args[2].." to you")
    elseif args[1] == "kill" and args[2] then
        -- Implement kill functionality
        AriseSendNotify("Attempting to kill "..args[2])
    elseif cmd == "tools" then
        -- Implement tools functionality
        AriseSendNotify("Giving all tools")
    elseif cmd == "clear" then
        -- Implement clear functionality
        AriseSendNotify("Output cleared")
    else
        AriseSendNotify("Unknown command: "..cmd)
    end
    
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

-- Pulse animation for command list
local listPulseConn
local function startListPulseAnimation()
    listPulseConn = RunService.Heartbeat:Connect(function(dt)
        ListUIStroke.Transparency = 0.7 + (math.sin(tick() * 2) * 0.1)
        ListGloss.BackgroundTransparency = 0.9 + (math.sin(tick() * 1.5) * 0.05)
    end)
end

startListPulseAnimation()

-- Initial notification
AriseSendNotify("System initialized. Press ' to open command bar")

print("Arise UI System loaded successfully!")
