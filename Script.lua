
--//Settings//--
_G.Enabled = true
local TPTime = 5 -- Put whatever number you want there
local ScriptLoadWaitTime = 6 -- DO NOT PUT IT LOWER THAN 5 OR IMA SLAP U
--//Script//--
local WaitForTheDamGui= game:WaitForChild("StarterGui")
wait(ScriptLoadWaitTime)

local startergui = game:GetService("StarterGui")
startergui:SetCore("SendNotification",{
	Title = "Auto Farm Started!";
	Text = "Just sit back and watch. Make Sure to give the script a few seconds to work!";
	Duration = 5;
})


function CheckIfLoaded()
	workspace.CurrentCamera.CameraType = Enum.CameraType.Follow
	game.Lighting:WaitForChild("Blur").Enabled = false
	game.Players.LocalPlayer.PlayerGui:WaitForChild("Main").Enabled = true
	game.Players.LocalPlayer.PlayerGui:WaitForChild("Intro").Enabled = false
end


function Noclip()
	Clip = false
	wait(0.1)
	local function Noclip()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true  then
					child.CanCollide = false
				end
			end
		end
	end
	game:GetService('RunService').Stepped:Connect(Noclip)
end

function TPStuffIdfk()
		for k,v in pairs(game:GetService("Workspace").MouseIgnore:GetDescendants()) do
		if v:IsA("ClickDetector")  and v.Parent.Name == 'ClickBox'  then
				game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(v.Parent.CFrame.X,v.Parent.CFrame.Y + -5,v.Parent.CFrame.Z)
				FirClickDetectorStuff()
			end
		end
	end

function FirClickDetectorStuff()
	for _,v in pairs(game:GetService("Workspace").MouseIgnore:GetDescendants()) do
		if v:IsA("ClickDetector")  and v.Parent.Name == 'ClickBox'  then
			fireclickdetector(v)
		end
	end
end

function AntiAfkIg()
	local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end


local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
	AllIDs = game:GetService('HttpService'):JSONDecode(readfile("ServersAlreadyJoined.json"))
end)
if not File then
	table.insert(AllIDs, actualHour)
	writefile("ServersAlreadyJoined.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPStuffLol()
	local Site;
	if foundAnything == "" then
		Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
	else
		Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
	end
	local ID = ""
	if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
		foundAnything = Site.nextPageCursor
	end
	local num = 0;
	for i,v in pairs(Site.data) do
		local Possible = true
		ID = tostring(v.id)
		if tonumber(v.maxPlayers) > tonumber(v.playing) then
			for _,Existing in pairs(AllIDs) do
				if num ~= 0 then
					if ID == tostring(Existing) then
						Possible = false
					end
				else
					if tonumber(actualHour) ~= tonumber(Existing) then
						local delFile = pcall(function()
							delfile("ServersAlreadyJoined.json")
							AllIDs = {}
							table.insert(AllIDs, actualHour)
						end)
					end
				end
				num = num + 1
			end
			if Possible == true then
				table.insert(AllIDs, ID)
				wait()
				pcall(function()
					writefile("ServersAlreadyJoined.json", game:GetService('HttpService'):JSONEncode(AllIDs))
					wait()
					game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
				end)
				wait(4)
			end
		end
	end
end

function Teleport()
	while wait() do
		pcall(function()
			TPStuffLol()
			if foundAnything ~= "" then
				TPStuffLol()
			end
		end)
	end
end

function CheckIfCrateIsThere()
	if not game:GetService("Workspace").MouseIgnore:FindFirstChild("ChikaraCrate") then
		Teleport()
	end
end

function TPAuto()
	wait(TPTime)
	Teleport()
end

if _G.Enabled == true then
	Noclip()
	AntiAfkIg()
	while wait() do
		TPAuto()
		CheckIfLoaded()
		CheckIfCrateIsThere()
		TPStuffIdfk()
	end
end


-- I gave up lol
