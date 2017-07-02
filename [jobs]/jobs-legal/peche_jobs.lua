----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = false
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local Prixpoisson = 1500
local Prixsushi = 1500
local qte = 0
local camionSortie = false
local bateauSortie = false
local vehicle
local bateau
local money = 0
local carJob = false
local batJob = false
local Position = {
  Compagnie={x=-1609.0318603516,y=5254.5454101563,z=2.9741013050079,distance=3},
  Vestiairepeche={x=-1593.786,y=5192.237,z=3.210,distance=2},
  SpawnCamion={x=-1575.8231201172,y=5162.3154296875,z=18.630516052246,distance=3},
  Spawnbateau={x=-1600.7421875,y=5264.498046875,z=-2.1694931268692,distance=10},
  Recolet={x=-1845.7663574219,y=5810.3120117188,z=1.0663683414459, distance=30},
  traitement={x=969.90081787109,y=-1637.5791015625,z=28.685180664063, distance=10},
  traitement2={x=-2192.85,y=4282.76,z=48.076, distance=10},
  traitement3={x=-569.87377929688,y=-1032.3819580078,z=20.978121566772, distance=10},
  vente={x=-1049.2591552734,y=-1397.1511230469,z=4.4230842590332, distance=10},
  vente2={x=312.24014282227,y=196.04663085938,z=103.07614746094, distance=10},
}

local Blipport
local BlipTraitement2
local BlipTraitement3
local BlipVente
local BlipVentesushi

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

local poisson = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)

Citizen.CreateThread(function()
  --Création des blips pour les faire aparaitre et disparaitre --
  if DrawBlipTradeShow then
    SetBlipTrade(68, "~g~ Port de peche", 15, Position.Vestiairepeche.x, Position.Vestiairepeche.y, Position.Vestiairepeche.z)
  end

  while true do
    Citizen.Wait(0)
    if DrawMarkerShow then
      DrawMarker(1, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    --DrawMarker(1, Position.Vestiairepeche.x, Position.Vestiairepeche.y, Position.Vestiairepeche.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 86, 27, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
      DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.vente2.x, Position.vente2.y, Position.vente2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 16.0, 16.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.Spawnbateau.x, Position.Spawnbateau.y, Position.Spawnbateau.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 86, 27, 75, 0, 0, 2, 0, 0, 0, 0)
	    DrawMarker(1, Position.SpawnCamion.x, Position.SpawnCamion.y, Position.SpawnCamion.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 86, 27, 75, 0, 0, 2, 0, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    if(IsInVehicle()) then
      if(IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("benson", _r))) then
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
      if(IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("tug", _r))) then
        batJob = true
        Wait(400000)
      else
        batJob = false
      end
    else
      batJob = false
    end
    Wait(5000)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))
	-------------------------------------------Vestiairepeche-----------------------------------------------------
	local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Vestiairepeche.x, Position.Vestiairepeche.y, Position.Vestiairepeche.z, true)
    if not IsInVehicle() then
      if distance < Position.Vestiairepeche.distance then
	    ShowInfo('~b~Appuyer sur ~g~E~b~ pour prendre votre service ~g~N~b~ pour le quitter', 0)
		  if myjob == 15 then 
			if IsControlJustPressed(1,38) then
			  TriggerEvent("vmenu:JobOutfit", 8, 124)
			  AfficherBlippeche()
			  DrawMarkerShow = true
			  Wait(200)
			elseif IsControlJustPressed(1,249) then
			  EndingDay = true
			  pecheEnding3()
			end
		  else
            ShowMsgtime.msg = '~r~ Vous devez être pécheur !'
            ShowMsgtime.time = 150
		  end  
	  end
	end
	---------------------------------------bateau-------------------------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Compagnie.x, Position.Compagnie.y, Position.Compagnie.z, true)
    if not IsInVehicle() then
      if distance < Position.Compagnie.distance then
        if onJobLegal == 0 then
          ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir votre bateau', 0)
          if IsControlJustPressed(1,38) then
            TriggerServerEvent("poleemploi:getjobs")
            TriggerServerEvent("job:getCash_s")
			DrawMarkerShow = true
            Wait(200)
            if myjob == 15 then
              if ArgentJoueur >= 1000 then
                onJobLegal = 1
                local car = GetHashKey("tug")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                TriggerEvent("vmenu:JobOutfit", 8, 124)
                bateau =  CreateVehicle(car, Position.Spawnbateau.x,  Position.Spawnbateau.y,  Position.Spawnbateau.z, 19.870, true, false)
                MISSION.truck2 = bateau
                SetVehicleOnGroundProperly(bateau)
				        SetVehicleNumberPlateText(bateau, job.plate)
				        Wait(100)
				        SetVehicleHasBeenOwnedByPlayer(bateau,true)
                SetVehRadioStation(bateau, "OFF")
                SetVehicleLivery(bateau, 4)
                SetPedIntoVehicle(GetPlayerPed(-1), bateau, -1)
                SetVehicleEngineOn(bateau, true, false, false)
                SetEntityAsMissionEntity(bateau, true, true)
                Wait(100)
                Citizen.Wait(1)
                bateauSortie = true
                AfficherBlippeche()
                TriggerServerEvent("job:removeMoney",1000)
                ShowMsgtime.msg = "Allez pécher et n'oubliez pas de ramener le bateau pour être remboursé"
                ShowMsgtime.time = 300
              else
                ShowMsgtime.msg = "Vous devez fournir 1000$ de caution pour prendre le bateau"
                ShowMsgtime.time = 300
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être pécheur !'
              ShowMsgtime.time = 150
            end
          end
        else
          if myjob == 15 then
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre bateau', 0)
            if IsControlJustPressed(1,38) and EndingDay == false then
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)

              TriggerServerEvent("job:addMoney",1000)
              pecheEnding2()
              ShowMsgtime.msg = "~r~ Vous avez été remboursé"
              ShowMsgtime.time = 300
              money = 0
            end
          end
        end
      end
    end
---------------------------------------camion-------------------------------------------------------------	
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.SpawnCamion.x, Position.SpawnCamion.y, Position.SpawnCamion.z, true)
    if not IsInVehicle() then
      if distance < Position.SpawnCamion.distance then
        if onJobLegal == 0 then
          ShowInfo('~b~Appuyer sur ~g~E~b~ pour obtenir votre camion', 0)
          if IsControlJustPressed(1,38) then
            TriggerServerEvent("poleemploi:getjobs")
            TriggerServerEvent("job:getCash_s")
			DrawMarkerShow = true
            Wait(200)
            if myjob == 15 then
              if ArgentJoueur >= 3000 then
                onJobLegal = 1
                local car = GetHashKey("benson")
                RequestModel(car)
                while not HasModelLoaded(car) do
                  Wait(1)
                end
                TriggerEvent("vmenu:JobOutfit", 8, 124)
                vehicle =  CreateVehicle(car, Position.SpawnCamion.x,  Position.SpawnCamion.y,  Position.SpawnCamion.z, 190.664, true, false)
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
                AfficherBlippeche()
                TriggerServerEvent("job:removeMoney",3000)
                ShowMsgtime.msg = "Allez travailler et n'oubliez pas de ramener le camion pour être remboursé"
                ShowMsgtime.time = 300
              else
                ShowMsgtime.msg = "Vous devez fournir 3000$ de caution pour prendre le véhicule"
                ShowMsgtime.time = 300
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être pécheur !'
              ShowMsgtime.time = 150
            end
          end
        else
          if myjob == 15 then
            ShowInfo('~b~Appuyer sur ~g~E~b~ pour ranger votre camion', 0)
            if IsControlJustPressed(1,38) then
              TriggerServerEvent("poleemploi:getjobs")
              Wait(100)

              TriggerServerEvent("job:addMoney",3000)
              pecheEnding()
              ShowMsgtime.msg = "~r~ Vous avez été remboursé"
              ShowMsgtime.time = 300
              money = 0
            end
          end
        end
      end
    end
-------------------------------------recolte poisson------------------------------------------------------
    if onJobLegal == 1 and myjob == 15 then
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
      if not IsInVehicle() then
        if distance < Position.Recolet.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour pécher', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 15 then
              if batJob == true then
                TriggerEvent("player:getQuantity", 25)
                poisson = qte
                Wait(100)
                Citizen.Wait(1)
                if (poisson) < 30 then
                  ShowMsgtime.msg = 'Pèche en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~poisson'
                  ShowMsgtime.time = 150
                  TriggerEvent("player:receiveItem", 25, 1)

                else
                  ShowMsgtime.msg = '~r~ Inventaire plein, allez au traitement !'
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être pécheur !'
              ShowMsgtime.time = 150
            end
          end
        end
      end	
-------------------------------------------traitement poisson-------------------------------------------------------------
	  local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, true)
      if not IsInVehicle() then
        if distance < Position.traitement2.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour nettoyer le ~b~poisson', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 15 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 25)
                poisson = qte

                local poisson_trait = 0
                
                TriggerEvent("player:getQuantity", 32)
                poisson_trait = qte
                
                Wait(100)
                if poisson ~= 0 and (poisson_trait) < 90 then
                  ShowMsgtime.msg = '~g~ Traitement ~b~du poisson'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Poisson nettoyé'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 25, 1)
                  TriggerEvent("player:receiveItem", 32, 1)
                
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de poisson ou trop de poisson nettoyé sur vous !"
                  ShowMsgtime.time = 300
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être pécheur !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
--------------------------------------------traitement sushi----------------------------------------------------------------------------
	  local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z, true)
      if not IsInVehicle() then
        if distance < Position.traitement3.distance then
          ShowInfo('~b~Appuyez sur ~g~E~b~ pour préparer des ~b~sushi', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 15 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 32)
                poissonnet = qte

                Wait(100)
                if poissonnet ~= 0 then
                  ShowMsgtime.msg = '~g~ Préparation de sushi ~b~en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ + 1 ~b~Sushi'
                  ShowMsgtime.time = 150

                  TriggerEvent("player:looseItem", 32, 1)
                  TriggerEvent("player:receiveItem", 33, 1)
                
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de poisson !"
                  ShowMsgtime.time = 300
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être pécheur !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
---------------------------------------------------Vente poisson--------------------------------------------------------
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
      if not IsInVehicle() then
        if distance < Position.vente.distance then
          ShowInfo('~b~ Appuyez sur ~g~E~b~ pour vendre', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 15 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 32)
                poissonnet = qte
                Wait(100)
                if poissonnet ~= 0 then
                  ShowMsgtime.msg = '~g~ Vente de poisson~b~ en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 poisson vendu + ' .. ' ' .. Prixpoisson .. '$'
                  ShowMsgtime.time = 150
                  TriggerEvent("inventory:sell",0, 1, 32, Prixpoisson, "")
                  money = money + Prixpoisson
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de poisson !"
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être pécheur !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
---------------------------------------------------Vente sushi--------------------------------------------------------
      local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente2.x, Position.vente2.y, Position.vente2.z, true)
      if not IsInVehicle() then
        if distance < Position.vente2.distance then
          ShowInfo('~b~ Appuyez sur ~g~E~b~ pour vendre', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 15 then
              if carJob == true then
                TriggerEvent("player:getQuantity", 33)
                sushi = qte
                Wait(100)
                if sushi ~= 0 then
                  ShowMsgtime.msg = '~g~ Vente de sushi~b~ en cours'
                  ShowMsgtime.time = 250
                  Wait(2500)
                  ShowMsgtime.msg = '~g~ 1 sushi vendu + ' .. ' ' .. Prixsushi .. '$'
                  ShowMsgtime.time = 150
                  TriggerEvent("inventory:sell",0, 1, 33, Prixsushi, "")
                  money = money + Prixsushi
                else
                  ShowMsgtime.msg = "~r~ Vous n'avez plus de sushi !"
                  ShowMsgtime.time = 150
                end
              else
                ShowMsgtime.msg = '~r~ Vous devez avoir été dans le bon véhicule dans les 5 dernières minutes !'
                ShowMsgtime.time = 150
              end
            else
              ShowMsgtime.msg = '~r~ Vous devez être pécheur !'
              ShowMsgtime.time = 150
            end
          end
        end
      end
-----------------------------------------------------------------------------------------------------------------
	end  
  end
end)

function AfficherBlippeche()

  Blipport = AddBlipForCoord(Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)

  SetBlipSprite(Blipport, 416)
  SetBlipColour(Blipport, 2)
  SetBlipAsShortRange(Blipport, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Zone de pèche')
  EndTextCommandSetBlipName(Blipport)

  
  BlipTraitement2 = AddBlipForCoord(Position.traitement2.x, Position.traitement2.y, Position.traitement2.z)

  SetBlipSprite(BlipTraitement2, 416)
  SetBlipColour(BlipTraitement2, 38)
  SetBlipAsShortRange(BlipTraitement2, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement des surgelé')
  EndTextCommandSetBlipName(BlipTraitement2)
  
  BlipTraitement3 = AddBlipForCoord(Position.traitement3.x, Position.traitement3.y, Position.traitement3.z)

  SetBlipSprite(BlipTraitement3, 416)
  SetBlipColour(BlipTraitement3, 38)
  SetBlipAsShortRange(BlipTraitement3, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement des sushis')
  EndTextCommandSetBlipName(BlipTraitement3)

  BlipVente = AddBlipForCoord(Position.vente.x, Position.vente.y, Position.vente.z)

  SetBlipSprite(BlipVente, 416)
  SetBlipColour(BlipVente, 49)
  SetBlipAsShortRange(BlipVente, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Vente de poisson')
  EndTextCommandSetBlipName(BlipVente)
  
  BlipVentesushi = AddBlipForCoord(Position.vente2.x, Position.vente2.y, Position.vente2.z)

  SetBlipSprite(BlipVentesushi, 416)
  SetBlipColour(BlipVentesushi, 49)
  SetBlipAsShortRange(BlipVentesushi, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Vente sushi')
  EndTextCommandSetBlipName(BlipVentesushi)
  

end

function pecheEnding()
  Wait(100)
  onJobLegal = 2
  camionSortie = false
end

RegisterNetEvent("jobslegal:pecheEnding")
AddEventHandler("jobslegal:pecheEnding", function()
  pecheEnding3()
end)

function pecheEnding2()
  Wait(100)
  onJobLegal = 3
  bateauSortie = false
end

function pecheEnding3()
  removeBlippeche()
  Wait(100)
  DrawMarkerShow = false
  TriggerServerEvent("vmenu:lastChar")
end

function removeBlippeche()
  RemoveBlip(BlipVente)
  RemoveBlip(BlipVentesushi)
  RemoveBlip(BlipTraitement2)
  RemoveBlip(BlipTraitement3)
  RemoveBlip(Blipport)
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
