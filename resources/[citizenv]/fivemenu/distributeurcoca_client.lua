-------- DISTANCE ENTRE JOUEUR ET POINT
function IsNearPoints(area, dist)
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	for _, item in pairs(area) do
		local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance <= dist) then
			return true
		end
	end
end

function Info(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end

local MoneyOk = false

RegisterNetEvent("inventory:MoneyOk")
AddEventHandler("inventory:MoneyOk", function(param) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	MoneyOk = param
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if (IsNearPoints(distributeurcoca, 1.01) == true)  then
			if IsControlJustPressed(1, 38)  then
				TriggerServerEvent("inventory:checkMoneyDistrib", 20)
				Wait(200)
				if MoneyOk then
					TriggerEvent("player:receiveItem", 34, 1)
					MoneyOk = false
					DrawNotif("~g~Vous avez acheté une canette de coca ~s~.")
				end
				Wait(2000)
			end
		end
		if (IsNearPoints(distributeurcoca, 1.01) == true)  then
			Info('Appuyer sur ~g~E~s~ pour acheter un coca', false)
		end
	end
end)

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end