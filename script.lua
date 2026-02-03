----------------------------------------------------------------
-- MOBILE TOPBAR UI (DRAG + CLOSE)
----------------------------------------------------------------

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local ui = Instance.new("ScreenGui")
ui.Name = "MobileFreecam"
ui.ResetOnSpawn = false
ui.Parent = PlayerGui

-- Topbar Frame
local topbar = Instance.new("Frame")
topbar.Parent = ui
topbar.Size = UDim2.fromScale(0.45, 0.12)
topbar.Position = UDim2.fromScale(0.5, 0.5) -- 🔥 tengah layar
topbar.AnchorPoint = Vector2.new(0.5, 0.5)
topbar.BackgroundColor3 = Color3.fromRGB(30,30,30)
topbar.Active = true
topbar.Draggable = true -- ✅ bisa digeser

-- Title
local title = Instance.new("TextLabel")
title.Parent = topbar
title.Size = UDim2.fromScale(0.7, 1)
title.BackgroundTransparency = 1
title.Text = "🎥 FREECAM"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

-- Close Button
local close = Instance.new("TextButton")
close.Parent = topbar
close.Size = UDim2.fromScale(0.15, 0.8)
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
