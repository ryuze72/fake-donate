-- Free Cam Mobile (Center + Draggable)
-- by joy_yepyep

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local cam = workspace.CurrentCamera

local enabled = false
local speed = 1.5
local moveDir = Vector3.zero
local lastTouchPos = nil

-- ================= UI =================
local gui = Instance.new("ScreenGui")
gui.Name = "FreeCamMobile"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.fromScale(0.45, 0.35)

-- 🔥 MUNCUL DI TENGAH
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)

frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true -- ✅ bisa digeser

-- ================= TOPBAR =================
local topbar = Instance.new("TextLabel")
topbar.Parent = frame
topbar.Size = UDim2.fromScale(1, 0.18)
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
