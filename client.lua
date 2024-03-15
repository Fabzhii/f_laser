
Citizen.CreateThread(function()
    LocalPlayer.state:set('laser', false, true)
end)

local visordown = false 
local laser = false 
local infrared = false 

exports("toggleLaser", function(toggle)
    if toggle == nil then 
        laser = not laser
    else 
        laser = toggle
    end 
end)

exports("toggleInfrared", function(toggle)
    if toggle == nil then 
        infrared = not infrared
    else 
        infrared = toggle
    end 
end)

exports("toggleVisor", function(toggle)
    if toggle == nil then 
        visordown = not visordown
    else 
        visordown = toggle
    end 
end)

Citizen.CreateThread(function()
    while true do 
        if laser then 
            if IsPlayerFreeAiming(PlayerId()) then

                local ped = PlayerPedId()
                local weapon = GetCurrentPedWeaponEntityIndex(ped)
                local offset = GetOffsetFromEntityInWorldCoords(weapon, 0, 0, -0.01)
                local hit, coords = RayCastPed(offset, 15000, ped)

                if hit ~= 0 then
                    from = vector3(offset.x, offset.y, offset.z)
                    to = vector3(coords.x, coords.y, coords.z)

                    laser = Config.Green
                    if infrared then 
                        laser = Config.White
                    end 

                    LocalPlayer.state:set('laser', {from, to, laser}, true)
                else
                    LocalPlayer.state:set('laser', false, true)
                end
            else 
                LocalPlayer.state:set('laser', false, true)
                Citizen.Wait(5)
            end

            Citizen.Wait(1)
        else 
            Citizen.Wait(500)
            LocalPlayer.state:set('laser', false, true)
        end 
    end 
end)

Citizen.CreateThread(function()
    while true do 
        for k,v in pairs(GetActivePlayers()) do 
            local id = GetPlayerServerId(v)

            laser_table = Player(id).state.laser

            if laser_table ~= nil and laser_table ~= false then 
                from = laser_table[1]
                to = laser_table[2]
                laser = laser_table[3]

                local pedCoords = GetEntityCoords(PlayerPedId())
                if #(pedCoords - from) < Config.RenderDistance or #(pedCoords - to) < Config.RenderDistance then 
                    if laser == Config.White then 
                        if visordown then 
                            DrawLine(from, to, laser.x, laser.y, laser.z, laser.w)
                        end 
                    else 
                        DrawLine(from, to, laser.x, laser.y, laser.z, laser.w)
                    end 
                end 
            end 

        end 

        Citizen.Wait(1)
    end 
end)

function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastPed(pos,distance,ped)
    local cameraRotation = GetGameplayCamRot()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = pos.x + direction.x * distance, 
		y = pos.y + direction.y * distance, 
		z = pos.z + direction.z * distance 
	}

	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(pos.x, pos.y, pos.z, destination.x, destination.y, destination.z, -1, ped, 1))
    return b, c
end