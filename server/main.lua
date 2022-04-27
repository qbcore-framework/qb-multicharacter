local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function GiveStarterItems(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k, v in pairs(QBCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "Class C Driver License"
        end
        Player.Functions.AddItem(v.item, v.amount, false, info)
    end
end

local function loadHouseData()
    local HouseGarages = {}
    local Houses = {}
    local result = MySQL.Sync.fetchAll('SELECT * FROM houselocations', {})
    if result[1] ~= nil then
        for k, v in pairs(result) do
            local garage = v.garage ~= nil and json.decode(v.garage) or {}
            Houses[v.name] = {
                coords = json.decode(v.coords),
                owned = v.owned,
                price = v.price,
                locked = true,
                adress = v.label,
                tier = v.tier,
                garage = garage,
                decorations = {},
            }
            HouseGarages[v.name] = {
                label = v.label,
                takeVehicle = garage,
            }
        end
    end
    TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Houses)
end

local function ValidateHidden(coords)
    local distance = #(vector3(coords) - vector3(Config.HiddenCoords))
    return distance<5
end

local function PlayerMaxCharacters(src)
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    local numOfChars = Config.DefaultNumberOfCharacters

    if Config.PlayersNumberOfCharacters then
        for i = 1, #Config.PlayersNumberOfCharacters do
            if Config.PlayersNumberOfCharacters[i].license == license then
                numOfChars = Config.PlayersNumberOfCharacters[i].numberOfChars
                break
            end
        end
    end
    return numOfChars
end

-- Commands

QBCore.Commands.Add("logout", "Logout of Character (Admin Only)", {}, false, function(source)
    local src = source
    QBCore.Player.Logout(src)
    TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
end, "admin")

QBCore.Commands.Add("closeNUI", "Close Multi NUI", {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-multicharacter:client:closeNUI', src)
end)

-- Events

RegisterNetEvent('qb-multicharacter:server:disconnect', function()
    local src = source
    DropPlayer(src, "You have disconnected from QBCore")
end)

RegisterNetEvent('qb-multicharacter:server:loadUserData', function(cData)
    local src = source
    local validCoords = ValidateHidden(GetEntityCoords(GetPlayerPed(src)))
    if validCoords then
        if QBCore.Player.Login(src, cData.citizenid) then
            print('^2[qb-core]^7 '..GetPlayerName(src)..' (Citizen ID: '..cData.citizenid..') has succesfully loaded!')
            QBCore.Commands.Refresh(src)
            loadHouseData()
            TriggerClientEvent('apartments:client:setupSpawnUI', src, cData)
            TriggerEvent("qb-log:server:CreateLog", "joinleave", "Loaded", "green", "**".. GetPlayerName(src) .. "** ("..(QBCore.Functions.GetIdentifier(src, 'discord') or 'undefined') .." |  ||"  ..(QBCore.Functions.GetIdentifier(src, 'ip') or 'undefined') ..  "|| | " ..(QBCore.Functions.GetIdentifier(src, 'license') or 'undefined') .." | " ..cData.citizenid.." | "..src..") loaded..")
        end
    else
        TriggerEvent('qb-log:server:CreateLog', 'multicharacter', 'multicharacter', "red", "**"..GetPlayerName(src) .. " (id: "..src..")** has attempted to login a character while not in the starting interior location")
    end
end)

RegisterNetEvent('qb-multicharacter:server:createCharacter', function(data)
    local src = source
    local validCoords = ValidateHidden(GetEntityCoords(GetPlayerPed(src)))
    if validCoords then
        local newData = {}
        newData.cid = data.cid
        newData.charinfo = data
        if QBCore.Player.Login(src, false, newData) then
            if Config.StartingApartment then
                local randbucket = (GetPlayerPed(src) .. math.random(1,999))
                SetPlayerRoutingBucket(src, randbucket)
                print('^2[qb-core]^7 '..GetPlayerName(src)..' has succesfully loaded!')
                QBCore.Commands.Refresh(src)
                loadHouseData()
                TriggerClientEvent("qb-multicharacter:client:closeNUI", src)
                TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
                GiveStarterItems(src)
            else
                print('^2[qb-core]^7 '..GetPlayerName(src)..' has succesfully loaded!')
                QBCore.Commands.Refresh(src)
                loadHouseData()
                TriggerClientEvent("qb-multicharacter:client:closeNUIdefault", src)
                GiveStarterItems(src)
            end
        end
    else
        TriggerEvent('qb-log:server:CreateLog', 'multicharacter', 'multicharacter', "red", "**"..GetPlayerName(src) .. " (id: "..src..")** has attempted to create a character while not in the starting interior location")
    end
end)

RegisterNetEvent('qb-multicharacter:server:deleteCharacter', function(citizenid)
    local src = source
    local validCoords = ValidateHidden(GetEntityCoords(GetPlayerPed(src)))
    if validCoords then
        QBCore.Player.DeleteCharacter(src, citizenid)
    else
        TriggerEvent('qb-log:server:CreateLog', 'multicharacter', 'multicharacter', "red", "**"..GetPlayerName(src) .. " (id: "..src..")** has attempted to delete a character while not in the starting interior location")
    end
end)

-- Callbacks

QBCore.Functions.CreateCallback("qb-multicharacter:server:GetUserCharacters", function(source, cb)
    local src = source
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    local limit = PlayerMaxCharacters(src)
    MySQL.Async.execute('SELECT * FROM players WHERE license = ? LIMIT ?', {license, limit}, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:GetNumberOfCharacters", function(source, cb)
    local src = source
    local validCoords = ValidateHidden(GetEntityCoords(GetPlayerPed(src)))
    if validCoords then
        local numOfChars = PlayerMaxCharacters(src)
        cb(numOfChars)
    else
        TriggerEvent('qb-log:server:CreateLog', 'multicharacter', 'multicharacter', "red", "**"..GetPlayerName(src) .. " (id: "..src..")** has attempted to get number of characters while not in the starting interior location")
    end
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:setupCharacters", function(source, cb)
    local src = source
    local validCoords = ValidateHidden(GetEntityCoords(GetPlayerPed(src)))
    if validCoords then
        local license = QBCore.Functions.GetIdentifier(src, 'license')
        local limit = PlayerMaxCharacters(src)
        local plyChars = {}
        MySQL.Async.fetchAll('SELECT * FROM players WHERE license = ? LIMIT ?', {license, limit}, function(result)
            for i = 1, (#result), 1 do
                result[i].charinfo = json.decode(result[i].charinfo)
                result[i].money = json.decode(result[i].money)
                result[i].job = json.decode(result[i].job)
                plyChars[#plyChars+1] = result[i]
            end
            cb(plyChars)
        end)
    else
        TriggerEvent('qb-log:server:CreateLog', 'multicharacter', 'multicharacter', "red", "**"..GetPlayerName(src) .. " (id: "..src..")** has attempted to get list characters while not in the starting interior location")
    end
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:getSkin", function(source, cb, cid)
    local result = MySQL.Sync.fetchSingle('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {cid, 1})
    if result ~= nil then
        cb(result.model, result.skin)
    else
        cb(nil)
    end
end)
