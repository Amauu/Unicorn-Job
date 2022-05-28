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

local pos = vector3(136.74, -1278.47, 29.35)
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(pos)

    SetBlipSprite (blip, 85)
    SetBlipScale  (blip, 0.7)
    SetBlipColour (blip, 19)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Unicorn')
    EndTextCommandSetBlipName(blip)
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


function GarageUnicAmauu()
    local GarageUnicAmauu = RageUI.CreateMenu("Garage", "Menu Intéraction..")
    GarageUnicAmauu:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(GarageUnicAmauu, not RageUI.Visible(GarageUnicAmauu))
            while GarageUnicAmauu do
            Citizen.Wait(0)
            RageUI.IsVisible(GarageUnicAmauu, true, true, true, function()

                RageUI.ButtonWithStyle("→ Sortir une Exemplar",nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
                    if (Selected) then  
                    local model = GetHashKey("exemplar")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    exports['progressBars']:startUI((3 * 1000), ('Sorti du véhicule'))
    
                    Citizen.Wait((3* 1000)) 
                    local vehicle = CreateVehicle(model, 142.08,-1282.78,29.33, 299.08, true, true)
                    RageUI.CloseAll()
                    FreezeEntityPosition(PlayerPedId(), false)
                    end
                end)


    
            end, function()
            end, 1)

            if not RageUI.Visible(GarageUnicAmauu) then
            GarageUnicAmauu = RMenu:DeleteType("GarageUnicAmauu", true)
        end
    end
end

local position = {
	{x = 136.03, y = -1278.85, z = 29.36}
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
			   RageUI.Text({

				message = "Appuyez sur [~p~E~w~] pour ouvrir le garage",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Salut Remy !",
            
                        time_display = 3000
            
                    })
                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~o~Remy~w~] Salut tu as besoin de quoi ?",
            
                        time_display = 3000
            
                    })
                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Il me faut un véhicule de fonction",
            
                        time_display = 3000
            
                    })
                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~o~Remy~w~] Ok je regarde si c'est bon...",
            
                        time_display = 3000
            
                    })

                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~o~Remy~w~] Oui parfait tiens regarde j'ai tout ça encore !",
            
                        time_display = 3000
            
                    })
                    Citizen.Wait(2000)
                    RageUI.Text({

                        message = "[~b~Vous~w~] Merci !",
            
                        time_display = 3000
            
                    })
                    Citizen.Wait(2000)
                    GarageUnicAmauu()

        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)



local npc2 = {
	{hash="s_m_m_cntrybar_01", x = 135.84, y = -1278.98, z = 29.36, a=300.07},
}

Citizen.CreateThread(function()
	for _, item2 in pairs(npc2) do
		local hash = GetHashKey(item2.hash)
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        TaskStartScenarioInPlace(ped2, 'WORLD_HUMAN_CLIPBOARD_FACILITY', 0, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
	end
end)
------------- RANGER VOITURE ----------------


local Nabilaaa = {
    {x = 144.95, y = -1287.35, z = 29.33}
}


function SquidGamepusamere(vehicle)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local props = ESX.Game.GetVehicleProperties(vehicle)
    local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
    local engineHealth = GetVehicleEngineHealth(current)

    if IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
        if engineHealth < 890 then
            ESX.ShowNotification("Votre véhicule est trop abimé, vous ne pouvez pas le ranger.")
        else
            ESX.Game.DeleteVehicle(vehicle)
            ESX.ShowNotification("~g~Le Véhicule a été rangé dans le garage.")
        end
    end
end

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(Nabilaaa) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Nabilaaa[k].x, Nabilaaa[k].y, Nabilaaa[k].z)
        
            if dist <= 4.0 then
               wait = 0
               if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            DrawMarker(22,  144.97,-1287.56,29.33, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255,255 , 255 , 255, true, true, p19, true)
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour donner ton véhicule à Remy",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    DoScreenFadeOut(3000)
                    Citizen.Wait(3000)
                    DoScreenFadeIn(3000)
					SquidGamepusamere()
            
        end
    end
    end
    end
    Citizen.Wait(wait)
    end
end
end)
