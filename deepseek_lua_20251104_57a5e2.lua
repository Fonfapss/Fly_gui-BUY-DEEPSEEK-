local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Создаём GUI
local main = Instance.new("ScreenGui")
main.Name = "FlyGUI"
main.Parent = player.PlayerGui
main.ResetOnSpawn = false

-- Главный фрейм с красивым дизайном
local Frame = Instance.new("Frame")
Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Frame.BorderColor3 = Color3.fromRGB(80, 120, 255)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.1, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 280, 0, 140)
Frame.Active = true
Frame.Draggable = true

-- Скруглённые углы
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Frame

-- Заголовок с красивым шрифтом
local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(60, 80, 220)
TextLabel.Size = UDim2.new(1, 0, 0, 35)
TextLabel.Font = Enum.Font.FredokaOne  -- Красивый шрифт
TextLabel.Text = "🚀 FLY GUI V4"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 18
TextLabel.TextStrokeTransparency = 0.8

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TextLabel

-- Крестик закрытия
local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Parent = Frame
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.Position = UDim2.new(0.9, -25, 0.02, 0)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.ZIndex = 2

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = closeButton

-- Кнопка вкл/выкл полёта
local onof = Instance.new("TextButton")
onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
onof.Position = UDim2.new(0.05, 0, 0.35, 0)
onof.Size = UDim2.new(0, 90, 0, 35)
onof.Font = Enum.Font.GothamSemibold  -- Красивый шрифт
onof.Text = "ВКЛЮЧИТЬ"
onof.TextColor3 = Color3.fromRGB(255, 255, 255)
onof.TextSize = 14

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = onof

-- Кнопка вверх
local up = Instance.new("TextButton")
up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
up.Position = UDim2.new(0.05, 0, 0.75, 0)
up.Size = UDim2.new(0, 60, 0, 28)
up.Font = Enum.Font.GothamMedium
up.Text = "↑ ВВЕРХ"
up.TextColor3 = Color3.fromRGB(255, 255, 255)
up.TextSize = 12

local UpCorner = Instance.new("UICorner")
UpCorner.CornerRadius = UDim.new(0, 5)
UpCorner.Parent = up

-- Кнопка вниз
local down = Instance.new("TextButton")
down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
down.Position = UDim2.new(0.3, 0, 0.75, 0)
down.Size = UDim2.new(0, 60, 0, 28)
down.Font = Enum.Font.GothamMedium
down.Text = "↓ ВНИЗ"
down.TextColor3 = Color3.fromRGB(255, 255, 255)
down.TextSize = 12

local DownCorner = Instance.new("UICorner")
DownCorner.CornerRadius = UDim.new(0, 5)
DownCorner.Parent = down

-- Отображение скорости
local speed = Instance.new("TextLabel")
speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
speed.Position = UDim2.new(0.4, 0, 0.35, 0)
speed.Size = UDim2.new(0, 70, 0, 35)
speed.Font = Enum.Font.GothamSemibold
speed.Text = "Скорость: 1"
speed.TextColor3 = Color3.fromRGB(255, 255, 255)
speed.TextSize = 12

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = speed

-- Кнопка увеличения скорости
local plus = Instance.new("TextButton")
plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
plus.Position = UDim2.new(0.75, 0, 0.35, 0)
plus.Size = UDim2.new(0, 30, 0, 35)
plus.Font = Enum.Font.GothamBold
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(255, 255, 255)
plus.TextSize = 18

local PlusCorner = Instance.new("UICorner")
PlusCorner.CornerRadius = UDim.new(0, 6)
PlusCorner.Parent = plus

-- Кнопка уменьшения скорости
local mine = Instance.new("TextButton")
mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
mine.Position = UDim2.new(0.65, 0, 0.35, 0)
mine.Size = UDim2.new(0, 30, 0, 35)
mine.Font = Enum.Font.GothamBold
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(255, 255, 255)
mine.TextSize = 18

local MineCorner = Instance.new("UICorner")
MineCorner.CornerRadius = UDim.new(0, 6)
MineCorner.Parent = mine

-- Переменные для полёта
local isFlying = false
local flySpeed = 1
local bodyVelocity, bodyGyro

-- Анимация при наведении
local function setupButtonHover(button)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {BackgroundColor3 = originalColor * 1.3})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {BackgroundColor3 = originalColor})
        tween:Play()
    end)
end

-- Применяем анимации ко всем кнопкам
setupButtonHover(onof)
setupButtonHover(up)
setupButtonHover(down)
setupButtonHover(plus)
setupButtonHover(mine)
setupButtonHover(closeButton)

-- Функция переключения полёта
local function toggleFlight()
    if isFlying then
        -- Выключаем полёт
        if bodyVelocity then 
            bodyVelocity:Destroy() 
            bodyVelocity = nil
        end
        if bodyGyro then 
            bodyGyro:Destroy() 
            bodyGyro = nil
        end
        
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
        
        onof.Text = "ВКЛЮЧИТЬ"
        onof.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        isFlying = false
        
    else
        -- Включаем полёт
        local character = player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not rootPart then return end
        
        humanoid.PlatformStand = true
        
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        bodyVelocity.Parent = rootPart
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
        bodyGyro.P = 1000
        bodyGyro.Parent = rootPart
        
        onof.Text = "ВЫКЛЮЧИТЬ"
        onof.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
        isFlying = true
        
        -- Цикл полёта
        spawn(function()
            while isFlying and bodyVelocity and bodyGyro do
                local camera = workspace.CurrentCamera
                bodyGyro.CFrame = camera.CFrame
                
                local direction = Vector3.new()
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    direction = direction + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    direction = direction - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    direction = direction - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    direction = direction + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    direction = direction + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    direction = direction + Vector3.new(0, -1, 0)
                end
                
                if direction.Magnitude > 0 then
                    bodyVelocity.Velocity = direction.Unit * (flySpeed * 50)
                else
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                end
                
                RunService.Heartbeat:Wait()
            end
        end)
    end
end

-- Обработчики кнопок
onof.MouseButton1Click:Connect(toggleFlight)

plus.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 1, 10)
    speed.Text = "Скорость: " .. flySpeed
end)

mine.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 1, 1)
    speed.Text = "Скорость: " .. flySpeed
end)

-- Кнопка ВВЕРХ
up.MouseButton1Down:Connect(function()
    if isFlying and bodyVelocity then
        bodyVelocity.Velocity = Vector3.new(0, flySpeed * 50, 0)
    end
end)

up.MouseButton1Up:Connect(function()
    if isFlying and bodyVelocity then
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- Кнопка ВНИЗ
down.MouseButton1Down:Connect(function()
    if isFlying and bodyVelocity then
        bodyVelocity.Velocity = Vector3.new(0, -flySpeed * 50, 0)
    end
end)

down.MouseButton1Up:Connect(function()
    if isFlying and bodyVelocity then
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- Закрытие GUI
closeButton.MouseButton1Click:Connect(function()
    -- Выключаем полёт перед закрытием
    if isFlying then
        toggleFlight()
    end
    
    -- Анимация исчезновения
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(Frame, tweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    tween:Play()
    
    tween.Completed:Wait()
    main:Destroy()
end)

-- Автоматическое отключение при смерти
player.CharacterAdded:Connect(function(character)
    if isFlying then
        wait(1)
        if isFlying then
            toggleFlight()
        end
    end
end)

print("✅ Fly GUI V4 загружен успешно!")
print("🎨 Красивый дизайн с анимациями")
print("❌ Крестик для закрытия")
print("🚀 Управление: WASD + Space/Ctrl")