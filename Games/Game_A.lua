-- ✅ Game Lock
if not (game.GameId == 8067966563) then return end

-- ✅ Wait For Game Load
if not game:IsLoaded() then
    print("⏳ Game is loading...")
    game.Loaded:Wait()
end
print("[Game_A] Loaded successfully.")

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Plr = Players.LocalPlayer
local PlrGui = Plr:WaitForChild("PlayerGui")
local Backpack = Plr:WaitForChild("Backpack")
local Workspace = game.Workspace

local GameTab = Rayfield:FindTab("Games")

-------------------------------------------------------------
-- 🔁 TIMER: Restock Timers
local SummonTimerSignal = PlrGui.Main.Summon.Main.Packs.Holder.Top.Timer
local GoldShopTimerSignal = PlrGui.Main.GoldShop.Holder.Main.Bottom.RestockBarBG.Title

local SummonTimerLabel = GameTab:CreateLabel("Next Summon : ", "clock")
local GoldShopTimerLabel = GameTab:CreateLabel("Next Gold Shop : ", "hourglass")

if _G.TimerConn then _G.TimerConn:Disconnect() end
_G.TimerConn = SummonTimerSignal:GetPropertyChangedSignal("Text"):Connect(function()
    local CleanSummon = SummonTimerSignal.Text:match("%d%d:%d%d") or "00:00"
    local CleanGold = GoldShopTimerSignal.Text:match("%d%d:%d%d") or "00:00"
    SummonTimerLabel:Set("Restock Summon : " .. CleanSummon)
    GoldShopTimerLabel:Set("Restock Gold Shop : " .. CleanGold)
end)

-------------------------------------------------------------
-- 🛒 BUY FOOD AUTOMATICALLY
-- (Same as original BuyStocks, WatchFoodList, etc.)
-- Will paste this after your confirmation to include.
-- 🛒 BUY FOOD AUTOMATICALLY
local FoodList = PlrGui.Main.GoldShop.Holder.Main.ItemSelection.List

local function BuyStocks()
	for _, food in ipairs(FoodList:GetChildren()) do
		local id = food:GetAttribute("ItemID")
		local amount = food:GetAttribute("Amount")
		if id and amount and amount > 0 then
			ReplicatedStorage.Packages.Knit.Services.GoldShopService.RF.BuyItem:InvokeServer(id, amount)
			print("🛒 Buying:", id, amount)
		end
	end
end

local function ClearFoodConns()
	if _G.FoodConns then
		for _, conn in ipairs(_G.FoodConns) do
			conn:Disconnect()
		end
	end
	_G.FoodConns = {}
end

local function WatchFoodList()
	ClearFoodConns()
	_G.FoodConns = {}

	for _, food in ipairs(FoodList:GetChildren()) do
		local conn = food:GetAttributeChangedSignal("Amount"):Connect(BuyStocks)
		table.insert(_G.FoodConns, conn)
	end

	local childAddedConn = FoodList.ChildAdded:Connect(function(child)
		local conn = child:GetAttributeChangedSignal("Amount"):Connect(BuyStocks)
		table.insert(_G.FoodConns, conn)
	end)
	table.insert(_G.FoodConns, childAddedConn)
end

-- 🔘 Toggle
local FoodToggle = GameTab:CreateToggle({
	Name = "Buy Food Automatically",
	CurrentValue = false,
	Flag = "FoodToggle",
	Callback = function(state)
		_G.FoodToggle = state

		if not state then
			ClearFoodConns()
			return
		end

		BuyStocks()
		WatchFoodList()
	end,
})

GameTab:CreateDivider()


-------------------------------------------------------------
-- 🚀 Teleport to Sell Area
local targetCFrame = CFrame.new(50.82, 4.50, 20.44, -0.38, 0.00, -0.92, 0.00, 1.00, 0.00, 0.92, 0.00, -0.38)
Plr.Character:WaitForChild("HumanoidRootPart").CFrame = targetCFrame

-------------------------------------------------------------
-- 🧹 SELL ARTIFACTS
-- 🔒 MANAGER ARTIFACTS
-- Will paste next after food section.

-------------------------------------------------------------
-- 📦 SUMMON PACK DROPDOWN + TOGGLE
-- 🎯 RARITIES SELECT
-- 🗑️ SELL UNITS
-- 🎁 GIFT PLAYER

-- These will also follow right after you confirm food block above.

