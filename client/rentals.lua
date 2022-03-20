local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false

-- Config Options 

local blips = {
    -- {title= Lang:t("info.land_veh"), colour= 50, id= 56, x= -672.33, y= -1105.1, z= 14.57},
    -- {title= Lang:t("info.land_veh"), colour= 50, id= 56, x= -1673.39, y= -3158.45, z= 13.99},
    -- {title= Lang:t("info.land_veh"), colour= 50, id= 56, x= -753.55, y= -1512.24, z= 5.02}, 

}

local vehicles = {
    land = {
        [1] = {
            model = 'panto',
            money = 800,
        },
        [2] = {
            model = 'issi7',
            money = 5000,
        },
        [3] = {
            model = 'faggio2',
            money = 500,
        },
    },
    air = {
        [1] = {
            model = 'panto',
            money = 800,
        },
        [2] = {
            model = 'issi7',
            money = 1500,
        },
        [3] = {
            model = 'faggio2',
            money = 500,
        },
    },
    sea = {
        [1] = {
            model = 'panto',
            money = 800,
        },
        [2] = {
            model = 'issi7',
            money = 1500,
        },
        [3] = {
            model = 'faggio2',
            money = 500,
        },
    }
}
-- Vehicle Rentals
local comma_value = function(n) -- credit http://richard.warburton.it
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

RegisterNetEvent('qb-rental:client:openMenu', function(data)
    menu = data.MenuType
    local vehMenu = {
        [1] = {
            header = "Rental Vehicles",
            isMenuHeader = true,
        },
        [2] = {
            id = 1,
            header = "Return Vehicle ",
            txt = Lang:t("task.return_veh"),
            params = {
                event = "qb-rental:client:return",
            }
        }
    }
    
    if menu == "vehicle" then
        for k=1, #vehicles.land do
            local veh = QBCore.Shared.Vehicles[vehicles.land[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.land[k].model:sub(1,1):upper()..vehicles.land[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(vehicles.land[k].money)),
                params = {
                    event = "qb-rental:client:spawncar",
                    args = {
                        model = vehicles.land[k].model,
                        money = vehicles.land[k].money,
                    }
                }
            }
        end
    elseif menu == "aircraft" then
        for k=1, #vehicles.air do
            local veh = QBCore.Shared.Vehicles[vehicles.air[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.air[k].model:sub(1,1):upper()..vehicles.air[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(vehicles.air[k].money)),
                params = {
                    event = "qb-rental:client:spawncar",
                    args = {
                        model = vehicles.air[k].model,
                        money = vehicles.air[k].money,
                    }
                }
            }
        end
    elseif menu == "boat" then
        for k=1, #vehicles.sea do
            local veh = QBCore.Shared.Vehicles[vehicles.sea[k].model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or vehicles.sea[k].model:sub(1,1):upper()..vehicles.sea[k].model:sub(2)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(vehicles.sea[k].money)),
                params = {
                    event = "qb-rental:client:spawncar",
                    args = {
                        model = vehicles.sea[k].model,
                        money = vehicles.sea[k].money,
                    }
                }
            }
        end
    end
    exports['qb-menu']:openMenu(vehMenu)
end)

local CreateNPC = function()
    -- Vehicle Rentals
    created_ped = CreatePed(5, `a_m_y_business_03` , -672.3297, -1105.0951, 13.5697, 296.3398, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Aircraft Rentals
    created_ped = CreatePed(5, `s_m_y_airworker` , -1282.5922, -426.0650, 33.7438, 123.2127, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)

    -- Boat Rentals
    created_ped = CreatePed(5, `mp_m_boatstaff_01` , 323.5210, -233.8525, 53.2172, 325.5685, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
end

local SpawnNPC = function()
    CreateThread(function()
        -- Vehicle Rentals
        RequestModel(`a_m_y_business_03`)
        while not HasModelLoaded(`a_m_y_business_03`) do
            Wait(1)
        end
        -- Aircraft Rentals
        RequestModel(`s_m_y_airworker`)
        while not HasModelLoaded(`s_m_y_airworker`) do
            Wait(1)
        end
        -- Aircraft Rentals
        RequestModel(`mp_m_boatstaff_01`)
        while not HasModelLoaded(`mp_m_boatstaff_01`) do
            Wait(1)
        end
        CreateNPC() 
    end)
end

CreateThread(function()
    SpawnNPC()
end)

RegisterNetEvent('qb-rental:client:spawncar', function(data)
    local player = PlayerPedId()
    local money = data.money
    local model = data.model
    local label = Lang:t("error.not_enough_space", {vehicle = menu:sub(1,1):upper()..menu:sub(2)})
    if menu == "vehicle" then
        if IsAnyVehicleNearPoint(-683.0463, -1112.9353, 14.5255, 27.3474) then
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end
    elseif menu == "aircraft" then
        if IsAnyVehicleNearPoint(-1285.3888, -428.2505, 34.7648, 26.0737) then 
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end 
    elseif menu == "boat" then
        if IsAnyVehicleNearPoint(0, 0 ,0 ,0) then 
            QBCore.Functions.Notify(label, "error", 4500)
            return
        end  
    end

    QBCore.Functions.TriggerCallback("qb-rental:server:CashCheck",function(money)
        if money then
            if menu == "vehicle" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, 340.0)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports['lj-fuel']:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, vector4(-683.0463, -1112.9353, 14.5255, 27.3474), true)
            elseif menu == "aircraft" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, 331.49)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports['lj-fuel']:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, vector4(-1285.4110, -428.4428, 34.7691, 213.5654), true)
            elseif menu == "boat" then
                QBCore.Functions.SpawnVehicle(model, function(vehicle)
                    SetEntityHeading(vehicle, 107.79)
                    TaskWarpPedIntoVehicle(player, vehicle, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                    SetVehicleEngineOn(vehicle, true, true)
                    SetVehicleDirtLevel(vehicle, 0.0)
                    exports['lj-fuel']:SetFuel(vehicle, 100)
                    SpawnVehicle = true
                end, vector4(326.4486, -207.0242, 54.0866, 156.5508), true)
            end 
            Wait(1000)
            local vehicle = GetVehiclePedIsIn(player, false)
            QBCore.Functions.Notify(Lang:t("To Return The Vehicle Please Go To The Man That Gave You nd Ask Him to Take It Back"), 'success', 10000)
            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            vehicleLabel = GetLabelText(vehicleLabel)
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent('qb-rental:server:rentalpapers', plate, vehicleLabel)
        else
            QBCore.Functions.Notify(Lang:t("error.not_enough_money"), "error", 4500)
        end
    end, money)
end)

RegisterNetEvent('qb-rental:client:return', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify(Lang:t("task.veh_returned"), 'success')
        TriggerServerEvent('qb-rental:server:removepapers')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify(Lang:t("error.no_vehicle"), "error")
    end
    SpawnVehicle = false
end)

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.65)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
    end
end)