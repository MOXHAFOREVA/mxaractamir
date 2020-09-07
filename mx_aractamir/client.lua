TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local blipdurum = false

function kaput(source, args, raw)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
        else
            SetVehicleDoorOpen(veh, door, false, false)

        end
    end
end

function aracstop()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local playerCoords = GetEntityCoords(ped)
    SetVehicleUndriveable(vehicle, true)
    SetVehicleEngineOn(vehicle, false, false, false)
    DisableControlAction(0, 75, true)
    IsVehicleEngineOnFire(vehicle)

end

function aractamir()
    local ped = PlayerPedId()
    local playerCoords = GetEntityCoords(ped)
    local vehicle = GetVehiclePedIsUsing(ped)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, false, false)
end

function arackapat()
Citizen.CreateThread(function()
    while mxtamir do
        Citizen.Wait(0)

        DisableControlAction(0, 75,  true) -- Disable exit vehicle
        DisableControlAction(27, 75, true) -- Disable exit vehicle
    end
end)
end

local aractamirpozisyonlari = {
   polisust = {x = 937.0327, y = -970.504, z = 39.118 },
   doktor = {x= 409.0, y = -986.76, z = 29.27},

}   



Citizen.CreateThread(function()
    if Config.blipolsunmu == true then
    for k,v in pairs(Config.aractamirpozisyonlari) do
	local blip = AddBlipForCoord(v.x, v.y)

	SetBlipSprite (blip, 402)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName("Tamirci")
    EndTextCommandSetBlipName(blip)
        end
    end
end)

-- local mxped = {
--     mxpedv =		{ ped = -44746786, x = -290.066, y = 2542.779,	z = 74.50, 	h = 357.48 },
--     mxpedch =       { ped = 68070371,  x = 849.42, y = -1937.91, z = 29.05, h = 81.98 },
--     mxpedev =       { ped = 68070371,  x = -554.99, y = -1707.37, z = 18.0, h = 304.47 },
--     mxpedil =       { ped = 797459875,  x = -1366.21, y = 56.56, z = 53.15, h = 92.52 },
-- }

RegisterCommand(Config.tamiretkomutu, function()
    for k,v in pairs(Config.aractamirpozisyonlari) do 
        
  
    local ped = PlayerPedId()
    local aracsorgu = GetVehiclePedIsUsing(ped)
    local pedcoords = GetEntityCoords(PlayerPedId())
    local dst = GetDistanceBetweenCoords(pedcoords, v.x, v.y, v.z, true)
    local vehicle = GetVehiclePedIsUsing(ped)
    ESX.TriggerServerCallback("mx-parakontrol", function(parasorgu)
        print(dst)


        
        
        if IsPedInAnyVehicle(ped, false) then

            if dst <= 10.0 then
                if parasorgu then
                    mxtamir = true
                    kaput()
                    TriggerServerEvent("mx-paracek")
                    -- exports['mythic_notify']:DoHudText('inform', 'Aracın Tamir Ediliyor')
                    exports["mythic_notify"]:SendAlert("inform", "Aracın Tamir Ediliyor")
                    aracstop()

                    arackapat()
                    exports['progressBars']:startUI(Config.tamiretmesuresi, "Aracın Tamir Ediliyor")
                    if Config.progressbarsorun == true then
                    Citizen.Wait(Config.tamiretmesuresi)
                    end
                   
                    aractamir()
                     mxtamir = false


                else
                    -- exports['mythic_notify']:DoHudText('error', 'Yeterli Paran Yok')
                    exports["mythic_notify"]:SendAlert("error", "Yeterli Paran Yok")
                end

            else
                -- exports['mythic_notify']:DoHudText('error', 'Mekanik de değilsin')
                -- exports["mythic_notify"]:SendAlert("error", "Mekanik De Değilsin") 
            end

        else
            exports["mythic_notify"]:SendAlert("inform", "Aracın İçinde Değilsin")
        end

    end)
end
end)



function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

