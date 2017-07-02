----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = false
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local Prixfarine = 1500
local Prixpain = 1500
local qte = 0
local camionSortie = false
local tracteurSortie = false
local vehicle
local tracteur
local money = 0
local carJob = false
local tracJob = false
local Position = {
  Compagnie={x=2887.5046386719,y=4473.6264648438,z=47.003829193115,distance=5},
  Vestiaireferme={x=2906.1315917969,y=4406.9545898438,z=49.162428283691,distance=2},
  SpawnCamion={x=2887.5046386719,y=4473.6264648438,z=47.003829193115,distance=5},
  SpawnRemorque={x=2862.0205078125,y=4506.939453125,z=47.785755157471,distance=3},
  SpawnTracteur={x=2218.7561035156,y=5157.2236328125,z=56.305309295654,distance=3},
  Recolet={x=2152.3002929688,y=5184.0751953125,z=55.926822662354, distance=10},
  traitement={x=2897.154296875,y=4382.2465820313,z=49.381404876709, distance=10},
  traitement2={x=996.59301757813,y=-1403.6798095703,z=30.277332305908, distance=10},
  vente={x=981.361999511719,y=-2443.95190429688,z=27.924825668335, distance=10},
  vente2={x=15.674163818359,y=-1345.1258544922,z=28.289693832397, distance=10},
}

local BlipBle
local BlipTraitement
local BlipTraitement2
local BlipVenteBle
local BlipVentePain

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x, y)
end

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

local ble = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)

Citizen.CreateThread(function()
  --Création des blips pour les faire aparaitre et disparaitre --
  if DrawBlipTradeShow then
    SetBlipTrade(211, "~g~ Ferme de blé", 2, Position.Vestiaireferme.x, Position.Vestiaireferme.y, Position.Vestiaireferme.z)
  end

  while true do
    Citizen.Wait(0)
    if DrawMarkerShow then
      DrawMarker(1, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    --DrawMarker(1, Position.Vestiaireferme.x, Position.Vestiaireferme.y, Position.Vestiaireferme.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 86, 27, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.vente2.x, Position.vente2.y, Position.vente2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.SpawnTracteur.x, Position.SpawnTracteur.y, Position.SpawnTracteur.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 86, 27, 75, 0, 0, 2, 0, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    if(IsInVehicle()) then
      if(IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("packer", _r))) then
        carJob = true
        Wait(400000)
      else
        carJob = false
      end
    else
      carJob = false
    end
    Wait(5000)
  end
end)

Citizen.CreateThread(function()
  while true do
    if(IsInVehicle()) then
      if(IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("tractor2", _r))) then
        tracJob = true
        Wait(400000)
      else
        tracJob = false
      end
    else
      tracJob = false
    end
    Wait(5000)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))
	-------------------------------------------Vestiaireferme-----------------------------------------------------
	local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Vestiaireferme.x, Position.Vestiaireferme.y, Position.Vestiaireferme.z, true)
    if not IsInVehicle() then
      if distance < Position.Vestiaireferme.distance then
	    ShowInfo('~b~Appuyer sur ~g~E~b~ pour prendre votre service ~g~N~b~ pour le quitter', 0)
		  if myjob == 14 then 
			if IsControlJustPressed(1,38) then
			  TriggerEvent("vmenu:JobOutfit", 19, 109)
			  AfficherBlipferme()
			  DrawMarkerShow = true
			  Wait(200)
			elseif IsControlJustPressed(1,249) then
			  EndingDay = true
			  fermeEnding3()
			end
		  else
            ShowMsgtime.msg = '~r~ Vous devez être fermier !'
            ShowMsgtime.time = 150
		  end  
	  end
	end
-------------------------------------------------------------------------------------------------	
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, true)
    if not IsInVehicle() then
      if distance < Position.Compagnie.distance then
        if onJobLegal == 0 then
          ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir votre camion', 0)
          if IsControlJustPressed(1,38) then
            TriggerServerEvent("poleemploi:getjobs")
            TriggerServerEvent("job:getCash_s")
			DrawMarkerShow = true
            Wait(200)
            if myjob == 14 then
              if ArgentJoueur >= 3000 then
                onJobLegal = 1
                local car = GetHashKey("packer")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                TriggerEvent("vmenu:JobOutfit", 19, 109)
                vehicle =  CreateVehicle(car, Position.SpawnCamion.x,  Position.SpawnCamion.y,  Position.SpawnCamion.z, 63.843, true, false)
                MISSION.truck = vehicle
                SetVehicleOnGroundProperly(vehicle)
				        SetVehicleNumberPlateText(vehicle, job.plate)
				        Wait(100)
				        SetVehicleHasBeenOwnedByPlayer(vehicle,true)
                SetVehRadioStation(vehicle, "OFF")
                SetVehicleColours(vehicle, 25, 25)
                SetVehicleLivery(vehicle, 4)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                SetVehicleEngineOn(vehicle, true, false, false)
                SetEntityAsMissionEntity(vehicle, true, true)
                Wait(100)
				local car = GetHashKey("trailers")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                vehicle =  CreateVehicle(car, Position.SpawnRemorque.x,  Position.SpawnRemorque.y,  Position.SpawnRemorque.z, 150.072, true, false)
                SetVehicleOnGroundProperly(vehicle)
				        SetVehicleNumberPlateText(vehicle, job.plate)
				        Wait(100)
				        SetVehicleHasBeenOwnedByPlayer(vehicle,true)
                SetVehRadioStation(vehicle, "OFF")
                SetVehicleColours(vehicle, 25, 25)
                SetVehicleLivery(vehicle, 4)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                SetVehicleEngineOn(vehicle, true, false, false)
                SetEntityAsMissionEntity(vehicle, true, true)
                Wait(100)
                Citizen.Wait(1)
                camionSortie = true
                AfficherBlipferme()
                TriggerServerEvent("job:removeMoney",3000)
                ShowMsgtime.msg = "Allez au champ et n'oubliez pas de ramener le camion pour être remboursé"
                ShowMsgtime.time = 300
              else
                ShowMsgtime.msg = "Vous devez fournir 3000$ de caution pour prendre le véhicule"
                ShowMsgtime.time = 300
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être fermier !'
              ShowMsgtime.time = 150
            end
          end
        else
          if myjob == 14 then
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre camion', 0)
            if IsControlJustPressed(1,38) then
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)

              TriggerServerEvent("job:addMoney",3000)
              fermeEnding()
              ShowMsgtime.msg = "~r~ Vous avez été remboursé"
              ShowMsgtime.time = 300
              money = 0
            end
          end
        end
      end
    end
---------------------------------------Tracteur-------------------------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.SpawnTracteur.x, Position.SpawnTracteur.y, Position.SpawnTracteur.z, true)
    if not IsInVehicle() then
      if distance < Position.SpawnTracteur.distance then
        if tracteurSortie == false then
          ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir votre tracteur', 0)
          if IsControlJustPressed(1,38) then
            TriggerServerEvent("poleemploi:getjobs")
            TriggerServerEvent("job:getCash_s")
            Wait(200)
            if myjob == 14 then
              if ArgentJoueur >= 1000 then
                onJobLegal = 1
                local car = GetHashKey("tractor2")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                TriggerEvent("vmenu:JobOutfit", 19, 109)
                tracteur =  CreateVehicle(car, Position.SpawnTracteur.x,  Position.SpawnTracteur.y,  Position.SpawnTracteur.z, 314.020, true, false)
                MISSION.truck2 = tracteur
                SetVehicleOnGroundProperly(tracteur)
				        SetVehicleNumberPlateText(tracteur, job.plate)
				        Wait(100)
				        SetVehicleHasBeenOwnedByPlayer(tracteur,true)
                SetVehRadioStation(tracteur, "OFF")
                SetVehicleLivery(tracteur, 4)
                SetPedIntoVehicle(GetPlayerPed(-1), tracteur, -1)
                SetVehicleEngineOn(tracteur, true, false, false)
                SetEntityAsMissionEntity(tracteur, true, true)
                Wait(100)
                Citizen.Wait(1)
                tracteurSortie = true
                AfficherBlipferme()
                TriggerServerEvent("job:removeMoney",1000)
                ShowMsgtime.msg = "Allez au champ et n'oubliez pas de ramener le tracteur pour être remboursé"
                ShowMsgtime.time = 300
              else
                ShowMsgtime.msg = "Vous devez fournir 3000$ de caution pour prendre le véhicule"
                ShowMsgtime.time = 300
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être fermier !'
              ShowMsgtime.time = 150
            end
          end
        else
          if myjob == 14 then
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre tracteur', 0)
            if IsControlJustPressed(1,38) then
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)

              TriggerServerEvent("job:addMoney",1000)
              fermeEnding2()
              ShowMsgtime.msg = "~r~ Vous avez été remboursé"
              ShowMsgtime.time = 300
              money = 0
            end
          end
        end
      end
    end
-------------------------------------recolte ble------------------------------------------------------
    if onJobLegal == 1 and myjob == 14 then
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
      if not IsInVehicle() then
        if distance < Position.Recolet.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour recolter le blé', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
              if tracJob == true then
                TriggerEvent("player:getQuantity", 28)
                ble = qte
                Wait(100)
                Citizen.Wait(1)
                if (ble) < 30 then
                  ShowMsgtime.msg = 'Recolte du blé'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~blé'
                  ShowMsgtime.time = 150
                  TriggerEvent("player:receiveItem", 28, 1)

                else
                  ShowMsgtime.msg = '~r~ Inventaire plein, allez au traitement !'
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être mineur !'
              ShowMsgtime.time = 150
            end
          end
        end
      end	
-------------------------------------------traitement ble-------------------------------------------------------------
	  local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement.x, Position.traitement.y, Position.traitement.z, true)
      if not IsInVehicle() then
        if distance < Position.traitement.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour traiter le ~b~blé', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 28)
                ble = qte

                local ble_trait = 0
                
                TriggerEvent("player:getQuantity", 29)
                ble_trait = qte
                
                Wait(100)
                if ble ~= 0 and (ble_trait) < 90 then
                  ShowMsgtime.msg = '~g~ Traitement ~b~du blé'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Farine'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 28, 1)
                  TriggerEvent("player:receiveItem", 29, 1)
                
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de blé à traiter ou trop de farine sur vous !"
                  ShowMsgtime.time = 300
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être fermier !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
--------------------------------------------traitement farine----------------------------------------------------------------------------
	  local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, true)
      if not IsInVehicle() then
        if distance < Position.traitement2.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour cuire du ~b~pain', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 29)
                farine = qte

                Wait(100)
                if farine ~= 0 then
                  ShowMsgtime.msg = '~g~ Cuisson du pain ~b~en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Pain'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 29, 1)
                  TriggerEvent("player:receiveItem", 30, 1)
                
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de farine à traiter !"
                  ShowMsgtime.time = 300
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être fermier !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
---------------------------------------------------Vente farine--------------------------------------------------------
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
      if not IsInVehicle() then
        if distance < Position.vente.distance then
          ShowInfo('~b~ Appuyez sur ~g~E~b~ pour vendre', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 29)
                farine = qte
                Wait(100)
                if farine ~= 0 then
                  ShowMsgtime.msg = '~g~ Vente de la farine~b~ en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 farine vendu + ' .. ' ' .. Prixfarine .. '$'
                  ShowMsgtime.time = 150
                  TriggerEvent("inventory:sell",0, 1, 29, Prixfarine, "")
                  money = money + Prixfarine
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de farine !"
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être fermier !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
---------------------------------------------------Vente pain--------------------------------------------------------
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente2.x, Position.vente2.y, Position.vente2.z, true)
      if not IsInVehicle() then
        if distance < Position.vente2.distance then
          ShowInfo('~b~ Appuyez sur ~g~E~b~ pour vendre', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 30)
                pain = qte
                Wait(100)
                if pain ~= 0 then
                  ShowMsgtime.msg = '~g~ Vente du pain~b~ en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 pain vendu + ' .. ' ' .. Prixpain .. '$'
                  ShowMsgtime.time = 150
                  TriggerEvent("inventory:sell",0, 1, 30, Prixpain, "")
                  money = money + Prixpain
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de pain !"
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être fermier !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
-----------------------------------------------------------------------------------------------------------------
	end  
  end
end)

function AfficherBlipferme()

  BlipBle = AddBlipForCoord(Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)

  SetBlipSprite(BlipBle, 416)
  SetBlipColour(BlipBle, 2)
  SetBlipAsShortRange(BlipBle, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Recolte du blé')
  EndTextCommandSetBlipName(BlipBle)

  BlipTraitement = AddBlipForCoord(Position.traitement.x, Position.traitement.y, Position.traitement.z)

  SetBlipSprite(BlipTraitement, 416)
  SetBlipColour(BlipTraitement, 38)
  SetBlipAsShortRange(BlipTraitement, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement du blé')
  EndTextCommandSetBlipName(BlipTraitement)
  
  BlipTraitement2 = AddBlipForCoord(Position.traitement2.x, Position.traitement2.y, Position.traitement2.z)

  SetBlipSprite(BlipTraitement2, 416)
  SetBlipColour(BlipTraitement2, 38)
  SetBlipAsShortRange(BlipTraitement2, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement de la farine')
  EndTextCommandSetBlipName(BlipTraitement2)

  BlipVenteBle = AddBlipForCoord(Position.vente.x, Position.vente.y, Position.vente.z)

  SetBlipSprite(BlipVenteBle, 416)
  SetBlipColour(BlipVenteBle, 49)
  SetBlipAsShortRange(BlipVenteBle, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Vente farine')
  EndTextCommandSetBlipName(BlipVenteBle)
  
  BlipVentePain = AddBlipForCoord(Position.vente2.x, Position.vente2.y, Position.vente2.z)

  SetBlipSprite(BlipVentePain, 416)
  SetBlipColour(BlipVentePain, 49)
  SetBlipAsShortRange(BlipVentePain, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Vente pain')
  EndTextCommandSetBlipName(BlipVentePain)
  

end

function fermeEnding()
  Wait(100)
  onJobLegal = 2
  camionSortie = false
end

RegisterNetEvent("jobslegal:fermeEnding")
AddEventHandler("jobslegal:fermeEnding", function()
  fermeEnding3()
end)

function fermeEnding2()
  Wait(100)
  onJobLegal = 3
  tracteurSortie = false
end

function fermeEnding3()
  removeBlipferme()
  Wait(100)
  DrawMarkerShow = false
  TriggerServerEvent("vmenu:lastChar")
end

function removeBlipferme()
  RemoveBlip(BlipVenteBle)
  RemoveBlip(BlipVentePain)
  RemoveBlip(BlipTraitement)
  RemoveBlip(BlipTraitement2)
  RemoveBlip(BlipBle)
end

function SetBlipTrade(id, text, color, x, y, z)
  local Blip = AddBlipForCoord(x, y, z)

  SetBlipSprite(Blip, id)
  SetBlipColour(Blip, color)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(Blip)
end


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))
	
	  if onJobLegal == 1 and myjob == 14 then
	  local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
	    if not IsInVehicle() then
	      if distance < Position.Recolet.distance then
	        if IsControlJustPressed(1, 38) then
	          TriggerServerEvent("poleemploi:getjobs")
	          Wait(100)
	          if myjob == 14 then
	            if tracJob == true then
	            TriggerEvent("player:getQuantity", 28)
	            ble = qte
	            Wait(100)
	            Citizen.Wait(1)
	              if (ble) < 30 then
	               PlayScenario("WORLD_HUMAN_GARDENER_PLANT","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	               Wait(90000)
	              else
	               ClearPedTasksImmediately(GetPlayerPed(-1))
	              end
	            end
			  end
	        end
	      end
	    end
	  end
  end
end)	

function PlayScenario(param1, param2, param3)
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(GetPlayerPed(-1), param1, 0, 1)
		PlayAmbientSpeech1(GetPlayerPed(-1), param2, param3)
		Citizen.Wait(20000)
	end)
end