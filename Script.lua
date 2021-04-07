--//Settings//--
_G.Enabled = true

--//Script//--
if game:IsLoaded() then
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

wait(1)

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
function CrateTP()
	for k,v in pairs(game:GetService("Workspace").MouseIgnore:GetDescendants()) do
		if v:IsA("ClickDetector")  and v.Parent.Name == 'ClickBox'  then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Parent.CFrame.X,v.Parent.CFrame.Y + -5,v.Parent.CFrame.Z)
			wait(0.2)
			fireclickdetector(v)
		end
	end
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
								delfile("NotSameServers.json")
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
						writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
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
	
if _G.Enabled == true then
Noclip()
CheckIfLoaded()
while wait() do
CheckIfCrateIsThere()
wait(0.1)
CrateTP()
end
end
end
