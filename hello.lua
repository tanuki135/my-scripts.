--// Dark Hub v1 | Lite Version (Speed ON/OFF + Jump ON/OFF)
--// Place inside StarterPlayerScripts

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name = "DarkHub"
gui.ResetOnSpawn = false

-- Open Button
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0,50,0,50)
openBtn.Position = UDim2.new(0,10,1,-60)
openBtn.AnchorPoint = Vector2.new(0,1)
openBtn.Text = "Dark"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 16
openBtn.BackgroundColor3 = Color3.fromRGB(160,80,220)
openBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", openBtn)

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,300,0,350)
frame.Position = UDim2.new(0.5,-150,0.5,-175)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Visible = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.Text = "🌑 Dark Hub v1 Lite"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

-- Close
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0,0)
close.BackgroundColor3 = Color3.fromRGB(255,60,60)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
Instance.new("UICorner", close)
close.MouseButton1Click:Connect(function() frame.Visible = false end)

-- Container
local container = Instance.new("Frame", frame)
container.Size = UDim2.new(1,-20,1,-60)
container.Position = UDim2.new(0,10,0,50)
container.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0,15)

-- ボタン生成
local function newBtn(txt, fn)
	local b = Instance.new("TextButton", container)
	b.Size = UDim2.new(1,0,0,45)
	b.BackgroundColor3 = Color3.fromRGB(60,60,90)
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(fn)
	return b
end

-- Speed ON/OFF
local speedOn = false
newBtn("🏃 Speed ON / OFF", function()
	local h = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
	if not h then return end
	speedOn = not speedOn
	h.WalkSpeed = speedOn and 60 or 16
end)

-- Infinity Jump
local jumpOn = false
newBtn("🦋 Infinity Jump ON / OFF", function()
	jumpOn = not jumpOn
end)

-- Infinity Jump 処理
game:GetService("UserInputService").JumpRequest:Connect(function()
	if jumpOn and lp.Character then
		local h = lp.Character:FindFirstChildOfClass("Humanoid")
		if h then h:ChangeState("Jumping") end
	end
end)

-- Open Button Toggle
local function toggle()
	frame.Visible = not frame.Visible
end
openBtn.MouseButton1Click:Connect(toggle)
openBtn.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.Touch then toggle() end
end)
