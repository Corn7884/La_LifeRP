-- Initialize global jobs legal vars
onJobLegal = 0
EndingDay = false
myjob = 0
ShowMsgtime = { msg = "", time = 0 }

RegisterNetEvent("jobslegal:getJobs")
AddEventHandler("jobslegal:getJobs", function(job)
	myjob = job
end)


job = {
	plate = 0,
}

RegisterNetEvent("job:f_GetIdentifier")
AddEventHandler("job:f_GetIdentifier", function(plate)
	job.plate = plate
end)

	TriggerServerEvent("job:GetIdentifier")

AddEventHandler("playerSpawned", function()
	TriggerServerEvent("job:GetIdentifier")
end)

ArgentJoueur = 0

RegisterNetEvent("job:f_getCash")
AddEventHandler("job:f_getCash", function(argent)
  ArgentJoueur = argent
end)

AddEventHandler("job:getJobInfos", function()
  TriggerEvent("fivemenu:f_getJobInfos", onJobLegal)
end)

AddEventHandler("job:setJobInfos", function(param)
  onJobLegal = param
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxtpool(ShowMsgtime.msg, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)

RegisterNetEvent("jobslegal:updateonJobLegal")
AddEventHandler("jobslegal:updateonJobLegal", function(status)
  onJobLegal = status
end)

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
        ClearPrints()
        SetTextEntry_2("STRING")
        AddTextComponentString(text)
        DrawSubtitleTimed(time, 1)
end)

-- When the player have left the job he was doing.
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if onJobLegal == 2 then
      clearJob()
    end
  end
end)

function clearJob()
  if ( DoesEntityExist(MISSION.truck) ) then
    SetEntityAsNoLongerNeeded(MISSION.truck)
    SetVehicleDoorsLocked(MISSION.truck, 2)
    SetVehicleUndriveable(MISSION.truck, true)

    local temptruck = MISSION.truck

    MISSION.truck = 0

    Wait(2000)
    SetEntityAsMissionEntity(temptruck, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(temptruck))
  end
  onJobLegal = 0
  Citizen.Trace("Cleared")
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if onJobLegal == 3 then
      clearJob2()
    end
  end
end)

function clearJob2()
  if ( DoesEntityExist(MISSION.truck2) ) then
    SetEntityAsNoLongerNeeded(MISSION.truck2)
    SetVehicleDoorsLocked(MISSION.truck2, 2)
    SetVehicleUndriveable(MISSION.truck2, true)

    local temptruck2 = MISSION.truck2

    MISSION.truck2 = 0

    Wait(2000)
    SetEntityAsMissionEntity(temptruck2, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(temptruck2))
  end
  onJobLegal = 0
  Citizen.Trace("Cleared")
end

-----------------------Affichage blip vestiaire--------------------------------

local DrawMarkerShow = true

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if DrawMarkerShow then
      DrawMarker(0,-1888.99267578125,2049.65966796875,139.984771728516,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)--vigneron
      DrawMarker(0,2906.1315917969,4406.9545898438,49.162428283691,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)--ferme
      DrawMarker(0,-1593.9884033203,5192.3881835938,3.3100876808167,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)--peche
      DrawMarker(0,895.14135742188,-179.02168273926,73.700256347656,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)--taxi
    end
  end
end)