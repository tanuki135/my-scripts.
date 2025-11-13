--// Dark Hub v1 | Stable + Sliders + Drag + Safe Startup
--// Place inside StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local lp = Players.LocalPlayer

--============= Load Animation (unchanged) =============
do
	local anim = Instance.new("TextLabel", lp:WaitForChild("PlayerGui"))
	anim.Size = UDim2.new(0,400,0,100)
	anim.Position = UDim2.new(0.5,-200,0.5,-50)
	anim.AnchorPoint = Vector2.new(0.5,0.5)
	anim.BackgroundTransparency = 1
	anim.Text = "Dark Hub v1"
	anim.TextColor3 = Color3.fromRGB(180,0,255)
	anim.Font = Enum.Font.GothamBlack
	anim.TextSize = 40
	anim.TextTransparency = 1
	anim.Rotation = 0

	local dt = 0.01
	for i = 0, 1, dt do
		anim.TextTransparency = 1-i
		anim.Position = UDim2.new(0.5,-200,0.5,-50-50*(1-i))
		wait(dt)
	end
	for i = 0,1,dt do
		anim.Rotation = 360*i
		anim.TextTransparency = i
		wait(dt)
	end
	anim:Destroy()
end

--============= ScreenGui (single creation) =============
local gui = Instance.new("ScreenGui")
gui.Name = "DarkHub"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

--============= Left-Bottom Open Button =============
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

local function buttonPressAnim(button)
	button:TweenSize(UDim2.new(0,45,0,45),"Out","Quad",0.1,true)
	wait(0.1)
	button:TweenSize(UDim2.new(0,50,0,50),"Out","Quad",0.1,true)
end

--============= Main Frame =============
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,300,0,400)
frame.Position = UDim2.new(0.5,-150,0.5,-200)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Visible = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- Title & Close
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.Text = "🌑 Dark Hub v1"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0,0)
close.BackgroundColor3 = Color3.fromRGB(255,60,60)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
Instance.new("UICorner", close).CornerRadius = UDim.new(0,12)
close.MouseButton1Click:Connect(function() frame.Visible = false end)
close.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then frame.Visible = false end end)

--============= Title Drag Only =============
local dragging = false
local dragStart, startPos
title.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState==Enum.UserInputState.End then dragging=false end
		end)
	end
end)
title.InputChanged:Connect(function(input)
	if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
end)

--============= Container & Layout =============
local container = Instance.new("Frame", frame)
container.Size = UDim2.new(1,-20,1,-60)
container.Position = UDim2.new(0,10,0,50)
container.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0,10)

--============= Utility Functions =============
local function newBtn(txt,color,fn)
	local b = Instance.new("TextButton", container)
	b.Size = UDim2.new(1,0,0,40)
	b.BackgroundColor3 = color or Color3.fromRGB(50,50,50)
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	b.MouseButton1Click:Connect(fn)
	return b
end

local function newSlider(lbl,min,max,init,fn)
	local fr = Instance.new("Frame", container)
	fr.Size = UDim2.new(1,0,0,50)
	fr.BackgroundTransparency = 1
	local l = Instance.new("TextLabel", fr)
	l.Size = UDim2.new(0.4,0,1,0)
	l.Position = UDim2.new(0,0,0,0)
	l.Text = lbl.." "..init
	l.TextColor3 = Color3.new(1,1,1)
	l.BackgroundTransparency = 1
	l.Font = Enum.Font.GothamBold
	l.TextSize = 14
	local bg = Instance.new("Frame", fr)
	bg.Size = UDim2.new(0.6,-10,0.3,0)
	bg.Position = UDim2.new(0.4,5,0.35,0)
	bg.BackgroundColor3 = Color3.fromRGB(60,60,60)
	Instance.new("UICorner", bg)
	local h = Instance.new("Frame", bg)
	h.Size = UDim2.new((init-min)/(max-min),0,1,0)
	h.Position = UDim2.new(0,0,0,0)
	h.BackgroundColor3 = Color3.fromRGB(180,0,255)
	Instance.new("UICorner", h)

	local draggingSlider=false
	h.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			draggingSlider=true
			frame.Draggable=false
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			draggingSlider=false
			frame.Draggable=true
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if draggingSlider and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			local x = math.clamp(i.Position.X - bg.AbsolutePosition.X,0,bg.AbsoluteSize.X)
			h.Size = UDim2.new(0,x,1,0)
			local v = min + (x/bg.AbsoluteSize.X)*(max-min)
			l.Text = lbl.." "..math.floor(v)
			if fn then fn(v) end
		end
	end)
	return fr
end

--============= Speed / Jump =============
local speedSlider
local speedBtn = newBtn("🏃 Speed Boost", Color3.fromRGB(60,60,90), function()
	local h = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
	if not h then return end
	if speedSlider then
		speedSlider:Destroy()
		speedSlider=nil
		h.WalkSpeed=16
	else
		speedSlider=newSlider("Speed",16,200,h.WalkSpeed or 16,function(v) h.WalkSpeed=v end)
	end
end)

local jumpSlider
local jumpBtn = newBtn("🦋 Infinity Jump", Color3.fromRGB(60,90,60), function()
	local h = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
	if not h then return end
	if jumpSlider then
		jumpSlider:Destroy()
		jumpSlider=nil
		h.JumpPower=50
	else
		jumpSlider=newSlider("Jump",50,300,h.JumpPower or 50,function(v) h.JumpPower=v end)
	end
end)

--============= Fly / ESP =============
local flying, flyConn
newBtn("🚀 Fly", Color3.fromRGB(80,60,60), function()
	local char = lp.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	if not flying then
		flying=true
		local bv=Instance.new("BodyVelocity",hrp)
		bv.Name="DarkHubFly"
		bv.MaxForce=Vector3.new(4000,4000,4000)
		bv.Velocity=Vector3.zero
		flyConn=RS.RenderStepped:Connect(function()
			local v=Vector3.zero
			if UIS:IsKeyDown(Enum.KeyCode.W) then v+=workspace.CurrentCamera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then v-=workspace.CurrentCamera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then v-=workspace.CurrentCamera.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then v+=workspace.CurrentCamera.CFrame.RightVector end
			bv.Velocity=v*60
		end)
	else
		flying=false
		if flyConn then flyConn:Disconnect() end
		for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") and v.Name=="DarkHubFly" then v:Destroy() end end
	end
end)

local highlights = {}
local espEnabled=false
newBtn("🔍 ESP", Color3.fromRGB(90,60,90), function()
	espEnabled = not espEnabled
	for _,p in ipairs(Players:GetPlayers()) do
		if p~=lp and p.Character then
			if espEnabled then
				if not highlights[p] then
					local h=Instance.new("Highlight",p.Character)
					h.FillTransparency, h.OutlineColor=1,Color3.fromRGB(255,0,255)
					highlights[p]=h
				end
			elseif highlights[p] then
				highlights[p]:Destroy()
				highlights[p]=nil
			end
		end
	end
end)

--============= Open/Close Toggle =============
local function toggle()
	frame.Visible = not frame.Visible
	frame:TweenPosition(frame.Position,"Out","Quad",0.2,true)
end
openBtn.MouseButton1Click:Connect(function()
	buttonPressAnim(openBtn)
	toggle()
end)
openBtn.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.Touch then
		buttonPressAnim(openBtn)
		toggle()
	end
end)
