AddEventHandler("menuanim:AnimOG", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
	VMenu.AddFunc(98, "Applaudir", "anim:play", {1}, "Valider")
	VMenu.AddFunc(98, "Filmer", "anim:play", {2}, "Valider")
	VMenu.AddFunc(98, "Jouer de la musique", "anim:play", {3}, "Valider")
	VMenu.AddFunc(98, "Regarder la carte", "anim:play", {4}, "Valider")
	VMenu.AddFunc(98, "Yoga", "anim:play", {5}, "Valider")
	VMenu.AddFunc(98, "Faire des pompes", "anim:play", {6}, "Valider")
	VMenu.AddFunc(98, "Discour", "anim:play", {7}, "Valider")
	VMenu.AddFunc(98, "Danse chelou", "anim:play", {8}, "Valider")
	VMenu.AddFunc(98, "Viens, je suis là!", "anim:play", {9}, "Valider")
	VMenu.AddFunc(98, "Pouces en l'air", "anim:play", {10}, "Valider")
	VMenu.AddFunc(98, "Planter", "anim:play", {11}, "Valider")
	VMenu.AddFunc(98, "Assis au sol", "anim:play", {12}, "Valider")
	VMenu.AddFunc(98, "A plat ventre", "anim:play", {13}, "Valider")
	VMenu.AddFunc(98, "Fumer une clope", "anim:play", {14}, "Valider")
	VMenu.AddFunc(98, "Jumelles", "anim:play", {15}, "Valider")
	VMenu.AddFunc(98, "Assis", "anim:play", {16}, "Valider")
	VMenu.AddFunc(98, "Sur le dos", "anim:play", {17}, "Valider")
	VMenu.AddFunc(98, "Dire bonjour", "anim:play", {18}, "Valider")
	VMenu.AddFunc(98, "Enlacer", "anim:play", {19}, "Valider")
	VMenu.AddFunc(98, "Signe de la main", "anim:play", {20}, "Valider")
	VMenu.AddFunc(98, "Dos au mur", "anim:play", {21}, "Valider")
	VMenu.AddFunc(98, "K.O", "anim:play", {22}, "Valider")
	VMenu.AddFunc(98, "Musculation", "anim:play", {23}, "Valider")
	VMenu.AddFunc(98, "Stop anim", "anim:play", {24}, "Valider")
end)

AddEventHandler("anim:play", function(target, anim)
	Wait(100)
	TriggerEvent("vmenu:closeMenu")
	Wait(1000)
	if anim == 1 then
		PlayScenario("WORLD_HUMAN_CHEERING","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 2 then
		PlayScenario("WORLD_HUMAN_MOBILE_FILM_SHOCKING","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 3 then
		PlayScenario("WORLD_HUMAN_MUSICIAN","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 4 then
		PlayScenario("WORLD_HUMAN_TOURIST_MAP","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 5 then
		PlayScenario("WORLD_HUMAN_YOGA","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 6 then
		PlayScenario("WORLD_HUMAN_PUSH_UPS","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 7 then
		TriggerEvent("vmenu:anim", "missmic4premiere", "prem_4stars_a_benton")
	elseif anim == 8 then
		TriggerEvent("vmenu:anim", "missmic4premiere", "prem_actress_star_a")
	elseif anim == 9 then
		TriggerEvent("vmenu:anim", "missmic4premiere", "wave_c")
	elseif anim == 10 then
		TriggerEvent("vmenu:anim", "mp_action", "thanks_male_06")
	elseif anim == 11 then
		PlayScenario("WORLD_HUMAN_GARDENER_PLANT","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 12 then
		PlayScenario("WORLD_HUMAN_PICNIC","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 13 then
		PlayScenario("WORLD_HUMAN_SUNBATHE","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 14 then
		PlayScenario("WORLD_HUMAN_SMOKING","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 15 then
		PlayScenario("WORLD_HUMAN_BINOCULARS","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 16 then
		PlayScenario("PROP_HUMAN_SEAT_CHAIR","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 17 then
		PlayScenario("WORLD_HUMAN_SUNBATHE_BACK","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 18 then
		TriggerEvent("vmenu:anim", "gestures@m@standing@casual", "gesture_hello")
	elseif anim == 19 then
		TriggerEvent("vmenu:anim", "mp_ped_interaction", "kisses_guy_a")
	elseif anim == 20 then
		TriggerEvent("vmenu:anim", "friends@frj@ig_1", "wave_e")
	elseif anim == 21 then
		PlayScenario("WORLD_HUMAN_LEANING","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 22 then
		PlayScenario("WORLD_HUMAN_STUPOR","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 23 then
		PlayScenario("WORLD_HUMAN_MUSCLE_FLEX","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 24 then
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end
end)

function PlayScenario(param1, param2, param3)
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(GetPlayerPed(-1), param1, 0, 1)
		PlayAmbientSpeech1(GetPlayerPed(-1), param2, param3)
		Citizen.Wait(20000)
	end)
end
