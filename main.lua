local executorName = ""
local TextBox = Instance.new("TextBox")

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

-- Инийиализация Темы
local Theme = {
    Background = Color3.fromRGB(25, 25, 25),
    SecondaryBackground = Color3.fromRGB(40, 40, 40),
    Text = Color3.fromRGB(255, 255, 255),
    AccentColor = Color3.fromRGB(10, 132, 255),
    ButtonColor = Color3.fromRGB(50, 50, 50),
    ButtonHover = Color3.fromRGB(65, 65, 65),
    Shadow = Color3.fromRGB(15, 15, 15)
}

-- Заголовок в стиле macOS для ScriptHub
local ScriptHubTitleBar = Instance.new("Frame")
ScriptHubTitleBar.Name = "TitleBar"
ScriptHubTitleBar.Parent = ScriptHubFrame
ScriptHubTitleBar.BackgroundColor3 = Theme.SecondaryBackground -- Исправлено
ScriptHubTitleBar.BorderSizePixel = 0
ScriptHubTitleBar.Size = UDim2.new(1, 0, 0, 40)
ScriptHubTitleBar.ZIndex = 11

local UICorner_ScriptHubTitleBar = Instance.new("UICorner")
UICorner_ScriptHubTitleBar.CornerRadius = UDim.new(0, 15)
UICorner_ScriptHubTitleBar.Parent = ScriptHubTitleBar

-- Исправление углов заголовка
local ScriptHubTitleCornerFix = Instance.new("Frame")
ScriptHubTitleCornerFix.Name = "CornerFix"
ScriptHubTitleCornerFix.BackgroundColor3 = Theme.SecondaryBackground
ScriptHubTitleCornerFix.BorderSizePixel = 0
ScriptHubTitleCornerFix.Size = UDim2.new(1, 0, 0, 10)
ScriptHubTitleCornerFix.Position = UDim2.new(0, 0, 1, -10)
ScriptHubTitleCornerFix.ZIndex = 11
ScriptHubTitleCornerFix.Parent = ScriptHubTitleBar

ScriptHubTitle = Instance.new("TextLabel")
ScriptHubTitle.Name = "Title"
ScriptHubTitle.Parent = ScriptHubTitleBar
ScriptHubTitle.BackgroundTransparency = 1
ScriptHubTitle.Position = UDim2.new(0, 15, 0, 0)
ScriptHubTitle.Size = UDim2.new(1, -50, 1, 0)
ScriptHubTitle.Font = Enum.Font.SourceSansBold
ScriptHubTitle.Text = executorName .. " Script Hub"
ScriptHubTitle.TextColor3 = Theme.Text
ScriptHubTitle.TextSize = 18
ScriptHubTitle.TextXAlignment = Enum.TextXAlignment.Center
ScriptHubTitle.ZIndex = 11

CloseScriptHubButton = Instance.new("TextButton")
CloseScriptHubButton.Name = "CloseScriptHubButton"
CloseScriptHubButton.Parent = ScriptHubTitleBar
CloseScriptHubButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseScriptHubButton.BackgroundTransparency = 0.2
CloseScriptHubButton.Position = UDim2.new(0, 15, 0.5, -7)
CloseScriptHubButton.Size = UDim2.new(0, 14, 0, 14)
CloseScriptHubButton.Font = Enum.Font.GothamBold
CloseScriptHubButton.Text = ""
CloseScriptHubButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseScriptHubButton.TextSize = 14.000
CloseScriptHubButton.ZIndex = 12

-- X для кнопки закрытия
local closeHubSymbol = Instance.new("TextLabel")
closeHubSymbol.Name = "Symbol"
closeHubSymbol.BackgroundTransparency = 1
closeHubSymbol.Size = UDim2.new(1, 0, 1, 0)
closeHubSymbol.Font = Enum.Font.GothamBold
closeHubSymbol.TextSize = 12
closeHubSymbol.TextColor3 = Color3.fromRGB(77, 77, 77)
closeHubSymbol.Text = "×"
closeHubSymbol.Visible = false
closeHubSymbol.ZIndex = 12
closeHubSymbol.Parent = CloseScriptHubButton

CloseScriptHubButton.MouseEnter:Connect(function()
    closeHubSymbol.Visible = true
end)

CloseScriptHubButton.MouseLeave:Connect(function()
    closeHubSymbol.Visible = false
end)

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
ScriptHubList.ZIndex = 11

-- Стилизуем скроллбар для ScriptHubList так же как и для редактора
local scriptHubScrollbar = Instance.new("Frame")
scriptHubScrollbar.Name = "MacScrollbar"
scriptHubScrollbar.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
scriptHubScrollbar.BackgroundTransparency = 0.7
scriptHubScrollbar.BorderSizePixel = 0
scriptHubScrollbar.Size = UDim2.new(0, 5, 0, 50)
scriptHubScrollbar.Position = UDim2.new(1, -5, 0, 0)
scriptHubScrollbar.Visible = false
scriptHubScrollbar.ZIndex = 12
scriptHubScrollbar.Parent = ScriptHubList

local UICorner_HubScrollbar = Instance.new("UICorner")
UICorner_HubScrollbar.CornerRadius = UDim.new(1, 0)
UICorner_HubScrollbar.Parent = scriptHubScrollbar

-- Показываем скроллбар при прокрутке
ScriptHubList:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    scriptHubScrollbar.Visible = true
    scriptHubScrollbar.Position = UDim2.new(1, -5, 0, ScriptHubList.CanvasPosition.Y / ScriptHubList.CanvasSize.Y.Offset * ScriptHubList.AbsoluteSize.Y)
    
    -- Размер скроллбара пропорционален отношению размера окна к размеру содержимого
    local ratio = ScriptHubList.AbsoluteSize.Y / ScriptHubList.CanvasSize.Y.Offset
    ratio = math.min(ratio, 1)
    scriptHubScrollbar.Size = UDim2.new(0, 5, ratio, 0)
    
    -- Скрываем через 2 секунды
    spawn(function()
        wait(2)
        if scriptHubScrollbar.Parent then
            scriptHubScrollbar.Visible = false
        end
    end)
end)

UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScriptHubList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Функция для обновления номеров строк
local function updateLineNumbers()
    local text = TextBox.Text
    local lines = text:split("\n")
    local lineNumbersText = ""
    
    for i = 1, #lines do
        lineNumbersText = lineNumbersText .. i .. "\n"
    end
    
    -- Убедимся, что есть хотя бы одна строка
    if lineNumbersText == "" then
        lineNumbersText = "1"
    end
    
    LineNumbers.Text = lineNumbersText
end

-- Функция для добавления скрипта в хаб
local function addScriptToHub(name, script)
    local scriptButton = Instance.new("TextButton")
    scriptButton.Name = name
    scriptButton.Parent = ScriptHubList
    scriptButton.BackgroundColor3 = Theme.ButtonColor
    scriptButton.Size = UDim2.new(1, -10, 0, 40)
    scriptButton.Font = Enum.Font.Gotham
    scriptButton.Text = "  " .. name
    scriptButton.TextColor3 = Theme.Text
    scriptButton.TextSize = 14
    scriptButton.ZIndex = 11
    scriptButton.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Добавим эффект тени
    createShadow(scriptButton, UDim2.new(1, 6, 1, 6), UDim2.new(0, -3, 0, -3), 0.9)
    
    local UICorner_ScriptButton = Instance.new("UICorner")
    UICorner_ScriptButton.CornerRadius = UDim.new(0, 8)
    UICorner_ScriptButton.Parent = scriptButton
    
    -- Добавим иконку документа
    local docIcon = Instance.new("Frame")
    docIcon.Name = "DocIcon"
    docIcon.BackgroundColor3 = Theme.AccentColor
    docIcon.Position = UDim2.new(1, -35, 0.5, -8)
    docIcon.Size = UDim2.new(0, 16, 0, 20)
    docIcon.ZIndex = 12
    docIcon.Parent = scriptButton
    
    local docIconCorner = Instance.new("UICorner")
    docIconCorner.CornerRadius = UDim.new(0, 3)
    docIconCorner.Parent = docIcon
    
    -- Маленькая деталь для иконки документа
    local docFold = Instance.new("Frame")
    docFold.Name = "DocFold"
    docFold.BackgroundColor3 = Theme.ButtonColor
    docFold.BorderSizePixel = 0
    docFold.Position = UDim2.new(1, -8, 0, -2)
    docFold.Size = UDim2.new(0, 8, 0, 8)
    docFold.ZIndex = 12
    docFold.Rotation = 45
    docFold.Parent = docIcon
    
    -- Эффекты при наведении и нажатии
    scriptButton.MouseEnter:Connect(function()
        TweenService:Create(scriptButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Theme.ButtonHover
        }):Play()
    end)
    
    scriptButton.MouseLeave:Connect(function()
        TweenService:Create(scriptButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Theme.ButtonColor
        }):Play()
    end)
    
    scriptButton.MouseButton1Click:Connect(function()
        TextBox.Text = script
        updateLineNumbers()
        ScriptHubFrame.Visible = false
        StatusLabel.Text = "Loaded script: " .. name
        
        -- Анимация успешного выполнения
        local originalColor = StatusLabel.TextColor3
        TweenService:Create(StatusLabel, TweenInfo.new(0.5), {
            TextColor3 = Color3.fromRGB(80, 255, 80)
        }):Play()
        
        spawn(function()
            wait(2)
            TweenService:Create(StatusLabel, TweenInfo.new(0.5), {
                TextColor3 = originalColor
            }):Play()
        end)
    end)
    
    return scriptButton
end

-- Функция для сохранения скрипта с именем
local function saveScript()
    local name = game:GetService("Players").LocalPlayer.Name .. "'s Script " .. os.date("%H:%M:%S")
    
    -- Создаем модальное окно ввода
    local backdrop = Instance.new("Frame")
    backdrop.Name = "ModalBackdrop"
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 0.5
    backdrop.BorderSizePixel = 0
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.ZIndex = 100
    backdrop.Parent = Frame
    
    local modalFrame = Instance.new("Frame")
    modalFrame.Name = "ModalFrame"
    modalFrame.BackgroundColor3 = Theme.SecondaryBackground
    modalFrame.BorderSizePixel = 0
    modalFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    modalFrame.Size = UDim2.new(0, 300, 0, 150)
    modalFrame.ZIndex = 101
    modalFrame.Parent = backdrop
    
    createShadow(modalFrame, UDim2.new(1, 20, 1, 20), UDim2.new(0, -10, 0, -10), 0.7)
    
    local modalCorner = Instance.new("UICorner")
    modalCorner.CornerRadius = UDim.new(0, 10)
    modalCorner.Parent = modalFrame
    
    local modalTitle = Instance.new("TextLabel")
    modalTitle.Name = "ModalTitle"
    modalTitle.BackgroundTransparency = 1
    modalTitle.Position = UDim2.new(0, 0, 0, 10)
    modalTitle.Size = UDim2.new(1, 0, 0, 30)
    modalTitle.Font = Enum.Font.SourceSansBold
    modalTitle.Text = "Save Script"
    modalTitle.TextColor3 = Theme.Text
    modalTitle.TextSize = 18
    modalTitle.ZIndex = 102
    modalTitle.Parent = modalFrame
    
    local nameInput = Instance.new("TextBox")
    nameInput.Name = "NameInput"
    nameInput.BackgroundColor3 = Theme.Background
    nameInput.Position = UDim2.new(0.5, -130, 0.5, -15)
    nameInput.Size = UDim2.new(0, 260, 0, 30)
    nameInput.Font = Enum.Font.SourceSans
    nameInput.PlaceholderText = "Enter script name..."
    nameInput.Text = name
    nameInput.TextColor3 = Theme.Text
    nameInput.TextSize = 14
    nameInput.ZIndex = 102
    nameInput.Parent = modalFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = nameInput
    
    local saveBtn = Instance.new("TextButton")
    saveBtn.Name = "SaveButton"
    saveBtn.BackgroundColor3 = Theme.AccentColor
    saveBtn.Position = UDim2.new(0.3, -50, 0.8, -15)
    saveBtn.Size = UDim2.new(0, 100, 0, 30)
    saveBtn.Font = Enum.Font.SourceSansBold
    saveBtn.Text = "Save"
    saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveBtn.TextSize = 16
    saveBtn.ZIndex = 102
    saveBtn.Parent = modalFrame
    
    createShadow(saveBtn, UDim2.new(1, 8, 1, 8), UDim2.new(0, -4, 0, -4), 0.8)
    
    local saveCorner = Instance.new("UICorner")
    saveCorner.CornerRadius = UDim.new(0, 6)
    saveCorner.Parent = saveBtn
    
    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Name = "CancelButton"
    cancelBtn.BackgroundColor3 = Theme.ButtonColor
    cancelBtn.Position = UDim2.new(0.7, -50, 0.8, -15)
    cancelBtn.Size = UDim2.new(0, 100, 0, 30)
    cancelBtn.Font = Enum.Font.SourceSansBold
    cancelBtn.Text = "Cancel"
    cancelBtn.TextColor3 = Theme.Text
    cancelBtn.TextSize = 16
    cancelBtn.ZIndex = 102
    cancelBtn.Parent = modalFrame
    
    createShadow(cancelBtn, UDim2.new(1, 8, 1, 8), UDim2.new(0, -4, 0, -4), 0.8)
    
    local cancelCorner = Instance.new("UICorner")
    cancelCorner.CornerRadius = UDim.new(0, 6)
    cancelCorner.Parent = cancelBtn
    
    -- Эффекты кнопок
    local function setupButtonEffect(button)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = button.BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.2)
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = button == saveBtn and Theme.AccentColor or Theme.ButtonColor
            }):Play()
        end)
        
        button.MouseButton1Down:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(0, button.Size.X.Offset - 2, 0, button.Size.Y.Offset - 2),
                Position = UDim2.new(button.Position.X.Scale, button.Position.X.Offset + 1, button.Position.Y.Scale, button.Position.Y.Offset + 1)
            }):Play()
        end)
        
        button.MouseButton1Up:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(0, button.Size.X.Offset + 2, 0, button.Size.Y.Offset + 2),
                Position = UDim2.new(button.Position.X.Scale, button.Position.X.Offset - 1, button.Position.Y.Scale, button.Position.Y.Offset - 1)
            }):Play()
        end)
    end
    
    setupButtonEffect(saveBtn)
    setupButtonEffect(cancelBtn)
    
    -- Анимация появления
    modalFrame.Size = UDim2.new(0, 0, 0, 0)
    modalFrame.BackgroundTransparency = 1
    backdrop.BackgroundTransparency = 1
    
    TweenService:Create(backdrop, TweenInfo.new(0.3), {
        BackgroundTransparency = 0.5
    }):Play()
    
    local appearTween = TweenService:Create(modalFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 300, 0, 150),
        BackgroundTransparency = 0
    })
    appearTween:Play()
    
    -- Обработчики событий
    saveBtn.MouseButton1Click:Connect(function()
        local scriptName = nameInput.Text
        if scriptName ~= "" then
            savedScripts[scriptName] = TextBox.Text
            saveScriptsList()
            addScriptToHub(scriptName, TextBox.Text)
            StatusLabel.Text = "Script saved: " .. scriptName
            
            -- Анимация успешного сохранения
            TweenService:Create(StatusLabel, TweenInfo.new(0.5), {
                TextColor3 = Color3.fromRGB(80, 255, 80)
            }):Play()
            
            spawn(function()
                wait(2)
                TweenService:Create(StatusLabel, TweenInfo.new(0.5), {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
            end)
        end
        
        -- Анимация закрытия
        TweenService:Create(backdrop, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        }):Play()
        
        local disappearTween = TweenService:Create(modalFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        })
        disappearTween:Play()
        
        disappearTween.Completed:Connect(function()
            backdrop:Destroy()
        end)
    end)
    
    cancelBtn.MouseButton1Click:Connect(function()
        -- Анимация закрытия
        TweenService:Create(backdrop, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        }):Play()
        
        local disappearTween = TweenService:Create(modalFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        })
        disappearTween:Play()
        
        disappearTween.Completed:Connect(function()
            backdrop:Destroy()
        end)
    end)
end

-- Функция для обновления размера канваса
local function updateCanvasSize()
    local textBounds = TextService:GetTextSize(
        TextBox.Text, 
        TextBox.TextSize, 
        TextBox.Font, 
        Vector2.new(EditorScrollingFrame.AbsoluteSize.X, 10000)
    )
    
    EditorScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(textBounds.Y + 20, EditorScrollingFrame.AbsoluteSize.Y))
end

-- Функция для переключения видимости UI
local function toggleUI()
    isVisible = not isVisible
    
    -- Анимация
    local targetSize = isVisible and UDim2.new(0, 768, 0, 476) or UDim2.new(0, 768, 0, 40)
    
    local sizeTween = TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = targetSize
    })
    
    sizeTween:Play()
    
    -- Скрываем все дочерние элементы кроме TitleBar
    if not isVisible then
        for _, child in pairs(Frame:GetChildren()) do
            if child ~= TitleBar and child.Name ~= "Shadow" then
                child.Visible = false
            end
        end
    else
        -- Показываем все дочерние элементы
        for _, child in pairs(Frame:GetChildren()) do
            if child.Name ~= "Shadow" then
                child.Visible = true
            end
        end
    end
end

-- Обработка изменений текста
TextBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateLineNumbers()
    updateCanvasSize()
end)

-- Синхронизация прокрутки между номерами строк и текстом
EditorScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    LineNumbers.Position = UDim2.new(0, 0, 0, -EditorScrollingFrame.CanvasPosition.Y)
end)

-- Эффекты при наведении для всех кнопок
local function setupButtonHoverEffect(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = hoverColor}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {BackgroundColor3 = normalColor}):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset - 4, button.Size.Y.Scale, button.Size.Y.Offset - 4),
            Position = UDim2.new(button.Position.X.Scale, button.Position.X.Offset + 2, button.Position.Y.Scale, button.Position.Y.Offset + 2)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset + 4, button.Size.Y.Scale, button.Size.Y.Offset + 4),
            Position = UDim2.new(button.Position.X.Scale, button.Position.X.Offset - 2, button.Position.Y.Scale, button.Position.Y.Offset - 2)
        }):Play()
    end)
end

setupButtonHoverEffect(ClearButton, Theme.ButtonColor, Theme.ButtonHover)
setupButtonHoverEffect(SaveButton, Theme.ButtonColor, Theme.ButtonHover)
setupButtonHoverEffect(LoadButton, Theme.ButtonColor, Theme.ButtonHover)
setupButtonHoverEffect(ScriptHubButton, Theme.ButtonColor, Theme.ButtonHover)
setupButtonHoverEffect(SettingsButton, Theme.ButtonColor, Theme.ButtonHover)

-- Для Execute кнопки особый эффект, т.к. у неё градиент
ExecuteButton.MouseEnter:Connect(function()
    TweenService:Create(ExecuteButton, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
end)

ExecuteButton.MouseLeave:Connect(function()
    TweenService:Create(ExecuteButton, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
end)

ExecuteButton.MouseButton1Down:Connect(function()
    TweenService:Create(ExecuteButton, TweenInfo.new(0.1), {
        Size = UDim2.new(0, 116, 0, 34),
        Position = UDim2.new(0.01, 2, 0.1, 2)
    }):Play()
end)

ExecuteButton.MouseButton1Up:Connect(function()
    TweenService:Create(ExecuteButton, TweenInfo.new(0.1), {
        Size = UDim2.new(0, 120, 0, 38),
        Position = UDim2.new(0.01, 0, 0.1, 0)
    }):Play()
end)

-- Обработчик нажатия на кнопку Execute
ExecuteButton.MouseButton1Click:Connect(function()
    local scriptContent = TextBox.Text
    if scriptContent ~= "" then
        StatusLabel.Text = "Executing script..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
        
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
            
            -- Эффект "вспышки" на кнопке Execute
            local originalColor = ExecuteButton.BackgroundColor3
            TweenService:Create(ExecuteButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            }):Play()
            
            spawn(function()
                wait(0.2)
                TweenService:Create(ExecuteButton, TweenInfo.new(0.5), {
                    BackgroundColor3 = originalColor
                }):Play()
            end)
        end
        
        -- Сбрасываем цвет статуса после задержки
        spawn(function()
            wait(3)
            TweenService:Create(StatusLabel, TweenInfo.new(0.5), {
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            StatusLabel.Text = "Ready | Press INSERT to toggle UI"
        end)
    end
end)

-- Добавляем функциональность другим кнопкам
ClearButton.MouseButton1Click:Connect(function()
    TextBox.Text = ""
    StatusLabel.Text = "Editor cleared"
    StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 255)
    
    spawn(function()
        wait(2)
        TweenService:Create(StatusLabel, TweenInfo.new(0.5), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
        StatusLabel.Text = "Ready | Press INSERT to toggle UI"
    end)
end)

SaveButton.MouseButton1Click:Connect(function()
    saveScript()
end)

LoadButton.MouseButton1Click:Connect(function()
    if not ScriptHubFrame.Visible then
        -- Анимация появления
        ScriptHubFrame.Size = UDim2.new(0, 0, 0, 0)
        ScriptHubFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        ScriptHubFrame.BackgroundTransparency = 1
        ScriptHubFrame.Visible = true
        
        local appearTween = TweenService:Create(ScriptHubFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 400, 0, 300),
            Position = UDim2.new(0.5, -200, 0.5, -150),
            BackgroundTransparency = 0
        })
        appearTween:Play()
        
        StatusLabel.Text = "Select a script to load"
    else
        -- Анимация исчезновения
        local disappearTween = TweenService:Create(ScriptHubFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        })
        disappearTween:Play()
        
        disappearTween.Completed:Connect(function()
            ScriptHubFrame.Visible = false
        end)
    end
end)

ScriptHubButton.MouseButton1Click:Connect(function()
    if not ScriptHubFrame.Visible then
        -- Анимация появления
        ScriptHubFrame.Size = UDim2.new(0, 0, 0, 0)
        ScriptHubFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        ScriptHubFrame.BackgroundTransparency = 1
        ScriptHubFrame.Visible = true
        
        local appearTween = TweenService:Create(ScriptHubFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 400, 0, 300),
            Position = UDim2.new(0.5, -200, 0.5, -150),
            BackgroundTransparency = 0
        })
        appearTween:Play()
        
        StatusLabel.Text = executorName .. " Script Hub opened"
    else
        -- Анимация исчезновения
        local disappearTween = TweenService:Create(ScriptHubFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        })
        disappearTween:Play()
        
        disappearTween.Completed:Connect(function()
            ScriptHubFrame.Visible = false
        end)
    end
end)

SettingsButton.MouseButton1Click:Connect(function()
    -- Создаем всплывающее уведомление
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = Theme.SecondaryBackground
    notification.BorderSizePixel = 0
    notification.Position = UDim2.new(1, 10, 0, 10) -- Начинаем за пределами экрана
    notification.Size = UDim2.new(0, 280, 0, 80)
    notification.ZIndex = 15
    notification.Parent = Frame
    
    -- Закругленные углы
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 10)
    notifCorner.Parent = notification
    
    -- Тень
    createShadow(notification, UDim2.new(1, 10, 1, 10), UDim2.new(0, -5, 0, -5))
    
    -- Иконка
    local iconContainer = Instance.new("Frame")
    iconContainer.Name = "IconContainer"
    iconContainer.BackgroundColor3 = Theme.AccentColor
    iconContainer.BorderSizePixel = 0
    iconContainer.Position = UDim2.new(0, 10, 0.5, -20)
    iconContainer.Size = UDim2.new(0, 40, 0, 40)
    iconContainer.ZIndex = 16
    iconContainer.Parent = notification
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = iconContainer
    
    -- Символ для иконки
    local iconSymbol = Instance.new("TextLabel")
    iconSymbol.Name = "IconSymbol"
    iconSymbol.BackgroundTransparency = 1
    iconSymbol.Size = UDim2.new(1, 0, 1, 0)
    iconSymbol.Font = Enum.Font.GothamBold
    iconSymbol.Text = "i"
    iconSymbol.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconSymbol.TextSize = 24
    iconSymbol.ZIndex = 17
    iconSymbol.Parent = iconContainer
    
    -- Заголовок уведомления
    local notifTitle = Instance.new("TextLabel")
    notifTitle.Name = "Title"
    notifTitle.BackgroundTransparency = 1
    notifTitle.Position = UDim2.new(0, 60, 0, 10)
    notifTitle.Size = UDim2.new(1, -70, 0, 20)
    notifTitle.Font = Enum.Font.SourceSansBold
    notifTitle.Text = "Settings"
    notifTitle.TextColor3 = Theme.Text
    notifTitle.TextSize = 16
    notifTitle.TextXAlignment = Enum.TextXAlignment.Left
    notifTitle.ZIndex = 16
    notifTitle.Parent = notification
    
    -- Текст уведомления
    local notifMessage = Instance.new("TextLabel")
    notifMessage.Name = "Message"
    notifMessage.BackgroundTransparency = 1
    notifMessage.Position = UDim2.new(0, 60, 0, 35)
    notifMessage.Size = UDim2.new(1, -70, 0, 40)
    notifMessage.Font = Enum.Font.SourceSans
    notifMessage.Text = "Settings panel coming soon!"
    notifMessage.TextColor3 = Theme.Text
    notifMessage.TextWrapped = true
    notifMessage.TextSize = 14
    notifMessage.TextXAlignment = Enum.TextXAlignment.Left
    notifMessage.TextYAlignment = Enum.TextYAlignment.Top
    notifMessage.ZIndex = 16
    notifMessage.Parent = notification
    
    -- Индикатор прогресса
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.BackgroundColor3 = Theme.AccentColor
    progressBar.BorderSizePixel = 0
    progressBar.Position = UDim2.new(0, 0, 1, -2)
    progressBar.Size = UDim2.new(1, 0, 0, 2)
    progressBar.ZIndex = 16
    progressBar.Parent = notification
    
    -- Анимация появления
    local appearTween = TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -290, 0, 10)
    })
    appearTween:Play()
    
    -- Анимация прогресса
    local progressTween = TweenService:Create(progressBar, TweenInfo.new(3, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 2)
    })
    progressTween:Play()
    
    -- Исчезновение после 3 секунд
    spawn(function()
        wait(3)
        local disappearTween = TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 10, 0, 10)
        })
        disappearTween:Play()
        
        disappearTween.Completed:Connect(function()
            notification:Destroy()
        end)
    end)
    
    StatusLabel.Text = "Settings coming soon..."
end)

CloseButton.MouseButton1Click:Connect(function()
    -- Анимация исчезновения
    local disappearTween = TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    })
    disappearTween:Play()
    
    disappearTween.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)

MinimizeButton.MouseButton1Click:Connect(function()
    toggleUI()
end)

-- Функция полноэкранного режима
local isFullscreen = false
fullscreenButton.MouseButton1Click:Connect(function()
    isFullscreen = not isFullscreen
    
    if isFullscreen then
        -- Запоминаем предыдущие размеры и позицию
        Frame.OldSize = Frame.Size
        Frame.OldPosition = Frame.Position
        
        -- Анимация увеличения до полного экрана
        TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(1, -40, 1, -40),
            Position = UDim2.new(0, 20, 0, 20)
        }):Play()
    else
        -- Возвращаем к предыдущим размерам
        TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = Frame.OldSize,
            Position = Frame.OldPosition
        }):Play()
    end
end)

CloseScriptHubButton.MouseButton1Click:Connect(function()
    -- Анимация исчезновения
    local disappearTween = TweenService:Create(ScriptHubFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    })
    disappearTween:Play()
    
    disappearTween.Completed:Connect(function()
        ScriptHubFrame.Visible = false
    end)
end)

-- Сделать Frame перетаскиваемым
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

-- Переключение UI с помощью клавиши Insert
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        toggleUI()
    end
end)

-- Добавление анимации радужного текста к заголовку
local titleHue = 0
RunService.Heartbeat:Connect(function(dt)
    titleHue = (titleHue + 0.1 * dt) % 1
    Title.TextColor3 = Color3.fromHSV(titleHue, 0.8, 1)
end)

-- Добавляем анимацию к кнопке Execute
spawn(function()
    while wait(0.05) do
        for i = 0, 1, 0.01 do
            if not ScreenGui.Parent then break end
            UIGradient.Offset = Vector2.new(i, 0)
            wait(0.05)
        end
    end
end)

-- Инициализация
updateLineNumbers()
updateCanvasSize()
StatusLabel.Text = "Ready | Press INSERT to toggle UI"

-- Загружаем сохраненные скрипты
loadSavedScripts()
for name, script in pairs(savedScripts) do
    addScriptToHub(name, script)
end

-- Обновление размера канваса для списка скриптов
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScriptHubList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Добавляем эффект вспышки при загрузке UI
local flashEffect = Instance.new("Frame")
flashEffect.Name = "FlashEffect"
flashEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
flashEffect.BackgroundTransparency = 0
flashEffect.BorderSizePixel = 0
flashEffect.Size = UDim2.new(1, 0, 1, 0)
flashEffect.ZIndex = 100
flashEffect.Parent = Frame

-- Анимация появления UI
Frame.Size = UDim2.new(0, 0, 0, 0)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.BackgroundTransparency = 1
ScriptEditor.BackgroundTransparency = 1
TitleBar.BackgroundTransparency = 1
ControlsFrame.BackgroundTransparency = 1

local appearTween = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 768, 0, 476),
    Position = UDim2.new(0.207, 0, 0.224, 0),
    BackgroundTransparency = 0
})

local flashTween = TweenService:Create(flashEffect, TweenInfo.new(0.5), {
    BackgroundTransparency = 1
})

appearTween:Play()
spawn(function()
    wait(0.1)
    flashTween:Play()
    
    TweenService:Create(ScriptEditor, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
        BackgroundTransparency = 0
    }):Play()
    
    TweenService:Create(TitleBar, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
        BackgroundTransparency = 0
    }):Play()
    
    TweenService:Create(ControlsFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
        BackgroundTransparency = 0
    }):Play()
    
    flashTween.Completed:Connect(function()
        flashEffect:Destroy()
    end)
end)
