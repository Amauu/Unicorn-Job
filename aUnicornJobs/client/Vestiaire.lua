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


function VestiaireUnicorn()
    local VestiaireUnicorn = RageUI.CreateMenu("", "Menu Intéraction..")
    VestiaireUnicorn:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(VestiaireUnicorn, not RageUI.Visible(VestiaireUnicorn))
            while VestiaireUnicorn do
            Citizen.Wait(0)
            RageUI.IsVisible(VestiaireUnicorn, true, true, true, function()

                RageUI.ButtonWithStyle("→ Reprendre ses vêtements",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand'e adjust'
                        exports['progressBars']:startUI((3 * 1000), ('Changement de tenue en cours'))

                        Citizen.Wait((3* 1000)) 
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                    end
                end)
    
                RageUI.ButtonWithStyle("→ Tenue Unicorn",nil, {nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        ExecuteCommand'e adjust'
                        exports['progressBars']:startUI((3 * 1000), ('Changement de tenue en cours'))

                        Citizen.Wait((3* 1000)) 
                        SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0) 
                        SetPedComponentVariation(GetPlayerPed(-1) , 11, 16, 0)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 3, 4, 0)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 4, 66, 0)  
                        SetPedComponentVariation(GetPlayerPed(-1) , 6, 19, 0)   
                    end
                end)

                
                RageUI.ButtonWithStyle("→ Fermer ton ~r~casier",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                    if Selected then
                    FreezeEntityPosition(PlayerPedId(), false)
                    
                    RageUI.CloseAll()
                    end
                end)

    
            end, function()
            end, 1)

            if not RageUI.Visible(VestiaireUnicorn) then
            VestiaireUnicorn = RMenu:DeleteType("VestiaireUnicorn", true)
        end
    end
end

local position = {
    {x = 108.37, y = -1304.62, z = 28.79}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

      for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.5 then
            wait = 0
        
            if dist <= 1.5 then
            DrawMarker(22,  108.65,-1304.49,28.79, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 127, 0, 255 , 255, false, true, p19, true)
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour enlever ses vêtements",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Bon je vais me changer c'est l'heure de travailler..",
            
                        time_display = 2000
            
                    })
                    ExecuteCommand'e adjust'
                    Citizen.Wait(2000)
                    SeMettreNu()
                    Citizen.Wait(2000)
                    VestiaireUnicorn()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

function SeMettreNu()
    SetPedComponentVariation(GetPlayerPed(-1) , 8, 15, 0) --tshirt 
     SetPedComponentVariation(GetPlayerPed(-1) , 11, 91, 0)  --torse
     SetPedComponentVariation(GetPlayerPed(-1) , 3, 15, 0)  -- bras
    SetPedComponentVariation(GetPlayerPed(-1) , 4, 14, 1)   --pants
    SetPedComponentVariation(GetPlayerPed(-1) , 6, 6, 0)   --shoes
    
    end


