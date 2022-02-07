
local xuiWidth, xuiHeight = GetActiveScreenResolution()
local xuiHandle = FiveX.CreateXui("https://raw.githubusercontent.com/illegal-instruction-co/text-xui/main/thebox.html", xuiWidth, xuiHeight)

function ChangeXuiBox(x, y, health)
    FiveX.SendXuiMessage(xuiHandle, json.encode({
        command = "change",
        x = x,
        y = y,
        health = health,
        maxHealth = maxHealth
    }))
end

Citizen.CreateThread(function()
    while true do
        if FiveX.IsKeyPressed(0x73) then -- F4
            FiveX.DestroyXui(xuiHandle)
        end
        
        Citizen.CreateThread(function() 
            
        local aScreenX, aScreenY = GetActiveScreenResolution()
        aScreenX = aScreenX / 100
        aScreenY = aScreenY / 100
            
        local player = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(playerCoords, playerCoords, true)
        local health = GetEntityHealth(player)
        local maxHealth = GetEntityMaxHealth(player)
        local retval, screenX, screenY = GetScreenCoordFromWorldCoord(playerCoords.x, playerCoords.y,  playerCoords.z)
        
        ChangeXuiBox((aScreenX * screenX * 100) - (aScreenX * 3), aScreenY * screenY * 100 - (aScreenY * 9), health, maxHealth)
        
        --print( aScreenX * screenX * 100, aScreenY * screenY * 100)
        --print(distance)
        
        end)
        
        Citizen.Wait(250)
    end
end)
