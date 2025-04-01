-- Advanced UI with Extended Features
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TitleBar = Instance.new("Frame")
local UICorner_TitleBar = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton") 
local ScriptEditor = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local EditorScrollingFrame = Instance.new("ScrollingFrame")
local TextBox = Instance.new("TextBox")
local LineNumbers = Instance.new("TextLabel")
local ControlsFrame = Instance.new("Frame")
local ExecuteButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local ClearButton = Instance.new("TextButton")
local UICorner_Clear = Instance.new("UICorner")
local SaveButton = Instance.new("TextButton") 
local UICorner_Save = Instance.new("UICorner")
local LoadButton = Instance.new("TextButton")
local UICorner_Load = Instance.new("UICorner")
local ScriptHubButton = Instance.new("TextButton")
local UICorner_ScriptHub = Instance.new("UICorner")
local SettingsButton = Instance.new("TextButton")
local UICorner_Settings = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")

-- Add the ScriptHub Frame
local ScriptHubFrame = Instance.new("Frame")
local UICorner_ScriptHubFrame = Instance.new("UICorner")
local ScriptHubList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ScriptHubTitle = Instance.new("TextLabel")
local CloseScriptHubButton = Instance.new("TextButton")

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Variables
local isVisible = true
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil
local savedScripts = {}
local executorName = ""

-- Get executor name function
local function getExecutorName()
    local success, result = pcall(function()
        return getexecutorname()
    end)
    
    if success then
        return result
    else
        return "Internal UI"
    end
end

executorName = getExecutorName()

-- Load saved scripts if they exist
local function loadSavedScripts()
    pcall(function()
        if isfile(executorName .. "_SavedScripts.json") then
            local content = readfile(executorName .. "_SavedScripts.json")
            savedScripts = HttpService:JSONDecode(content)
        end
    end)
end

-- Save scripts to json
local function saveScriptsList()
    pcall(function()
        local json = HttpService:JSONEncode(savedScripts)
        writefile(executorName .. "_SavedScripts.json", json)
    end)
end

-- Properties:
ScreenGui.Name = executorName .. "UI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.207, 0, 0.224, 0)
Frame.Size = UDim2.new(0, 768, 0, 476)
Frame.Active = true
Frame.ClipsDescendants = true

UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = Frame

-- Title Bar
TitleBar.Name = "TitleBar"
TitleBar.Parent = Frame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

UICorner_TitleBar.CornerRadius = UDim.new(0, 25)
UICorner_TitleBar.Parent = TitleBar

Title.Parent = TitleBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = executorName .. " Internal UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20.000
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.BackgroundTransparency = 0.2
CloseButton.Position = UDim2.new(1, -35, 0.5, -10)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14.000
CloseButton.AutoButtonColor = false

Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(1, 0)

MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 70)
MinimizeButton.BackgroundTransparency = 0.2
MinimizeButton.Position = UDim2.new(1, -65, 0.5, -10)
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14.000
MinimizeButton.AutoButtonColor = false

Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(1, 0)

ScriptEditor.Name = "ScriptEditor"
ScriptEditor.Parent = Frame
ScriptEditor.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
ScriptEditor.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScriptEditor.BorderSizePixel = 0
ScriptEditor.Position = UDim2.new(0.0138408346, 0, 0.0971820322, 0)
ScriptEditor.Size = UDim2.new(0, 747, 0, 329)
ScriptEditor.ClipsDescendants = true

UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = ScriptEditor

-- Line numbers with proper padding
LineNumbers = Instance.new("TextLabel")
LineNumbers.Name = "LineNumbers"
LineNumbers.Parent = ScriptEditor
LineNumbers.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LineNumbers.BorderSizePixel = 0
LineNumbers.Size = UDim2.new(0, 30, 1, 0)
LineNumbers.Position = UDim2.new(0, 0, 0, 0)
LineNumbers.Font = Enum.Font.Code
LineNumbers.Text = "1"
LineNumbers.TextColor3 = Color3.fromRGB(150, 150, 150)
LineNumbers.TextSize = 14
LineNumbers.TextYAlignment = Enum.TextYAlignment.Top
LineNumbers.TextXAlignment = Enum.TextXAlignment.Right

-- Add UIPadding for proper text padding
local UIPadding = Instance.new("UIPadding")
UIPadding.Parent = LineNumbers
UIPadding.PaddingRight = UDim.new(0, 5)
UIPadding.PaddingTop = UDim.new(0, 5)

EditorScrollingFrame = Instance.new("ScrollingFrame")
EditorScrollingFrame.Name = "EditorScrollingFrame"
EditorScrollingFrame.Parent = ScriptEditor
EditorScrollingFrame.BackgroundTransparency = 1
EditorScrollingFrame.Position = UDim2.new(0, 35, 0, 0)
EditorScrollingFrame.Size = UDim2.new(1, -40, 1, 0)
EditorScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
EditorScrollingFrame.ScrollBarThickness = 5
EditorScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
EditorScrollingFrame.BorderSizePixel = 0
EditorScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

TextBox = Instance.new("TextBox")
TextBox.Parent = EditorScrollingFrame
TextBox.BackgroundTransparency = 1
TextBox.Size = UDim2.new(1, -10, 1, 0)
TextBox.Position = UDim2.new(0, 5, 0, 5)
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 14
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true
TextBox.AutomaticSize = Enum.AutomaticSize.Y
TextBox.Text = ""
TextBox.PlaceholderText = "Enter your script here..."
TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)

-- Controls Frame
ControlsFrame = Instance.new("Frame")
ControlsFrame.Name = "ControlsFrame"
ControlsFrame.Parent = Frame
ControlsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ControlsFrame.BorderSizePixel = 0
ControlsFrame.Position = UDim2.new(0.0138408346, 0, 0.826504064, 0)
ControlsFrame.Size = UDim2.new(0, 747, 0, 75)

Instance.new("UICorner", ControlsFrame).CornerRadius = UDim.new(0, 15)

StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = ControlsFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.01, 0, 0.68, 0)
StatusLabel.Size = UDim2.new(0.98, 0, 0.3, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Ready | Press INSERT to toggle UI"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

ExecuteButton = Instance.new("TextButton")
ExecuteButton.Parent = ControlsFrame
ExecuteButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
ExecuteButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ExecuteButton.BorderSizePixel = 0
ExecuteButton.Position = UDim2.new(0.01, 0, 0.1, 0)
ExecuteButton.Size = UDim2.new(0, 120, 0, 38)
ExecuteButton.Font = Enum.Font.GothamBold
ExecuteButton.Text = "Execute"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextSize = 16.000

UICorner_3.CornerRadius = UDim.new(0, 8)
UICorner_3.Parent = ExecuteButton

UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 170, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 85, 255))
}
UIGradient.Parent = ExecuteButton

ClearButton = Instance.new("TextButton")
ClearButton.Name = "ClearButton"
ClearButton.Parent = ControlsFrame
ClearButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ClearButton.Position = UDim2.new(0.18, 0, 0.1, 0)
ClearButton.Size = UDim2.new(0, 80, 0, 38)
ClearButton.Font = Enum.Font.GothamBold
ClearButton.Text = "Clear"
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.TextSize = 14.000

UICorner_Clear.CornerRadius = UDim.new(0, 8)
UICorner_Clear.Parent = ClearButton

SaveButton = Instance.new("TextButton")
SaveButton.Name = "SaveButton"
SaveButton.Parent = ControlsFrame
SaveButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SaveButton.Position = UDim2.new(0.3, 0, 0.1, 0)
SaveButton.Size = UDim2.new(0, 80, 0, 38)
SaveButton.Font = Enum.Font.GothamBold
SaveButton.Text = "Save"
SaveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveButton.TextSize = 14.000

UICorner_Save.CornerRadius = UDim.new(0, 8)
UICorner_Save.Parent = SaveButton

LoadButton = Instance.new("TextButton")
LoadButton.Name = "LoadButton"
LoadButton.Parent = ControlsFrame
LoadButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LoadButton.Position = UDim2.new(0.42, 0, 0.1, 0)
LoadButton.Size = UDim2.new(0, 80, 0, 38)
LoadButton.Font = Enum.Font.GothamBold
LoadButton.Text = "Load"
LoadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadButton.TextSize = 14.000

UICorner_Load.CornerRadius = UDim.new(0, 8)
UICorner_Load.Parent = LoadButton

ScriptHubButton = Instance.new("TextButton")
ScriptHubButton.Name = "ScriptHubButton"
ScriptHubButton.Parent = ControlsFrame
ScriptHubButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScriptHubButton.Position = UDim2.new(0.54, 0, 0.1, 0)
ScriptHubButton.Size = UDim2.new(0, 100, 0, 38)
ScriptHubButton.Font = Enum.Font.GothamBold
ScriptHubButton.Text = "Script Hub"
ScriptHubButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptHubButton.TextSize = 14.000

UICorner_ScriptHub.CornerRadius = UDim.new(0, 8)
UICorner_ScriptHub.Parent = ScriptHubButton

SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = ControlsFrame
SettingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SettingsButton.Position = UDim2.new(0.68, 0, 0.1, 0)
SettingsButton.Size = UDim2.new(0, 90, 0, 38)
SettingsButton.Font = Enum.Font.GothamBold
SettingsButton.Text = "Settings"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 14.000

UICorner_Settings.CornerRadius = UDim.new(0, 8)
UICorner_Settings.Parent = SettingsButton

-- Script Hub Frame
ScriptHubFrame.Name = "ScriptHubFrame"
ScriptHubFrame.Parent = ScreenGui
ScriptHubFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ScriptHubFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
ScriptHubFrame.Size = UDim2.new(0, 400, 0, 300)
ScriptHubFrame.Visible = false
ScriptHubFrame.ZIndex = 10
ScriptHubFrame.Active = true
ScriptHubFrame.Draggable = true

UICorner_ScriptHubFrame.CornerRadius = UDim.new(0, 15)
UICorner_ScriptHubFrame.Parent = ScriptHubFrame

ScriptHubTitle = Instance.new("TextLabel")
ScriptHubTitle.Name = "ScriptHubTitle"
ScriptHubTitle.Parent = ScriptHubFrame
ScriptHubTitle.BackgroundTransparency = 1
ScriptHubTitle.Position = UDim2.new(0, 15, 0, 10)
ScriptHubTitle.Size = UDim2.new(1, -30, 0, 25)
ScriptHubTitle.Font = Enum.Font.GothamBold
ScriptHubTitle.Text = executorName .. " Script Hub"
ScriptHubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptHubTitle.TextSize = 18
ScriptHubTitle.TextXAlignment = Enum.TextXAlignment.Left

CloseScriptHubButton = Instance.new("TextButton")
CloseScriptHubButton.Name = "CloseScriptHubButton"
CloseScriptHubButton.Parent = ScriptHubFrame
CloseScriptHubButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseScriptHubButton.BackgroundTransparency = 0.2
CloseScriptHubButton.Position = UDim2.new(1, -30, 0, 10)
CloseScriptHubButton.Size = UDim2.new(0, 20, 0, 20)
CloseScriptHubButton.Font = Enum.Font.GothamBold
CloseScriptHubButton.Text = "X"
CloseScriptHubButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseScriptHubButton.TextSize = 14.000
CloseScriptHubButton.ZIndex = 11

Instance.new("UICorner", CloseScriptHubButton).CornerRadius = UDim.new(1, 0)

ScriptHubList = Instance.new("ScrollingFrame")
ScriptHubList.Name = "ScriptHubList"
ScriptHubList.Parent = ScriptHubFrame
ScriptHubList.BackgroundTransparency = 1
ScriptHubList.Position = UDim2.new(0, 10, 0, 45)
ScriptHubList.Size = UDim2.new(1, -20, 1, -55)
ScriptHubList.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptHubList.ScrollBarThickness = 5
ScriptHubList.ScrollingDirection = Enum.ScrollingDirection.Y
ScriptHubList.BorderSizePixel = 0
ScriptHubList.ZIndex = 10

UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScriptHubList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Function to update line numbers
local function updateLineNumbers()
    local text = TextBox.Text
    local lines = text:split("\n")
    local lineNumbersText = ""
    
    for i = 1, #lines do
        lineNumbersText = lineNumbersText .. i .. "\n"
    end
    
    -- Ensure there's at least one line number
    if lineNumbersText == "" then
        lineNumbersText = "1"
    end
    
    LineNumbers.Text = lineNumbersText
end

-- Function to add a script to the script hub
local function addScriptToHub(name, script)
    local scriptButton = Instance.new("TextButton")
    scriptButton.Name = name
    scriptButton.Parent = ScriptHubList
    scriptButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    scriptButton.Size = UDim2.new(1, -10, 0, 40)
    scriptButton.Font = Enum.Font.Gotham
    scriptButton.Text = name
    scriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    scriptButton.TextSize = 14
    scriptButton.ZIndex = 11
    
    Instance.new("UICorner", scriptButton).CornerRadius = UDim.new(0, 8)
    
    scriptButton.MouseButton1Click:Connect(function()
        TextBox.Text = script
        updateLineNumbers()
        ScriptHubFrame.Visible = false
        StatusLabel.Text = "Loaded script: " .. name
    end)
    
    return scriptButton
end

-- Function to save script with name
local function saveScript()
    local name = game:GetService("Players").LocalPlayer.Name .. "'s Script " .. os.date("%H:%M:%S")
    
    -- Show input dialog (simplified version)
    local nameInput = Instance.new("TextBox")
    nameInput.Parent = Frame
    nameInput.Position = UDim2.new(0.5, -150, 0.5, -15)
    nameInput.Size = UDim2.new(0, 300, 0, 30)
    nameInput.Text = name
    nameInput.PlaceholderText = "Enter script name"
    nameInput.Font = Enum.Font.Gotham
    nameInput.TextSize = 14
    nameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    nameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameInput.BorderSizePixel = 0
    nameInput.ZIndex = 100
    
    Instance.new("UICorner", nameInput).CornerRadius = UDim.new(0, 8)
    
    local saveConfirm = Instance.new("TextButton")
    saveConfirm.Parent = Frame
    saveConfirm.Position = UDim2.new(0.5, -55, 0.5, 20)
    saveConfirm.Size = UDim2.new(0, 110, 0, 30)
    saveConfirm.Text = "Save"
    saveConfirm.Font = Enum.Font.GothamBold
    saveConfirm.TextSize = 14
    saveConfirm.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
    saveConfirm.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveConfirm.BorderSizePixel = 0
    saveConfirm.ZIndex = 100
    
    Instance.new("UICorner", saveConfirm).CornerRadius = UDim.new(0, 8)
    
    local cancelButton = Instance.new("TextButton")
    cancelButton.Parent = Frame
    cancelButton.Position = UDim2.new(0.5, 65, 0.5, 20)
    cancelButton.Size = UDim2.new(0, 110, 0, 30)
    cancelButton.Text = "Cancel"
    cancelButton.Font = Enum.Font.GothamBold
    cancelButton.TextSize = 14
    cancelButton.BackgroundColor3 = Color3.fromRGB(170, 85, 127)
    cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelButton.BorderSizePixel = 0
    cancelButton.ZIndex = 100
    
    Instance.new("UICorner", cancelButton).CornerRadius = UDim.new(0, 8)
    
    local backdrop = Instance.new("Frame")
    backdrop.Parent = Frame
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 0.7
    backdrop.BorderSizePixel = 0
    backdrop.ZIndex = 99
    
    saveConfirm.MouseButton1Click:Connect(function()
        local scriptName = nameInput.Text
        if scriptName ~= "" then
            savedScripts[scriptName] = TextBox.Text
            saveScriptsList()
            addScriptToHub(scriptName, TextBox.Text)
            StatusLabel.Text = "Script saved: " .. scriptName
        end
        nameInput:Destroy()
        saveConfirm:Destroy()
        cancelButton:Destroy()
        backdrop:Destroy()
    end)
    
    cancelButton.MouseButton1Click:Connect(function()
        nameInput:Destroy()
        saveConfirm:Destroy()
        cancelButton:Destroy()
        backdrop:Destroy()
    end)
end

-- Function to update canvas size
local function updateCanvasSize()
    local textBounds = TextService:GetTextSize(
        TextBox.Text, 
        TextBox.TextSize, 
        TextBox.Font, 
        Vector2.new(EditorScrollingFrame.AbsoluteSize.X, 10000)
    )
    
    EditorScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(textBounds.Y + 20, EditorScrollingFrame.AbsoluteSize.Y))
end

-- Function to toggle UI visibility
local function toggleUI()
    isVisible = not isVisible
    
    -- Create animation
    local targetSize = isVisible and UDim2.new(0, 768, 0, 476) or UDim2.new(0, 768, 0, 40)
    local targetPos = isVisible and UDim2.new(0.207, 0, 0.224, 0) or UDim2.new(0.207, 0, 0, -446)
    
    local sizeTween = TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = targetSize
    })
    
    sizeTween:Play()
    
    -- Hide all children except TitleBar when minimized
    if not isVisible then
        for _, child in pairs(Frame:GetChildren()) do
            if child ~= TitleBar then
                child.Visible = false
            end
        end
    else
        -- Show all children when restored
        for _, child in pairs(Frame:GetChildren()) do
            child.Visible = true
        end
    end
end

-- Handle text changes
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateLineNumbers()
    updateCanvasSize()
end)

-- Sync scrolling between line numbers and text
EditorScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    LineNumbers.Position = UDim2.new(0, 0, 0, -EditorScrollingFrame.CanvasPosition.Y)
end)

-- Button hover effects for all buttons
local function setupButtonHoverEffect(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = hoverColor}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = normalColor}):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset - 4, button.Size.Y.Scale, button.Size.Y.Offset - 4)}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset + 4, button.Size.Y.Scale, button.Size.Y.Offset + 4)}):Play()
    end)
end

setupButtonHoverEffect(ExecuteButton, Color3.fromRGB(34, 34, 34), Color3.fromRGB(45, 45, 45))
setupButtonHoverEffect(ClearButton, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))
setupButtonHoverEffect(SaveButton, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))
setupButtonHoverEffect(LoadButton, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))
setupButtonHoverEffect(ScriptHubButton, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))
setupButtonHoverEffect(SettingsButton, Color3.fromRGB(40, 40, 40), Color3.fromRGB(60, 60, 60))

-- Add the click event for the Execute button
-- Add the click event for the Execute button
ExecuteButton.MouseButton1Click:Connect(function()
    local scriptContent = TextBox.Text
    if scriptContent ~= "" then
        StatusLabel.Text = "Executing script..."
        
        local success, errorMsg = pcall(function()
            loadstring(scriptContent)()
        end)
        
        if not success then
            warn("Script execution error: " .. errorMsg)
            StatusLabel.Text = "Error: " .. errorMsg:sub(1, 40) .. "..."
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        else
            StatusLabel.Text = "Script executed successfully!"
            StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
        end
    end
end)

-- Add functionality to other buttons
ClearButton.MouseButton1Click:Connect(function()
    TextBox.Text = ""
    StatusLabel.Text = "Editor cleared"
end)

SaveButton.MouseButton1Click:Connect(function()
    saveScript()
end)

LoadButton.MouseButton1Click:Connect(function()
    if not ScriptHubFrame.Visible then
        ScriptHubFrame.Visible = true
        StatusLabel.Text = "Select a script to load"
    else
        ScriptHubFrame.Visible = false
    end
end)

ScriptHubButton.MouseButton1Click:Connect(function()
    if not ScriptHubFrame.Visible then
        ScriptHubFrame.Visible = true
        StatusLabel.Text = executorName .. " Script Hub opened"
    else
        ScriptHubFrame.Visible = false
    end
end)

SettingsButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "Settings coming soon..."
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    toggleUI()
end)

CloseScriptHubButton.MouseButton1Click:Connect(function()
    ScriptHubFrame.Visible = false
end)

-- Make Frame draggable
local function updateDrag(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Toggle UI with Insert key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        toggleUI()
    end
end)

-- Sample scripts for the Script Hub
local sampleScripts = {
    ["ESP Script"] = [[
        -- Simple ESP Script
        local esp = {}
        local players = game:GetService("Players")
        local runService = game:GetService("RunService")
        
        local function createESP(player)
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = player.Character
            esp[player] = highlight
        end
        
        for _, player in pairs(players:GetPlayers()) do
            if player ~= players.LocalPlayer and player.Character then
                createESP(player)
            end
        end
        
        players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                wait(1)
                createESP(player)
            end)
        end)
        
        players.PlayerRemoving:Connect(function(player)
            if esp[player] then
                esp[player]:Destroy()
                esp[player] = nil
            end
        end)
        
        print("ESP enabled!")
    ]],
    
    ["Infinite Jump"] = [[
        -- Infinite Jump Script
        local Player = game:GetService("Players").LocalPlayer
        local UserInputService = game:GetService("UserInputService")
        
        -- Variables
        local InfiniteJumpEnabled = true
        
        UserInputService.JumpRequest:Connect(function()
            if InfiniteJumpEnabled then
                Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
        
        print("Infinite Jump enabled! Press SPACE to jump infinitely.")
    ]],
    
    ["Speed Hack"] = [[
        -- Speed Hack Script
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        
        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        
        -- Settings
        local SpeedMultiplier = 3  -- Adjust this value to change speed
        
        -- Speed hack function
        local function updateSpeed()
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                Humanoid.WalkSpeed = 16 * SpeedMultiplier
            else
                Humanoid.WalkSpeed = 16
            end
        end
        
        RunService.RenderStepped:Connect(updateSpeed)
        
        print("Speed hack enabled! Hold SHIFT to run faster.")
    ]],
    
    ["No-Clip"] = [[
        -- No-Clip Script
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        
        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        
        -- Variables
        local NoClipEnabled = false
        
        -- Toggle function
        local function toggleNoClip()
            NoClipEnabled = not NoClipEnabled
            local state = NoClipEnabled and "Enabled" or "Disabled"
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "No-Clip",
                Text = state,
                Duration = 2
            })
        end
        
        -- No-clip loop
        RunService.Stepped:Connect(function()
            if NoClipEnabled then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
        -- Toggle on 'T' key press
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
                toggleNoClip()
            end
        end)
        
        print("No-Clip script loaded! Press T to toggle.")
    ]],
    
    ["Aimbot"] = [[
        -- Basic Aimbot
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        
        -- Settings
        local Settings = {
            Enabled = true,
            TeamCheck = true,
            ToggleKey = Enum.KeyCode.RightAlt,
            MaxDistance = 500,
            FieldOfView = 100,
            AimPart = "Head",
            Sensitivity = 0.5
        }
        
        -- Variables
        local ClosestPlayer = nil
        local AimActive = false
        
        -- Functions
        local function getClosestPlayer()
            local shortestDistance = Settings.MaxDistance
            local target = nil
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(Settings.AimPart) then
                    if Settings.TeamCheck and player.Team == LocalPlayer.Team then continue end
                    
                    local worldPoint = player.Character[Settings.AimPart].Position
                    local vector, onScreen = Camera:WorldToScreenPoint(worldPoint)
                    local magnitude = (Vector2.new(vector.X, vector.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                    
                    if onScreen and magnitude < shortestDistance and magnitude <= Settings.FieldOfView then
                        shortestDistance = magnitude
                        target = player
                    end
                end
            end
            
            return target
        end
        
        -- Main loop
        RunService.RenderStepped:Connect(function()
            if Settings.Enabled and AimActive then
                ClosestPlayer = getClosestPlayer()
                
                if ClosestPlayer and ClosestPlayer.Character and ClosestPlayer.Character:FindFirstChild(Settings.AimPart) then
                    local aimPos = Camera:WorldToViewportPoint(ClosestPlayer.Character[Settings.AimPart].Position)
                    local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local move = Vector2.new((aimPos.X - mousePos.X) * Settings.Sensitivity, (aimPos.Y - mousePos.Y) * Settings.Sensitivity)
                    
                    mousemoverel(move.X, move.Y)
                end
            end
        end)
        
        -- Toggle aim with right mouse button
        UserInputService.InputBegan:Connect(function(input, processed)
            if not processed then
                if input.UserInputType == Enum.UserInputType.MouseButton2 then
                    AimActive = true
                elseif input.KeyCode == Settings.ToggleKey then
                    Settings.Enabled = not Settings.Enabled
                end
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input, processed)
            if not processed and input.UserInputType == Enum.UserInputType.MouseButton2 then
                AimActive = false
            end
        end)
        
        print("Aimbot loaded! Hold right mouse button to aim.")
    ]]
}

-- Дополнительные скрипты для Script Hub
local additionalScripts = {
    ["Universal FPS Booster"] = [[
        -- Universal FPS Booster
        local decalsEnabled = true
        local lightingEnabled = false
        local particlesEnabled = false
        
        -- Performance Settings
        settings().Rendering.QualityLevel = 1
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
        
        -- Disable Textures/Decals
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                
                if decalsEnabled == false then
                    if v:IsA("BasePart") and v.Transparency == 0 then
                        v.Transparency = 0.05
                    end
                end
            elseif v:IsA("Decal") and decalsEnabled == false then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") and particlesEnabled == false then
                v.Enabled = false
            elseif v:IsA("Fire") and particlesEnabled == false then
                v.Enabled = false
            elseif v:IsA("Smoke") and particlesEnabled == false then
                v.Enabled = false
            elseif v:IsA("Sparkles") and particlesEnabled == false then
                v.Enabled = false
            elseif v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false
            end
        end
        
        -- Lighting Configuration
        local lighting = game:GetService("Lighting")
        
        if lightingEnabled == false then
            lighting.GlobalShadows = false
            lighting.FogEnd = 9e9
            lighting.Brightness = 2
        end
        
        lighting.Ambient = Color3.fromRGB(180, 180, 180)
        
        -- Game Settings
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FPS Booster",
            Text = "FPS Boost enabled!",
            Duration = 5
        })
        
        print("FPS Booster enabled. Your game may look different but should run smoother.")
    ]],
    
    ["Universal Admin Commands"] = [[
        -- Universal Admin Commands
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local prefix = "/"
        
        local function findPlayer(name)
            name = name:lower()
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name:lower():sub(1, #name) == name then
                    return player
                end
            end
            
            return nil
        end
        
        -- Command Functions
        local commands = {
            kill = function(target)
                local player = findPlayer(target)
                if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.Health = 0
                    return "Killed " .. player.Name
                end
                return "Player not found or cannot be killed"
            end,
            
            teleport = function(targetName)
                local target = findPlayer(targetName)
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                    return "Teleported to " .. target.Name
                end
                return "Cannot teleport to player"
            end,
            
            bring = function(targetName)
                local target = findPlayer(targetName)
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    target.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    return "Brought " .. target.Name .. " to you"
                end
                return "Cannot bring player"
            end,
            
            speed = function(speed)
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    local speedNum = tonumber(speed) or 16
                    LocalPlayer.Character.Humanoid.WalkSpeed = speedNum
                    return "Set speed to " .. speedNum
                end
                return "Cannot set speed"
            end,
            
            jump = function(height)
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    local heightNum = tonumber(height) or 50
                    LocalPlayer.Character.Humanoid.JumpPower = heightNum
                    return "Set jump power to " .. heightNum
                end
                return "Cannot set jump power"
            end,
            
            fly = function()
                -- Simple fly implementation
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("Humanoid") then
                    return "Cannot enable fly"
                end
                
                local humanoid = character:FindFirstChild("Humanoid")
                local torso = character:FindFirstChild("HumanoidRootPart")
                
                if not torso then
                    return "Cannot enable fly"
                end
                
                local flyPart = Instance.new("BodyVelocity")
                flyPart.Parent = torso
                flyPart.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                flyPart.Velocity = Vector3.new(0, 0.1, 0)
                
                humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
                
                return "Fly enabled. Use WASD to move and Space/Shift to go up/down."
            end,
            
            unfly = function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then
                    return "Cannot disable fly"
                end
                
                local torso = character:FindFirstChild("HumanoidRootPart")
                
                for _, v in pairs(torso:GetChildren()) do
                    if v:IsA("BodyVelocity") then
                        v:Destroy()
                    end
                end
                
                if character:FindFirstChild("Humanoid") then
                    character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
                
                return "Fly disabled"
            end,
            
            noclip = function()
                local character = LocalPlayer.Character
                if not character then
                    return "Cannot enable noclip"
                end
                
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                
                game:GetService("RunService").Stepped:Connect(function()
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
                
                return "Noclip enabled"
            end,
            
            respawn = function()
                local character = LocalPlayer.Character
                if character then
                    character:BreakJoints()
                end
                return "Respawning..."
            end,
            
            god = function()
                local character = LocalPlayer.Character
                if not character or not character:FindFirstChild("Humanoid") then
                    return "Cannot enable god mode"
                end
                
                character.Humanoid.MaxHealth = math.huge
                character.Humanoid.Health = math.huge
                
                return "God mode enabled"
            end,
            
            reset = function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.Health = 0
                end
                return "Character reset"
            end,
            
            help = function()
                return "Available commands: kill, teleport, bring, speed, jump, fly, unfly, noclip, respawn, god, reset, help"
            end
        }
        
        -- Command Handler
        LocalPlayer.Chatted:Connect(function(message)
            if message:sub(1, 1) == prefix then
                local args = {}
                for arg in message:sub(2):gmatch("%S+") do
                    table.insert(args, arg)
                end
                
                local commandName = args[1]:lower()
                table.remove(args, 1)
                
                if commands[commandName] then
                    local result = commands[commandName](unpack(args))
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Admin Command",
                        Text = result,
                        Duration = 3
                    })
                else
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Admin Command",
                        Text = "Unknown command: " .. commandName,
                        Duration = 3
                    })
                end
            end
        end)
        
        print("Admin Commands Loaded! Use " .. prefix .. "help to see available commands.")
    ]],
    
    ["Item ESP"] = [[
        -- Item ESP Script
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        
        -- Settings
        local Settings = {
            ItemColor = Color3.fromRGB(0, 255, 0),
            ItemTransparency = 0.5,
            MaxDistance = 500,
            DisplayDistance = true,
            ItemNames = {
                "Chest", "Item", "Tool", "Gun", "Weapon", "Sword", "Knife", "Ammo", "Cash",
                "Money", "Gold", "Coin", "PowerUp", "Power", "Gem", "Diamond", "Ruby", "Key"
            }
        }
        
        -- Storage for ESP objects
        local ESPInstances = {}
        
        local function isItemRelevant(obj)
            -- Check name
            local lowerName = obj.Name:lower()
            for _, itemName in pairs(Settings.ItemNames) do
                if lowerName:find(itemName:lower()) then
                    return true
                end
            end
            
            -- Check for typical item characteristics
            if obj:IsA("Tool") or obj:IsA("Model") then
                return true
            end
            
            -- Check for special item properties
            if obj:FindFirstChild("ClickDetector") or obj:FindFirstChild("TouchTransmitter") then
                return true
            end
            
            return false
        end
        
        local function createESP(item)
            if not item:IsA("BasePart") and not item:IsA("Model") then
                return
            end
            
            local itemPart = item:IsA("Model") and (item:FindFirstChild("Handle") or item:FindFirstChildWhichIsA("BasePart")) or item
            
            if not itemPart then return end
            
            -- Create the ESP
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESP"
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.Adornee = itemPart
            
            local itemName = Instance.new("TextLabel")
            itemName.Name = "ItemName"
            itemName.BackgroundTransparency = 1
            itemName.Size = UDim2.new(1, 0, 0.5, 0)
            itemName.Position = UDim2.new(0, 0, 0, 0)
            itemName.Font = Enum.Font.GothamBold
            itemName.Text = item.Name
            itemName.TextColor3 = Settings.ItemColor
            itemName.TextStrokeTransparency = 0.7
            itemName.TextSize = 14
            itemName.Parent = billboard
            
            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Name = "Distance"
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
            distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
            distanceLabel.Font = Enum.Font.Gotham
            distanceLabel.Text = "0m"
            distanceLabel.TextColor3 = Settings.ItemColor
            distanceLabel.TextStrokeTransparency = 0.7
            distanceLabel.TextSize = 12
            distanceLabel.Parent = billboard
            
            billboard.Parent = item
            
            -- Add to storage
            ESPInstances[item] = {
                billboard = billboard,
                nameLabel = itemName,
                distanceLabel = distanceLabel,
                part = itemPart
            }
        end
        
        local function updateESP()
            for item, espData in pairs(ESPInstances) do
                if not item or not item:IsDescendantOf(workspace) or not espData.part or not espData.part:IsDescendantOf(workspace) then
                    if espData.billboard then
                        espData.billboard:Destroy()
                    end
                    ESPInstances[item] = nil
                    continue
                end
                
                local distance = (Camera.CFrame.Position - espData.part.Position).Magnitude
                
                -- Check if within range
                if distance > Settings.MaxDistance then
                    espData.billboard.Enabled = false
                else
                    espData.billboard.Enabled = true
                    
                    -- Update distance text
                    if Settings.DisplayDistance then
                        espData.distanceLabel.Text = math.floor(distance) .. "m"
                    else
                        espData.distanceLabel.Text = ""
                    end
                    
                    -- Scale text based on distance (optional)
                    local textSize = math.clamp(14 * (1 - distance / Settings.MaxDistance), 8, 14)
                    espData.nameLabel.TextSize = textSize
                    espData.distanceLabel.TextSize = textSize - 2
                end
            end
        end
        
        -- Scan the workspace initially
        for _, item in pairs(workspace:GetDescendants()) do
            if isItemRelevant(item) then
                createESP(item)
            end
        end
        
        -- Listen for new items
        workspace.DescendantAdded:Connect(function(item)
            wait(1) -- Small delay to let the object initialize
            if isItemRelevant(item) then
                createESP(item)
            end
        end)
        
        -- Update ESP
        RunService.RenderStepped:Connect(updateESP)
        
        print("Item ESP enabled! Looking for valuable items...")
    ]],
    
    ["Hitbox Expander"] = [[
        -- Hitbox Expander
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        
        -- Settings
        local Settings = {
            Enabled = true,
            TeamCheck = true,
            Size = 10, -- Hitbox size multiplier
            Transparency = 0.8, -- Visual hitbox transparency
            Color = Color3.fromRGB(255, 0, 0), -- Visual hitbox color
            VisualizeHitbox = true, -- Show the hitbox
            HeadshotOnly = false -- Only expand the head hitbox
        }
        
        -- Variables
        local LocalPlayer = Players.LocalPlayer
        local expandedHitboxes = {}
        
        local function isTeammate(player)
            if Settings.TeamCheck then
                return player.Team == LocalPlayer.Team
            end
            return false
        end
        
        local function expandHitbox(player)
            if player == LocalPlayer or isTeammate(player) then return end
            
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
            
            if not humanoidRootPart or not head then return end
            
            -- Store original sizes to restore later
            if not expandedHitboxes[player] then
                expandedHitboxes[player] = {
                    rootPartSize = humanoidRootPart.Size,
                    headSize = head.Size,
                    rootPartTransparency = humanoidRootPart.Transparency,
                    headTransparency = head.Transparency
                }
            end
            
            -- Expand the hitbox
            if Settings.HeadshotOnly then
                head.Size = Vector3.new(Settings.Size, Settings.Size, Settings.Size)
                if Settings.VisualizeHitbox then
                    head.Transparency = Settings.Transparency
                    head.Color = Settings.Color
                end
            else
                humanoidRootPart.Size = Vector3.new(Settings.Size, Settings.Size, Settings.Size)
                if Settings.VisualizeHitbox then
                    humanoidRootPart.Transparency = Settings.Transparency
                    humanoidRootPart.Color = Settings.Color
                end
            end
            
            -- Make it CanCollide false to avoid pushing the player
            humanoidRootPart.CanCollide = false
            head.CanCollide = false
        end
        
        local function revertHitbox(player)
            local data = expandedHitboxes[player]
            if not data then return end
            
            local character = player.Character
            if not character then return end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local head = character:FindFirstChild("Head")
            
            if humanoidRootPart then
                humanoidRootPart.Size = data.rootPartSize
                humanoidRootPart.Transparency = data.rootPartTransparency
            end
            
            if head then
                head.Size = data.headSize
                head.Transparency = data.headTransparency
            end
            
            expandedHitboxes[player] = nil
        end
        
        -- Handle existing players
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                expandHitbox(player)
            end
        end
        
        -- Handle new players
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                if Settings.Enabled then
                    wait(1) -- Wait for character to fully load
                    expandHitbox(player)
                end
            end)
        end)
        
        -- Handle players leaving
        Players.PlayerRemoving:Connect(function(player)
            expandedHitboxes[player] = nil
        end)
        
        -- Toggle functionality
        local UserInputService = game:GetService("UserInputService")
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
                Settings.Enabled = not Settings.Enabled
                
                if Settings.Enabled then
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            expandHitbox(player)
                        end
                    end
                else
                    for player, _ in pairs(expandedHitboxes) do
                        revertHitbox(player)
                    end
                end
                
                -- Notification
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Hitbox Expander",
                    Text = Settings.Enabled and "Enabled" or "Disabled",
                    Duration = 2
                })
            end
        end)
        
        print("Hitbox Expander loaded! Press H to toggle.")
    ]],
    
    ["Teleport Tool"] = [[
        -- Teleport Tool
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        -- Create the teleport tool
        local tool = Instance.new("Tool")
        tool.Name = "Teleport Tool"
        tool.CanBeDropped = false
        tool.RequiresHandle = false
        
        -- Set up the tool
        tool.Activated:Connect(function()
            local character = LocalPlayer.Character
            if not character then return end
            
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end
            
            local mouse = LocalPlayer:GetMouse()
            local target = mouse.Hit.Position
            
            -- Teleport the player
            humanoidRootPart.CFrame = CFrame.new(target + Vector3.new(0, 3, 0))
            
            -- Effect
            local effect = Instance.new("Part")
            effect.Shape = Enum.PartType.Ball
            effect.Size = Vector3.new(1, 1, 1)
            effect.Anchored = true
            effect.CanCollide = false
            effect.Material = Enum.Material.Neon
            effect.BrickColor = BrickColor.new("Cyan")
            effect.Transparency = 0.3
            effect.Position = target
            effect.Parent = workspace
            
            -- Animate the effect
            for i = 1, 10 do
                effect.Size = Vector3.new(i, i, i)
                effect.Transparency = 0.3 + (i * 0.07)
                wait(0.02)
            end
            
            effect:Destroy()
        end)
        
        -- Give the tool to the player
        if LocalPlayer.Character then
            tool.Parent = LocalPlayer.Backpack
        end
        
        LocalPlayer.CharacterAdded:Connect(function()
            wait(1)
            tool.Parent = LocalPlayer.Backpack
        end)
        
        print("Teleport Tool added to your inventory. Equip and click to teleport!")
    ]],
    
    ["Auto Farm"] = [[
        -- Auto Farm Script (Basic Template)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        
        -- Settings (customize these for each game)
        local Settings = {
            Enabled = true,
            FarmSpeed = 15,
            FarmDistance = 10,
            CollectibleNames = {"Coin", "Gem", "Diamond", "Cash", "Money"},
            EnemyNames = {"Zombie", "Monster", "Enemy", "Mob"},
            AutoAttack = true,
            AttackDelay = 0.5
        }
        
        -- Variables
        local targets = {}
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local attacking = false
        
        -- Auto Farm Functions
        local function isTarget(obj)
            -- Check if it's a collectible
            local name = obj.Name:lower()
            for _, collectible in pairs(Settings.CollectibleNames) do
                if name:find(collectible:lower()) then
                    return true, "collectible"
                end
            end
            
            -- Check if it's an enemy
            for _, enemy in pairs(Settings.EnemyNames) do
                if name:find(enemy:lower()) then
                    return true, "enemy"
                end
            end
            
            -- Check for special markers or properties
            if obj:FindFirstChild("CollectibleScript") or obj:FindFirstChild("CoinScript") then
                return true, "collectible"
            end
            
            if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("Humanoid").Health > 0 and not Players:GetPlayerFromCharacter(obj) then
                return true, "enemy"
            end
            
            return false, ""
        end
        
        local function getTargets()
            targets = {}
            
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") or obj:IsA("Model") then
                    local isValidTarget, targetType = isTarget(obj)
                    
                    if isValidTarget then
                        local targetPart = obj:IsA("Model") and (obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or obj
                        
                        if targetPart then
                            local distance = (rootPart.Position - targetPart.Position).Magnitude
                            
                            if distance <= Settings.FarmDistance then
                                table.insert(targets, {
                                    instance = obj,
                                    part = targetPart,
                                    distance = distance,
                                    type = targetType
                                })
                            end
                        end
                    end
                end
            end
            
            -- Sort targets by distance
            table.sort(targets, function(a, b)
                return a.distance < b.distance
            end)
        end
        
        local function farmTargets()
            if #targets == 0 then return end
            
            -- Get the closest target
            local target = targets[1]
            
            -- Move to target
            local targetCFrame = target.part.CFrame
            rootPart.CFrame = targetCFrame
            
            -- Auto attack if it's an enemy
            if Settings.AutoAttack and target.type == "enemy" and not attacking then
                attacking = true
                
                -- Simulate attacking
                local tool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                if tool and tool:FindFirstChild("Activate") then
                    tool.Activate:FireServer()
                elseif tool and tool:FindFirstChild("Fire") then
                    tool.Fire:FireServer()
                end
                
                wait(Settings.AttackDelay)
                attacking = false
            end
        end
        
        -- Main Farm Loop
        RunService.Heartbeat:Connect(function()
            if not Settings.Enabled then return end
            
            character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            rootPart = character:FindFirstChild("HumanoidRootPart")
            humanoid = character:FindFirstChild("Humanoid")
            
            getTargets()
            farmTargets()
        end)
        
        -- Toggle with key
        local UserInputService = game:GetService("UserInputService")
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.F then
                Settings.Enabled = not Settings.Enabled
                
                -- Notification
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Auto Farm",
                    Text = Settings.Enabled and "Enabled" or "Disabled",
                    Duration = 2
                })
            end
        end)
        
        print("Auto Farm loaded! Press F to toggle.")
    ]],
    
    ["Invisible Character"] = [[
        -- Invisible Character Script
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        
        -- Variables
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local isInvisible = false
        local storedPosition = nil
        local invisibleCharacter = nil
        local parts = {}
        
        -- Function to make character invisible
        local function makeInvisible()
            if isInvisible then return end
            
            -- Store the current position
            if character and character:FindFirstChild("HumanoidRootPart") then
                storedPosition = character.HumanoidRootPart.CFrame
            else
                return
            end
            
            -- Clone the character
            invisibleCharacter = character:Clone()
            
            -- Make all parts invisible and non-collidable but keep them functional
            for _, part in pairs(invisibleCharacter:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    if part.Name ~= "HumanoidRootPart" then
                        parts[part] = {
                            transparency = part.Transparency,
                            canCollide = part.CanCollide
                        }
                        
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            end
            
            -- Hide the name billboardgui if it exists
            local billboard = invisibleCharacter:FindFirstChild("Head") and invisibleCharacter.Head:FindFirstChild("BillboardGui")
            if billboard then
                billboard.Enabled = false
            end
            
            -- Replace the character
            LocalPlayer.Character = invisibleCharacter
            character.Parent = game:GetService("Lighting")
            
            -- Move to the stored position
            if invisibleCharacter:FindFirstChild("HumanoidRootPart") and storedPosition then
                invisibleCharacter.HumanoidRootPart.CFrame = storedPosition
            end
            
            isInvisible = true
            
            -- Notification
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Invisibility",
                Text = "You are now invisible!",
                Duration = 3
            })
        end
        
        -- Function to restore visibility
        local function restoreVisibility()
            if not isInvisible then return end
            
            -- Store position again
            if invisibleCharacter and invisibleCharacter:FindFirstChild("HumanoidRootPart") then
                storedPosition = invisibleCharacter.HumanoidRootPart.CFrame
            end
            
            -- Restore the original character
            character.Parent = workspace
            LocalPlayer.Character = character
            
            -- Move to the position
            if character:FindFirstChild("HumanoidRootPart") and storedPosition then
                character.HumanoidRootPart.CFrame = storedPosition
            end
            
            -- Clean up the invisible character
            if invisibleCharacter then
                invisibleCharacter:Destroy()
                invisibleCharacter = nil
            end
            
            isInvisible = false
            
            -- Notification
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Invisibility",
                Text = "You are now visible!",
                Duration = 3
            })
        end
        
        -- Toggle functionality
        local UserInputService = game:GetService("UserInputService")
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.V then
                if isInvisible then
                    restoreVisibility()
                else
                    makeInvisible()
                end
            end
        end)
        
        -- Handle respawning
        LocalPlayer.CharacterAdded:Connect(function(newCharacter)
            character = newCharacter
            isInvisible = false
        end)
        
        print("Invisibility script loaded! Press V to toggle invisibility.")
    ]],

    ["Lag Switch"] = [[
        -- Lag Switch
        local UserInputService = game:GetService("UserInputService")
        local NetworkClient = game:GetService("NetworkClient")
        local RunService = game:GetService("RunService")
        
        -- Settings
        local LagSwitchKey = Enum.KeyCode.L
        local LagSwitchEnabled = false
        local LagDuration = 2  -- seconds
        local incomingReplicationLag = false
        local outgoingReplicationLag = false
        
        -- Create GUI indicator
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "LagSwitchIndicator"
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 120, 0, 40)
        Frame.Position = UDim2.new(0, 10, 0, 10)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Frame.BorderSizePixel = 0
        Frame.Visible = false
        Frame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Frame
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Size = UDim2.new(1, 0, 1, 0)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "LAG SWITCH: OFF"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        StatusLabel.Font = Enum.Font.GothamBold
        StatusLabel.TextSize = 14
        StatusLabel.Parent = Frame
        
        -- Functions
        local function toggleLagSwitch()
            LagSwitchEnabled = not LagSwitchEnabled
            Frame.Visible = true
            
            if LagSwitchEnabled then
                StatusLabel.Text = "LAG SWITCH: ON"
                Frame.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                
                -- Enable lag by blocking network
                settings().Network.IncomingReplicationLag = 1000
                outgoingReplicationLag = true
                
                -- Schedule to disable it after duration
                spawn(function()
                    wait(LagDuration)
                    if LagSwitchEnabled then
                        LagSwitchEnabled = false
                        settings().Network.IncomingReplicationLag = 0
                        outgoingReplicationLag = false
                        
                        StatusLabel.Text = "LAG SWITCH: OFF"
                        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        
                        -- Hide indicator after 2 seconds
                        wait(2)
                        Frame.Visible = false
                    end
                end)
            else
                StatusLabel.Text = "LAG SWITCH: OFF"
                Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                
                -- Disable lag
                settings().Network.IncomingReplicationLag = 0
                outgoingReplicationLag = false
                
                -- Hide indicator after 2 seconds
                spawn(function()
                    wait(2)
                    if not LagSwitchEnabled then
                        Frame.Visible = false
                    end
                end)
            end
        end
        
        -- Lag Switch Key Binding
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == LagSwitchKey then
                toggleLagSwitch()
            end
        end)
        
        print("Lag Switch loaded! Press L to activate for " .. LagDuration .. " seconds.")
    ]],
    
    ["Tycoon Auto Collect"] = [[
        -- Tycoon Auto Collect Script
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        
        -- Settings
        local Settings = {
            Enabled = true,
            CollectSpeed = 0.1,
            AutoBuy = true,
            BuyDelay = 1
        }
        
        -- Variables
        local collectParts = {}
        local buyButtons = {}
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local lastBuy = 0
        
        -- Find the player's tycoon
        local function findPlayerTycoon()
            -- Common patterns in tycoon games
            local possibleTycoons = {}
            
            -- Look for objects with the player's name
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Model") and (obj.Name:find(LocalPlayer.Name) or obj.Name:find("Tycoon")) then
                    table.insert(possibleTycoons, obj)
                end
            end
            
            -- Look for objects with 'Owner' values
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("Owner") and obj.Owner.Value == LocalPlayer then
                    table.insert(possibleTycoons, obj)
                end
            end
            
            return possibleTycoons
        end
        
        -- Find collectibles and buttons
        local function findCollectiblesAndButtons()
            collectParts = {}
            buyButtons = {}
            
            local tycoons = findPlayerTycoon()
            
            for _, tycoon in pairs(tycoons) do
                -- Find collectibles (common patterns)
                for _, obj in pairs(tycoon:GetDescendants()) do
                    if obj:IsA("BasePart") and (
                        obj.Name:lower():find("collect") or 
                        obj.Name:lower():find("cash") or 
                        obj.Name:lower():find("money") or
                        obj.Name:lower():find("pickup")
                    ) then
                        table.insert(collectParts, obj)
                    end
                    
                    -- Find buy buttons
                    if Settings.AutoBuy and obj:IsA("BasePart") and (
                        obj.Name:lower():find("button") or 
                        obj.Name:lower():find("buy") or 
                        obj.Name:lower():find("purchase")
                    ) then
                        table.insert(buyButtons, obj)
                    end
                end
            end
        end
        
        -- Auto collect function
        local function autoCollect()
            for _, part in pairs(collectParts) do
                if part and part:IsA("BasePart") then
                    firetouchinterest(rootPart, part, 0)
                    wait(0.01)
                    firetouchinterest(rootPart, part, 1)
                end
            end
        end
        
        -- Auto buy function
        local function autoBuy()
            if not Settings.AutoBuy then return end
            if tick() - lastBuy < Settings.BuyDelay then return end
            
            for _, button in pairs(buyButtons) do
                if button and button:IsA("BasePart") then
                    firetouchinterest(rootPart, button, 0)
                    wait(0.01)
                    firetouchinterest(rootPart, button, 1)
                    lastBuy = tick()
                    break  -- Only buy one thing at a time
                end
            end
        end
        
        -- Initial setup
        findCollectiblesAndButtons()
        
        -- Update collection objects periodically
        spawn(function()
            while wait(5) do
                findCollectiblesAndButtons()
            end
        end)
        
        -- Main loop
        RunService.Heartbeat:Connect(function()
            if not Settings.Enabled then return end
            
            character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            rootPart = character:FindFirstChild("HumanoidRootPart")
            humanoid = character:FindFirstChild("Humanoid")
            
            autoCollect()
            autoBuy()
        end)
        
        -- Toggle with key
        local UserInputService = game:GetService("UserInputService")
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.X then
                Settings.Enabled = not Settings.Enabled
                
                -- Notification
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Tycoon Auto Farm",
                    Text = Settings.Enabled and "Enabled" or "Disabled",
                    Duration = 2
                })
            end
        end)
        
        print("Tycoon Auto Collect loaded! Press X to toggle.")
    ]],
    
    ["Parkour Helper"] = [[
        -- Parkour Helper Script
        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        
        -- Settings
        local Settings = {
            Enabled = true,
            AutoJump = true,
            JumpPower = 60,
            SafeMode = true,
            HighlightPlatforms = true,
            PlatformColor = Color3.fromRGB(0, 255, 0),
            DangerousColor = Color3.fromRGB(255, 0, 0),
            MaxCheckDistance = 100
        }
        
        -- Variables
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        local highlights = {}
        local safeJumpPos = nil
        local jumping = false
        
        -- Helper Functions
        local function isOnPlatform()
            local rayOrigin = rootPart.Position
            local rayDirection = Vector3.new(0, -3.5, 0)
            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            raycastParams.FilterDescendantsInstances = {character}
            
            local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
            
            if raycastResult then
                return true, raycastResult.Instance, raycastResult.Position
            else
                return false, nil, nil
            end
        end
        
        local function scanForNextPlatform()
            -- Clear old highlights
            for _, highlight in pairs(highlights) do
                if highlight then highlight:Destroy() end
            end
            highlights = {}
            
            -- Get the player's look direction
            local lookVector = camera.CFrame.LookVector
            local horizontalLook = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
            
            -- Scan in front of the player
            local rayOrigin = rootPart.Position
            local platformsFound = {}
            
            for distance = 5, Settings.MaxCheckDistance, 5 do
                local forwardPos = rayOrigin + (horizontalLook * distance)
                
                -- Scan in a small grid
                for xOffset = -2, 2, 1 do
                    for zOffset = -2, 2, 1 do
                        local scanPos = forwardPos + Vector3.new(xOffset * 2, 0, zOffset * 2)
                        
                        -- Cast a ray downward
                        local rayDir = Vector3.new(0, -50, 0)
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                        raycastParams.FilterDescendantsInstances = {character}
                        
                        local raycastResult = workspace:Raycast(scanPos, rayDir, raycastParams)
                        
                        if raycastResult then
                            -- Found a potential platform
                            local hitPart = raycastResult.Instance
                            local hitPos = raycastResult.Position
                            
                            -- Skip if it's too high to jump to
                            if (hitPos.Y - rayOrigin.Y) > Settings.JumpPower * 0.07 then
                                continue
                            end
                            
                            -- Check if the platform is safe (has enough space)
                            local headroomCheck = workspace:Raycast(
                                hitPos + Vector3.new(0, 0.1, 0), 
                                Vector3.new(0, 3, 0), 
                                raycastParams
                            )
                            
                            local isSafe = not headroomCheck
                            
                            -- Add to platforms list
                            table.insert(platformsFound, {
                                part = hitPart,
                                position = hitPos,
                                distance = (hitPos - rayOrigin).Magnitude,
                                safe = isSafe
                            })
                            
                            -- Highlight the platform
                            if Settings.HighlightPlatforms then
                                local highlight = Instance.new("Highlight")
                                highlight.FillColor = isSafe and Settings.PlatformColor or Settings.DangerousColor
                                highlight.OutlineColor = Color3.new(1, 1, 1)
                                highlight.FillTransparency = 0.7
                                highlight.OutlineTransparency = 0.3
                                highlight.Adornee = hitPart
                                highlight.Parent = game.CoreGui
                                
                                table.insert(highlights, highlight)
                            end
                        end
                    end
                end
            end
            
            -- Find the closest safe platform
            table.sort(platformsFound, function(a, b)
                return a.distance < b.distance
            end)
            
            for _, platform in ipairs(platformsFound) do
                if not Settings.SafeMode or platform.safe then
                    safeJumpPos = platform.position
                    break
                end
            end
        end
        
        local function autoJump()
            if jumping or not Settings.AutoJump then return end
            
            local isGrounded, currentPlatform, currentPos = isOnPlatform()
            
            if isGrounded and safeJumpPos then
                -- Calculate jump direction
                local jumpDir = (safeJumpPos - rootPart.Position).Unit
                jumpDir = Vector3.new(jumpDir.X, 0, jumpDir.Z).Unit
                
                -- Rotate character toward jump target
                local lookAt = CFrame.lookAt(rootPart.Position, safeJumpPos)
                rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + jumpDir)
                
                -- Jump
                jumping = true
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                
                -- Reset after a delay
                spawn(function()
                    wait(1)
                    jumping = false
                end)
            end
        end
        
        -- Main functionality
        RunService.RenderStepped:Connect(function()
            if not Settings.Enabled then return end
            
            character = LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            rootPart = character:FindFirstChild("HumanoidRootPart")
            humanoid = character:FindFirstChild("Humanoid")
            
            scanForNextPlatform()
            autoJump()
        end)
        
        -- Set initial jump power
        humanoid.JumpPower = Settings.JumpPower
        
        -- Toggle with key
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.P then
                Settings.Enabled = not Settings.Enabled
                
                -- Clear highlights when disabled
                if not Settings.Enabled then
                    for _, highlight in pairs(highlights) do
                        if highlight then highlight:Destroy() end
                    end
                    highlights = {}
                end
                
                -- Notification
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Parkour Helper",
                    Text = Settings.Enabled and "Enabled" or "Disabled",
                    Duration = 2
                })
            end
        end)
        
        print("Parkour Helper loaded! Press P to toggle.")
    ]],
    
    ["Camera Tweaks"] = [[
        -- Camera Tweaks Script
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        
        -- Settings
        local Settings = {
            Enabled = true,
            FOV = 90,
            ThirdPerson = false,
            ThirdPersonDistance = 10,
            FreeCam = false,
            FreeCamSpeed = 2,
            ZoomMin = 5,
            ZoomMax = 100,
            NoClipCam = true
        }
        
        -- Variables
        local defaultFOV = Camera.FieldOfView
        local defaultSubject = Camera.CameraSubject
        local defaultType = Camera.CameraType
        local zoomLevel = Settings.ThirdPersonDistance
        local freeCamPos = Camera.CFrame
        local keys = {
            W = false,
            A = false,
            S = false,
            D = false,
            Q = false,
            E = false
        }
        
        -- Create GUI for controls
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "CameraTweaksGUI"
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 200, 0, 160)
        Frame.Position = UDim2.new(0, 10, 0.5, -80)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Frame.BorderSizePixel = 0
        Frame.Visible = false
        Frame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Frame
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 30)
        Title.BackgroundTransparency = 1
        Title.Text = "Camera Tweaks"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 16
        Title.Parent = Frame
        
        local function createButton(name, position, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(0.9, 0, 0, 25)
            Button.Position = position
            Button.AnchorPoint = Vector2.new(0.5, 0)
            Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Button.BorderSizePixel = 0
            Button.Text = name
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Font = Enum.Font.Gotham
            Button.TextSize = 14
            Button.Parent = Frame
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = Button
            
            Button.MouseButton1Click:Connect(callback)
            return Button
        end
        
        local FOVButton = createButton("FOV: " .. Settings.FOV, UDim2.new(0.5, 0, 0, 35), function()
            Settings.FOV = (Settings.FOV % 120) + 10
            Camera.FieldOfView = Settings.FOV
            FOVButton.Text = "FOV: " .. Settings.FOV
        end)
        
        local ThirdPersonButton = createButton("Third Person: " .. tostring(Settings.ThirdPerson), UDim2.new(0.5, 0, 0, 65), function()
            Settings.ThirdPerson = not Settings.ThirdPerson
            
            if Settings.ThirdPerson then
                Camera.CameraType = Enum.CameraType.Custom
                
                RunService:BindToRenderStep("ThirdPersonCam", Enum.RenderPriority.Camera.Value, function()
                    local character = LocalPlayer.Character
                    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                    
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    local humanoid = character:FindFirstChild("Humanoid")
                    
                    if not humanoid then return end
                    
                    -- Set the camera subject to the humanoid
                    Camera.CameraSubject = humanoid
                    
                    -- Calculate the camera position
                    local camPos = rootPart.Position - (Camera.CFrame.LookVector * zoomLevel)
                    
                    -- Check for obstacles
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    raycastParams.FilterDescendantsInstances = {character}
                    
                    local raycastResult = workspace:Raycast(rootPart.Position, (camPos - rootPart.Position), raycastParams)
                    
                    if raycastResult and not Settings.NoClipCam then
                        camPos = raycastResult.Position + (Camera.CFrame.LookVector * 0.5)
                    end
                    
                    -- Set the camera CFrame
                    Camera.CFrame = CFrame.new(camPos, rootPart.Position + Vector3.new(0, humanoid.CameraOffset.Y, 0))
                end)
            else
                RunService:UnbindFromRenderStep("ThirdPersonCam")
                Camera.CameraSubject = defaultSubject
                Camera.CameraType = defaultType
            end
            
            ThirdPersonButton.Text = "Third Person: " .. tostring(Settings.ThirdPerson)
        end)
        
        local FreeCamButton = createButton("Free Cam: " .. tostring(Settings.FreeCam), UDim2.new(0.5, 0, 0, 95), function()
            Settings.FreeCam = not Settings.FreeCam
            
            if Settings.FreeCam then
                freeCamPos = Camera.CFrame
                RunService:BindToRenderStep("FreeCam", Enum.RenderPriority.Camera.Value, function()
                    Camera.CameraType = Enum.CameraType.Scriptable
                    
                    -- Handle key movement
                    local speed = Settings.FreeCamSpeed
                    local cf = freeCamPos
                    
                    if keys.W then cf = cf + (cf.LookVector * speed) end
                    if keys.S then cf = cf - (cf.LookVector * speed) end
                    if keys.A then cf = cf - (cf.RightVector * speed) end
                    if keys.D then cf = cf + (cf.RightVector * speed) end
                    if keys.Q then cf = cf + (cf.UpVector * speed) end
                    if keys.E then cf = cf - (cf.UpVector * speed) end
                    
                    freeCamPos = cf
                    Camera.CFrame = freeCamPos
                end)
            else
                RunService:UnbindFromRenderStep("FreeCam")
                Camera.CameraType = defaultType
                Camera.CameraSubject = defaultSubject
            end
            
            FreeCamButton.Text = "Free Cam: " .. tostring(Settings.FreeCam)
        end)
        
        local NoClipCamButton = createButton("NoClip Cam: " .. tostring(Settings.NoClipCam), UDim2.new(0.5, 0, 0, 125), function()
            Settings.NoClipCam = not Settings.NoClipCam
            NoClipCamButton.Text = "NoClip Cam: " .. tostring(Settings.NoClipCam)
        end)
        
        -- Key handling for free cam
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.KeyCode == Enum.KeyCode.W then
                keys.W = true
            elseif input.KeyCode == Enum.KeyCode.A then
                keys.A = true
            elseif input.KeyCode == Enum.KeyCode.S then
                keys.S = true
            elseif input.KeyCode == Enum.KeyCode.D then
                keys.D = true
            elseif input.KeyCode == Enum.KeyCode.Q then
                keys.Q = true
            elseif input.KeyCode == Enum.KeyCode.E then
                keys.E = true
            elseif input.KeyCode == Enum.KeyCode.C then
                Frame.Visible = not Frame.Visible
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input, gameProcessed)
            if input.KeyCode == Enum.KeyCode.W then
                keys.W = false
            elseif input.KeyCode == Enum.KeyCode.A then
                keys.A = false
            elseif input.KeyCode == Enum.KeyCode.S then
                keys.S = false
            elseif input.KeyCode == Enum.KeyCode.D then
                keys.D = false
            elseif input.KeyCode == Enum.KeyCode.Q then
                keys.Q = false
            elseif input.KeyCode == Enum.KeyCode.E then
                keys.E = false
            end
        end)
        
        -- Mouse wheel zoom for third person
        UserInputService.InputChanged:Connect(function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseWheel and Settings.ThirdPerson then
                zoomLevel = math.clamp(zoomLevel - input.Position.Z * 2, Settings.ZoomMin, Settings.ZoomMax)
            end
        end)
        
        -- Initialize
        Camera.FieldOfView = Settings.FOV
        
        print("Camera Tweaks loaded! Press C to toggle UI. Scroll to zoom in third person.")
    ]],
    
    ["Fast Animation Player"] = [[
        -- Fast Animation Player Script
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        
        -- Create Animations GUI
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "AnimationPlayerGUI"
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 300, 0, 400)
        Frame.Position = UDim2.new(0, 10, 0.5, -200)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Frame.BorderSizePixel = 0
        Frame.Visible = false
        Frame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = Frame
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 40)
        Title.BackgroundTransparency = 1
        Title.Text = "Animation Player"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 18
        Title.Parent = Frame
        
        local CloseButton = Instance.new("TextButton")
        CloseButton.Size = UDim2.new(0, 30, 0, 30)
        CloseButton.Position = UDim2.new(1, -35, 0, 5)
        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        CloseButton.BorderSizePixel = 0
        CloseButton.Text = "X"
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.TextSize = 16
        CloseButton.Parent = Frame
        
        local UICornerClose = Instance.new("UICorner")
        UICornerClose.CornerRadius = UDim.new(0, 8)
        UICornerClose.Parent = CloseButton
        
        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.Size = UDim2.new(1, -20, 1, -50)
        ScrollingFrame.Position = UDim2.new(0, 10, 0, 45)
        ScrollingFrame.BackgroundTransparency = 1
        ScrollingFrame.BorderSizePixel = 0
        ScrollingFrame.ScrollBarThickness = 5
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollingFrame.Parent = Frame
        
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Padding = UDim.new(0, 5)
        UIListLayout.Parent = ScrollingFrame
        
        -- Common Animations Dictionary
        local AnimationsDict = {
            ["Ninja Run"] = 656118852,
            ["Zombie"] = 4210116953,
            ["Cartoony Run"] = 4810086990,
            ["Cartoony Walk"] = 4810088811,
            ["Princess Run"] = 4810086857,
            ["Mage Run"] = 4810086974,
            ["Werewolf Run"] = 4810088118,
            ["Stylish Run"] = 4810088220,
            ["Zombie Run"] = 4810087029,
            ["Toy Run"] = 4810086936,
            ["Levitation"] = 4810091302,
            ["Bubbly"] = 4810022993,
            ["Confident"] = 4810086070,
            ["Popstar"] = 4810087993,
            ["Cowboy"] = 4810086078,
            ["Robot"] = 4810088062,
            ["T-Pose"] = 4810086800,
            ["Joyful Jump"] = 4810086917,
            ["Happy"] = 4810086634,
            ["Dorky Dance"] = 4810087940,
            ["Heroic Landing"] = 4810091278,
            ["Fast Hands"] = 4810086798,
            ["Applaud"] = 4810088088,
            ["Dolphin Dance"] = 4810087843,
            ["Floss Dance"] = 4810087795,
            ["Smooth Moves"] = 4810091118,
            ["Fresh Dance"] = 4810091591,
            ["Orange Justice"] = 4810088175,
            ["Rock Guitar"] = 4810088596,
            ["Shy"] = 4810088255,
            ["Hype Dance"] = 4810087833,
            ["Lunar Lift"] = 4810091304,
            ["Side to Side"] = 4810087909,
            ["Air Dance"] = 4810090322,
            ["Thriller"] = 4810088274,
            ["Around Town"] = 4810086770,
            ["Confused"] = 4810088264,
            ["Jumping Wave"] = 4810086863,
            ["Laughing"] = 4810086439,
            ["Heisman Pose"] = 4810087941,
            ["Sad"] = 4810087907,
            ["Agree"] = 4810086712,
            ["Sleep"] = 4810086131,
            ["Superhero Reveal"] = 4810088263,
            ["Swim Idle"] = 4810086646,
            ["Swing Dance"] = 4810088440
        }
        
        -- Variables
        local activeAnimations = {}
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        -- Function to create animation buttons
        local function createAnimationButtons()
            for name, id in pairs(AnimationsDict) do
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, -10, 0, 40)
                Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                Button.BorderSizePixel = 0
                Button.Text = name
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Font = Enum.Font.Gotham
                Button.TextSize = 14
                Button.Parent = ScrollingFrame
                
                local UICornerBtn = Instance.new("UICorner")
                UICornerBtn.CornerRadius = UDim.new(0, 8)
                UICornerBtn.Parent = Button
                
                Button.MouseButton1Click:Connect(function()
                    -- Check if animation already active
                    if activeAnimations[name] then
                        -- Stop the animation
                        activeAnimations[name]:Stop()
                        activeAnimations[name] = nil
                        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    else
                        -- Load and play the animation
                        local animation = Instance.new("Animation")
                        animation.AnimationId = "rbxassetid://" .. id
                        
                        local animTrack = humanoid:LoadAnimation(animation)
                        animTrack:Play()
                        
                        activeAnimations[name] = animTrack
                        Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                        
                        -- Listen for when animation stops
                        animTrack.Stopped:Connect(function()
                            if activeAnimations[name] then
                                activeAnimations[name] = nil
                                Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                            end
                        end)
                    end
                end)
            end
        end
        
        -- Initialize
        createAnimationButtons()
        
        -- Handle character respawning
        LocalPlayer.CharacterAdded:Connect(function(newCharacter)
            character = newCharacter
            humanoid = character:WaitForChild("Humanoid")
            
            -- Clear active animations
            for name, _ in pairs(activeAnimations) do
                activeAnimations[name] = nil
            end
            
            -- Update buttons
            for _, button in pairs(ScrollingFrame:GetChildren()) do
                if button:IsA("TextButton") then
                    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                end
            end
        end)
        
        -- Toggle GUI with key
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
                Frame.Visible = not Frame.Visible
            end
        end)
        
        -- Close button
        CloseButton.MouseButton1Click:Connect(function()
            Frame.Visible = false
        end)
        
        print("Animation Player loaded! Press K to open the menu.")
    ]],
    
    ["Chat Translator"] = [[
        -- Chat Translator Script
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local HttpService = game:GetService("HttpService")
        local LocalPlayer = Players.LocalPlayer
        
        -- Settings
        local Settings = {
            Enabled = true,
            TargetLanguage = "en", -- Language code to translate to
            TranslateIncoming = true,
            TranslateOutgoing = false,
            ShowOriginal = true,
            LanguageCodes = {
                ["English"] = "en",
                ["Spanish"] = "es",
                ["French"] = "fr",
                ["German"] = "de",
                ["Italian"] = "it",
                ["Portuguese"] = "pt",
                ["Dutch"] = "nl",
                ["Russian"] = "ru",
                ["Japanese"] = "ja",
                ["Korean"] = "ko",
                ["Chinese"] = "zh",
                ["Arabic"] = "ar",
            }
        }
        
        -- Create GUI for settings
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "TranslatorGUI"
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 250, 0, 280)
        Frame.Position = UDim2.new(0, 10, 0.5, -140)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Frame.BorderSizePixel = 0
        Frame.Visible = false
        Frame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = Frame
        
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 40)
        Title.BackgroundTransparency = 1
        Title.Text = "Chat Translator"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 18
        Title.Parent = Frame
        
        local CloseButton = Instance.new("TextButton")
        CloseButton.Size = UDim2.new(0, 30, 0, 30)
        CloseButton.Position = UDim2.new(1, -35, 0, 5)
        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        CloseButton.BorderSizePixel = 0
        CloseButton.Text = "X"
        CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.TextSize = 16
        CloseButton.Parent = Frame
        
        local UICornerClose = Instance.new("UICorner")
        UICornerClose.CornerRadius = UDim.new(0, 8)
        UICornerClose.Parent = CloseButton
        
        -- Create toggle buttons
        local function createToggle(text, position, value, callback)
            local Toggle = Instance.new("Frame")
            Toggle.Size = UDim2.new(0.9, 0, 0, 30)
            Toggle.Position = position
            Toggle.AnchorPoint = Vector2.new(0.5, 0)
            Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Toggle.BorderSizePixel = 0
            Toggle.Parent = Frame
            
            local UICornerToggle = Instance.new("UICorner")
            UICornerToggle.CornerRadius = UDim.new(0, 6)
            UICornerToggle.Parent = Toggle
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.7, 0, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Parent = Toggle
            
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(0, 50, 0, 20)
            Button.Position = UDim2.new(1, -60, 0.5, -10)
            Button.BackgroundColor3 = value and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
            Button.BorderSizePixel = 0
            Button.Text = value and "ON" or "OFF"
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Font = Enum.Font.GothamBold
            Button.TextSize = 12
            Button.Parent = Toggle
            
            local UICornerButton = Instance.new("UICorner")
            UICornerButton.CornerRadius = UDim.new(0, 4)
            UICornerButton.Parent = Button
            
            Button.MouseButton1Click:Connect(function()
                value = not value
                Button.BackgroundColor3 = value and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
                Button.Text = value and "ON" or "OFF"
                callback(value)
            end)
            
            return Toggle, value
        end
        
        -- Create language dropdown
        local function createDropdown(text, position, options, defaultValue, callback)
            local Dropdown = Instance.new("Frame")
            Dropdown.Size = UDim2.new(0.9, 0, 0, 60)
            Dropdown.Position = position
            Dropdown.AnchorPoint = Vector2.new(0.5, 0)
            Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Dropdown.BorderSizePixel = 0
            Dropdown.Parent = Frame
            
            local UICornerDropdown = Instance.new("UICorner")
            UICornerDropdown.CornerRadius = UDim.new(0, 6)
            UICornerDropdown.Parent = Dropdown
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 25)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Center
            Label.Parent = Dropdown
            
            local DropButton = Instance.new("TextButton")
            DropButton.Size = UDim2.new(0.8, 0, 0, 25)
            DropButton.Position = UDim2.new(0.1, 0, 0, 30)
            DropButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            DropButton.BorderSizePixel = 0
            DropButton.Text = defaultValue
            DropButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropButton.Font = Enum.Font.Gotham
            DropButton.TextSize = 12
            DropButton.Parent = Dropdown
            
            local UICornerButton = Instance.new("UICorner")
            UICornerButton.CornerRadius = UDim.new(0, 4)
            UICornerButton.Parent = DropButton
            
            local OptionsFrame = Instance.new("Frame")
            OptionsFrame.Size = UDim2.new(0, 200, 0, #options * 25)
            OptionsFrame.Position = UDim2.new(0.5, 0, 1, 5)
            OptionsFrame.AnchorPoint = Vector2.new(0.5, 0)
            OptionsFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            OptionsFrame.BorderSizePixel = 0
            OptionsFrame.Visible = false
            OptionsFrame.ZIndex = 10
            OptionsFrame.Parent = Dropdown
            
            local UICornerOptions = Instance.new("UICorner")
            UICornerOptions.CornerRadius = UDim.new(0, 4)
            UICornerOptions.Parent = OptionsFrame
            
            -- Create option buttons
            local yPos = 0
            for _, optionName in pairs(options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Size = UDim2.new(1, 0, 0, 25)
                OptionButton.Position = UDim2.new(0, 0, 0, yPos)
                OptionButton.BackgroundTransparency = 1
                OptionButton.Text = optionName
                OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.TextSize = 12
                OptionButton.ZIndex = 11
                OptionButton.Parent = OptionsFrame
                
                OptionButton.MouseButton1Click:Connect(function()
                    DropButton.Text = optionName
                    OptionsFrame.Visible = false
                    callback(optionName)
                end)
                
                yPos = yPos + 25
            end
            
            DropButton.MouseButton1Click:Connect(function()
                OptionsFrame.Visible = not OptionsFrame.Visible
            end)
            
            return Dropdown
        end
        
        -- Create the GUI elements
        local toggleEnabled, _ = createToggle("Translator Enabled", UDim2.new(0.5, 0, 0, 50), Settings.Enabled, function(value)
            Settings.Enabled = value
        end)
        
        local toggleIncoming, _ = createToggle("Translate Incoming", UDim2.new(0.5, 0, 0, 85), Settings.TranslateIncoming, function(value)
            Settings.TranslateIncoming = value
        end)
        
        local toggleOutgoing, _ = createToggle("Translate Outgoing", UDim2.new(0.5, 0, 0, 120), Settings.TranslateOutgoing, function(value)
            Settings.TranslateOutgoing = value
        end)
        
        local toggleShowOriginal, _ = createToggle("Show Original Text", UDim2.new(0.5, 0, 0, 155), Settings.ShowOriginal, function(value)
            Settings.ShowOriginal = value
        end)
        
        local languageKeys = {}
        for lang, _ in pairs(Settings.LanguageCodes) do
            table.insert(languageKeys, lang)
        end
        
        local targetLang = "English"
        for lang, code in pairs(Settings.LanguageCodes) do
            if code == Settings.TargetLanguage then
                targetLang = lang
                break
            end
        end
        
        local languageDropdown = createDropdown("Target Language", UDim2.new(0.5, 0, 0, 190), languageKeys, targetLang, function(selected)
            Settings.TargetLanguage = Settings.LanguageCodes[selected]
        end)
        
        -- Simulate translation function (in real exploit this would use HTTP to call translation API)
        local function translateText(text, targetLang)
            -- Since we can't actually make HTTP requests in this example, we'll just add a prefix
            return "[" .. targetLang .. "] " .. text
        end
        
        -- Hook into chat system
        local oldChatted = nil
        
        -- Handle incoming chat messages
        for _, player in pairs(Players:GetPlayers()) do
            player.Chatted:Connect(function(message)
                if player == LocalPlayer or not Settings.Enabled or not Settings.TranslateIncoming then return end
                
                -- Translate the message
                local translatedText = translateText(message, Settings.TargetLanguage)
                
                -- Display in chat (this would need to be customized based on the game's chat system)
                if Settings.ShowOriginal then
                    print(player.Name .. ": " .. message)
                    print("↳ " .. translatedText)
                else
                    print(player.Name .. ": " .. translatedText)
                end
            end)
        end
        
        -- Handle outgoing chat messages (if available in the exploit)
        -- This would need to hook into the game's chat remote event
        
        -- Toggle GUI with key
        local UserInputService = game:GetService("UserInputService")
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.J then
                Frame.Visible = not Frame.Visible
            end
        end)
        
        -- Close button
        CloseButton.MouseButton1Click:Connect(function()
            Frame.Visible = false
        end)
        
        print("Chat Translator loaded! Press J to open settings.")
    ]],
    
    ["Anti AFK"] = [[
        -- Anti AFK Script
        local Players = game:GetService("Players")
        local VirtualUser = game:GetService("VirtualUser")
        local RunService = game:GetService("RunService")
        
        -- Variables
        local LocalPlayer = Players.LocalPlayer
        local connections = {}
        local enabled = true
        local lastActivity = tick()
        local showVisual = true
        
        -- Visual indicator
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "AntiAFKGui"
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 180, 0, 30)
        Frame.Position = UDim2.new(0, 10, 0, 10)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Frame.BackgroundTransparency = 0.3
        Frame.BorderSizePixel = 0
        Frame.Visible = showVisual
        Frame.Parent = ScreenGui
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = Frame
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Size = UDim2.new(1, 0, 1, 0)
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Text = "Anti-AFK: Active"
        StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
        StatusLabel.Font = Enum.Font.GothamBold
        StatusLabel.TextSize = 14
        StatusLabel.Parent = Frame
        
        -- Register user activity
        local function registerActivity()
            lastActivity = tick()
        end
        
        -- Watch for user input
        table.insert(connections, game:GetService("UserInputService").InputBegan:Connect(registerActivity))
        table.insert(connections, game:GetService("UserInputService").InputEnded:Connect(registerActivity))
        table.insert(connections, game:GetService("UserInputService").WindowFocused:Connect(registerActivity))
        
        -- Anti-AFK loop
        local afkCheckTimer = 0
        local colorTimer = 0
        
        table.insert(connections, RunService.Heartbeat:Connect(function(delta)
            afkCheckTimer = afkCheckTimer + delta
            colorTimer = colorTimer + delta
            
            -- Visual pulsing effect
            if showVisual then
                local alpha = (math.sin(colorTimer * 2) + 1) / 2
                StatusLabel.TextColor3 = Color3.fromRGB(
                    80 + (175 * alpha),
                    255,
                    80 + (175 * (1 - alpha))
                )
            end
            
            -- Check if we need to simulate activity (every 30 seconds)
            if afkCheckTimer >= 30 then
                afkCheckTimer = 0
                
                -- Only simulate if no real activity in last 60 seconds
                if tick() - lastActivity >= 60 and enabled then
                    -- Simulate user
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new(0, 0))
                    
                    -- Update visual
                    if showVisual then
                        StatusLabel.Text = "Anti-AFK: Prevented Kick!"
                        wait(2)
                        StatusLabel.Text = "Anti-AFK: Active"
                    end
                end
            end
        end))
        
        -- Toggle with key
        local UserInputService = game:GetService("UserInputService")
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.RightAlt then
                enabled = not enabled
                
                if enabled then
                    StatusLabel.Text = "Anti-AFK: Active"
                    StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
                else
                    StatusLabel.Text = "Anti-AFK: Disabled"
                    StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                end
            elseif not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
                showVisual = not showVisual
                Frame.Visible = showVisual
            end
        end)
        
        print("Anti-AFK loaded! Right Alt to toggle, Right Ctrl to hide/show indicator.")
    ]]
}

-- Add sample scripts to hub
for name, script in pairs(sampleScripts) do
    addScriptToHub(name, script)
    savedScripts[name] = script
end
for name, script in pairs(additionalScripts) do
    addScriptToHub(name, script)
    savedScripts[name] = script
end

-- Load any saved scripts
loadSavedScripts()
for name, script in pairs(savedScripts) do
    if not sampleScripts[name] then  -- Don't duplicate sample scripts
        addScriptToHub(name, script)
    end
end

-- Update ScriptHubList canvas size
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScriptHubList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Initialize
updateLineNumbers()
updateCanvasSize()
StatusLabel.Text = "Ready | Press INSERT to toggle UI"

-- Add syntax highlighting highlights for common Lua keywords
local function applySyntaxColoring()
    local text = TextBox.Text:gsub("\t", "    ")  -- Replace tabs with spaces
    TextBox.Text = text  -- Update the text with tabs replaced
    
    -- The actual syntax highlighting would be done here in a more complex implementation
    -- This is a placeholder for a feature that would be better implemented with a custom TextBox component
end

-- Connect text change to syntax coloring (placeholder)
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
    applySyntaxColoring()
end)

-- Add a rainbow animation to the title
local titleHue = 0
RunService.Heartbeat:Connect(function(dt)
    titleHue = (titleHue + 0.2 * dt) % 1
    Title.TextColor3 = Color3.fromHSV(titleHue, 0.8, 1)
end)

-- Add a small animation to the execute button
spawn(function()
    while wait(0.05) do
        for i = 0, 1, 0.01 do
            if not ScreenGui.Parent then break end
            UIGradient.Offset = Vector2.new(i, 0)
            wait(0.05)
        end
    end
end)
