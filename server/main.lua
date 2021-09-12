RegisterServerEvent('qb-multicharacter:server:disconnect')
AddEventHandler('qb-multicharacter:server:disconnect', function()
    local src = source
    DropPlayer(src, "You have disconnected from QBCore")
end)

RegisterServerEvent('qb-multicharacter:server:loadUserData')
AddEventHandler('qb-multicharacter:server:loadUserData', function(cData)
    local src = source
    if QBCore.Player.Login(src, cData.citizenid) then
        --print('^2[qb-core]^7 '..GetPlayerName(src)..' (Citizen ID: '..cData.citizenid..') has succesfully loaded!')
        QBCore.Commands.Refresh(src)
        loadHouseData()
        TriggerClientEvent('apartments:client:setupSpawnUI', src, cData)
        TriggerEvent("qb-log:server:CreateLog", "joinleave", "Loaded", "green", "**".. GetPlayerName(src) .. "** ("..cData.citizenid.." | "..src..") loaded..")
	end
end)

RegisterServerEvent('qb-multicharacter:server:createCharacter')
AddEventHandler('qb-multicharacter:server:createCharacter', function(data)
    local src = source
    local newData = {}
    newData.cid = data.cid
    newData.charinfo = data
    --QBCore.Player.CreateCharacter(src, data)
    if QBCore.Player.Login(src, false, newData) then
        --print('^2[qb-core]^7 '..GetPlayerName(src)..' has succesfully loaded!')
        QBCore.Commands.Refresh(src)
        loadHouseData()
        TriggerClientEvent("qb-multicharacter:client:closeNUI", src)
        TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
        GiveStarterItems(src)
	end
end)

function GiveStarterItems(source)
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

RegisterServerEvent('qb-multicharacter:server:deleteCharacter')
AddEventHandler('qb-multicharacter:server:deleteCharacter', function(citizenid)
    local src = source
    QBCore.Player.DeleteCharacter(src, citizenid)
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:GetUserCharacters", function(source, cb)
    local license = QBCore.Functions.GetIdentifier(source, 'license')

    exports.oxmysql:fetch('SELECT * FROM players WHERE license=@license', {['@license'] = license}, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:GetServerLogs", function(source, cb)
    exports.oxmysql:fetch('SELECT * FROM server_logs', {}, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:setupCharacters", function(source, cb)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    local plyChars = {}
    
    exports.oxmysql:fetch('SELECT * FROM players WHERE license = @license', {['@license'] = license}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)
            table.insert(plyChars, result[i])
        end
        cb(plyChars)
    end)
end)

QBCore.Commands.Add("logout", "Logout of Character (Admin Only)", {}, false, function(source, args)
    QBCore.Player.Logout(source)
    TriggerClientEvent('qb-multicharacter:client:chooseChar', source)
end, "admin")

QBCore.Commands.Add("closeNUI", "Close Multi NUI", {}, false, function(source, args)
    TriggerClientEvent('qb-multicharacter:client:closeNUI', source)
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:getSkin", function(source, cb, cid)
    local src = source

    local result = exports.oxmysql:fetchSync('SELECT * FROM playerskins WHERE citizenid=@citizenid AND active=@active', {['@citizenid'] = cid, ['@active'] = 1})
    if result[1] ~= nil then
        cb(result[1].model, result[1].skin)
    else
        cb(nil)
    end
end)

function loadHouseData()
    local HouseGarages = {}
    local Houses = {}
    local result = exports.oxmysql:fetchSync('SELECT * FROM houselocations', {})
    if result[1] ~= nil then
        for k, v in pairs(result) do
            local owned = false
            if tonumber(v.owned) == 1 then
                owned = true
            end
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
