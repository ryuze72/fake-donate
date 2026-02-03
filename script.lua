-- Free Cam Mobile (Touch)
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
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "FreeCamMobile"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.45, 0.35)
frame.Position = UDim2.fromScale(0.05, 0.55)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1,0.2)
title.BackgroundTransparency = 1
title.Text = "🎥 Free Cam Mobile"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.fromScale(0.8,0.2)
toggle.Position = UDim2.fromScale(0.1,0.25)
toggle.Text = "FREECAM : OFF"

local function makeBtn(txt, x, y)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.fromScale(0.35,0.15)
	b.Position = UDim2.fromScale(x,y)
	b.Text = txt
	return b
end

local forward = makeBtn("↑", 0.1, 0.5)
local back = makeBtn("↓", 0.55, 0.5)
local up = makeBtn("⬆", 0.1, 0.7)
local down = makeBtn("⬇", 0.55, 0.7)

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
bind(back, Vector3.new(0,0,1))
bind(up, Vector3.new(0,1,0))
bind(down, Vector3.new(0,-1,0))

-- ================= TOUCH LOOK =================
UIS.TouchMoved:Connect(function(touch, gpe)
	if not enabled then return end
	if not lastTouchPos then
		lastTouchPos = touch.Position
		return
	end

	local delta = touch.Position - lastTouchPos
	lastTouchPos = touch.Position

	local rotX = -delta.Y * 0.002
	local rotY = -delta.X * 0.002

	cam.CFrame = cam.CFrame * CFrame.Angles(rotX, rotY, 0)
end)

UIS.TouchEnded:Connect(function()
	lastTouchPos = nil
end)

-- ================= MOVE LOOP =================
RunService.RenderStepped:Connect(function(dt)
	if enabled and moveDir.Magnitude > 0 then
		cam.CFrame = cam.CFrame + cam.CFrame:VectorToWorldSpace(moveDir * speed)
	end
end)SpeedLabel.Size = UDim2.fromScale(0.8,0.15)
SpeedLabel.Position = UDim2.fromScale(0.1,0.5)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.new(1,1,1)
SpeedLabel.Text = "Speed : 1x"

local SpeedUp = Instance.new("TextButton", Frame)
SpeedUp.Size = UDim2.fromScale(0.35,0.15)
SpeedUp.Position = UDim2.fromScale(0.1,0.7)
SpeedUp.Text = "+"
SpeedUp.BackgroundColor3 = Color3.fromRGB(80,80,80)
SpeedUp.TextColor3 = Color3.new(1,1,1)

local SpeedDown = Instance.new("TextButton", Frame)
SpeedDown.Size = UDim2.fromScale(0.35,0.15)
SpeedDown.Position = UDim2.fromScale(0.55,0.7)
SpeedDown.Text = "-"
SpeedDown.BackgroundColor3 = Color3.fromRGB(80,80,80)
SpeedDown.TextColor3 = Color3.new(1,1,1)

-- ================= TOPBAR =================
StarterGui:SetCore("SendNotification", {
	Title = "Fishit Script",
	Text = "Klik ikon Backpack untuk buka/tutup UI",
	Duration = 5
})

-- ================= LOGIC =================
local Enabled = false
local Speed = 1

Toggle.MouseButton1Click:Connect(function()
	Enabled = not Enabled
	Toggle.Text = Enabled and "STATUS : ON" or "STATUS : OFF"
end)

SpeedUp.MouseButton1Click:Connect(function()
	Speed = math.clamp(Speed + 0.5, 1, 10)
	SpeedLabel.Text = "Speed : "..Speed.."x"
end)

SpeedDown.MouseButton1Click:Connect(function()
	Speed = math.clamp(Speed - 0.5, 1, 10)
	SpeedLabel.Text = "Speed : "..Speed.."x"
end)

-- ================= FAST FISHING CORE =================
task.spawn(function()
	while task.wait(0.1) do
		if Enabled then
			-- Contoh percepatan (umum dipakai)
			pcall(function()
				game:GetService("Players").LocalPlayer:SetAttribute("FishingSpeed", Speed)
			end)
		end
	end
end)

-- ================= TOGGLE UI =================
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.B then
		Frame.Visible = not Frame.Visible
	end
end)
