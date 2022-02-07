local pedData = {}
local maxDistance = 1000
local minDistance = 0.01
local activeXui = true
local xuiWidth, xuiHeight = GetActiveScreenResolution()
local xuiHandle = FiveX.CreateXui("https://raw.githubusercontent.com/illegal-instruction-co/text-xui/main/xesp.html", xuiWidth, xuiHeight)

function SavePedData(player, xc, yc, h, mH, d) 
  table.insert(pedData, {id = player, x = xc, y = yc, health = h, maxHealth = mH, distance = d})
end

--[[ 
  Save Ped Data Thread
--]]
Citizen.CreateThread(function()
    while true do
       if activeXui then
        Citizen.CreateThread(function() 
            
          local aScreenX, aScreenY = GetActiveScreenResolution()
          aScreenX = aScreenX / 100
          aScreenY = aScreenY / 100

          for playerNum, playerPedId in pairs(GetActivePlayers()) do
            local player = GetPlayerPed(playerPedId)
            local localPlayer = GetPlayerPed(-1)
            local playerCoords = GetEntityCoords(player)
            local distance = GetDistanceBetweenCoords(GetFinalRenderedCamCoord(), playerCoords, true)
            local health = GetEntityHealth(player)
            local maxHealth = GetEntityMaxHealth(player)
            local retval, screenX, screenY = GetScreenCoordFromWorldCoord(playerCoords.x, playerCoords.y,  playerCoords.z)

            if(distance < maxDistance and distance > minDistance) then 
              SavePedData("P-"..player, (aScreenX * screenX * 100) - (aScreenX * 4), aScreenY * screenY * 100 - (aScreenY * 9), health, maxHealth, distance)
            end
            Citizen.Wait(1)
          end
        end)
      end
      Citizen.Wait(1)
    end
end)

--[[ 
  Destroy XESP Thread
--]]
Citizen.CreateThread(function() 
  while true do
    if activeXui then
      if FiveX.IsKeyPressed(0x73) then -- F4
          FiveX.DestroyXui(xuiHandle)
          activeXui = false
      end
    end
    Citizen.Wait(0)
  end
end)


--[[ 
  Send Ped Data Thread
--]]
Citizen.CreateThread(function() 
  while true do
    if activeXui then
      FiveX.SendXuiMessage(xuiHandle, json.encode({
          command = "change",
          peds = pedData
      }))
      pedData = {}
    end
    Citizen.Wait(10)
  end
end)

print("injected?")
