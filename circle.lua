local xuiWidth, xuiHeight = GetActiveScreenResolution()
local xuiHandle = FiveX.CreateXui("https://raw.githubusercontent.com/illegal-instruction-co/text-xui/main/circle.html", xuiWidth, xuiHeight)

function ChangeXuiCircleColor(clr)
    FiveX.SendXuiMessage(xuiHandle, json.encode({
        command = "color",
        color = clr
    }))
end

function ChangeXuiCircleSize(sz)
    FiveX.SendXuiMessage(xuiHandle, json.encode({
        command = "size",
        size = sz
    }))
end


Citizen.CreateThread(function()
    while true do
        if FiveX.IsKeyPressed(0x73) then -- F4
            FiveX.DestroyXui(xuiHandle)
        end
        
        if FiveX.IsKeyPressed(0x74) then -- F5
            ChangeXuiCircleColor("red")
        end
        
        if FiveX.IsKeyPressed(0x75) then -- F6
            ChangeXuiCircleSize("500")
        end
        Citizen.Wait(0)
    end
end)
