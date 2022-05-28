ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local unicornboss = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
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


function unicornbossyy()
    local F6Unic = RageUI.CreateMenu("Unicorn", "Menu Intéraction..")
    F6Unic:SetRectangleBanner(140, 38, 109)
      RageUI.Visible(F6Unic, not RageUI.Visible(F6Unic))
  
              while F6Unic do
                  Citizen.Wait(0)
                      RageUI.IsVisible(F6Unic, true, true, true, function()
  
            if Unicornboss ~= nil then
                RageUI.ButtonWithStyle("→ Argent société :", nil, {RightLabel = "$" .. unicornboss}, true, function()
                end)
            end

            RageUI.ButtonWithStyle("→ Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    ExecuteCommand'e type'
                    local amount = KeyboardInput("Montant", "", 10)
                    exports['progressBars']:startUI((3 * 1000), ('Retrait d\'argent en cours'))
    
                    Citizen.Wait((3* 1000)) 
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:withdrawMoney', 'unicorn', amount)
                        Refreshunicornboss()
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end
            end)

            RageUI.ButtonWithStyle("→ Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    ExecuteCommand'e type'
                    local amount = KeyboardInput("Montant", "", 10)
                    exports['progressBars']:startUI((3 * 1000), ('Dêpot d\'argent en cours'))
    
                    Citizen.Wait((3* 1000)) 
                    amount = tonumber(amount)
                    if amount == nil then
                        RageUI.Popup({message = "Montant invalide"})
                    else
                        TriggerServerEvent('esx_society:depositMoney', 'unicorn', amount)
                        Refreshunicornboss()
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                    end
                end
            end) 

           RageUI.ButtonWithStyle("→ Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    aboss()
                    RageUI.CloseAll()
                end
            end)

            RageUI.ButtonWithStyle("→ Fermer votre ~r~panel",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasksImmediately(GetPlayerPed(-1))
                RageUI.CloseAll()
                end
            end)


        end, function()
        end)
        if not RageUI.Visible(F6Unic) then
        F6Unic = RMenu:DeleteType("F6Unic", true)
    end
end
end


local position = {

    {x = 94.74, y = -1292.84, z = 29.26}

}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' and ESX.PlayerData.job.grade_name == 'boss' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.0 then
            wait = 0
        
            if dist <= 1.0 then
                DrawMarker(25,  94.74,-1292.84,28.26, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 0, 0 , 255, false, true, p19, true)
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour accéder au panel administratif",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    ExecuteCommand'e type'
                    exports['progressBars']:startUI((3 * 1000), ('Connexion à votre session'))
    
                    Citizen.Wait((3* 1000)) 
                    Refreshunicornboss()           
                    unicornbossyy()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

function Refreshunicornboss()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            Updateunicornboss(money)
        end, ESX.PlayerData.job.name)
    end
end

function Updateunicornboss(money)
    unicornboss = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'unicorn', function(data, menu)
        menu.close()
    end, {wash = false})
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

