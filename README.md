local UserInputService = game:GetService("UserInputService")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 60)
button.Position = UDim2.new(0, 20, 0, 20) -- угол
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.Text = ""
button.Parent = script.Parent

-- Картинка (OFF)
local image = Instance.new("ImageLabel")
image.Size = UDim2.new(1, 0, 1, 0)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://124968083551523"
image.Parent = button

-- Музыка
local sound = Instance.new("Sound")
sound.Parent = button
sound.Looped = true

-- 👉 ВСТАВЬ СВОЙ ID МУЗЫКИ СЮДА:
sound.SoundId = "rbxassetid://YOUR_MUSIC_ID_HERE"

local on = false

button.MouseButton1Click:Connect(function()
	on = not on

	if on then
		button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		image.Visible = false
		button.Text = "ON"
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.TextScaled = true

		sound:Stop()
		sound.TimePosition = 0
		sound:Play()
	else
		button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		image.Visible = true
		button.Text = ""

		sound:Stop()
	end
end)

-- =======================
-- 📌 DRAG (мышь + палец)
-- =======================

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
	if input.UserInputType == Enum.UserInputType.MouseMovement 
		or input.UserInputType == Enum.UserInputType.Touch then

		if dragging then
			local delta = input.Position - dragStart
			button.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)
