--// Dark Hub v1 | Stable + Features
--// Place inside StarterPlayerScripts

local Players, UIS, RS = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService")
local lp = Players.LocalPlayer

-- ScreenGui
local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
gui.Name, gui.ResetOnSpawn = "DarkHub", false

--============= Animation =============
local anim = Instance.new("TextLabel", gui)
anim.Size, anim.Position, anim.AnchorPoint, anim.BackgroundTransparency = UDim2.new(0,400,0,100), UDim2.new(0.5,-200,0.5,-50), Vector2.new(0.5,0.5), 1
anim.Text, anim.TextColor3, anim.Font, anim.TextSize, anim.TextTransparency, anim.Rotation = "Dark Hub v1", Color3.fromRGB(180,0,255), Enum.Font.GothamBlack, 40, 1, 0
local dt=0.01
for i=0,1,dt do anim.TextTransparency=1-i; anim.Position=UDim2.new(0.5,-200,0.5,-50-50*(1-i)); wait(dt) end
for i=0,1,dt do anim.Rotation=360*i; anim.TextTransparency=i; wait(dt) end
anim:Destroy()

--============= Left-Bottom Open Button =============
local function mkBtn(parent,size,pos,text)
	local b = Instance.new("TextButton", parent)
	b.Size,b.Position,b.AnchorPoint,b.Text,b.Font,b.TextSize,b.BackgroundColor3 = size,pos,Vector2.new(0,1),text,Enum.Font.GothamBold,14,Color3.fromRGB(40,40,40)
	Instance.new("UICorner", b)
	return b
end
local openBtn = mkBtn(gui, UDim2.new(0,50,0,50), UDim2.new(0,10,1,-60), "Dark")

--============= Main Frame =============
local frame = Instance.new("Frame", gui)
frame.Size, frame.Position, frame.BackgroundColor3, frame.Active, frame.Draggable, frame.Visible = UDim2.new(0,300,0,350), UDim2.new(0.5,-150,0.5,-175), Color3.fromRGB(25,25,25), true, true, false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- Title & Close
local title = Instance.new("TextLabel", frame)
title.Size, title.BackgroundColor3, title.Text, title.TextColor3, title.Font, title.TextSize = UDim2.new(1,0,0,40), Color3.fromRGB(40,40,40), "🌑 Dark Hub v1", Color3.new(1,1,1), Enum.Font.GothamBold, 18
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

local close = Instance.new("TextButton", frame)
close.Size, close.Position, close.BackgroundColor3, close.Text, close.TextColor3, close.Font, close.TextSize = UDim2.new(0,40,0,40), UDim2.new(1,-45,0,0), Color3.fromRGB(255,60,60), "X", Color3.new(1,1,1), Enum.Font.GothamBold, 16
Instance.new("UICorner", close).CornerRadius = UDim.new(0,12)
close.MouseButton1Click:Connect(function() frame.Visible = false end)
close.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then frame.Visible = false end end)

-- Container
local container = Instance.new("Frame", frame)
container.Size, container.Position, container.BackgroundTransparency = UDim2.new(1,-20,1,-60), UDim2.new(0,10,0,50), 1
local layout = Instance.new("UIListLayout", container) layout.Padding = UDim.new(0,10)

--============= Utility Functions =============
local function newBtn(txt, color, fn)
	local b = Instance.new("TextButton", container)
	b.Size, b.BackgroundColor3, b.TextColor3, b.Text = UDim2.new(1,0,0,40), color or Color3.fromRGB(50,50,50), Color3.new(1,1,1), txt
	b.Font, b.TextSize = Enum.Font.GothamBold, 16
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	b.MouseButton1Click:Connect(fn)
	return b
end

local function newSlider(lbl,min,max,init,fn)
	local fr = Instance.new("Frame", container)
	fr.Size, fr.BackgroundTransparency = UDim2.new(1,0,0,50),1
	local l = Instance.new("TextLabel", fr)
	l.Size, l.Position, l.Text, l.TextColor3, l.BackgroundTransparency, l.Font, l.TextSize = UDim2.new(0.4,0,1,0), UDim2.new(0,0,0,0), lbl.." "..init, Color3.new(1,1,1), 1, Enum.Font.GothamBold, 14
	local bg = Instance.new("Frame", fr)
	bg.Size,bg.Position,bg.BackgroundColor3 = UDim2.new(0.6,-10,0.3,0), UDim2.new(0.4,5,0.35,0), Color3.fromRGB(60,60,60)
	Instance.new("UICorner", bg)
	local h = Instance.new("Frame", bg)
	h.Size, h.Position, h.BackgroundColor3 = UDim2.new((init-min)/(max-min),0,1,0), UDim2.new(0,0,0,0), Color3.fromRGB(180,0,255)
	Instance.new("UICorner", h)
	local dragging=false
	h.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true end end)
	UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
	UIS.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			local x = math.clamp(i.Position.X - bg.AbsolutePosition.X,0,bg.AbsoluteSize.X)
			h.Size = UDim2.new(0,x,1,0)
			local v = min + (x/bg.AbsoluteSize.X)*(max-min)
			l.Text = lbl.." "..math.floor(v)
			if fn then fn(v) end
		end
	end)
	return fr
end

--============= Features =============
-- Speed
newSlider("Speed",16,200,16,function(v)
	local h = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
	if h then h.WalkSpeed = v end
end)

-- Jump
newSlider("Jump",50,300,50,function(v)
	local h = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
	if h then h.JumpPower = v end
end)

-- Fly
local flying, flyConn
newBtn("🚀 Fly", Color3.fromRGB(80,60,60), function()
	local char = lp.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	if not flying then
		flying = true
		local bv = Instance.new("BodyVelocity", hrp)
		bv.Name, bv.MaxForce, bv.Velocity = "DarkHubFly", Vector3.new(4000,4000,4000), Vector3.zero
		flyConn = RS.RenderStepped:Connect(function()
			if not flying then flyConn:Disconnect() return end
			local v = Vector3.zero
			if UIS:IsKeyDown(Enum.KeyCode.W) then v += workspace.CurrentCamera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then v -= workspace.CurrentCamera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then v -= workspace.CurrentCamera.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then v += workspace.CurrentCamera.CFrame.RightVector end
			bv.Velocity = v * 60
		end)
	else
		flying = false
		if flyConn then flyConn:Disconnect() end
		for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") and v.Name=="DarkHubFly" then v:Destroy() end end
	end
end)

-- ESP
local highlights = {}
local espEnabled = false
newBtn("🔍 ESP", Color3.fromRGB(90,60,90), function()
	espEnabled = not espEnabled
	for _,p in ipairs(Players:GetPlayers()) do
		if p~=lp and p.Character then
			if espEnabled then
				if not highlights[p] then
					local h = Instance.new("Highlight", p.Character)
					h.FillTransparency, h.OutlineColor = 1, Color3.fromRGB(255,0,255)
					highlights[p] = h
				end
			elseif highlights[p] then
				highlights[p]:Destroy()
				highlights[p] = nil
			end
		end
	end
end)

--============= Left-Bottom Open/Close =============
local function toggle() frame.Visible = not frame.Visible end
openBtn.MouseButton1Click:Connect(toggle)
openBtn.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then toggle() end end)
