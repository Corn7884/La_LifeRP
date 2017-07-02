-- Configure the coordinates where the strippers should be placed.
local strippers = {
  {type=5, hash=0xC6B49A2F, x=-551.00311279297, y=287.16439819336, z=82.97664642334, a=74.685},
  }
  
local chanteur = {
  {type=5, hash=0xBE20FA04, x=-551.84497070313, y=284.24914550781, z=82.976654052734, a=69.136},
  }
  
local guitar2 = {
  {type=5, hash=0xF041880B, x=-551.16790771484, y=282.09521484375, z=82.976638793945, a=80.022},
  }
  
-- Configure the coordinates for the barman.
  local bartenders = {
    {type=5, hash=0x780c01bd, x=-561.85021972656, y=286.39947509766, z=82.17643737793, a=258.086},
  }

-- Configure the coordinates for the videur.
local bouncers = {
   {type=4, hash=0x9fd4292d, x=-566.28265380859, y=274.60015869141, z=83.019638061523, a=168.264},
   {type=4, hash=0x9fd4292d, x=-564.41882324219, y=279.46600341797, z=83.440460205078, a=175.925},
   {type=4, hash=0x9fd4292d, x=-563.51037597656, y=274.34335327148, z=83.0196, a=171.292},
}

function LocalPed()
  return GetPlayerPed(-1)
end

function StartText()
  ShowInfo("Appuis sur ~INPUT_CONTEXT~ pour boire un verre", 0)
end

Citizen.CreateThread(function()
  -- Load the ped modal barman(s_f_y_bartender_01)
  RequestModel(GetHashKey("s_f_y_bartender_01"))
  while not HasModelLoaded(GetHashKey("s_f_y_bartender_01")) do
    Wait(1)
  end

  -- Load the ped modal (mp_f_stripperlite)
  RequestModel(GetHashKey("U_M_Y_Guido_01"))
  while not HasModelLoaded(GetHashKey("U_M_Y_Guido_01")) do
    Wait(1)
  end
  
 -- Load the ped modal (mp_f_stripperlite)
  RequestModel(GetHashKey("U_M_Y_Hippie_01"))
  while not HasModelLoaded(GetHashKey("U_M_Y_Hippie_01")) do
    Wait(1)
  end
  
 -- Load the ped modal (mp_f_stripperlite)
  RequestModel(GetHashKey("S_M_Y_XMech_02"))
  while not HasModelLoaded(GetHashKey("S_M_Y_XMech_02")) do
    Wait(1)
  end

  -- Load the ped modal videur(s_m_m_bouncer_01)
  RequestModel(GetHashKey("s_m_m_bouncer_01"))
  while not HasModelLoaded(GetHashKey("s_m_m_bouncer_01")) do
    Wait(1)
  end

  -- Load the strip animation (testing)
  RequestAnimDict("missminuteman_1ig_1")
  while not HasAnimDictLoaded("missminuteman_1ig_1") do
    Wait(1)
  end
  
  -- Load the strip animation (testing)
  RequestAnimDict("amb@world_human_musician@guitar@male@idle_a")
  while not HasAnimDictLoaded("amb@world_human_musician@guitar@male@idle_a") do
    Wait(1)
  end

  -- Load the videur animation (testing)
  RequestAnimDict("mini@strip_club@idles@bouncer@base")
  while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
    Wait(1)
  end
  
    -- Spawn the barman to the coordinates
    bartender =  CreatePed(5, 0x780c01bd, -561.85021972656, 286.39947509766, 82.17643737793, 258.086, false, true)
    SetBlockingOfNonTemporaryEvents(bartender, true)
    SetPedCombatAttributes(bartender, 46, true)
    SetPedFleeAttributes(bartender, 0, 0)
    SetPedRelationshipGroupHash(bartender, GetHashKey("CIVFEMALE"))


  -- Spawn the videurs to the coordinates
  for _, item in pairs(bouncers) do
    ped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    GiveWeaponToPed(ped, 0x1B06D571, 2800, false, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetPedArmour(ped, 100)
    SetPedMaxHealth(ped, 100)
    SetPedRelationshipGroupHash(ped, GetHashKey("army"))
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GUARD_STAND_PATROL", 0, true)
    SetPedCanRagdoll(ped, false)
    SetPedDiesWhenInjured(ped, false)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end

  -- Spawn the strippers to the coordinates
  for _, item in pairs(strippers) do
    strippers =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    SetPedCombatAttributes(strippers, 46, true)
    SetPedFleeAttributes(strippers, 0, 0)
    SetPedRelationshipGroupHash(strippers, GetHashKey("CIVFEMALE"))
    TaskPlayAnim(strippers,"amb@world_human_musician@guitar@male@idle_a","idle_a", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
  
  for _, item in pairs(guitar2) do
    guitar2 =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    SetPedCombatAttributes(guitar2, 46, true)
    SetPedFleeAttributes(guitar2, 0, 0)
    SetPedRelationshipGroupHash(guitar2, GetHashKey("CIVFEMALE"))
    TaskPlayAnim(guitar2,"amb@world_human_musician@guitar@male@idle_a","idle_b", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
  
  for _, item in pairs(chanteur) do
    chanteur =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    SetPedCombatAttributes(chanteur, 46, true)
    SetPedFleeAttributes(chanteur, 0, 0)
    SetPedRelationshipGroupHash(chanteur, GetHashKey("CIVFEMALE"))
  end
  
end)


local playerCoords
local playerPed
showStartText = false

Citizen.CreateThread(function()
    while true do
       Wait(0)
       playerPed = GetPlayerPed(-1)
       playerCoords = GetEntityCoords(playerPed, 0)

       if(GetDistanceBetweenCoords(playerCoords, -561.85021972656, 286.39947509766, 82.17643737793) < 2) then
         if(showStartText == false) then
           StartText()
         end

         -- Start mission
         if(IsControlPressed(1, 38)) then
           TriggerServerEvent("job:removeMoney",100)
           Toxicated2()
           Citizen.Wait(120000)
           reality2()
         end
       else
         showStartText = false
       end --if GetDistanceBetweenCoords ...
    end
end)


function Toxicated2()
  RequestAnimSet("move_m@drunk@verydrunk")
  while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
    Citizen.Wait(0)
  end

  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, 1)
  Wait(8000)
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(GetPlayerPed(-1), true)
  SetPedMovementClipset(GetPlayerPed(-1), "move_m@drunk@verydrunk", true)
  SetPedIsDrunk(GetPlayerPed(-1), true)
  DoScreenFadeIn(1000)
  end

  function reality2()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedIsDrunk(GetPlayerPed(-1), false)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    -- Stop the toxication
    Citizen.Trace("Going back to reality\n")
    end
