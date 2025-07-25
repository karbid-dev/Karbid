if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local PlrGui = Plr:WaitForChild("PlayerGui")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local PlaceId = game.PlaceId
local JobId = game.JobId

_G.Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "KARB.ID - SCRIPT HUB",
	Icon = "gamepad",
	LoadingTitle = "KARBID SCRIPT HUB",
	LoadingSubtitle = "Karya Anak Bangsa ID",
	ShowText = "👁️",
	Theme = "Amethyst",
	ToggleUIKeybind = "K",
	DisableRayfieldPrompts = true,
	DisableBuildWarnings = true,
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "KARB.ID - Configs",
		FileName = "Place ID_" .. tostring(PlaceId),
	},
	Discord = {
		Enabled = true,
		Invite = "dPPrFqBA7w",
		RememberJoins = true,
	},
	KeySystem = false,
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided",
		FileName = "Key",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = { "Hello" },
	},
})

-- Tabs
local GameTab = Window:CreateTab("Games", "gamepad-2")
local CharacterTab = Window:CreateTab("Character", "user")

-- CharacterTab Buttons
CharacterTab:CreateButton({
	Name = "Rejoin",
	Callback = function()
		local success, err = pcall(function()
			TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Plr)
		end)
		if not success then
			TeleportService:Teleport(PlaceId)
		end
	end,
})

CharacterTab:CreateButton({
	Name = "Server Hop",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua"))():Teleport(PlaceId)
	end,
})

CharacterTab:CreateLabel("Put this script on AutoExec folder of your executor", "triangle-alert")
CharacterTab:CreateLabel("Because the game teleport you if you afk", "triangle-alert")

CharacterTab:CreateToggle({
	Name = "Anti-AFK (Doesnt Work On This Game)",
	CurrentValue = false,
	Flag = "AntiAFKToggle",
	Callback = function(state)
		_G.AntiAFKToggle = state
		if _G.AntiAFKConn then _G.AntiAFKConn:Disconnect() end
		if state then
			_G.AntiAFKConn = Plr.Idled:Connect(function()
				VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				task.wait(1)
				VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end)
		end
	end,
})

Rayfield.LoadConfiguration()
