TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
    end)
RegisterServerEvent("mx-paracek")
AddEventHandler("mx-paracek", function()
        xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeMoney(Config.paracekmemiktari)
    end)

ESX.RegisterServerCallback("mx-parakontrol", function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        local paran = Config.paracekmemiktari
        if xPlayer.getMoney() >= paran then
            cb(true)
        else
            cb(false)
        end
    end)

