-- Hello there!!!

-- There will be plenty of notes for you to understand how to add things and the github also
-- gives instructions on how to add things like toggles, functions, etc.

-- Most of the stuff like references or main gui stuff you dont need to really worry about
-- unless you plan on modifying them to your liking (specifically main gui stuff)

-- I RECOMMENED READING THROUGH THE NOTES AND SCRIPT IN GENERAL, LUAU IS VERY EASY TO READ.

-- Help:
-- + Use 'CTRL + F' and lookup "Example", this can help with changing the gui name to whatever you want it to be.
-- + Make sure to read mostly ALL the notes as I go into detail on how to modify it to your liking, especially
-- when you get to adding your own things like toggles, buttons, etc.
-- + feel free to join my discord server where I make guis for roblox, discord.gg/vellumscripts (or https://discord.gg/bjuC8z97qj if vanity is gone)
-- + To change the keybind to open the gui, use "CTRL + F" and search "Enum.KeyCode.RightShift", change "RightShift"
-- to whatever you want the keybind to me (numbers will be formated in letters btw (Example: 0 = Zero, 1 = One))

-- Developer [@cytrixgt]
-- Discord [discord.gg/vellumscripts]

local cloneRef = (typeof(cloneref) == "function" and cloneref) or function(v) return v end
local players = game:GetService("Players")
local coregui = game:GetService("CoreGui")
local userinputservice = game:GetService("UserInputService")
local tweenservice = game:GetService("TweenService")
local runservice = game:GetService("RunService")
local localizationService = game:GetService("LocalizationService")
local camera = cloneRef(workspace.CurrentCamera)

-- Basic info, mainly need to only change the 'Version' text
local player = players.LocalPlayer
local version = "1.0.0"
local currenttab = "Info"

-- Feel free to just add different fonts if you want, but this font goes on EVERY text.
local globalfont = Enum.Font.BuilderSansBold

-- To make your own themes, its kinda obvious but make it JUST like the premade "Default"
-- and the premade "Rainbow" themes.
local activeTheme = "Default"
local themes = {
	["Default"] = {
		Background = Color3.fromRGB(25, 25, 25),
		NavBackground = Color3.fromRGB(20, 20, 20),
		CardBackground = Color3.fromRGB(50, 50, 50),
		Accent = Color3.fromRGB(100, 100, 100),
		Stroke = Color3.fromRGB(0, 0, 0),
		TextHeader = Color3.fromRGB(150, 150, 150),
		TextMain = Color3.fromRGB(220, 215, 230),
		ButtonBg = Color3.fromRGB(75, 75, 75),
		ButtonActive = Color3.fromRGB(50, 50, 50),
		InputBg = Color3.fromRGB(100, 100, 100),
	},
	["Rainbow"] = { 
		Background = Color3.fromRGB(15, 15, 15),
		NavBackground = Color3.fromRGB(20, 20, 20),
		CardBackground = Color3.fromRGB(25, 25, 25),
		Accent = Color3.fromRGB(255, 0, 0),
		Stroke = Color3.fromRGB(100, 100, 100),
		TextHeader = Color3.fromRGB(150, 150, 150),
		TextMain = Color3.fromRGB(230, 230, 230),
		ButtonBg = Color3.fromRGB(35, 35, 35),
		ButtonActive = Color3.fromRGB(50, 50, 50),
		InputBg = Color3.fromRGB(28, 28, 28),
	},
}

-- You can ignore this unless you would like to modify it.
-- Below this is for the loading gui, feel free to change things too in this like the color and size.
local screengui = Instance.new("ScreenGui")
screengui.Name = "ExampleGui"
screengui.ResetOnSpawn = false
pcall(function() screengui.Parent = coregui end)
if not screengui.Parent then screengui.Parent = player:WaitForChild("PlayerGui") end

local loadgui = Instance.new("ScreenGui")
loadgui.Name = "ExampleLoader"
loadgui.ResetOnSpawn = false
pcall(function() loadgui.Parent = coregui end)
if not loadgui.Parent then loadgui.Parent = player:WaitForChild("PlayerGui") end

local loadframe = Instance.new("Frame")
loadframe.Size = UDim2.new(0, 320, 0, 180)
loadframe.Position = UDim2.new(0.5, -160, 0.5, -90)
loadframe.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loadframe.BorderSizePixel = 0
loadframe.Transparency = 0.2
loadframe.Parent = loadgui
Instance.new("UICorner", loadframe).CornerRadius = UDim.new(0, 10)

local loadtitle = Instance.new("TextLabel")
loadtitle.Size = UDim2.new(1, 0, 0, 40)
loadtitle.Position = UDim2.new(0, 0, 0, 30)
loadtitle.BackgroundTransparency = 1
loadtitle.Text = "EXAMPLE GUI"
loadtitle.TextColor3 = Color3.fromRGB(240, 235, 255)
loadtitle.Font = globalfont
loadtitle.TextSize = 20
loadtitle.Parent = loadframe

local loadstatus = Instance.new("TextLabel")
loadstatus.Size = UDim2.new(1, 0, 0, 20)
loadstatus.Position = UDim2.new(0, 0, 0, 75)
loadstatus.BackgroundTransparency = 1
loadstatus.Text = "Launching..."
loadstatus.TextColor3 = Color3.fromRGB(150, 150, 150)
loadstatus.Font = globalfont
loadstatus.TextSize = 14
loadstatus.Parent = loadframe

local barbg = Instance.new("Frame")
barbg.Size = UDim2.new(1, -60, 0, 6)
barbg.Position = UDim2.new(0, 30, 0, 115)
barbg.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
barbg.BorderSizePixel = 0
barbg.Parent = loadframe
Instance.new("UICorner", barbg).CornerRadius = UDim.new(1, 0)

local barfill = Instance.new("Frame")
barfill.Size = UDim2.new(0, 0, 1, 0)
barfill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barfill.BorderSizePixel = 0
barfill.Parent = barbg
Instance.new("UICorner", barfill).CornerRadius = UDim.new(1, 0)

screengui.Enabled = false

-- When the gui is loading, these texts will pop up in which you can make them say anything
task.spawn(function()
	local phases = {
		{t = "Example1", p = 0.25},
		{t = "Example2", p = 0.55},
		{t = "Example3", p = 0.85},
		{t = "Example4", p = 1.00}
	}
	for _, phase in ipairs(phases) do
		task.wait(0.3)
		loadstatus.Text = phase.t
		tweenservice:Create(barfill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(phase.p, 0, 1, 0)}):Play()
	end
	task.wait(0.2)
	tweenservice:Create(loadframe, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1}):Play()
	tweenservice:Create(loadtitle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
	tweenservice:Create(loadstatus, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
	tweenservice:Create(barbg, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
	tweenservice:Create(barfill, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
	task.wait(0.3)
	loadgui:Destroy()
	screengui.Enabled = true
end)

local notificationGui = Instance.new("ScreenGui")
notificationGui.Name = "ExampleNotifications"
notificationGui.ResetOnSpawn = false
pcall(function() notificationGui.Parent = coregui end)
if not notificationGui.Parent then notificationGui.Parent = player:WaitForChild("PlayerGui") end


-- This is the function to show the notifications.
local function showNotification()
	local currentCfg = themes[activeTheme]
	local notifFrame = Instance.new("Frame")
	notifFrame.Size = UDim2.new(0, 240, 0, 65)
	notifFrame.Position = UDim2.new(1, 30, 1, -80)
	notifFrame.BackgroundColor3 = currentCfg.NavBackground
	notifFrame.BorderSizePixel = 0
	notifFrame.Parent = notificationGui
	Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 8)

	local notifStroke = Instance.new("UIStroke")
	notifStroke.Thickness = 1
	notifStroke.Color = currentCfg.Accent
	notifStroke.Parent = notifFrame

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -20, 0, 25)
	title.Position = UDim2.new(0, 10, 0, 5)
	title.BackgroundTransparency = 1
	title.Text = "GUI HIDDEN"
	title.TextColor3 = currentCfg.TextHeader
	title.Font = globalfont
	title.TextSize = 15
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = notifFrame

	local desc = Instance.new("TextLabel")
	desc.Size = UDim2.new(1, -20, 0, 30)
	desc.Position = UDim2.new(0, 10, 0, 26)
	desc.BackgroundTransparency = 1
	desc.Text = "Press [Right Shift] to reopen the GUI."
	desc.TextColor3 = currentCfg.TextMain
	desc.Font = globalfont
	desc.TextSize = 14
	desc.TextWrapped = true
	desc.TextXAlignment = Enum.TextXAlignment.Left
	desc.Parent = notifFrame

	tweenservice:Create(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -260, 1, -80)}):Play()

	task.delay(3.5, function()
		local closeTween = tweenservice:Create(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 30, 1, -80)})
		closeTween:Play()
		closeTween.Completed:Wait()
		notifFrame:Destroy()
	end)
end

-- Basic GUI Framework, modify the "basewindow.Size" to change the width/length ("600 = Width" "400 = Height")
local basewindow = Instance.new("Frame")
basewindow.Size = UDim2.new(0, 600, 0, 400)
basewindow.Position = UDim2.new(0.5, -300, 0.5, -200)
basewindow.BackgroundColor3 = themes[activeTheme].Background
basewindow.BorderSizePixel = 0
basewindow.Active = true
basewindow.Parent = screengui
basewindow.Transparency = 0
Instance.new("UICorner", basewindow).CornerRadius = UDim.new(0, 12)

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundTransparency = 1
header.Active = true
header.ZIndex = 3
header.Parent = basewindow

local brandtitle = Instance.new("TextLabel")
brandtitle.Size = UDim2.new(0, 300, 1, 0)
brandtitle.Position = UDim2.new(0, 18, 0, 0)
brandtitle.BackgroundTransparency = 1
brandtitle.Text = "PLACEHOLDER"
brandtitle.TextColor3 = Color3.fromRGB(240, 235, 255)
brandtitle.Font = globalfont
brandtitle.TextSize = 34
brandtitle.TextScaled = false
brandtitle.TextXAlignment = Enum.TextXAlignment.Left
brandtitle.ZIndex = 3
brandtitle.Parent = header

local exitbtn = Instance.new("TextButton")
exitbtn.Size = UDim2.new(0, 28, 0, 28)
exitbtn.Position = UDim2.new(1, -36, 0.5, -14)
exitbtn.BackgroundColor3 = themes[activeTheme].InputBg
exitbtn.Text = "X"
exitbtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitbtn.Font = globalfont
exitbtn.TextSize = 22
exitbtn.ZIndex = 3
exitbtn.Parent = header

-- Notification function.
exitbtn.MouseButton1Click:Connect(function() 
	screengui.Enabled = false 
	showNotification()
end)
Instance.new("UICorner", exitbtn).CornerRadius = UDim.new(0, 6)

local running = true
local toggleConnection
toggleConnection = userinputservice.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.RightShift and running then
		screengui.Enabled = not screengui.Enabled
		showNotification()
	end
end)

-- Dragging function
local dragging, draginput, dragstart, startpos
header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragstart = input.Position;
		startpos = basewindow.Position
		input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
	end
end)
header.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then draginput = input end end)
userinputservice.InputChanged:Connect(function(input)
	if input == draginput and dragging then
		local delta = input.Position - dragstart
		basewindow.Position = UDim2.new(startpos.X.Scale, startpos.X.Offset + delta.X, startpos.Y.Scale, startpos.Y.Offset + delta.Y)
	end
end)

local navdeck = Instance.new("Frame")
navdeck.Size = UDim2.new(1, -28, 0, 36)
navdeck.Position = UDim2.new(0, 14, 0, 42)
navdeck.BackgroundColor3 = themes[activeTheme].NavBackground
navdeck.ZIndex = 2
navdeck.Parent = basewindow
navdeck.Transparency = 0
Instance.new("UICorner", navdeck).CornerRadius = UDim.new(0, 8)

local navlist = Instance.new("UIListLayout")
navlist.FillDirection = Enum.FillDirection.Horizontal
navlist.Padding = UDim.new(0, 6)
navlist.HorizontalAlignment = Enum.HorizontalAlignment.Left
navlist.VerticalAlignment = Enum.VerticalAlignment.Center
navlist.Parent = navdeck
Instance.new("UIPadding", navdeck).PaddingLeft = UDim.new(0, 8)

local viewport = Instance.new("Frame")
viewport.Size = UDim2.new(1, -28, 1, -94)
viewport.Position = UDim2.new(0, 14, 0, 84)
viewport.BackgroundTransparency = 1
viewport.ZIndex = 2
viewport.Parent = basewindow

local pages = {}
local cardsList = {}
local registeredToggles = {}
local registeredButtons = {}
local registeredTextBoxes = {}
local registeredLabels = {}
local registeredDropdowns = {}
local activenavbuttons = {}

-- Function to create pages
local function createpage(name)
	local p = Instance.new("Frame")
	p.Size = UDim2.new(1, 0, 1, 0)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 2
	p.Parent = viewport
	pages[name] = p

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 95, 1, -8)
	btn.BackgroundColor3 = (name == currenttab) and themes[activeTheme].ButtonActive or themes[activeTheme].InputBg
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(240, 235, 255)
	btn.Font = globalfont
	btn.TextSize = 15
	btn.ZIndex = 3
	btn.Parent = navdeck
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	btn.MouseButton1Click:Connect(function()
		currenttab = name
		for pName, pageFrame in pairs(pages) do
			pageFrame.Visible = (pName == name)
		end
		for bName, navBtn in pairs(activenavbuttons) do
			navBtn.BackgroundColor3 = (bName == name) and themes[activeTheme].ButtonActive or themes[activeTheme].InputBg
		end
	end)

	activenavbuttons[name] = btn
	if name == currenttab then p.Visible = true end
	return p
end

-- List of pages to create (This includes the button to go to the page and the page itself.)
local infopage = createpage("Info")
local example1page = createpage("Example1")
local example2page = createpage("Example2")
local example3page = createpage("Example3")
local settingspage = createpage("Settings")

-- Function to create cards.
local function createcard(parent, title, size, pos)
	local currentCfg = themes[activeTheme]
	local card = Instance.new("Frame")
	card.Size = size
	card.Transparency = 0
	card.Position = pos or UDim2.new(0,0,0,0)
	card.BackgroundColor3 = currentCfg.CardBackground
	card.BorderSizePixel = 0
	card.ZIndex = 2
	card.Parent = parent
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
	table.insert(cardsList, card)

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -24, 0, 28)
	lbl.Position = UDim2.new(0, 12, 0, 6)
	lbl.BackgroundTransparency = 1
	lbl.Text = title:upper()
	lbl.TextColor3 = currentCfg.TextHeader
	lbl.Font = globalfont
	lbl.TextSize = 20
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.ZIndex = 2
	lbl.Parent = card
	table.insert(registeredLabels, {lbl = lbl, isHeader = true})

	local body = Instance.new("ScrollingFrame")
	body.Size = UDim2.new(1, -24, 1, -40)
	body.Position = UDim2.new(0, 12, 0, 36)
	body.BackgroundTransparency = 1
	body.ScrollBarThickness = 1
	body.ScrollBarImageTransparency = 1
	body.ScrollBarImageColor3 = currentCfg.InputBg
	body.CanvasSize = UDim2.new(0, 0, 0, 0)
	body.AutomaticCanvasSize = Enum.AutomaticSize.Y
	body.ZIndex = 2
	body.ClipsDescendants = true
	body.Parent = card

	return body
end

-- Function to add texts
local function addtext(parent, text, properties)
	local currentCfg = themes[activeTheme]
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 24)
	row.AutomaticSize = Enum.AutomaticSize.Y
	row.BackgroundTransparency = 1
	row.ZIndex = 2
	row.Parent = parent

	local txt = Instance.new("TextLabel")
	txt.TextWrapped = true
	txt.Size = UDim2.new(1, 0, 1, 0)
	txt.BackgroundTransparency = 1
	txt.Text = text and text:upper() or ""
	txt.TextColor3 = currentCfg.TextHeader
	txt.Font = globalfont
	txt.TextSize = 20
	txt.TextXAlignment = Enum.TextXAlignment.Left
	txt.ZIndex = 2
	txt.Parent = row

	if properties then
		for prop, value in pairs(properties) do
			if txt[prop] ~= nil then
				txt[prop] = value
			end
		end
	end

	table.insert(registeredLabels, {lbl = txt, isHeader = (properties and properties.isHeader) or false})
	return row
end

-- These boxes are basically how you add things like toggles, buttons, dropdowns, etc into the pages.
-- Make sure when you add a box, make it look neat and do it EXACTLY how the other ones look, dont worry about
-- the "Udim2.new" sizes or anything as those only change for the "infoleft" and "info right", you can change
-- them though ONLY if you know what you're doing.
local example1box = createcard(example1page, "EXAMPLE1", UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
local example2box = createcard(example2page, "EXAMPLE2", UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
local example3box = createcard(example3page, "EXAMPLE3", UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
local infoleft = createcard(infopage, "USER INFO", UDim2.new(0.5, -6, 1, 0), UDim2.new(0, 0, 0, 0))
local inforight = createcard(infopage, "OTHER INFO", UDim2.new(0.5, -6, 1, 0), UDim2.new(0.5, 6, 0, 0))
local settingsbox = createcard(settingspage, "SETTINGS", UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))


-- Function to add text lines.
local function addtextline(parent, inittext)
	local txt = Instance.new("TextLabel")
	txt.Size = UDim2.new(1, 0, 0, 22)
	txt.AutomaticSize = Enum.AutomaticSize.Y
	txt.BackgroundTransparency = 1
	txt.Text = inittext
	txt.TextColor3 = themes[activeTheme].TextMain
	txt.Font = globalfont
	txt.TextSize = 16
	txt.TextXAlignment = Enum.TextXAlignment.Left
	txt.TextWrapped = true
	txt.ZIndex = 2
	txt.Parent = parent
	table.insert(registeredLabels, {lbl = txt, isHeader = false})
	return txt
end

local function addlistlayout(parent, padding)
	local ly = Instance.new("UIListLayout")
	ly.Padding = UDim.new(0, padding)
	ly.Parent = parent
	return
end

-- The list layout of the pages, make sure this is configured correctly or pages/boxes may end up on other pages.
-- Below is an example of how it should look, I *HIGHLY* recommend keeping "infoleft" and "inforight" at the top
-- and also keep "settingsbox" at the bottom, but feel free to move them as you like.
addlistlayout(infoleft, 1)
addlistlayout(inforight, 2)
addlistlayout(example1box, 3)
addlistlayout(example2box, 4)
addlistlayout(example3box, 5)
addlistlayout(settingsbox, 6)


-- Function to add toggles
local function addtoggle(parent, titletext, defaultstate, callback)
	local currentCfg = themes[activeTheme]
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 32)
	row.AutomaticSize = Enum.AutomaticSize.Y
	row.BackgroundTransparency = 1
	row.ZIndex = 2
	row.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -50, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = titletext
	label.TextColor3 = currentCfg.TextMain
	label.Font = globalfont
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	label.ZIndex = 2
	label.Parent = row
	table.insert(registeredLabels, {lbl = label, isHeader = false})

	local switch = Instance.new("TextButton")
	switch.Size = UDim2.new(0, 40, 0, 20)
	switch.Position = UDim2.new(1, -42, 0.5, -10)
	switch.BackgroundColor3 = currentCfg.InputBg
	switch.Text = ""
	switch.ZIndex = 2
	switch.Parent = row
	Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

	local dot = Instance.new("Frame")
	dot.Size = UDim2.new(0, 14, 0, 14)
	dot.Position = UDim2.new(0, 3, 0.5, -7)
	dot.BackgroundColor3 = Color3.fromRGB(150, 140, 165)
	dot.BorderSizePixel = 0
	dot.ZIndex = 2
	dot.Parent = switch
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

	local active = false

	local function updatevisuals(animate)
		local loopCfg = themes[activeTheme]
		local targetx = active and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
		local coltrack = active and loopCfg.Accent or loopCfg.InputBg
		local coldot = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 140, 165)

		if animate then
			tweenservice:Create(dot, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetx, BackgroundColor3 = coldot}):Play()
			tweenservice:Create(switch, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = coltrack}):Play()
		else
			dot.Position = targetx
			dot.BackgroundColor3 = coldot
			switch.BackgroundColor3 = coltrack
		end
	end

	local function trigger()
		active = not active
		updatevisuals(true)
		callback(active)
	end

	switch.MouseButton1Click:Connect(trigger)

	if defaultstate then
		active = true
		updatevisuals(false)
		task.spawn(function() callback(true) end)
	end

	table.insert(registeredToggles, {switch = switch, dot = dot, getState = function() return active end, update = updatevisuals})
end

-- Function to add textbox's
local function addtextbox(parent, titletext, placeholder, callback)
	local currentCfg = themes[activeTheme]
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 32)
	row.BackgroundTransparency = 1
	row.ZIndex = 2
	row.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -90, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = titletext
	label.TextColor3 = currentCfg.TextMain
	label.Font = globalfont
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	label.ZIndex = 2
	label.Parent = row
	table.insert(registeredLabels, {lbl = label, isHeader = false})

	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0, 75, 0, 24)
	box.Position = UDim2.new(1, -77, 0.5, -12)
	box.BackgroundColor3 = currentCfg.InputBg
	box.Text = ""
	box.PlaceholderText = placeholder
	box.PlaceholderColor3 = Color3.fromRGB(110, 100, 130)
	box.TextColor3 = Color3.fromRGB(240, 235, 255)
	box.Font = globalfont
	box.TextSize = 14
	box.ZIndex = 2
	box.ClearTextOnFocus = false
	box.Parent = row
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1
	stroke.Color = currentCfg.Stroke
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = box

	box.FocusLost:Connect(function(enterpressed)
		callback(box.Text)
	end)

	table.insert(registeredTextBoxes, {box = box, stroke = stroke})
end

-- Function to add button's
local function addbutton(parent, titletext, buttontext, callback)
	local currentCfg = themes[activeTheme]
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 32)
	row.AutomaticSize = Enum.AutomaticSize.Y
	row.BackgroundTransparency = 1
	row.ZIndex = 2
	row.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -110, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = titletext
	label.TextColor3 = currentCfg.TextMain
	label.Font = globalfont
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	label.ZIndex = 2
	label.Parent = row
	table.insert(registeredLabels, {lbl = label, isHeader = false})

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 96, 0, 24)
	btn.Position = UDim2.new(1, -98, 0.5, -12)
	btn.BackgroundColor3 = currentCfg.ButtonBg
	btn.Text = buttontext
	btn.Font = globalfont
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(240, 235, 255)
	btn.ZIndex = 2
	btn.Parent = row
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	btn.MouseButton1Click:Connect(callback)
	table.insert(registeredButtons, btn)
end

-- Function to add drop down's
local function adddropdown(parent, titletext, listoptions, defaultoption, callback)
	local currentCfg = themes[activeTheme]
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 32)
	row.BackgroundTransparency = 1
	row.ZIndex = 4
	row.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -140, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = titletext
	label.TextColor3 = currentCfg.TextMain
	label.Font = globalfont
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.ZIndex = 4
	label.Parent = row
	table.insert(registeredLabels, {lbl = label, isHeader = false})

	local menuBtn = Instance.new("TextButton")
	menuBtn.Size = UDim2.new(0, 120, 0, 24)
	menuBtn.Position = UDim2.new(1, -122, 0.5, -12)
	menuBtn.BackgroundColor3 = currentCfg.InputBg
	menuBtn.Text = defaultoption .. " ▼"
	menuBtn.Font = globalfont
	menuBtn.TextSize = 14
	menuBtn.TextColor3 = Color3.fromRGB(240, 235, 255)
	menuBtn.ZIndex = 5
	menuBtn.Parent = row
	Instance.new("UICorner", menuBtn).CornerRadius = UDim.new(0, 6)

	local mStroke = Instance.new("UIStroke")
	mStroke.Thickness = 1
	mStroke.Color = currentCfg.Stroke
	mStroke.Parent = menuBtn

	local screenGui = parent:FindFirstAncestorWhichIsA("ScreenGui")

	local optionsContainer = Instance.new("Frame")
	optionsContainer.Size = UDim2.new(1, 0, 0, 0)
	optionsContainer.BackgroundColor3 = currentCfg.CardBackground
	optionsContainer.BorderSizePixel = 0
	optionsContainer.Visible = false
	optionsContainer.ZIndex = 9999
	optionsContainer.Parent = screenGui or menuBtn
	Instance.new("UICorner", optionsContainer).CornerRadius = UDim.new(0, 6)

	local cStroke = Instance.new("UIStroke")
	cStroke.Thickness = 1
	cStroke.Color = currentCfg.Stroke
	cStroke.Parent = optionsContainer

	local containerList = Instance.new("UIListLayout")
	containerList.Padding = UDim.new(0, 2)
	containerList.Parent = optionsContainer
	Instance.new("UIPadding", optionsContainer).PaddingTop = UDim.new(0, 4)

	local expanded = false
	local optionButtons = {}

	local function toggleDropdown()
		expanded = not expanded
		optionsContainer.Visible = expanded
		if expanded then
			local itemsCount = #listoptions
			local absPos = menuBtn.AbsolutePosition
			local absSize = menuBtn.AbsoluteSize

			optionsContainer.Size = UDim2.new(0, absSize.X, 0, (itemsCount * 24) + 8)
			optionsContainer.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 2)

			menuBtn.Text = (menuBtn.Text:gsub("▼", "▲"))
		else
			menuBtn.Text = (menuBtn.Text:gsub("▲", "▼"))
		end
	end

	menuBtn.MouseButton1Click:Connect(toggleDropdown)

	for _, optionName in ipairs(listoptions) do
		local opt = Instance.new("TextButton")
		opt.Size = UDim2.new(1, -8, 0, 22)
		opt.BackgroundColor3 = currentCfg.InputBg
		opt.BackgroundTransparency = 1
		opt.Text = optionName
		opt.Font = globalfont
		opt.TextSize = 14
		opt.TextColor3 = currentCfg.TextMain
		opt.ZIndex = 10000
		opt.Parent = optionsContainer
		Instance.new("UICorner", opt).CornerRadius = UDim.new(0, 4)

		opt.MouseButton1Click:Connect(function()
			menuBtn.Text = optionName .. " ▼"
			toggleDropdown()
			callback(optionName)
		end)
		table.insert(optionButtons, opt)
	end

	if parent:IsA("ScrollingFrame") then
		parent:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			if expanded then
				toggleDropdown()
			end
		end)
	end

	table.insert(registeredDropdowns, {
		menuBtn = menuBtn,
		mStroke = mStroke,
		optionsContainer = optionsContainer,
		cStroke = cStroke,
		optionButtons = optionButtons
	})
end

-- Theme style manager
local function reloadThemeStyle()
	local cfg = themes[activeTheme]
	basewindow.BackgroundColor3 = cfg.Background
	exitbtn.BackgroundColor3 = cfg.InputBg
	navdeck.BackgroundColor3 = cfg.NavBackground

	for _, c in ipairs(cardsList) do
		c.BackgroundColor3 = cfg.CardBackground
		local sf = c:FindFirstChildOfClass("ScrollingFrame")
		if sf then sf.ScrollBarImageColor3 = cfg.InputBg end
	end
	for _, lData in ipairs(registeredLabels) do
		lData.lbl.TextColor3 = lData.isHeader and cfg.TextHeader or cfg.TextMain
	end

	for _, tData in ipairs(registeredToggles) do
		tData.update(false)
	end

	for _, bData in ipairs(registeredTextBoxes) do
		bData.box.BackgroundColor3 = cfg.InputBg
		bData.stroke.Color = cfg.Stroke
	end
	for _, btn in ipairs(registeredButtons) do
		btn.BackgroundColor3 = cfg.ButtonBg
	end
	for _, drop in ipairs(registeredDropdowns) do
		drop.menuBtn.BackgroundColor3 = cfg.InputBg
		drop.mStroke.Color = cfg.Stroke
		drop.optionsContainer.BackgroundColor3 = cfg.CardBackground
		drop.cStroke.Color = cfg.Stroke
		for _, oBtn in ipairs(drop.optionButtons) do
			oBtn.TextColor3 = cfg.TextMain
		end
	end
	for name, btn in pairs(activenavbuttons) do
		btn.BackgroundColor3 = (name == currenttab) and cfg.ButtonActive or cfg.InputBg
	end
end

-- Texts that appear on the info left and info right
local uname = addtextline(infoleft, "Username: Loading...")
local udisplay = addtextline(infoleft, "Display Name: Loading...")
local uaccage = addtextline(infoleft, "Account Age: Loading...")

local utime = addtextline(inforight, "Time Status: Syncing...")
local ucredits = addtextline(inforight, "Credits: Syncing...")
addtextline(inforight, "GUI Version: " .. version)
local ubodytype = addtextline(inforight, "Scale: Syncing...")

task.spawn(function()
	if player then
		uname.Text = "Username: " .. player.Name
		udisplay.Text = "Display Name: " .. player.DisplayName
		uaccage.Text = "Account Age: " .. player.AccountAge .. " days"
	end
end)

-- Random rainbowtheme fixer because I kinda messed it up and had to add extra stuff
local rainbowTheme = themes["Rainbow"]
local rainbowHue = 0
local rainbowStep = 0.0018
local rainbowSpeed = 0.72

local function updateRainbowTheme()
	local hue = (rainbowHue % 1)

	local bgColor  = Color3.fromHSV(hue, 0.85, 0.95)
	local navColor = Color3.fromHSV(hue, 0.85, 0.95)
	local cardColor = Color3.fromHSV(hue, 0.85, 0.95)

	rainbowTheme.Background = bgColor
	rainbowTheme.NavBackground = navColor
	rainbowTheme.CardBackground = cardColor

	reloadThemeStyle()

	rainbowHue = (rainbowHue + rainbowStep * rainbowSpeed) % 1
end

-- Basically the text that appears on info left/info right
runservice.RenderStepped:Connect(function()
	local dt = os.date("*t")
	utime.Text = string.format("Time: %02d:%02d:%02d", dt.hour, dt.min, dt.sec)

	ucredits.Text = "Credits: @cframe.value/@boot.linux on discord :3"

	ubodytype.Text = ""
end)

runservice.RenderStepped:Connect(function()
	if activeTheme == "Rainbow" then
		updateRainbowTheme()
	end
end)

-- This is where you will put all of your toggles, buttons, dropdowns, etc. Below is an example of how it
-- can look. You, of course, can change how it looks. I have provided an example on how to create a button,
-- toggle, and dropdown to the gui. I will go into further detail as we continue on.

-- So, when adding something, make sure you do it like this: addbutton(YOUR_BOX_NAME_HERE, "TextDisplay", "Click Me!", function()
-- That is how it should look, its not much different for dropdown or toggle except instead of "Click Me!", you should
-- either include a boolean value (True or False) for the toggle, and for the dropdown you should include
-- another reference (Example: local dropdownstuff = {"gaming1", "gaming2", "gaming3"}) so the dropdown knows what
-- to display and give options to.

addbutton(example1box, "Example Button", "Example", function()
	print("put whatever function stuff you want here, you can also put ur functions above this if you would like.")
end)

addtoggle(example1box, "Example Toggle", false, function()
	print("put whatever function stuff you want here, you can also put ur functions above this if you would like.")
end)

addtext(example1box, "SPACER EXAMPLE")

local dropdownexample = {"test1", "test2", "test3", "test4"}
adddropdown(example1box, "Example Dropdown", dropdownexample, "Off", function()
	print("put whatever function stuff you want here, you can also put ur functions above this if you would like.")
end)

-- Settings, dont really need to modify unless you need to add to the unload.
local themeNames = {}
for themeName, _ in pairs(themes) do
	table.insert(themeNames, themeName)
end
table.sort(themeNames)

adddropdown(settingsbox, "Theme", themeNames, activeTheme, function(selectedTheme)
	if themes[selectedTheme] then
		activeTheme = selectedTheme
		reloadThemeStyle()
	end
end)

addbutton(settingsbox, "Unload Script", "Unload", function()
	local antiFlingConn = nil
	running = false
	if toggleConnection then 
		toggleConnection:Disconnect() end
	
	screengui:Destroy()
	notificationGui:Destroy()
	-- If you plan on adding scripts, I recommend adding an unload function and putting it here
	-- so if someone unloads the gui it dosent keep their stuff toggled on.
end)

-- Developer [@cytrixgt]
-- Discord [discord.gg/vellumscripts]