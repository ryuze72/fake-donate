-- Fishit Fast Fishing (Client Side)
-- by joy_yepyep

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local StarterGui = game:GetService("StarterGui")

-- ================= UI =================
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "FishitFastUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.fromScale(0.25, 0.25)
Frame.Position = UDim2.fromScale(0.37, 0.3)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Visible = false
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.fromScale(1,0.2)
Title.BackgroundTransparency = 1
Title.Text = "🎣 Fishit Fast Fishing"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true

local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.fromScale(0.8,0.2)
Toggle.Position = UDim2.fromScale(0.1,0.25)
Toggle.Text = "STATUS : OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
Toggle.TextColor3 = Color3.new(1,1,1)

local SpeedLabel = Instance.new("TextLabel", Frame)
SpeedLabel.Size = UDim2.fromScale(0.8,0.15)
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
