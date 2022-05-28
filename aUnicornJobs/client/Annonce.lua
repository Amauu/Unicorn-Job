ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


function AnnonceUnic()
    local AnnonceUnic = RageUI.CreateMenu("Annonce", "Menu Intéraction..")
    AnnonceUnic:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(AnnonceUnic, not RageUI.Visible(AnnonceUnic))
            while AnnonceUnic do
            Citizen.Wait(0)
            RageUI.IsVisible(AnnonceUnic, true, true, true, function()

                RageUI.ButtonWithStyle("→ Annonce Ouverture",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        ExecuteCommand'e type' 
                        exports['progressBars']:startUI((3 * 1000), ('Initialisation de l\'annonce en cours'))

                        Citizen.Wait((3* 1000))       
                        TriggerServerEvent('OUnicorn')
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end)
        
                RageUI.ButtonWithStyle("→ Annonce Fermeture",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand'e type' 
                        exports['progressBars']:startUI((3 * 1000), ('Initialisation de l\'annonce en cours'))

                        Citizen.Wait((3* 1000))   
                        TriggerServerEvent('FUnicorn')
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end)

                RageUI.ButtonWithStyle("→ Annonce Recrutement",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then    
                        ExecuteCommand'e type' 
                        exports['progressBars']:startUI((3 * 1000), ('Initialisation de l\'annonce en cours'))

                        Citizen.Wait((3* 1000))   
                        TriggerServerEvent('RUnicorn')
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end)

                        
                RageUI.Separator("↓ ~b~     Message    ~s~↓")
        
                RageUI.ButtonWithStyle("→ Message aux Employés",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                    ExecuteCommand'e type'  
                    local info = 'patron'
                    local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', 40)
                    exports['progressBars']:startUI((3 * 1000), ('Envoie du message en cours'))

                    Citizen.Wait((3* 1000))    
                    TriggerServerEvent('amau:unicornjob', info, message)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                end
                end)
        
                RageUI.ButtonWithStyle("→ Message Personnalisé",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand'e type' 
                        local te = KeyboardInput("Message", "", 100)
                        exports['progressBars']:startUI((3 * 1000), ('Envoie du message en cours'))
    
                        Citizen.Wait((3* 1000)) 
                        ExecuteCommand("ghyu " ..te)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end)
            

                RageUI.ButtonWithStyle("→ Fermer la ~r~session",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                    FreezeEntityPosition(PlayerPedId(), false)
                    RageUI.CloseAll()
                    end
                end)
        
    
            end, function()
            end, 1)

            if not RageUI.Visible(AnnonceUnic) then
            AnnonceUnic = RMenu:DeleteType("AnnonceUnic", true)
        end
    end
end

local position = {
    {x = 129.86, y = -1284.62, z = 29.26}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

      for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
        
            if dist <= 1.5 then
            DrawMarker(25,  129.86,-1284.62,28.40, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 127, 0, 255 , 255, false, true, p19, true)
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour accéder à l'ordinateur",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    AnnonceUnic()
                    
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)
