-- Arise Cmds
-- Made By 2y/Rukuu Discord: goc2v
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

-- Create the UI
local AriseUI = Instance.new("ScreenGui")
AriseUI.Name = "AriseCommandsUI"
AriseUI.Parent = game.CoreGui

-- Command List Frame
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
CmdList.Visible = true -- Visible by default for standalone
CmdList.Parent = AriseUI

-- Add HD shader effect
local ListShaderFrame = Instance.new("Frame")
ListShaderFrame.Name = "ShaderFrame"
ListShaderFrame.Size = UDim2.new(1, 0, 1, 0)
ListShaderFrame.BackgroundTransparency = 1
ListShaderFrame.ZIndex = 11
ListShaderFrame.Parent = CmdList

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
    {name = "help", description = "Shows this command list"}
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

-- Pulse animation for command list
local listPulseConn
local function startListPulseAnimation()
    listPulseConn = RunService.Heartbeat:Connect(function(dt)
        ListUIStroke.Transparency = 0.7 + (math.sin(tick() * 2) * 0.1)
        ListGloss.BackgroundTransparency = 0.9 + (math.sin(tick() * 1.5) * 0.05)
    end)
end

startListPulseAnimation()

print("Arise Command List loaded! Contains all available commands.")