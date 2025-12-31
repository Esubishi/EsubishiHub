-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local BillboardGui = Instance.new("BillboardGui")
local Frame = Instance.new("Frame", BillboardGui)
local UIStroke = Instance.new("UIStroke", Frame)
local NameLabel = Instance.new("TextLabel", Frame)

BillboardGui.Name = "BOX_ESP"
BillboardGui.Size = UDim2.new(4, 0, 6, 0)
BillboardGui.AlwaysOnTop = true
BillboardGui.LightInfluence = 0
BillboardGui.DistanceLowerLimit = 9999

Frame.BackgroundTransparency = 1
Frame.Size = UDim2.new(1, 0, 1, 0)

UIStroke.Transparency = 0
UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
UIStroke.Color = Color3.fromRGB(0, 0, 0)
UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize

NameLabel.BackgroundTransparency = 1
NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
NameLabel.TextStrokeTransparency = 0
NameLabel.BorderSizePixel = 0
NameLabel.TextScaled = true
NameLabel.Size = UDim2.new(1, 0, 0.2, 0)
NameLabel.Name = "NameLabel"

local lplayer = game.Players.LocalPlayer
local char = lplayer.Character
local hrp = char:WaitForChild("HumanoidRootPart")
local lighting = game:GetService("Lighting")
local wrkspace = game:GetService("Workspace")

local Window = Library:CreateWindow({
	-- Set Center to true if you want the menu to appear in the center
	-- Set AutoShow to true if you want the menu to appear when it is created
	-- Position and Size are also valid options here
	-- but you do not need to define them unless you are changing them :)f
	Title = "🗿Forsaken Script🗿",
	Center = true,
	AutoShow = true,
	TabPadding = 8,
	MenuFadeTime = 0.2,
})

-- CALLBACK NOTE:
-- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works
-- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.
-- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

-- You do not have to set your tabs & groups up this way, just a prefrence.
local Tabs = {
	-- Creates a new tab titled Main and ESP
	Main = Window:AddTab("Main"),
	ESP = Window:AddTab("ESP"),
	["UI Settings"] = Window:AddTab("UI Settings"),
}

-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local LeftGroupBox = Tabs.Main:AddLeftGroupbox("Groupbox")
local ESPLeftGroupBox = Tabs.ESP:AddLeftGroupbox("ESP")
local MiscRightGroupBox = Tabs.Main:AddRightGroupbox("Misc")

local fullbright = MiscRightGroupBox:AddButton({
	Text = "FullBright",
	Func = function()
		lighting.Brightness = 5
		lighting.Ambient = Color3.fromRGB(255, 255, 255)
		lighting.GlobalShadows = false
		lighting.ShadowSoftness = 0
		lighting.ClockTime = 14
		if game.Lighting.Atmosphere then
			game.Lighting.Atmosphere:Destory()
		end
		if game.Lighting.Sky then
			game.Lighting.Sky:Destroy()
		end
	end,
	Tooltip = "Turn on fullbright",
	DoubleClick = false,
})

ESPLeftGroupBox:AddToggle("PlayerESP", {
	Text = "Toggle Chams ESP",
	Default = false,
	Tooltip = "When enabled, creates a highlight for every in-game player",
	Callback = function(Value)
		if Value == true then
			repeat
				task.wait()
			until wrkspace.Players.Survivors
			local INGPlayers = wrkspace.Players.Survivors:GetChildren()
			for i = 1, #INGPlayers do
				print(INGPlayers[i])
				--local path = game.Workspace:FindFirstChild(v.Name)
				--local highlight = Instance.new("Highlight")
				--highlight.Parent = path
				local highlight = Instance.new("Highlight")
				highlight.FillTransparency = 0
				highlight.OutlineTransparency = 1
				highlight.Name = "Esp"
				highlight.Parent = INGPlayers[i]
				highlight.FillColor = Color3.fromRGB(0, 255, 0)
				highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
			end
		else
			for i, v in pairs(wrkspace.Players.Survivors:GetChildren()) do
				--local path = game.Workspace:FindFirstChild(v.Name)
				--local highlight = Instance.new("Highlight")
				--highlight.Parent = path

				local path = wrkspace.Players.Survivors:FindFirstChild(v.Name)
				if path.Esp then
					path.Esp:Destroy()
				end
			end
		end
	end,
})

ESPLeftGroupBox:AddToggle("BoxESP", {
	Text = "Toggle Box ESP",
	Default = false,
	Tooltip = "Encapsulates the players in a rectangle with their name showing above",
	Callback = function(Value)
		local INGPlayers = wrkspace.Players.Survivors:GetChildren()
		if Value == true then
			repeat
				task.wait()
			until wrkspace.Players.Survivors

			for i = 1, #INGPlayers do
				local clone = BillboardGui:Clone()
				clone.Parent = INGPlayers[i]
			end
		else
			for i = 1, #INGPlayers do
				if INGPlayers[i].BOX_ESP then
					INGPlayers[i].BOX_ESP:Destory()
				end
			end
		end
	end,
})

ESPLeftGroupBox:AddToggle("Killer ESP", {
	Text = "Toggle Killer ESP",
	Default = false,
	Tooltip = "When enabled, creates a highlight for the killer",
	Callback = function(Value)
		if Value == true then
			repeat
				task.wait()
			until wrkspace.Players.Killers
			for i, v in pairs(game.Workspace.Players.Killers:GetChildren()) do
				--local path = game.Workspace:FindFirstChild(v.Name)
				--local highlight = Instance.new("Highlight")
				--highlight.Parent = path
				local path = wrkspace.Players.Killers:FindFirstChild(v.Name)
				local highlight = Instance.new("Highlight")
				highlight.FillTransparency = 0
				highlight.OutlineTransparency = 1
				highlight.Name = "Esp"
				highlight.Parent = path
				highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
			end
		else
			for i, v in pairs(wrkspace.Players.Killers:GetChildren()) do
				--local path = game.Workspace:FindFirstChild(v.Name)
				--local highlight = Instance.new("Highlight")
				--highlight.Parent = path
				local path = wrkspace.Players.Killers:FindFirstChild(v.Name)
				if path.Esp then
					path.Esp:Destory()
				end
			end
		end
	end,
})

ESPLeftGroupBox:AddToggle("Generator ESP", {
	Text = "Toggle Generator ESP",
	Default = false,
	Tooltip = "When enabled, creates a highlight for the killer",
	Callback = function(Value)
		local ingamedescndents = wrkspace.Map.Ingame.Map:GetDescendants()
		if Value == true then
			repeat
				task.wait()
			until wrkspace.Map.Ingame
			for i, v in pairs(wrkspace.Map.Ingame.Map:GetDescendants()) do
				local highlight = Instance.new("Highlight")
				if v.Name == "Generator" then
					highlight.FillTransparency = 0
					highlight.OutlineTransparency = 1
					highlight.Parent = v
					highlight.Name = "Esp"
					highlight.FillColor = Color3.fromRGB(0, 0, 255)
					highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
				end
			end
		else
			for i = 1, #ingamedescndents, 1 do
				if ingamedescndents[i].Name == "Generator" then
					if ingamedescndents[i].Esp then
						ingamedescndents[i].Esp:Destory()
					end
				end
			end
		end
	end,
})

-- We can also get our Main tab via the following code:
-- local LeftGroupBox = Window.Tabs.Main:AddLeftGroupbox('Groupbox')

-- Tabboxes are a tiny bit different, but here's a basic example:
--[[

local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side

local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')

-- You can now call AddToggle, etc on the tabs you added to the Tabbox
]]

-- Groupbox:AddToggle
-- Arguments: Index, Options
LeftGroupBox:AddToggle("MyToggle", {
	Text = "This is a toggle",
	Default = true, -- Default value (true / false)
	Tooltip = "This is a tooltip", -- Information shown when you hover over the toggle

	Callback = function(Value)
		print("[cb] MyToggle changed to:", Value)
	end,
})

-- Fetching a toggle object for later use:
-- Toggles.MyToggle.Value

-- Toggles is a table added to getgenv() by the library
-- You index Toggles with the specified index, in this case it is 'MyToggle'
-- To get the state of the toggle you do toggle.Value

-- Calls the passed function when the toggle is updated
Toggles.MyToggle:OnChanged(function()
	-- here we get our toggle object & then get its value
	print("MyToggle changed to:", Toggles.MyToggle.Value)
end)

-- This should print to the console: "My toggle state changed! New value: false"
Toggles.MyToggle:SetValue(false)

-- 1/15/23
-- Deprecated old way of creating buttons in favor of using a table
-- Added DoubleClick button functionality

--[[
    Groupbox:AddButton
    Arguments: {
        Text = string,
        Func = function,
        DoubleClick = boolean
        Tooltip = string,
    }

    You can call :AddButton on a button to add a SubButton!
]]

local MyButton = LeftGroupBox:AddButton({
	Text = "Button",
	Func = function()
		print("You clicked a button!")
	end,
	DoubleClick = false,
	Tooltip = "This is the main button",
})

local MyButton2 = MyButton:AddButton({
	Text = "Sub button",
	Func = function()
		print("You clicked a sub button!")
	end,
	DoubleClick = true, -- You will have to click this button twice to trigger the callback
	Tooltip = "This is the sub button (double click me!)",
})

--[[
    NOTE: You can chain the button methods!
    EXAMPLE:

    LeftGroupBox:AddButton({ Text = 'Kill all', Func = Functions.KillAll, Tooltip = 'This will kill everyone in the game!' })
        :AddButton({ Text = 'Kick all', Func = Functions.KickAll, Tooltip = 'This will kick everyone in the game!' })
]]

-- Groupbox:AddLabel
-- Arguments: Text, DoesWrap
LeftGroupBox:AddLabel("This is a label")
LeftGroupBox:AddLabel("This is a label\n\nwhich wraps its text!", true)

-- Groupbox:AddDivider
-- Arguments: None
LeftGroupBox:AddDivider()

--[[
    Groupbox:AddSlider
    Arguments: Idx, SliderOptions

    SliderOptions: {
        Text = string,
        Default = number,
        Min = number,
        Max = number,
        Suffix = string,
        Rounding = number,
        Compact = boolean,
        HideMax = boolean,
    }

    Text, Default, Min, Max, Rounding must be specified.
    Suffix is optional.
    Rounding is the number of decimal places for precision.

    Compact will hide the title label of the Slider

    HideMax will only display the value instead of the value & max value of the slider
    Compact will do the same thing
]]
LeftGroupBox:AddSlider("MySlider", {
	Text = "This is my slider!",
	Default = 0,
	Min = 0,
	Max = 5,
	Rounding = 1,
	Compact = false,

	Callback = function(Value)
		print("[cb] MySlider was changed! New value:", Value)
	end,
})

-- Options is a table added to getgenv() by the library
-- You index Options with the specified index, in this case it is 'MySlider'
-- To get the value of the slider you do slider.Value

local Number = Options.MySlider.Value
Options.MySlider:OnChanged(function()
	print("MySlider was changed! New value:", Options.MySlider.Value)
end)

-- This should print to the console: "MySlider was changed! New value: 3"
Options.MySlider:SetValue(3)

-- Groupbox:AddInput
-- Arguments: Idx, Info
LeftGroupBox:AddInput("MyTextbox", {
	Default = "My textbox!",
	Numeric = false, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter

	Text = "This is a textbox",
	Tooltip = "This is a tooltip", -- Information shown when you hover over the textbox

	Placeholder = "Placeholder text", -- placeholder text when the box is empty
	-- MaxLength is also an option which is the max length of the text

	Callback = function(Value)
		print("[cb] Text updated. New text:", Value)
	end,
})

Options.MyTextbox:OnChanged(function()
	print("Text updated. New text:", Options.MyTextbox.Value)
end)

-- Groupbox:AddDropdown
-- Arguments: Idx, Info

LeftGroupBox:AddDropdown("MyDropdown", {
	Values = { "This", "is", "a", "dropdown" },
	Default = 1, -- number index of the value / string
	Multi = false, -- true / false, allows multiple choices to be selected

	Text = "A dropdown",
	Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown

	Callback = function(Value)
		print("[cb] Dropdown got changed. New value:", Value)
	end,
})

Options.MyDropdown:OnChanged(function()
	print("Dropdown got changed. New value:", Options.MyDropdown.Value)
end)

Options.MyDropdown:SetValue("This")

-- Multi dropdowns
LeftGroupBox:AddDropdown("MyMultiDropdown", {
	-- Default is the numeric index (e.g. "This" would be 1 since it if first in the values list)
	-- Default also accepts a string as well

	-- Currently you can not set multiple values with a dropdown

	Values = { "This", "is", "a", "dropdown" },
	Default = 1,
	Multi = true, -- true / false, allows multiple choices to be selected

	Text = "A dropdown",
	Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown

	Callback = function(Value)
		print("[cb] Multi dropdown got changed:", Value)
	end,
})

Options.MyMultiDropdown:OnChanged(function()
	-- print('Dropdown got changed. New value:', )
	print("Multi dropdown got changed:")
	for key, value in next, Options.MyMultiDropdown.Value do
		print(key, value) -- should print something like This, true
	end
end)

Options.MyMultiDropdown:SetValue({
	This = true,
	is = true,
})

LeftGroupBox:AddDropdown("MyPlayerDropdown", {
	SpecialType = "Player",
	Text = "A player dropdown",
	Tooltip = "This is a tooltip", -- Information shown when you hover over the dropdown

	Callback = function(Value)
		print("[cb] Player dropdown got changed:", Value)
	end,
})

-- Label:AddColorPicker
-- Arguments: Idx, Info

-- You can also ColorPicker & KeyPicker to a Toggle as well

LeftGroupBox:AddLabel("Color"):AddColorPicker("ColorPicker", {
	Default = Color3.new(0, 1, 0), -- Bright green
	Title = "Some color", -- Optional. Allows you to have a custom color picker title (when you open it)
	Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

	Callback = function(Value)
		print("[cb] Color changed!", Value)
	end,
})

Options.ColorPicker:OnChanged(function()
	print("Color changed!", Options.ColorPicker.Value)
	print("Transparency changed!", Options.ColorPicker.Transparency)
end)

Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

-- Label:AddKeyPicker
-- Arguments: Idx, Info

LeftGroupBox:AddLabel("Keybind"):AddKeyPicker("KeyPicker", {
	-- SyncToggleState only works with toggles.
	-- It allows you to make a keybind which has its state synced with its parent toggle

	-- Example: Keybind which you use to toggle flyhack, etc.
	-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

	Default = "MB2", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
	SyncToggleState = false,

	-- You can define custom Modes but I have never had a use for it.
	Mode = "Toggle", -- Modes: Always, Toggle, Hold

	Text = "Auto lockpick safes", -- Text to display in the keybind menu
	NoUI = false, -- Set to true if you want to hide from the Keybind menu,

	-- Occurs when the keybind is clicked, Value is `true`/`false`
	Callback = function(Value)
		print("[cb] Keybind clicked!", Value)
	end,

	-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
	ChangedCallback = function(New)
		print("[cb] Keybind changed!", New)
	end,
})

-- OnClick is only fired when you press the keybind and the mode is Toggle
-- Otherwise, you will have to use Keybind:GetState()
Options.KeyPicker:OnClick(function()
	print("Keybind clicked!", Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
	print("Keybind changed!", Options.KeyPicker.Value)
end)

task.spawn(function()
	while true do
		wait(1)

		-- example for checking if a keybind is being pressed
		local state = Options.KeyPicker:GetState()
		if state then
			print("KeyPicker is being held down")
		end

		if Library.Unloaded then
			break
		end
	end
end)

Options.KeyPicker:SetValue({ "MB2", "Toggle" }) -- Sets keybind to MB2, mode to Hold

-- Long text label to demonstrate UI scrolling behaviour.
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox("Groupbox #2")
LeftGroupBox2:AddLabel(
	"Oh no...\nThis label spans multiple lines!\n\nWe're gonna run out of UI space...\nJust kidding! Scroll down!\n\n\nHello from below!",
	true
)

local TabBox = Tabs.Main:AddRightTabbox() -- Add Tabbox on right side

-- Anything we can do in a Groupbox, we can do in a Tabbox tab (AddToggle, AddSlider, AddLabel, etc etc...)
local Tab1 = TabBox:AddTab("Tab 1")
Tab1:AddToggle("Tab1Toggle", { Text = "Tab1 Toggle" })

local Tab2 = TabBox:AddTab("Tab 2")
Tab2:AddToggle("Tab2Toggle", { Text = "Tab2 Toggle" })

-- Dependency boxes let us control the visibility of UI elements depending on another UI elements state.
-- e.g. we have a 'Feature Enabled' toggle, and we only want to show that features sliders, dropdowns etc when it's enabled!
-- Dependency box example:
local RightGroupbox = Tabs.Main:AddRightGroupbox("Groupbox #3")
RightGroupbox:AddToggle("ControlToggle", { Text = "Dependency box toggle" })

local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle("DepboxToggle", { Text = "Sub-dependency box toggle" })

-- We can also nest dependency boxes!
-- When we do this, our SupDepbox automatically relies on the visiblity of the Depbox - on top of whatever additional dependencies we set
local SubDepbox = Depbox:AddDependencyBox()
SubDepbox:AddSlider("DepboxSlider", { Text = "Slider", Default = 50, Min = 0, Max = 100, Rounding = 0 })
SubDepbox:AddDropdown("DepboxDropdown", { Text = "Dropdown", Default = 1, Values = { "a", "b", "c" } })

Depbox:SetupDependencies({
	{ Toggles.ControlToggle, true }, -- We can also pass `false` if we only want our features to show when the toggle is off!
})

SubDepbox:SetupDependencies({
	{ Toggles.DepboxToggle, true },
})

-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Example of dynamically-updating watermark with common traits (fps and ping)
local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60

local WatermarkConnection = game:GetService("RunService").RenderStepped:Connect(function()
	FrameCounter += 1

	if (tick() - FrameTimer) >= 1 then
		FPS = FrameCounter
		FrameTimer = tick()
		FrameCounter = 0
	end

	Library:SetWatermark(
		("Forsaken script🗿  | %s fps | %s ms"):format(
			math.floor(FPS),
			math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
		)
	)
end)

Library.KeybindFrame.Visible = true -- todo: add a function for this

Library:OnUnload(function()
	WatermarkConnection:Disconnect()

	print("Unloaded!")
	Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "Insert", NoUI = true, Text = "Menu keybind" })

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs["UI Settings"])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
