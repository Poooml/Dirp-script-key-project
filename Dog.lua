-- NONNOI KEY SYSTEM
repeat task.wait() until game:IsLoaded()

local KeyURL = "https://raw.githubusercontent.com/Poooml/Dirp-script-key-project/refs/heads/main/Rgb"
local ScriptURL = "https://raw.githubusercontent.com/Poooml/Dirp-script-key-project/refs/heads/main/Kuy.lua"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- โหลดคีย์จาก GitHub
local Success, CorrectKey = pcall(function()
    return game:HttpGet(KeyURL)
end)

if not Success then
    warn("โหลดคีย์ไม่ได้")
    return
end

CorrectKey = tostring(CorrectKey):gsub("%s+", "")

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NONNOI_KEYSYSTEM"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 300, 0, 180)
Main.Position = UDim2.new(0.5, -150, 0.5, -90)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "NONNOI KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = Main
KeyBox.Size = UDim2.new(0.85,0,0,40)
KeyBox.Position = UDim2.new(0.075,0,0.35,0)
KeyBox.PlaceholderText = "ENTER KEY"
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
KeyBox.ClearTextOnFocus = false

local BoxCorner = Instance.new("UICorner", KeyBox)
BoxCorner.CornerRadius = UDim.new(0,8)

local CheckButton = Instance.new("TextButton")
CheckButton.Parent = Main
CheckButton.Size = UDim2.new(0.85,0,0,40)
CheckButton.Position = UDim2.new(0.075,0,0.65,0)
CheckButton.Text = "CHECK KEY"
CheckButton.TextColor3 = Color3.fromRGB(255,255,255)
CheckButton.BackgroundColor3 = Color3.fromRGB(255,0,100)
CheckButton.Font = Enum.Font.GothamBold
CheckButton.TextSize = 18

local BtnCorner = Instance.new("UICorner", CheckButton)
BtnCorner.CornerRadius = UDim.new(0,8)

local Status = Instance.new("TextLabel")
Status.Parent = Main
Status.Size = UDim2.new(1,0,0,20)
Status.Position = UDim2.new(0,0,0.9,0)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextColor3 = Color3.fromRGB(255,255,255)
Status.Font = Enum.Font.Gotham
Status.TextSize = 14

-- ลาก UI มือถือ
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- เช็คคีย์
CheckButton.MouseButton1Click:Connect(function()
    local InputKey = tostring(KeyBox.Text):gsub("%s+", "")

    if InputKey == CorrectKey then
        Status.Text = "KEY CORRECT"
        Status.TextColor3 = Color3.fromRGB(0,255,100)

        task.wait(1)
        ScreenGui:Destroy()

        loadstring(game:HttpGet(ScriptURL))()
    else
        Status.Text = "WRONG KEY"
        Status.TextColor3 = Color3.fromRGB(255,50,50)
    end
end)
