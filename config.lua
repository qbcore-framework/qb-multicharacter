Config = {}
Config.StartingApartment = true -- Enable/disable starting apartments (make sure to set default spawn coords)
Config.Interior = vector3(-814.89, 181.95, 76.85) -- Interior to load where characters are previewed

--default random spawn code is somone will decide to add random places for spawning players at the begining. this will avoid spawn players at the same place if many players are joing the server at the same time. 
--local spawns = {vector4(-1035.71, -2731.87, 12.86, 0.0), vector4(100.52, -1713.44, 30.11, 138.14), vector4(129.69, -1739.09, 30.11, 149.73), vector4(432.15, -646.0, 28.72, 80.83), vector4(-207.2, -1015.77, 30.14, 339.53), vector4(-217.13, -1038.44, 30.14, 52.81), vector4(-220.63, -1052.83, 30.14, 49.43), vector4(-502.19, -683.29, 20.03, 201.38), vector4(119.83, -1728.39, 30.11, 346.95), vector4(-499.64, -665.41, 20.03, 174.33),}
--random = math.random(1~10)

Config.DefaultSpawn = vector3(-1035.71, -2731.87, 12.86) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(-813.97, 176.22, 76.74, -7.5) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(-812.23, 182.54, 76.74, 156.5) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(-813.46, 178.95, 76.85, 174.5) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = true -- Define if the player can delete the character or not

Config.DefaultNumberOfCharacters = 5 -- Define maximum amount of default characters (maximum 5 characters defined by default)
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}
