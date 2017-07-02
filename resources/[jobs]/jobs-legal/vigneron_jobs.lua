----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = false
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local Prixraisin = 1500
local Prixvin = 1500
local qte = 0
local camionSortie = false
local tracteurSortie = false
local vehicle
local tracteur
local money = 0
local carJob = false
local tracJob = false
local Position = {
  Compagnie={x=-1906.57, y=2040.54, z=139.738,distance=5},
  VestiaireVigne={x=-1888.99267578125,y=2049.65966796875,z=139.984771728516,distance=1.5},
  SpawnCamion={x=2887.5046386719,y=4473.6264648438,z=46.003829193115,distance=5},---1911.318, 2042.647, 139.737
  SpawnTracteur={x=-1918.6822509766,y=2063.9333496094,z=139.08775939941,distance=3},
  Recolet={x=-1767.95,y=2201.6,z=102.744,distance=10},
  traitement={x=-1876.2073974609,y=2082.5622558594,z=140.00671936035,distance=10},
  traitement2={x=840.893,y=-1952.84,z=27.6353,distance=10},
  vente={x=981.361999511719,y=-2443.95190429688,z=27.924825668335,distance=10},
  vente2={x=464.17755126953,y=-1851.5913085938,z=26.614085006714,distance=10},
}

local BlipRaisin
local BlipTraitement
local BlipTraitement2
local Blipvente
local Blipvente2

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

local Raisin = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)

Citizen.CreateThread(function()
  --Création des blips pour les faire aparaitre et disparaitre --
  if DrawBlipTradeShow then
    SetBlipTrade(93, "~g~ Copérative vignicole", 2, Position.VestiaireVigne.x, Position.VestiaireVigne.y, Position.VestiaireVigne.z)
  end

  while true do
    Citizen.Wait(0)
    if DrawMarkerShow then
      DrawMarker(1, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    --DrawMarker(1, Position.VestiaireVigne.x, Position.VestiaireVigne.y, Position.VestiaireVigne.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
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
      if(IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("mule", _r))) then
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
	-------------------------------------------Vestiaire-Vigne-----------------------------------------------------
	local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.VestiaireVigne.x, Position.VestiaireVigne.y, Position.VestiaireVigne.z, true)
    if not IsInVehicle() then
      if distance < Position.VestiaireVigne.distance then
	    ShowInfo('~b~Appuyer sur ~g~E~b~ pour prendre votre service ~g~N~b~ pour le quitter', 0)
		  if myjob == 16 then 
			if IsControlJustPressed(1,38) then
			  TriggerEvent("vmenu:JobOutfit", 19, 109)
			  AfficherBlipVigne()
			  DrawMarkerShow = true
			  Wait(200)
			elseif IsControlJustPressed(1,249) then
			  EndingDay = true
			  VigneEnding3()
			end
		  else
        ShowMsgtime.msg = '~r~ Vous devez être vigneron !'
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
            if myjob == 16 then
              if ArgentJoueur >= 3000 then
                onJobLegal = 1
                local car = GetHashKey("mule")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                TriggerEvent("vmenu:JobOutfit", 19, 109)
                vehicle =  CreateVehicle(car, Position.Compagnie.x,  Position.Compagnie.y,  Position.Compagnie.z, 191.511, true, false)
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
                Citizen.Wait(1)
                camionSortie = true
                AfficherBlipVigne()
                TriggerServerEvent("job:removeMoney",3000)
                ShowMsgtime.msg = "Allez au travailler et n'oubliez pas de ramener le camion pour être remboursé"
                ShowMsgtime.time = 300
              else
                ShowMsgtime.msg = "Vous devez fournir 3000$ de caution pour prendre le véhicule"
                ShowMsgtime.time = 300
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être vigneron !'
              ShowMsgtime.time = 150
            end
          end
        else
          if myjob == 16 then
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre camion', 0)
            if IsControlJustPressed(1,38) then
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)

              TriggerServerEvent("job:addMoney",3000)
              VigneEnding()
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
            if myjob == 16 then
              if ArgentJoueur >= 1000 then
                onJobLegal = 1
                local car = GetHashKey("tractor2")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                TriggerEvent("vmenu:JobOutfit", 19, 109)
                tracteur =  CreateVehicle(car, Position.SpawnTracteur.x,  Position.SpawnTracteur.y,  Position.SpawnTracteur.z, 23.944, true, false)
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
                AfficherBlipVigne()
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
          if myjob == 16 then
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre tracteur', 0)
            if IsControlJustPressed(1,38) then
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)

              TriggerServerEvent("job:addMoney",1000)
              VigneEnding2()
              ShowMsgtime.msg = "~r~ Vous avez été remboursé"
              ShowMsgtime.time = 300
              money = 0
            end
          end
        end
      end
    end
-------------------------------------recolte Raisin------------------------------------------------------
    if onJobLegal == 1 and myjob == 16 then
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
      if not IsInVehicle() then
        if distance < Position.Recolet.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour recolter le raisin', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 16 then
              if tracJob == true then
                TriggerEvent("player:getQuantity", 35)
                grapRaisin = qte
                Wait(100)
                Citizen.Wait(1)
                if (grapRaisin) < 30 then
                  ShowMsgtime.msg = 'Recolte du raisin'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~grappe de raisin'
                  ShowMsgtime.time = 150
                  TriggerEvent("player:receiveItem", 35, 1)

                else
                  ShowMsgtime.msg = '~r~ Inventaire plein, allez au traitement !'
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être vigneron !'
              ShowMsgtime.time = 150
            end
          end
        end
      end	
-------------------------------------------traitement Raisin-------------------------------------------------------------
	  local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement.x, Position.traitement.y, Position.traitement.z, true)
      if not IsInVehicle() then
        if distance < Position.traitement.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour nettoyer les ~b~grappes', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 16 then
              if tracJob == true then
                TriggerEvent("player:getQuantity", 35)
                grapRaisin = qte

                local Raisin_trait = 0
                
                TriggerEvent("player:getQuantity", 36)
                Raisin_trait = qte
                
                Wait(100)
                if grapRaisin ~= 0 and (Raisin_trait) < 90 then
                  ShowMsgtime.msg = '~g~ Traitement ~b~des grappes'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~raisin'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 35, 1)
                  TriggerEvent("player:receiveItem", 36, 1)
                
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de grappes ou trop de raisin sur vous !"
                  ShowMsgtime.time = 300
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être vigneron !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
--------------------------------------------traitement raisin----------------------------------------------------------------------------
	  local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, true)
      if not IsInVehicle() then
        if distance < Position.traitement2.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour traiter le ~b~raisin', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 16 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 36)
                raisin = qte

                Wait(100)
                if raisin ~= 0 then
                  ShowMsgtime.msg = '~g~ Cuvage du vin ~b~en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~bouteille de vin'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 36, 1)
                  TriggerEvent("player:receiveItem", 37, 1)
                
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de raisin à traiter !"
                  ShowMsgtime.time = 300
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être vigneron !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
---------------------------------------------------Vente raisin--------------------------------------------------------
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
      if not IsInVehicle() then
        if distance < Position.vente.distance then
          ShowInfo('~b~ Appuyez sur ~g~E~b~ pour vendre le raisin', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 16 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 36)
                raisin = qte
                Wait(100)
                if raisin ~= 0 then
                  ShowMsgtime.msg = '~g~ Vente de raisin~b~ en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 raisin vendu + ' .. ' ' .. Prixraisin .. '$'
                  ShowMsgtime.time = 150
                  TriggerEvent("inventory:sell",0, 1, 29, Prixraisin, "")
                  money = money + Prixraisin
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de raisin !"
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
---------------------------------------------------Vente vin--------------------------------------------------------
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente2.x, Position.vente2.y, Position.vente2.z, true)
      if not IsInVehicle() then
        if distance < Position.vente2.distance then
          ShowInfo('~b~ Appuyez sur ~g~E~b~ pour vendre du vin', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 16 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 37)
                vin = qte
                Wait(100)
                if vin ~= 0 then
                  ShowMsgtime.msg = '~g~ Vente du vin~b~ en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 bouteille de vin vendu + ' .. ' ' .. Prixvin .. '$'
                  ShowMsgtime.time = 150
                  TriggerEvent("inventory:sell",0, 1, 37, Prixvin, "")
                  money = money + Prixvin
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de vin !"
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être vigneron !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
-----------------------------------------------------------------------------------------------------------------
	end  
  end
end)

function AfficherBlipVigne()

  BlipRaisin = AddBlipForCoord(Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)

  SetBlipSprite(BlipRaisin, 416)
  SetBlipColour(BlipRaisin, 2)
  SetBlipAsShortRange(BlipRaisin, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Recolte du raisin')
  EndTextCommandSetBlipName(BlipRaisin)

  BlipTraitement = AddBlipForCoord(Position.traitement.x, Position.traitement.y, Position.traitement.z)

  SetBlipSprite(BlipTraitement, 416)
  SetBlipColour(BlipTraitement, 38)
  SetBlipAsShortRange(BlipTraitement, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement des grappes')
  EndTextCommandSetBlipName(BlipTraitement)
  
  BlipTraitement2 = AddBlipForCoord(Position.traitement2.x, Position.traitement2.y, Position.traitement2.z)

  SetBlipSprite(BlipTraitement2, 416)
  SetBlipColour(BlipTraitement2, 38)
  SetBlipAsShortRange(BlipTraitement2, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement du raisin')
  EndTextCommandSetBlipName(BlipTraitement2)

  Blipvente = AddBlipForCoord(Position.vente.x, Position.vente.y, Position.vente.z)

  SetBlipSprite(Blipvente, 416)
  SetBlipColour(Blipvente, 49)
  SetBlipAsShortRange(Blipvente, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Vente raisin')
  EndTextCommandSetBlipName(Blipvente)
  
  Blipvente2 = AddBlipForCoord(Position.vente2.x, Position.vente2.y, Position.vente2.z)

  SetBlipSprite(Blipvente2, 416)
  SetBlipColour(Blipvente2, 49)
  SetBlipAsShortRange(Blipvente2, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Vente vin')
  EndTextCommandSetBlipName(Blipvente2)
  

end

function VigneEnding()
  Wait(100)
  onJobLegal = 2
  camionSortie = false
end

RegisterNetEvent("jobslegal:VigneEnding")
AddEventHandler("jobslegal:VigneEnding", function()
  VigneEnding3()
end)

function VigneEnding2()
  Wait(100)
  onJobLegal = 3
  tracteurSortie = false
end

function VigneEnding3()
  removeBlipVigne()
  Wait(100)
  DrawMarkerShow = false
  camionSortie = false
  tracteurSortie = false
  TriggerServerEvent("vmenu:lastChar")
end

function removeBlipVigne()
  RemoveBlip(Blipvente)
  RemoveBlip(Blipvente2)
  RemoveBlip(BlipTraitement)
  RemoveBlip(BlipTraitement2)
  RemoveBlip(BlipRaisin)
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
