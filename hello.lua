print("Hello from GitHub!")

local gui = Instance.new("ScreenGui")
gui.Name = "HelloGui"
gui.Parent = game:GetService("CoreGui")

local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0, 200, 0, 50)
label.Position = UDim2.new(0.5, -100, 0.1, 0)
label.Text = "Hello from GitHub!"
label.BackgroundColor3 = Color3.new(0, 0, 0)
label.TextColor3 = Color3.new(1, 1, 1)