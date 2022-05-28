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


function CreationUnicorn()
    local CreationUnicorn = RageUI.CreateMenu("Création", "Menu Intéraction..")
    CreationUnicorn:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(CreationUnicorn, not RageUI.Visible(CreationUnicorn))
            while CreationUnicorn do
            Citizen.Wait(0)
            RageUI.IsVisible(CreationUnicorn, true, true, true, function()

                RageUI.ButtonWithStyle("→ Faire un Mojito","Ingrédients: 4x ~g~Feuilles de Menthe~w~ & 2x ~y~Rhum Blanc", {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                     local playerPed        = GetPlayerPed(-1)
                     TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                     exports['progressBars']:startUI((4 * 1000), ('Fabrication en cours'))
 
                     Citizen.Wait((4* 1000)) 
                    TriggerServerEvent('mojito')
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    RageUI.CloseAll()
                    end
                end)

                RageUI.ButtonWithStyle("→ Faire un Whisky Coca","Ingrédients: 2x ~r~Coca~w~ & 2x ~y~Whisky", {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local playerPed        = GetPlayerPed(-1)
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        exports['progressBars']:startUI((4 * 1000), ('Fabrication en cours'))
    
                        Citizen.Wait((4* 1000)) 
                    TriggerServerEvent('whiskycoca')
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    RageUI.CloseAll()
                    end
                end)

                RageUI.ButtonWithStyle("→ Rhum-jus de fruits","Ingrédients: 2x ~p~Jus de fruit~w~ & 1x ~y~Sucre en Poudre", {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local playerPed        = GetPlayerPed(-1)
                        TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                        exports['progressBars']:startUI((4 * 1000), ('Fabrication en cours'))
    
                        Citizen.Wait((4* 1000))  
                    TriggerServerEvent('rhumfruit')
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    RageUI.CloseAll()
                    end
                end)

                
                RageUI.ButtonWithStyle("→ Fermer ~r~l'établi",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                    FreezeEntityPosition(PlayerPedId(), false)
                    
                    RageUI.CloseAll()
                    end
                end)

    
            end, function()
            end, 1)

            if not RageUI.Visible(CreationUnicorn) then
            CreationUnicorn = RMenu:DeleteType("CreationUnicorn", true)
        end
    end
end

local position = {
    {x = 128.82, y = -1282.44, z = 29.26}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

      for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 0.7 then
            wait = 0
        
            if dist <= 0.7 then
            DrawMarker(25,  128.82,-1282.44,28.30, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 127, 0, 255 , 255, false, true, p19, true)
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour consulter l'établi",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    CreationUnicorn()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

