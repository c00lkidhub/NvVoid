local UserInputService = game:GetService("UserInputService")

local player = game.Players.LocalPlayer

-- GUI контейнер (ВАЖНО)
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = true

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 60)
button.Position = UDim2.new(0, 20, 0, 20)
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.Text = ""
button.Parent = gui
button.ZIndex = 2

-- Картинка
local image = Instance.new("ImageLabel")
image.Size = UDim2.new(1, 0, 1, 0)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://124968083551523"
image.Parent = button
image.ZIndex = 3

-- ЗВУК
local sound = Instance.new("Sound")
sound.Parent = button
sound.Looped = true

-- 👉 ВСТАВЬ СВОЙ ID МУЗЫКИ:
sound.SoundId = "rbxassetid://18841898522"
sound.Volume = 1

local on = false

button.MouseButton1Click:Connect(function()
	on = not on

	if on then
		button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		image.Visible = false
		button.Text = "ON"
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.TextScaled = true

		sound.TimePosition = 0
		sound:Play()
	else
		button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		image.Visible = true
		button.Text = ""
		sound:Stop()
	end
end)

-- DRAG
local dragging = false
local dragStart
local startPos

button.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = button.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

button.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then

		local delta = input.Position - dragStart
		button.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
