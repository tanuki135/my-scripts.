-- Dark Hub v1 | Full Features Compact GUI
local P,S,RS,UIS=game.Players,game:GetService("Players"),game:GetService("RunService"),game:GetService("UserInputService")
local plr=P.LocalPlayer
local gui=Instance.new("ScreenGui",plr:WaitForChild("PlayerGui")); gui.Name="DarkHub"

--============= 初期演出 =============
local anim=Instance.new("TextLabel",gui)
anim.Size,anim.Position,anim.AnchorPoint,anim.BackgroundTransparency=UDim2.new(0,400,0,100),UDim2.new(0.5,-200,0.5,-50),Vector2.new(0.5,0.5),1
anim.Text,anim.TextColor3,anim.TextStrokeTransparency,anim.Font,anim.TextSize,anim.Rotation,anim.TextTransparency="Dark Hub v1",Color3.fromRGB(180,0,255),0,Enum.Font.GothamBlack,40,0,1
for i=0,1,0.01 do anim.TextTransparency=1-i; anim.Position=UDim2.new(0.5,-200,0.5,-50-50*(1-i)); wait(0.05) end
for i=0,1,0.05 do anim.Rotation=360*i; anim.TextTransparency=i; wait(0.1) end
anim:Destroy()

--============= 左下開閉ボタン =============
local function btn(parent,size,pos,text)
	local b=Instance.new("TextButton",parent)
	b.Size, b.Position, b.Text, b.Font, b.TextSize, b.BackgroundColor3= size,pos,text,Enum.Font.GothamBold,14,Color3.fromRGB(40,40,40)
	Instance.new("UICorner",b)
	return b
end
local open=btn(gui,UDim2.new(0,50,0,50),UDim2.new(0,10,1,-60),"Dark"); open.AnchorPoint=Vector2.new(0,1)

--============= メインフレーム =============
local f=Instance.new("Frame",gui)
f.Size,f.Position,f.BackgroundColor3,f.Active,f.Draggable,f.Visible=UDim2.new(0,300,0,350),UDim2.new(0.5,-150,0.5,-175),Color3.fromRGB(25,25,25),true,true,false
Instance.new("UICorner",f)

-- Title & Close
local t=Instance.new("TextLabel",f); t.Size,t.Position,t.BackgroundColor3,t.Text="🌑 Dark Hub v1",Color3.fromRGB(40,40,40)
t.TextColor3,t.Font,t.TextSize=Color3.new(1,1,1),Enum.Font.GothamBold,18
Instance.new("UICorner",t).CornerRadius=UDim.new(0,12)
local close=Instance.new("TextButton",f); close.Size,close.Position,close.Text,close.Font,close.TextSize,close.BackgroundColor3=UDim2.new(0,40,0,40),UDim2.new(1,-45,0,0),"X",Enum.Font.GothamBold,16,Color3.fromRGB(255,60,60)
Instance.new("UICorner",close).CornerRadius=UDim.new(0,12)
close.MouseButton1Click:Connect(function() f.Visible=false end)
close.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then f.Visible=false end end)

-- Container
local c=Instance.new("Frame",f); c.Size,c.Position,c.BackgroundTransparency=UDim2.new(1,-20,1,-60),UDim2.new(0,10,0,50),1
local layout=Instance.new("UIListLayout",c); layout.Padding=UDim.new(0,10)

--============= ボタン/スライダー関数 =============
local function mkBtn(lbl,col,onCol,fn)
	local b=Instance.new("TextButton",c); b.Size,b.Text,b.BackgroundColor3,b.Font,b.TextSize=UDim2.new(1,0,0,40),lbl,col or Color3.fromRGB(50,50,50),Enum.Font.GothamBold,16
	Instance.new("UICorner",b)
	local state=false
	b.MouseButton1Click:Connect(function()
		state=not state; b.BackgroundColor3=state and (onCol or Color3.fromRGB(100,100,100)) or col; if fn then fn(state) end
	end)
	b.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then b:CaptureFocus() end end)
	return b
end

local function mkSldr(lbl,min,max,init,fn)
	local fr=Instance.new("Frame",c); fr.Size,fr.BackgroundTransparency=UDim2.new(1,0,0,50),1
	local l=Instance.new("TextLabel",fr); l.Size,l.Position,l.Text,l.TextColor3,l.BackgroundTransparency,l.Font,l.TextSize=UDim2.new(0.4,0,1,0),UDim2.new(0,0,0,0),lbl.." "..init,Color3.new(1,1,1),1,Enum.Font.GothamBold,14
	local bg=Instance.new("Frame",fr); bg.Size,bg.Position,bg.BackgroundColor3=UDim2.new(0.6,-10,0.3,0),UDim2.new(0.4,5,0.35,0),Color3.fromRGB(60,60,60); Instance.new("UICorner",bg)
	local h=Instance.new("Frame",bg); h.Size,h.Position,h.BackgroundColor3=UDim2.new((init-min)/(max-min),0,1,0),UDim2.new(0,0,0,0),Color3.fromRGB(180,0,255); Instance.new("UICorner",h)
	local d=false
	h.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=true end end)
	UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then d=false end end)
	UIS.InputChanged:Connect(function(i)
		if d and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			local x=math.clamp(i.Position.X-bg.AbsolutePosition.X,0,bg.AbsoluteSize.X)
			h.Size=UDim2.new(0,x,1,0)
			local v=min+(x/bg.AbsoluteSize.X)*(max-min)
			l.Text=lbl.." "..math.floor(v)
			if fn then fn(v) end
		end
	end)
	return fr
end

--============= 機能追加 =============
mkSldr("Speed",16,200,16,function(v) if plr.Character and plr.Character:FindFirstChild("Humanoid") then plr.Character.Humanoid.WalkSpeed=v end end)
mkSldr("Jump",50,300,50,function(v) if plr.Character and plr.Character:FindFirstChild("Humanoid") then plr.Character.Humanoid.JumpPower=v end end)

-- Fly
mkBtn("Fly",Color3.fromRGB(80,60,60),Color3.fromRGB(0,180,255),function(state)
	local char=plr.Character
	if not char or not char:FindFirstChildOfClass("Humanoid") then return end
	local hrp=char:FindFirstChild("HumanoidRootPart")
	if state then
		local bv=Instance.new("BodyVelocity",hrp)
		bv.MaxForce=Vector3.new(4000,4000,4000); bv.Velocity=Vector3.zero
		local conn; conn=RS.RenderStepped:Connect(function()
			if not state then conn:Disconnect() return end
			local move=Vector3.zero
			if UIS:IsKeyDown(Enum.KeyCode.W) then move+=workspace.CurrentCamera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then move-=workspace.CurrentCamera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then move-=workspace.CurrentCamera.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then move+=workspace.CurrentCamera.CFrame.RightVector end
			bv.Velocity=move*60
		end)
	else
		for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") then v:Destroy() end end
	end
end)

-- ESP
mkBtn("ESP",Color3.fromRGB(90,60,90),Color3.fromRGB(255,0,255),function(state)
	for _,p in pairs(P:GetPlayers()) do
		if p~=plr and p.Character then
			local h=p.Character:FindFirstChildOfClass("Highlight")
			if state and not h then
				local hh=Instance.new("Highlight",p.Character); hh.FillTransparency=1; hh.OutlineColor=Color3.fromRGB(255,0,255)
			elseif not state and h then h:Destroy() end
		end
	end
end)

--============= 左下開閉 =============
local function toggle() f.Visible=not f.Visible end
open.MouseButton1Click:Connect(toggle)
open.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then toggle() end end)
