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



function CoffreUnic()
    local CUnic = RageUI.CreateMenu("Coffre", "Menu Intéraction..")
    CUnic:SetRectangleBanner(140, 38, 109)
        RageUI.Visible(CUnic, not RageUI.Visible(CUnic))
            while CUnic do
            Citizen.Wait(0)
            RageUI.IsVisible(CUnic, true, true, true, function()

                    RageUI.ButtonWithStyle("→ Retirer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            UnicRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("→ Déposer un objet(s)",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            UnicDeposeobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("→ Fermer le ~r~coffre",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                        FreezeEntityPosition(PlayerPedId(), false)
                        RageUI.CloseAll()
                        end
                    end)
                    
                end, function()
                end)
            if not RageUI.Visible(CUnic) then
            CUnic = RMenu:DeleteType("CUnic", true)
        end
    end
end

local position = {
    {x = 129.35, y = -1281.10, z = 29.26}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.0 then
            wait = 0
        
            if dist <= 1.0 then
            DrawMarker(25,  129.35, -1281.10,  28.30, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 0, 0 , 255, false, true, p19, true)
               wait = 0
			   RageUI.Text({

				message = "Appuyez sur [~r~E~w~] pour ouvrir le coffre",
	
				time_display = 1
	
			})
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
					CoffreUnic()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

itemstock = {}
function UnicRetirerobjet()
    local StockUnic = RageUI.CreateMenu("Coffre", "Menu Intéraction..")
    StockUnic:SetRectangleBanner(140, 38, 109)
    ESX.TriggerServerCallback('KUnicorn:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StockUnic, not RageUI.Visible(StockUnic))
        while StockUnic do
            Citizen.Wait(0)
                RageUI.IsVisible(StockUnic, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    ExecuteCommand'e pickup'
                                    TriggerServerEvent('KUnicorn:getStockItem', v.name, tonumber(count))
                                    UnicRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockUnic) then
            StockUnic = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function UnicDeposeobjet()
    local DeposerUnic = RageUI.CreateMenu("Coffre", "Menu Intéraction..")
    DeposerUnic:SetRectangleBanner(140, 38, 109)
    ESX.TriggerServerCallback('KUnicorn:getPlayerInventory', function(inventory)
        RageUI.Visible(DeposerUnic, not RageUI.Visible(DeposerUnic))
    while DeposerUnic do
        Citizen.Wait(0)
            RageUI.IsVisible(DeposerUnic, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            ExecuteCommand'e pickup'
                                            TriggerServerEvent('KUnicorn:putStockItems', item.name, tonumber(count))
                                            UnicDeposeobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DeposerUnic) then
                DeposerUnic = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end



function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end
