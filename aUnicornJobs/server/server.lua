ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_society:registerSociety', 'unicorn', 'unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', {type = 'private'})

local config = {
    AuTravailleTaume = false,
}

local configoui = {
    lrdplo = false,
}

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'unicorn' then
			Citizen.Wait(5000)
			TriggerClientEvent('KUnicorn:updateBlip', -1)
		end
	end
end)

RegisterServerEvent('KUnicorn:spawned')
AddEventHandler('KUnicorn:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'unicorn' then
		Citizen.Wait(5000)
		TriggerClientEvent('KUnicorn:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('KUnicorn:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'unicorn')
	end
end)


RegisterServerEvent('KUnicorn:message')
AddEventHandler('KUnicorn:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)


RegisterServerEvent('OUnicorn')
AddEventHandler('OUnicorn', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Unicorn~w~', '~b~Annonce', 'L\'unicorn est ouvert !', 'CHAR_STRIPPER_PEACH', 8)
	end
end)

RegisterServerEvent('FUnicorn')
AddEventHandler('FUnicorn', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Unicorn~w~', '~b~Annonce', 'L\'unicorn est fermé !', 'CHAR_STRIPPER_PEACH', 8)
	end
end)


RegisterServerEvent('amauu:unicornjob')
AddEventHandler('amauu:unicornjob', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'unicorn' then
            TriggerClientEvent('amauu:unicornjob', xPlayers[i], _raison, name, message)
        end
    end
end)

RegisterServerEvent('RUnicorn')
AddEventHandler('RUnicorn', function (target)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Unicorn~w~', '~b~Annonce', 'Recrutement en cours, rendez-vous à L\'Unicorn!', 'CHAR_STRIPPER_PEACH', 8)

    end
end)



RegisterCommand('ghyu', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "unicorn" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '~p~Unicorn~w~', '~b~Annonce', ''..msg..'', 'CHAR_STRIPPER_PEACH', 0)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_STRIPPER_PEACH', 0)
    end
else
    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~r~Erreur' , '~y~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_STRIPPER_PEACH', 0)
end
end, false)


RegisterNetEvent('mojito')
AddEventHandler('mojito', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local menthe = xPlayer.getInventoryItem('menthe').count
    local rhum = xPlayer.getInventoryItem('rhum').count
    local mojito = xPlayer.getInventoryItem('mojito').count

    if menthe> 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de ~p~Feuille de menthe...')
    elseif menthe and rhum < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'ingrédients pour faire le Mojito...')
    else
        xPlayer.removeInventoryItem('menthe', 4)
        xPlayer.removeInventoryItem('rhum', 2)
        xPlayer.addInventoryItem('mojito', 1)    
    end
end)

RegisterNetEvent('whiskycoca')
AddEventHandler('whiskycoca', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local coca = xPlayer.getInventoryItem('coca').count
    local whisky = xPlayer.getInventoryItem('whisky').count
    local whiskycoca = xPlayer.getInventoryItem('whiskycoca').count

    if whiskycoca > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de ~p~Coca...')
    elseif coca and whisky < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'ingrédients pour un Whisky coca...')
    else
        xPlayer.removeInventoryItem('coca', 2)
        xPlayer.removeInventoryItem('whisky', 2)
        xPlayer.addInventoryItem('whiskycoca', 1)    
    end
end)

RegisterNetEvent('rhumfruit')
AddEventHandler('rhumfruit', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local jusfruit = xPlayer.getInventoryItem('jusfruit').count
    local sucreP = xPlayer.getInventoryItem('sucreP').count
    local rhumfruit = xPlayer.getInventoryItem('rhumfruit').count

    if rhumfruit >= 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de ~p~Jus de fruit...')
    elseif jusfruit < 1 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'ingrédients pour faire un Rhum Fruit...')
    elseif  sucreP < 1 then 
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'ingrédients pour faire un Rhum Fruit...')
    else
        xPlayer.removeInventoryItem('jusfruit', 2)
        xPlayer.removeInventoryItem('sucreP', 1)
        xPlayer.addInventoryItem('rhumfruit', 1) 
       
    end
end)
        RegisterNetEvent('AchactUnic')

AddEventHandler('AchactUnic', function(item, labelamau, price)

	local xPlayer = ESX.GetPlayerFromId(source)

	local playerMoney = xPlayer.getMoney()

	local societyAccount
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_unicorn', function(account)
		societyAccount = account
	end)

	if price < societyAccount.money then

		xPlayer.addInventoryItem(item, 1)

		societyAccount.removeMoney(price)

		TriggerClientEvent('esx:showNotification', source, "Vous avez bien reçu votre ~g~"..labelamau.." ~s~!")
        PerformHttpRequest('https://discord.com/api/webhooks/949968098214154280/HE1FQ5c9MxsEG0d7s1xENAF45FhFWfK7pM6wSKifSrRtFvXnUJ3TsoeXX96VgFKyntpc', function(err, text, headers) end, 'POST', json.encode({username = "", content = xPlayer.getName() .. " a acheter " .. labelamau}), { ['Content-Type'] = 'application/json' })

	else

		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez !")

	end
end)

ESX.RegisterServerCallback('KUnicorn:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('KUnicorn:getStockItem')
AddEventHandler('KUnicorn:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('KUnicorn:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('KUnicorn:putStockItems')
AddEventHandler('KUnicorn:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)