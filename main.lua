-- MacOS Style UI with Settings Panel
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TitleBar = Instance.new("Frame")
local UICorner_TitleBar = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton") 
local MaximizeButton = Instance.new("TextButton")
local ScriptEditor = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local EditorScrollingFrame = Instance.new("ScrollingFrame")
local TextBox = Instance.new("TextBox")
local LineNumbers = Instance.new("TextLabel")
local ControlsFrame = Instance.new("Frame")
local ExecuteButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local ClearButton = Instance.new("TextButton")
local UICorner_Clear = Instance.new("UICorner")
local SaveButton = Instance.new("TextButton") 
local UICorner_Save = Instance.new("UICorner")
local LoadButton = Instance.new("TextButton")
local UICorner_Load = Instance.new("UICorner")
local SettingsButton = Instance.new("TextButton")
local UICorner_Settings = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")

-- Settings Panel
local SettingsFrame = Instance.new("Frame")
local UICorner_SettingsFrame = Instance.new("UICorner")
local SettingsTitle = Instance.new("TextLabel")
local CloseSettingsButton = Instance.new("TextButton")
local SettingsScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout_Settings = Instance.new("UIListLayout")
local UIPadding_Settings = Instance.new("UIPadding")

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
local themeSettings = {
    DarkMode = true,
    TransparencyEnabled = false,
    AnimationsEnabled = true,
    AutoExecute = false,
    SyntaxHighlighting = true,
    AutoSave = true,
    LineNumbersVisible = true,
    FontSize = 14
}

-- Theme Colors
local colors = {
    dark = {
        background = Color3.fromRGB(30, 30, 32),
        titlebar = Color3.fromRGB(50, 50, 55),
        editor = Color3.fromRGB(40, 40, 45),
        controls = Color3.fromRGB(50, 50, 55),
        button = Color3.fromRGB(80, 80, 85),
        buttonHover = Color3.fromRGB(100, 100, 110),
        text = Color3.fromRGB(230, 230, 230),
        lineNumbers = Color3.fromRGB(150, 150, 150),
        accent = Color3.fromRGB(0, 122, 255),
        accentHover = Color3.fromRGB(40, 142, 255),
        statusSuccess = Color3.fromRGB(40, 200, 110),
        statusError = Color3.fromRGB(255, 80, 80)
    },
    light = {
        background = Color3.fromRGB(236, 236, 236),
        titlebar = Color3.fromRGB(210, 210, 210),
        editor = Color3.fromRGB(246, 246, 246),
        controls = Color3.fromRGB(230, 230, 230),
        button = Color3.fromRGB(240, 240, 240),
        buttonHover = Color3.fromRGB(220, 220, 220),
        text = Color3.fromRGB(50, 50, 50),
        lineNumbers = Color3.fromRGB(130, 130, 130),
        accent = Color3.fromRGB(0, 122, 255),
        accentHover = Color3.fromRGB(40, 142, 255),
        statusSuccess = Color3.fromRGB(40, 180, 100),
        statusError = Color3.fromRGB(220, 60, 60)
    }
}

-- Get executor name function
local function getExecutorName()
    local success, result = pcall(function()
        return getexecutorname()
    end)
    
    if success then
        return result
    else
        return "MacUI"
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

-- Load settings if they exist
local function loadSettings()
    pcall(function()
        if isfile(executorName .. "_Settings.json") then
            local content = readfile(executorName .. "_Settings.json")
            themeSettings = HttpService:JSONDecode(content)
        end
    end)
end

-- Save settings to json
local function saveSettings()
    pcall(function()
        local json = HttpService:JSONEncode(themeSettings)
        writefile(executorName .. "_Settings.json", json)
    end)
end

-- Apply current theme
local function applyTheme()
    local theme = themeSettings.DarkMode and colors.dark or colors.light
    
    Frame.BackgroundColor3 = theme.background
    TitleBar.BackgroundColor3 = theme.titlebar
    ScriptEditor.BackgroundColor3 = theme.editor
    LineNumbers.BackgroundColor3 = theme.editor
    LineNumbers.TextColor3 = theme.lineNumbers
    TextBox.TextColor3 = theme.text
    TextBox.PlaceholderColor3 = Color3.fromRGB(theme.text.R * 0.7, theme.text.G * 0.7, theme.text.B * 0.7)
    ControlsFrame.BackgroundColor3 = theme.controls
    
    -- Apply to settings frame if it exists
    if SettingsFrame then
        SettingsFrame.BackgroundColor3 = theme.background
        SettingsTitle.TextColor3 = theme.text
    end
    
    -- Set button colors
    local buttons = {ExecuteButton, ClearButton, SaveButton, LoadButton, SettingsButton}
    for _, button in ipairs(buttons) do
        if button == ExecuteButton then
            -- Leave execute button with accent color
        else
            button.BackgroundColor3 = theme.button
            button.TextColor3 = theme.text
        end
    end
    
    -- Execute button special coloring
    ExecuteButton.BackgroundColor3 = theme.accent
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Status Label
    StatusLabel.TextColor3 = theme.statusSuccess
    
    -- Line numbers visibility
    LineNumbers.Visible = themeSettings.LineNumbersVisible
    if themeSettings.LineNumbersVisible then
        EditorScrollingFrame.Position = UDim2.new(0, 35, 0, 0)
        EditorScrollingFrame.Size = UDim2.new(1, -40, 1, 0)
    else
        EditorScrollingFrame.Position = UDim2.new(0, 5, 0, 0)
        EditorScrollingFrame.Size = UDim2.new(1, -10, 1, 0)
    end
    
    -- Font size
    TextBox.TextSize = themeSettings.FontSize
    LineNumbers.TextSize = themeSettings.FontSize
    
    -- Apply transparency if enabled
    if themeSettings.TransparencyEnabled then
        Frame.BackgroundTransparency = 0.1
        TitleBar.BackgroundTransparency = 0.2
        ScriptEditor.BackgroundTransparency = 0.1
        ControlsFrame.BackgroundTransparency = 0.1
    else
        Frame.BackgroundTransparency = 0
        TitleBar.BackgroundTransparency = 0
        ScriptEditor.BackgroundTransparency = 0
        ControlsFrame.BackgroundTransparency = 0
    end
end

-- Properties:
ScreenGui.Name = executorName .. "UI"
local CoreGui = game:GetService("CoreGui")
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 32)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.207, 0, 0.224, 0)
Frame.Size = UDim2.new(0, 768, 0, 476)
Frame.Active = true
Frame.ClipsDescendants = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

-- Title Bar (macOS style)
TitleBar.Name = "TitleBar"
TitleBar.Parent = Frame
TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)

UICorner_TitleBar.CornerRadius = UDim.new(0, 10)
UICorner_TitleBar.Parent = TitleBar

Title.Parent = TitleBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.GothamMedium
Title.Text = executorName
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16.000

-- Window buttons (macOS style)
CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 95, 87)
CloseButton.Position = UDim2.new(0, 15, 0.5, -6)
CloseButton.Size = UDim2.new(0, 12, 0, 12)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = ""
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14.000
CloseButton.AutoButtonColor = false

Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(1, 0)

MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
MinimizeButton.Position = UDim2.new(0, 37, 0.5, -6)
MinimizeButton.Size = UDim2.new(0, 12, 0, 12)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = ""
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14.000
MinimizeButton.AutoButtonColor = false

Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(1, 0)

MaximizeButton = Instance.new("TextButton")
MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = TitleBar
MaximizeButton.BackgroundColor3 = Color3.fromRGB(40, 200, 64)
MaximizeButton.Position = UDim2.new(0, 59, 0.5, -6)
MaximizeButton.Size = UDim2.new(0, 12, 0, 12)
MaximizeButton.Font = Enum.Font.SourceSans
MaximizeButton.Text = ""
MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MaximizeButton.TextSize = 14.000
MaximizeButton.AutoButtonColor = false

Instance.new("UICorner", MaximizeButton).CornerRadius = UDim.new(1, 0)

ScriptEditor.Name = "ScriptEditor"
ScriptEditor.Parent = Frame
ScriptEditor.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ScriptEditor.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScriptEditor.BorderSizePixel = 0
ScriptEditor.Position = UDim2.new(0.0138408346, 0, 0.07, 0)
ScriptEditor.Size = UDim2.new(0, 747, 0, 350)
ScriptEditor.ClipsDescendants = true

UICorner_2.CornerRadius = UDim.new(0, 8)
UICorner_2.Parent = ScriptEditor

-- Line numbers with proper padding
LineNumbers = Instance.new("TextLabel")
LineNumbers.Name = "LineNumbers"
LineNumbers.Parent = ScriptEditor
LineNumbers.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
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
TextBox.TextColor3 = Color3.fromRGB(230, 230, 230)
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true
TextBox.AutomaticSize = Enum.AutomaticSize.Y
TextBox.Text = ""
TextBox.PlaceholderText = "Enter your script here..."
TextBox.PlaceholderColor3 = Color3.fromRGB(160, 160, 160)

-- Controls Frame
ControlsFrame = Instance.new("Frame")
ControlsFrame.Name = "ControlsFrame"
ControlsFrame.Parent = Frame
ControlsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
ControlsFrame.BorderSizePixel = 0
ControlsFrame.Position = UDim2.new(0.0138408346, 0, 0.82, 0)
ControlsFrame.Size = UDim2.new(0, 747, 0, 75)

Instance.new("UICorner", ControlsFrame).CornerRadius = UDim.new(0, 8)

StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = ControlsFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.01, 0, 0.68, 0)
StatusLabel.Size = UDim2.new(0.98, 0, 0.3, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Ready | Press INSERT to toggle UI"
StatusLabel.TextColor3 = Color3.fromRGB(40, 200, 110)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Create macOS style buttons
local function createMacButton(name, position, color, parent)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = parent
    button.BackgroundColor3 = color
    button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    button.BorderSizePixel = 0
    button.Position = position
    button.Size = UDim2.new(0, 100, 0, 30)
    button.Font = Enum.Font.GothamMedium
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14.000
    button.AutoButtonColor = false
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    return button, corner
end

ExecuteButton, UICorner_3 = createMacButton("Execute", UDim2.new(0.01, 0, 0.1, 0), Color3.fromRGB(0, 122, 255), ControlsFrame)
ExecuteButton.Size = UDim2.new(0, 120, 0, 38)

ClearButton, UICorner_Clear = createMacButton("Clear", UDim2.new(0.18, 0, 0.1, 0), Color3.fromRGB(80, 80, 85), ControlsFrame)
ClearButton.Size = UDim2.new(0, 80, 0, 38)

SaveButton, UICorner_Save = createMacButton("Save", UDim2.new(0.3, 0, 0.1, 0), Color3.fromRGB(80, 80, 85), ControlsFrame)
SaveButton.Size = UDim2.new(0, 80, 0, 38)

LoadButton, UICorner_Load = createMacButton("Load", UDim2.new(0.42, 0, 0.1, 0), Color3.fromRGB(80, 80, 85), ControlsFrame)
LoadButton.Size = UDim2.new(0, 80, 0, 38)

SettingsButton, UICorner_Settings = createMacButton("Settings", UDim2.new(0.54, 0, 0.1, 0), Color3.fromRGB(80, 80, 85), ControlsFrame)
SettingsButton.Size = UDim2.new(0, 100, 0, 38)

-- Settings Frame (macOS style)
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Parent = ScreenGui
SettingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 32)
SettingsFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
SettingsFrame.Size = UDim2.new(0, 400, 0, 300)
SettingsFrame.Visible = false
SettingsFrame.ZIndex = 10
SettingsFrame.Active = true
SettingsFrame.Draggable = true

UICorner_SettingsFrame.CornerRadius = UDim.new(0, 10)
UICorner_SettingsFrame.Parent = SettingsFrame

SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Name = "SettingsTitle"
SettingsTitle.Parent = SettingsFrame
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.new(0, 0, 0, 10)
SettingsTitle.Size = UDim2.new(1, 0, 0, 25)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Text = "Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.TextSize = 18
SettingsTitle.ZIndex = 11

CloseSettingsButton = Instance.new("TextButton")
CloseSettingsButton.Name = "CloseSettingsButton"
CloseSettingsButton.Parent = SettingsFrame
CloseSettingsButton.BackgroundColor3 = Color3.fromRGB(255, 95, 87)
CloseSettingsButton.Position = UDim2.new(0, 15, 0, 15)
CloseSettingsButton.Size = UDim2.new(0, 12, 0, 12)
CloseSettingsButton.Font = Enum.Font.SourceSans
CloseSettingsButton.Text = ""
CloseSettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseSettingsButton.TextSize = 14.000
CloseSettingsButton.ZIndex = 11
CloseSettingsButton.AutoButtonColor = false

Instance.new("UICorner", CloseSettingsButton).CornerRadius = UDim.new(1, 0)

SettingsScrollFrame = Instance.new("ScrollingFrame")
SettingsScrollFrame.Name = "SettingsScrollFrame"
SettingsScrollFrame.Parent = SettingsFrame
SettingsScrollFrame.BackgroundTransparency = 1
SettingsScrollFrame.Position = UDim2.new(0, 0, 0, 45)
SettingsScrollFrame.Size = UDim2.new(1, 0, 1, -50)
SettingsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsScrollFrame.ScrollBarThickness = 5
SettingsScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
SettingsScrollFrame.BorderSizePixel = 0
SettingsScrollFrame.ZIndex = 10

UIListLayout_Settings = Instance.new("UIListLayout")
UIListLayout_Settings.Parent = SettingsScrollFrame
UIListLayout_Settings.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Settings.Padding = UDim.new(0, 10)

UIPadding_Settings = Instance.new("UIPadding")
UIPadding_Settings.Parent = SettingsScrollFrame
UIPadding_Settings.PaddingLeft = UDim.new(0, 20)
UIPadding_Settings.PaddingRight = UDim.new(0, 20)
UIPadding_Settings.PaddingTop = UDim.new(0, 10)

-- Create toggle switch for settings
local function createToggleSwitch(name, description, value, callback, parent)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = name .. "Frame"
    toggleFrame.Parent = parent
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Size = UDim2.new(1, 0, 0, 60)
    toggleFrame.ZIndex = 11
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = toggleFrame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Size = UDim2.new(1, -60, 0, 25)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = name
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 12
    
    local descriptionLabel = Instance.new("TextLabel")
    descriptionLabel.Name = "Description"
    descriptionLabel.Parent = toggleFrame
    descriptionLabel.BackgroundTransparency = 1
    descriptionLabel.Position = UDim2.new(0, 0, 0, 25)
    descriptionLabel.Size = UDim2.new(1, -60, 0, 35)
    descriptionLabel.Font = Enum.Font.Gotham
    descriptionLabel.Text = description
    descriptionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descriptionLabel.TextSize = 14
    descriptionLabel.TextWrapped = true
    descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
    descriptionLabel.TextYAlignment = Enum.TextYAlignment.Top
    descriptionLabel.ZIndex = 12
    
    -- Create the toggle switch (macOS style)
    local toggleBackground = Instance.new("Frame")
    toggleBackground.Name = "Background"
    toggleBackground.Parent = toggleFrame
    toggleBackground.Position = UDim2.new(1, -50, 0, 10)
    toggleBackground.Size = UDim2.new(0, 50, 0, 30)
    toggleBackground.BackgroundColor3 = value and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(100, 100, 110)
    toggleBackground.ZIndex = 12
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = toggleBackground
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "Circle"
    toggleCircle.Parent = toggleBackground
    toggleCircle.Position = value and UDim2.new(1, -28, 0.5, -12) or UDim2.new(0, 2, 0.5, -12)
    toggleCircle.Size = UDim2.new(0, 24, 0, 24)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.ZIndex = 13
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = toggleCircle
    
    -- Add click functionality
    toggleBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            value = not value
            
            -- Animate the toggle
            local newPosition = value and UDim2.new(1, -28, 0.5, -12) or UDim2.new(0, 2, 0.5, -12)
            local newColor = value and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(100, 100, 110)
            
            TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = newPosition
            }):Play()
            
            TweenService:Create(toggleBackground, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = newColor
            }):Play()
            
            -- Call the callback
            callback(value)
        end
    end)
    
    toggleCircle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            value = not value
            
            -- Animate the toggle
            local newPosition = value and UDim2.new(1, -28, 0.5, -12) or UDim2.new(0, 2, 0.5, -12)
            local newColor = value and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(100, 100, 110)
            
            TweenService:Create(toggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = newPosition
            }):Play()
            
            TweenService:Create(toggleBackground, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = newColor
            }):Play()
            
            -- Call the callback
            callback(value)
        end
    end)
    
    return toggleFrame
end

local function createSlider(name, description, min, max, value, callback, parent)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "Frame"
    sliderFrame.Parent = parent
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Size = UDim2.new(1, 0, 0, 70)
    sliderFrame.ZIndex = 11
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = sliderFrame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Size = UDim2.new(1, 0, 0, 25)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = name
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 12
    
    local descriptionLabel = Instance.new("TextLabel")
    descriptionLabel.Name = "Description"
    descriptionLabel.Parent = sliderFrame
    descriptionLabel.BackgroundTransparency = 1
    descriptionLabel.Position = UDim2.new(0, 0, 0, 25)
    descriptionLabel.Size = UDim2.new(1, 0, 0, 20)
    descriptionLabel.Font = Enum.Font.Gotham
    descriptionLabel.Text = description
    descriptionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descriptionLabel.TextSize = 14
    descriptionLabel.TextWrapped = true
    descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
    descriptionLabel.TextYAlignment = Enum.TextYAlignment.Top
    descriptionLabel.ZIndex = 12
    
    -- Create the slider track
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Name = "Track"
    sliderTrack.Parent = sliderFrame
    sliderTrack.Position = UDim2.new(0, 0, 0, 50)
    sliderTrack.Size = UDim2.new(0.9, 0, 0, 6)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(80, 80, 85)
    sliderTrack.ZIndex = 12
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = sliderTrack
    
    -- Create the filled portion
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Parent = sliderTrack
    sliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
    sliderFill.ZIndex = 13
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = sliderFill
    
    -- Create the slider knob
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Name = "Knob"
    sliderKnob.Parent = sliderTrack
    sliderKnob.Position = UDim2.new((value - min) / (max - min), -10, 0.5, -10)
    sliderKnob.Size = UDim2.new(0, 20, 0, 20)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.ZIndex = 14
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = sliderKnob
    
    -- Create value display
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Parent = sliderFrame
    valueLabel.BackgroundTransparency = 1
    valueLabel.Position = UDim2.new(0.9, 10, 0, 45)
    valueLabel.Size = UDim2.new(0, 40, 0, 20)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Text = tostring(value)
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.TextSize = 14
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    valueLabel.ZIndex = 12
    
    -- Slider functionality
    local dragging = false
    
    sliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    sliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            
            -- Update on click
            local xOffset = math.clamp((input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * xOffset
            
            -- Update UI
            sliderFill.Size = UDim2.new(xOffset, 0, 1, 0)
            sliderKnob.Position = UDim2.new(xOffset, -10, 0.5, -10)
            valueLabel.Text = tostring(math.floor(value))
            
            -- Call callback
            callback(value)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            -- Calculate the new value
            local xOffset = math.clamp((input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * xOffset
            
            -- Update UI
            sliderFill.Size = UDim2.new(xOffset, 0, 1, 0)
            sliderKnob.Position = UDim2.new(xOffset, -10, 0.5, -10)
            valueLabel.Text = tostring(math.floor(value))
            
            -- Call callback
            callback(value)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return sliderFrame
end

-- Create all settings options
local function createSettingsUI()
    -- Dark Mode
    createToggleSwitch("Dark Mode", "Toggle between dark and light theme", themeSettings.DarkMode, function(value)
        themeSettings.DarkMode = value
        applyTheme()
        saveSettings()
    end, SettingsScrollFrame)
    
    -- Transparency
    createToggleSwitch("Transparency", "Enable UI transparency", themeSettings.TransparencyEnabled, function(value)
        themeSettings.TransparencyEnabled = value
        applyTheme()
        saveSettings()
    end, SettingsScrollFrame)
    
    -- Animations
    createToggleSwitch("Animations", "Enable UI animations", themeSettings.AnimationsEnabled, function(value)
        themeSettings.AnimationsEnabled = value
        saveSettings()
    end, SettingsScrollFrame)
    
    -- Auto Execute
    createToggleSwitch("Auto Execute", "Execute script on startup", themeSettings.AutoExecute, function(value)
        themeSettings.AutoExecute = value
        saveSettings()
    end, SettingsScrollFrame)
    
    -- Syntax Highlighting
    createToggleSwitch("Syntax Highlighting", "Highlight code syntax (experimental)", themeSettings.SyntaxHighlighting, function(value)
        themeSettings.SyntaxHighlighting = value
        saveSettings()
    end, SettingsScrollFrame)
    
    -- Auto Save
    createToggleSwitch("Auto Save", "Automatically save scripts", themeSettings.AutoSave, function(value)
        themeSettings.AutoSave = value
        saveSettings()
    end, SettingsScrollFrame)
    
    -- Line Numbers
    createToggleSwitch("Line Numbers", "Display line numbers", themeSettings.LineNumbersVisible, function(value)
        themeSettings.LineNumbersVisible = value
        applyTheme()
        saveSettings()
    end, SettingsScrollFrame)
    
    -- Font Size
    createSlider("Font Size", "Adjust the code editor font size", 10, 24, themeSettings.FontSize, function(value)
        themeSettings.FontSize = value
        applyTheme()
        saveSettings()
    end, SettingsScrollFrame)
    
    -- Update the canvas size
    UIListLayout_Settings:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        SettingsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_Settings.AbsoluteContentSize.Y + 20)
    end)
end

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

-- Function to save script with name
local function saveScript()
    local name = game:GetService("Players").LocalPlayer.Name .. "'s Script " .. os.date("%H:%M:%S")
    
    -- Show input dialog (macOS style)
    local backdrop = Instance.new("Frame")
    backdrop.Parent = Frame
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 0.7
    backdrop.BorderSizePixel = 0
    backdrop.ZIndex = 99
    
    local dialogFrame = Instance.new("Frame")
    dialogFrame.Parent = Frame
    dialogFrame.Size = UDim2.new(0, 350, 0, 180)
    dialogFrame.Position = UDim2.new(0.5, -175, 0.5, -90)
    dialogFrame.BackgroundColor3 = themeSettings.DarkMode and Color3.fromRGB(40, 40, 45) or Color3.fromRGB(240, 240, 240)
    dialogFrame.BorderSizePixel = 0
    dialogFrame.ZIndex = 100
    
    local dialogCorner = Instance.new("UICorner")
    dialogCorner.CornerRadius = UDim.new(0, 10)
    dialogCorner.Parent = dialogFrame
    
    local dialogTitle = Instance.new("TextLabel")
    dialogTitle.Parent = dialogFrame
    dialogTitle.BackgroundTransparency = 1
    dialogTitle.Position = UDim2.new(0, 20, 0, 20)
    dialogTitle.Size = UDim2.new(1, -40, 0, 30)
    dialogTitle.Font = Enum.Font.GothamBold
    dialogTitle.Text = "Save Script"
    dialogTitle.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
    dialogTitle.TextSize = 18
    dialogTitle.TextXAlignment = Enum.TextXAlignment.Left
    dialogTitle.ZIndex = 101
    
    local dialogMessage = Instance.new("TextLabel")
    dialogMessage.Parent = dialogFrame
    dialogMessage.BackgroundTransparency = 1
    dialogMessage.Position = UDim2.new(0, 20, 0, 50)
    dialogMessage.Size = UDim2.new(1, -40, 0, 30)
    dialogMessage.Font = Enum.Font.Gotham
    dialogMessage.Text = "Enter a name for your script:"
    dialogMessage.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(80, 80, 80)
    dialogMessage.TextSize = 14
    dialogMessage.TextXAlignment = Enum.TextXAlignment.Left
    dialogMessage.ZIndex = 101
    
    local nameInput = Instance.new("TextBox")
    nameInput.Parent = dialogFrame
    nameInput.Position = UDim2.new(0, 20, 0, 85)
    nameInput.Size = UDim2.new(1, -40, 0, 40)
    nameInput.Text = name
    nameInput.PlaceholderText = "Enter script name"
    nameInput.Font = Enum.Font.Gotham
    nameInput.TextSize = 14
    nameInput.BackgroundColor3 = themeSettings.DarkMode and Color3.fromRGB(50, 50, 55) or Color3.fromRGB(230, 230, 230)
    nameInput.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
    nameInput.BorderSizePixel = 0
    nameInput.ZIndex = 101
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = nameInput
    
    local cancelButton = Instance.new("TextButton")
    cancelButton.Parent = dialogFrame
    cancelButton.Position = UDim2.new(0, 20, 1, -60)
    cancelButton.Size = UDim2.new(0.5, -30, 0, 40)
    cancelButton.Text = "Cancel"
    cancelButton.Font = Enum.Font.GothamMedium
    cancelButton.TextSize = 14
    cancelButton.BackgroundColor3 = themeSettings.DarkMode and Color3.fromRGB(60, 60, 65) or Color3.fromRGB(210, 210, 210)
    cancelButton.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 80, 80)
    cancelButton.BorderSizePixel = 0
    cancelButton.ZIndex = 101
    
    local cancelCorner = Instance.new("UICorner")
    cancelCorner.CornerRadius = UDim.new(0, 8)
    cancelCorner.Parent = cancelButton
    
    local saveConfirm = Instance.new("TextButton")
    saveConfirm.Parent = dialogFrame
    saveConfirm.Position = UDim2.new(0.5, 10, 1, -60)
    saveConfirm.Size = UDim2.new(0.5, -30, 0, 40)
    saveConfirm.Text = "Save"
    saveConfirm.Font = Enum.Font.GothamMedium
    saveConfirm.TextSize = 14
    saveConfirm.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
    saveConfirm.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveConfirm.BorderSizePixel = 0
    saveConfirm.ZIndex = 101
    
    local saveCorner = Instance.new("UICorner")
    saveCorner.CornerRadius = UDim.new(0, 8)
    saveCorner.Parent = saveConfirm
    
    saveConfirm.MouseButton1Click:Connect(function()
        local scriptName = nameInput.Text
        if scriptName ~= "" then
            savedScripts[scriptName] = TextBox.Text
            saveScriptsList()
            StatusLabel.Text = "Script saved: " .. scriptName
        end
        dialogFrame:Destroy()
        backdrop:Destroy()
    end)
    
    cancelButton.MouseButton1Click:Connect(function()
        dialogFrame:Destroy()
        backdrop:Destroy()
    end)
    
    -- Auto focus the input
    nameInput:CaptureFocus()
end

-- Function to load a script
local function loadScript()
    -- Create the load script dialog
    local backdrop = Instance.new("Frame")
    backdrop.Parent = Frame
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 0.7
    backdrop.BorderSizePixel = 0
    backdrop.ZIndex = 99
    
    local dialogFrame = Instance.new("Frame")
    dialogFrame.Parent = Frame
    dialogFrame.Size = UDim2.new(0, 400, 0, 350)
    dialogFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    dialogFrame.BackgroundColor3 = themeSettings.DarkMode and Color3.fromRGB(40, 40, 45) or Color3.fromRGB(240, 240, 240)
    dialogFrame.BorderSizePixel = 0
    dialogFrame.ZIndex = 100
    
    local dialogCorner = Instance.new("UICorner")
    dialogCorner.CornerRadius = UDim.new(0, 10)
    dialogCorner.Parent = dialogFrame
    
    local dialogTitle = Instance.new("TextLabel")
    dialogTitle.Parent = dialogFrame
    dialogTitle.BackgroundTransparency = 1
    dialogTitle.Position = UDim2.new(0, 20, 0, 20)
    dialogTitle.Size = UDim2.new(1, -40, 0, 30)
    dialogTitle.Font = Enum.Font.GothamBold
    dialogTitle.Text = "Load Script"
    dialogTitle.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
    dialogTitle.TextSize = 18
    dialogTitle.TextXAlignment = Enum.TextXAlignment.Left
    dialogTitle.ZIndex = 101
    
    local dialogMessage = Instance.new("TextLabel")
    dialogMessage.Parent = dialogFrame
    dialogMessage.BackgroundTransparency = 1
    dialogMessage.Position = UDim2.new(0, 20, 0, 50)
    dialogMessage.Size = UDim2.new(1, -40, 0, 30)
    dialogMessage.Font = Enum.Font.Gotham
    dialogMessage.Text = "Select a script to load:"
    dialogMessage.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(80, 80, 80)
    dialogMessage.TextSize = 14
    dialogMessage.TextXAlignment = Enum.TextXAlignment.Left
    dialogMessage.ZIndex = 101
    
    local scriptsScrollFrame = Instance.new("ScrollingFrame")
    scriptsScrollFrame.Name = "ScriptsScrollFrame"
    scriptsScrollFrame.Parent = dialogFrame
    scriptsScrollFrame.BackgroundTransparency = 1
    scriptsScrollFrame.Position = UDim2.new(0, 20, 0, 85)
    scriptsScrollFrame.Size = UDim2.new(1, -40, 1, -145)
    scriptsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scriptsScrollFrame.ScrollBarThickness = 5
    scriptsScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    scriptsScrollFrame.BorderSizePixel = 0
    scriptsScrollFrame.ZIndex = 101
    
    local scriptsList = Instance.new("UIListLayout")
    scriptsList.Parent = scriptsScrollFrame
    scriptsList.SortOrder = Enum.SortOrder.Name
    scriptsList.Padding = UDim.new(0, 8)
    
    -- Add script buttons
    local scriptCount = 0
    for name, script in pairs(savedScripts) do
        scriptCount = scriptCount + 1
        local scriptButton = Instance.new("TextButton")
        scriptButton.Name = name
        scriptButton.Parent = scriptsScrollFrame
        scriptButton.Size = UDim2.new(1, 0, 0, 40)
        scriptButton.BackgroundColor3 = themeSettings.DarkMode and Color3.fromRGB(60, 60, 65) or Color3.fromRGB(220, 220, 220)
        scriptButton.Text = name
        scriptButton.Font = Enum.Font.GothamMedium
        scriptButton.TextSize = 14
        scriptButton.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 60, 60)
        scriptButton.BorderSizePixel = 0
        scriptButton.ZIndex = 102
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = scriptButton
        
        scriptButton.MouseButton1Click:Connect(function()
            TextBox.Text = script
            updateLineNumbers()
            dialogFrame:Destroy()
            backdrop:Destroy()
            StatusLabel.Text = "Loaded script: " .. name
        end)
    end
    
    -- Update canvas size
    scriptsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, scriptCount * 48)
    
    local closeButton = Instance.new("TextButton")
    closeButton.Parent = dialogFrame
    closeButton.Position = UDim2.new(0.5, -60, 1, -60)
    closeButton.Size = UDim2.new(0, 120, 0, 40)
    closeButton.Text = "Close"
    closeButton.Font = Enum.Font.GothamMedium
    closeButton.TextSize = 14
    closeButton.BackgroundColor3 = themeSettings.DarkMode and Color3.fromRGB(60, 60, 65) or Color3.fromRGB(210, 210, 210)
    closeButton.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 80, 80)
    closeButton.BorderSizePixel = 0
    closeButton.ZIndex = 101
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        dialogFrame:Destroy()
        backdrop:Destroy()
    end)
    
    -- Show message if no scripts
    if scriptCount == 0 then
        local noScriptsLabel = Instance.new("TextLabel")
        noScriptsLabel.Parent = scriptsScrollFrame
        noScriptsLabel.BackgroundTransparency = 1
        noScriptsLabel.Size = UDim2.new(1, 0, 0, 40)
        noScriptsLabel.Font = Enum.Font.GothamMedium
        noScriptsLabel.Text = "No saved scripts found"
        noScriptsLabel.TextColor3 = themeSettings.DarkMode and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(120, 120, 120)
        noScriptsLabel.TextSize = 14
        noScriptsLabel.ZIndex = 102
    end
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
    
    local targetSize, targetPos
    
    if isVisible then
        targetSize = UDim2.new(0, 768, 0, 476)
        targetPos = Frame.Position
    else
        targetPos = Frame.Position
        targetSize = UDim2.new(0, 768, 0, 30)
    end
    
    if themeSettings.AnimationsEnabled then
        local sizeTween = TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = targetSize
        })
        
        sizeTween:Play()
    else
        Frame.Size = targetSize
    end
    
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
    
    -- Auto-save
    if themeSettings.AutoSave then
        savedScripts["AutoSave"] = TextBox.Text
        saveScriptsList()
    end
end)

-- Sync scrolling between line numbers and text
EditorScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    LineNumbers.Position = UDim2.new(0, 0, 0, -EditorScrollingFrame.CanvasPosition.Y)
end)

-- Button hover effects for macOS style
local function setupButtonHoverEffect(button, normalColor, hoverColor)
    -- Only apply hover effect when animations are enabled
    if not themeSettings.AnimationsEnabled then return end
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset - 4, button.Size.Y.Scale, button.Size.Y.Offset - 2)}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset + 4, button.Size.Y.Scale, button.Size.Y.Offset + 2)}):Play()
    end)
end

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
            StatusLabel.TextColor3 = themeSettings.DarkMode and colors.dark.statusError or colors.light.statusError
        else
            StatusLabel.Text = "Script executed successfully!"
            StatusLabel.TextColor3 = themeSettings.DarkMode and colors.dark.statusSuccess or colors.light.statusSuccess
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
    loadScript()
end)

SettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = true
    StatusLabel.Text = "Settings opened"
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    toggleUI()
end)

MaximizeButton.MouseButton1Click:Connect(function()
    -- Toggle fullscreen or reset size
    local newSize = Frame.Size == UDim2.new(0, 768, 0, 476) 
        and UDim2.new(0.8, 0, 0.8, 0) 
        or UDim2.new(0, 768, 0, 476)
    
    local newPos = Frame.Size == UDim2.new(0, 768, 0, 476) 
        and UDim2.new(0.1, 0, 0.1, 0) 
        or UDim2.new(0.207, 0, 0.224, 0)
    
    if themeSettings.AnimationsEnabled then
        TweenService:Create(Frame, TweenInfo.new(0.3), {
            Size = newSize,
            Position = newPos
        }):Play()
    else
        Frame.Size = newSize
        Frame.Position = newPos
    end
end)

CloseSettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
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

-- Function to apply syntax highlighting (basic implementation)
local function applySyntaxColoring()
    if not themeSettings.SyntaxHighlighting then return end
    
    -- This is a placeholder for actual syntax highlighting
    -- A full implementation would require custom text rendering
    -- or special GUI components which is complex for this script
    
    -- For now, keep a record of the current text
    local currentText = TextBox.Text
end

-- Initialize settings
loadSettings()
createSettingsUI()
applyTheme()

-- Initialize
loadSavedScripts()
updateLineNumbers()
updateCanvasSize()
StatusLabel.Text = "Ready | Press INSERT to toggle UI"

-- Set up button hover effects after settings are loaded
local theme = themeSettings.DarkMode and colors.dark or colors.light
setupButtonHoverEffect(ExecuteButton, theme.accent, theme.accentHover)
setupButtonHoverEffect(ClearButton, theme.button, theme.buttonHover)
setupButtonHoverEffect(SaveButton, theme.button, theme.buttonHover)
setupButtonHoverEffect(LoadButton, theme.button, theme.buttonHover)
setupButtonHoverEffect(SettingsButton, theme.button, theme.buttonHover)

-- Check for auto-execute
if themeSettings.AutoExecute and savedScripts["AutoExecute"] then
    local scriptContent = savedScripts["AutoExecute"]
    if scriptContent and scriptContent ~= "" then
        pcall(function()
            loadstring(scriptContent)()
            StatusLabel.Text = "Auto-executed script successfully"
        end)
    end
end

-- MacOS window button hover effects
CloseButton.MouseEnter:Connect(function()
    if themeSettings.AnimationsEnabled then
        CloseButton.Text = "×"
    end
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.Text = ""
end)

MinimizeButton.MouseEnter:Connect(function()
    if themeSettings.AnimationsEnabled then
        MinimizeButton.Text = "−"
    end
end)

MinimizeButton.MouseLeave:Connect(function()
    MinimizeButton.Text = ""
end)

MaximizeButton.MouseEnter:Connect(function()
    if themeSettings.AnimationsEnabled then
        MaximizeButton.Text = "+"
    end
end)

MaximizeButton.MouseLeave:Connect(function()
    MaximizeButton.Text = ""
end)
