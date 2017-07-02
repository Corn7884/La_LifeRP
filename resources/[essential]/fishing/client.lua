local IsFishing = false
local CFish = false
local h = 0
local max = 0.095
local PosX = 0.5
local PosY = 0.1
local Faketime = 0
local qte = 0
local One = true
local StartFishing_KEY = 38
AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)
Citizen.CreateThread(function()
	while true do Citizen.Wait(1)
	  TriggerEvent("player:getQuantity", 38)
      canne = qte
	  if IsEntityInWater(GetPed()) and canne ~= 0 then
	    ShowInfo('~b~Appuyez sur ~g~E~b~ pour pécher', 0)
		if IsControlJustPressed(1, StartFishing_KEY) then
			if IsEntityInWater(GetPed()) then
				IsFishing = true
				DrawNotif("~h~~b~Vous avez lancé la ligne.")
				One = true
				h = 0
			else
				DrawNotif("~h~~b~Vous avez lancé la ligne.")
			end
		end
		while IsFishing do
			time = 4*3000
			TaskStandStill(GetPed(), time+7000)
			FishRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
			PlayAnim(GetPed(),'amb@world_human_stand_fishing@base','base',4,3000)
			Citizen.Wait(time)
			CFish = true
			IsFishing = false
		end
		while CFish do
			Citizen.Wait(1)
			FishGUI(true)
			if One then
				Faketime = 1
				PlayAnim(GetPed(),'amb@world_human_stand_fishing@idle_a','idle_c',1,0) -- 10sec
				One = false
			end
			if Faketime % 8 == 0 then
				CFish = false
				StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',1.5)
				Citizen.Wait(1000)
				DeleteEntity(FishRod)
				DrawNotif("~r~Pff ! Raté ...~s~")
			end
			if IsControlJustPressed(1, 201) then
				if h >= max then
					DrawNotif("Yes !!! ~g~+ 1 poisson~s~")
					TriggerEvent("player:receiveItem", 25, 1)
					StopAnimTask(GetPed(), 'amb@world_human_stand_fishing@idle_a','idle_c',0.5)
					Citizen.Wait(1000)
					DeleteEntity(FishRod)
					CFish = false
				else
					DrawNotif("~r~Arf j'y etais presque !~s~")
				end
			end
		end
	  end
	end
end)
Citizen.CreateThread(function() 
while true do Citizen.Wait(1000)
Faketime = Faketime + 1 end end)
function GetCar() return GetVehiclePedIsIn(GetPlayerPed(-1),false) end
function GetPed() return GetPlayerPed(-1) end
function text(x,y,scale,text,font)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(255,255,255,255)
    SetTextDropShadow(0,0,0,0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
function FishGUI(bool)
	if not bool then return end
	DrawRect(PosX,PosY,0.1,0.02,0,0,0,255)
	if h >= max then
		DrawRect(PosX,PosY,h,0.02,102,255,102,150)
	else
		DrawRect(PosX,PosY,h,0.02,255,51,51,150)
	end
	if h <= 0 then
		up = true
	end
	if h >= 0.1 then
		up = false
	end
	if not up then
		h = h - 0.0015
	else
		h = h + 0.0015
	end
end
function PlayAnim(ped,base,sub,nr,time) 
	Citizen.CreateThread(function() 
		RequestAnimDict(base) 
		while not HasAnimDictLoaded(base) do 
			Citizen.Wait(1) 
		end
		if IsEntityPlayingAnim(ped, base, sub, 3) then
			ClearPedSecondaryTask(ped) 
		else 
			for i = 1,nr do 
				TaskPlayAnim(ped, base, sub, 8.0, -8, -1, 16, 0, 0, 0, 0) 
				Citizen.Wait(time) 
			end 
		end 
	end) 
end
function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
	BoneID = GetPedBoneIndex(GetPed(), bone_ID)
	obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
	vX,vY,vZ = table.unpack(GetEntityCoords(GetPed()))
	xRot, yRot, zRot = table.unpack(GetEntityRotation(GetPed(),2))
	AttachEntityToEntity(obj,  GetPed(),  BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
	return obj
end
function Chat(text)
	TriggerEvent("chatMessage", 'SYSTEM', { 255,255,0}, text)
end

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

local Position = {
  Feux={x=-2187.1713867188,y=-401.44400024414,z=12.238845825195,distance=5},
}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPos = GetEntityCoords(GetPlayerPed(-1))
	local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Feux.x, Position.Feux.y, Position.Feux.z, true)
	  if distance < Position.Feux.distance then
        ShowInfo('~b~Appuyez sur ~g~E~b~ cuire le ~b~poisson', 0)
        if IsControlJustPressed(1, 38) then
		  TriggerEvent("player:getQuantity", 25)
          poisson = qte

          Wait(100)
          if poisson ~= 0 then
			DrawNotif('~g~ Cuisson ~b~en cours')
            Wait(2500)
            DrawNotif('~g~ + 1 ~b~Poisson grillé')
			
			TriggerEvent("player:looseItem", 25, 1)
            TriggerEvent("player:receiveItem", 39, 1)
			
		  else
            DrawNotif("~r~ Vous n'avez plus de poisson à griller !")
          end
		end
	  end
  end
end)

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
  --Création des blips pour les faire aparaitre et disparaitre --
  SetBlipTrade(436, "Grillade du poisson", 76, Position.Feux.x, Position.Feux.y, Position.Feux.z)
end)