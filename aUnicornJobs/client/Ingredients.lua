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


function AchatUnic()
    local AchatUnic = RageUI.CreateMenu("Achat", "Menu Intéraction..")
    AchatUnic:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(AchatUnic, not RageUI.Visible(AchatUnic))
            while AchatUnic do
            Citizen.Wait(0)
            RageUI.IsVisible(AchatUnic, true, true, true, function()

                RageUI.Separator("↓ ~o~   Voici les ingrédients  ~s~↓")
            
                RageUI.ButtonWithStyle("→ Pâte Sablée", "Prix : 50 ~y~$~", {nil},true, function(Hovered, Active, Selected)

                if (Selected) then   

                local item = "pateS"
                 
                local labelkaito = "Pâte Sablée"

                local prix = 50

                TriggerServerEvent('AchactUnic', item, labelkaito, prix)

                end

                end)


                RageUI.ButtonWithStyle("→ Sucre en Poudre", "Prix : 60 ~y~$~", {nil},true, function(Hovered, Active, Selected)

                    if (Selected) then   
    
                    local item = "sucreP"
                     
                    local labelkaito = "Sucre en Poudre"
    
                    local prix = 60
    
                    TriggerServerEvent('AchactUnic', item, labelkaito, prix)
    
                    end
    
                    end)

                    RageUI.ButtonWithStyle("→ Bouteille", "Prix : Gratuit ~y~$~", {nil},true, function(Hovered, Active, Selected)

                        if (Selected) then   
        
                        local item = "bouteilleV"
                         
                        local labelkaito = "Bouteille"
        
                        local prix = 0
        
                        TriggerServerEvent('AchactUnic', item, labelkaito, prix)
        
                        end
        
                        end)
    


                RageUI.ButtonWithStyle("→ Terminer vos ~r~achats",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                FreezeEntityPosition(PlayerPedId(), false)
                RageUI.CloseAll()
                end
                end)


        
end, function()

end)
            if not RageUI.Visible(AchatUnic) then
            AchatUnic = RMenu:DeleteType("AchatUnic", true)
        end
    end
end

local position = {
    {x = -555.53, y = -619.24, z = 34.67}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.0 then
                DrawMarker(25,  542.11,  2668.95,  41.16, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 0, 0 , 255, false, true, p19, true)
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour acheter vos ingrédints",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
					AchatUnic()
            
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)




