-- Free Cam GUI + Control
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

--------------------------------------------------
-- GUI
--------------------------------------------------
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "FreeCamGUI"
gui.ResetOnSpawn = false

-- Topbar
local topbar = Instance.new("Frame", gui)
topbar.Size = UDim2.new(0, 200, 0, 35)
topbar.Position = UDim2.new(0.4, 0, 0.05, 0)
topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topbar.Active = true
topbar.Draggable = true

local title = Instance.new("TextLabel", topbar)
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = "FREE CAM"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- Popup
local popup = Instance.new("Frame", gui)
popup.Size = UDim2.new(0, 220, 0, 180)
popup.Position = UDim2.new(0.4, 0, 0.12, 0)
popup.BackgroundColor3 = Color3.fromRGB(40,40,40)
popup.Visible = false

local toggleBtn = Instance.new("TextButton", popup)
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.Text = "Free Cam : OFF"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)

--------------------------------------------------
-- Control Buttons
--------------------------------------------------
local function makeBtn(txt, pos)
	local b = Instance.new("TextButton", popup)
	b.Size = UDim2.new(0, 40, 0, 40)
	b.Position = pos
	b.Text = txt
	b.Font = Enum.Font.SourceSansBold
	b.TextSize = 20
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(70,70,70)
	b.Visible = false
	return b
end

-- kiri (gerak)
local forward = makeBtn("⬆", UDim2.new(0, 40, 0, 70))
local back    = makeBtn("⬇", UDim2.new(0, 40, 0, 120))
local left    = makeBtn("⬅", UDim2.new(0, 0, 0, 95))
local right   = makeBtn("➡", UDim2.new(0, 80, 0, 95))

-- kanan (naik turun)
local up   = makeBtn("⬆", UDim2.new(0, 150, 0, 80))
local down = makeBtn("⬇", UDim2.new(0, 150, 0, 120))

--------------------------------------------------
-- Free Cam Logic
--------------------------------------------------
local freecam = false
local camCF
local speed = 1

local move = {
	F = 0, B = 0, L = 0, R = 0, U = 0, D = 0
}

local function updateCam()
	if not freecam then return end

	local dir =
		(camera.CFrame.LookVector * (move.F - move.B)) +
		(camera.CFrame.RightVector * (move.R - move.L)) +
		(Vector3.new(0,1,0) * (move.U - move.D))

	camCF = camCF + dir * speed
	camera.CFrame = camCF
end

RunService.RenderStepped:Connect(updateCam)

--------------------------------------------------
-- Button Hold
--------------------------------------------------
local function hold(btn, key)
	btn.MouseButton1Down:Connect(function()
		move[key] = 1
	end)
	btn.MouseButton1Up:Connect(function()
		move[key] = 0
	end)
end

hold(forward,"F")
hold(back,"B")
hold(left,"L")
hold(right,"R")
hold(up,"U")
hold(down,"D")

--------------------------------------------------
-- Toggle
--------------------------------------------------
toggleBtn.MouseButton1Click:Connect(function()
	freecam = not freecam

	if freecam then
		toggleBtn.Text = "Free Cam : ON"
		camera.CameraType = Enum.CameraType.Scriptable
		camCF = camera.CFrame

		for _,v in ipairs(popup:GetChildren()) do
			if v:IsA("TextButton") and v ~= toggleBtn then
				v.Visible = true
			end
		end
	else
		toggleBtn.Text = "Free Cam : OFF"
		camera.CameraType = Enum.CameraType.Custom

		for _,v in ipairs(popup:GetChildren()) do
			if v:IsA("TextButton") and v ~= toggleBtn then
				v.Visible = false
			end
		end
	end
end)

--------------------------------------------------
-- Open Popup
--------------------------------------------------
topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		popup.Visible = not popup.Visible
	end
end)close.Size = UDim2.fromScale(0.15, 0.8)
close.Position = UDim2.fromScale(0.85, 0.1)
close.Text = "✕"
close.TextScaled = true
close.BackgroundColor3 = Color3.fromRGB(120,30,30)
close.TextColor3 = Color3.new(1,1,1)

-- Toggle Button
local toggle = Instance.new("TextButton")
toggle.Parent = ui
toggle.Size = UDim2.fromScale(0.3, 0.1)
toggle.Position = UDim2.fromScale(0.35, 0.63)
toggle.Text = "FREECAM : OFF"
toggle.TextScaled = true
toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggle.TextColor3 = Color3.new(1,1,1)

-- Bind ke Freecam script kamu
local enabled = false
local toggleEvent = Instance.new("BindableEvent")
toggleEvent.Name = "Toggle"
toggleEvent.Parent = ui

-- Toggle logic
toggle.MouseButton1Click:Connect(function()
	enabled = not enabled
	toggle.Text = enabled and "FREECAM : ON" or "FREECAM : OFF"
	toggleEvent:Fire(enabled)
end)

-- Close UI
close.MouseButton1Click:Connect(function()
	ui.Enabled = false
end)topbar.Size = UDim2.fromScale(1, 0.18)
topbar.BackgroundColor3 = Color3.fromRGB(45,45,45)
topbar.Text = "🎥 Free Cam Mobile"
topbar.TextColor3 = Color3.new(1,1,1)
topbar.TextScaled = true

-- ================= BUTTON =================
local toggle = Instance.new("TextButton")
toggle.Parent = frame
toggle.Size = UDim2.fromScale(0.8, 0.18)
toggle.Position = UDim2.fromScale(0.1, 0.25)
toggle.Text = "FREECAM : OFF"

local function makeBtn(txt, x, y)
	local b = Instance.new("TextButton")
	b.Parent = frame
	b.Size = UDim2.fromScale(0.35, 0.15)
	b.Position = UDim2.fromScale(x, y)
	b.Text = txt
	return b
end

local forward = makeBtn("↑", 0.1, 0.5)
local back    = makeBtn("↓", 0.55, 0.5)
local up      = makeBtn("⬆", 0.1, 0.7)
local down    = makeBtn("⬇", 0.55, 0.7)

-- ================= LOGIC =================
toggle.MouseButton1Click:Connect(function()
	enabled = not enabled
	toggle.Text = enabled and "FREECAM : ON" or "FREECAM : OFF"

	if enabled then
		cam.CameraType = Enum.CameraType.Scriptable
	else
		cam.CameraType = Enum.CameraType.Custom
	end
end)

local function bind(btn, vec)
	btn.MouseButton1Down:Connect(function()
		moveDir = vec
	end)
	btn.MouseButton1Up:Connect(function()
		moveDir = Vector3.zero
	end)
end

bind(forward, Vector3.new(0,0,-1))
bind(back,    Vector3.new(0,0, 1))
bind(up,      Vector3.new(0,1, 0))
bind(down,    Vector3.new(0,-1,0))

-- ================= TOUCH LOOK =================
UIS.TouchMoved:Connect(function(touch, gpe)
	if not enabled then return end
	if not lastTouchPos then
		lastTouchPos = touch.Position
		return
	end

	local delta = touch.Position - lastTouchPos
	lastTouchPos = touch.Position

	cam.CFrame = cam.CFrame * CFrame.Angles(
		-delta.Y * 0.002,
		-delta.X * 0.002,
		0
	)
end)

UIS.TouchEnded:Connect(function()
	lastTouchPos = nil
end)

-- ================= MOVE LOOP =================
RunService.RenderStepped:Connect(function()
	if enabled and moveDir.Magnitude > 0 then
		cam.CFrame = cam.CFrame + cam.CFrame:VectorToWorldSpace(moveDir * speed)
	end
end)
