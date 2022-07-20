local QBCore = exports['qb-core']:GetCoreObject()

-- verificar player
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(Player)
    PlayerData = QBCore.Functions.GetPlayerData()
end)

-- verificar job
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)

-- spawn veiculo
RegisterNetEvent('linksanco-ambulancegarage:spawn')
AddEventHandler('linksanco-ambulancegarage:spawn', function(pd)
    local vehicle = pd.vehicle
    local coords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "ambulance"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
      --  SetEntityHeading(veh, coords.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)     
end)

-- guardar veiculo
RegisterNetEvent('linksanco-ambulancegarage:guardar')
AddEventHandler('linksanco-ambulancegarage:guardar', function()

    QBCore.Functions.Notify('Veiculo guardado!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    DeleteVehicle(car)
    DeleteEntity(car)
end)

-- Menu da garagem 
RegisterNetEvent('linksanco-ambulancegarage:menu', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Garage politi",
            txt = ""
        },
        {
            id = 2,
            header = "Coil Raiden",
            txt = "",
            params = {
                event = "linksanco-ambulancegarage:spawn",
                args = {
                    vehicle = 'gdraidena',
                    
                }
            }
        },
        {
            id = 3,
            header = "Benefactor XLS",
            txt = "",
            params = {
                event = "linksanco-ambulancegarage:spawn",
                args = {
                    vehicle = 'gdxlsa',
                    
                }
            }
        },
        {
            id = 4,
            header = "Übermacht Rebla GTS",
            txt = "",
            params = {
                event = "linksanco-ambulancegarage:spawn",
                args = {
                    vehicle = 'gdreblaa',
                    
                }
            }
        },
        {
            id = 5,
            header = "Vapid Speedo",
            txt = "",
            params = {
                event = "linksanco-ambulancegarage:spawn",
                args = {
                    vehicle = 'gdspeedoa',
                    
                }
            }
        },
        {
            id = 6,
            header = "Store Vehicle",
            txt = "",
            params = {
                event = "linksanco-ambulancegarage:guardar",
                args = {
                    
                }
            }
        },
    })
end)

-- Trigger para o target
Citizen.CreateThread(function ()
    exports['qb-target']:AddBoxZone("ambulanceGarage", vector3(329.67, -573.36, 28.8), 10, 10, {
        name = "ambulanceGarage",
        heading = 245.84,
        debugPoly = false,
    }, {
        options = {
            {
                type = "Client",
                event = "linksanco-ambulancegarage:menu",
                icon = "fas fa-car",
                label = 'Open ambulanceGarage'
            },
        },
        distance = 10
    })
end)

