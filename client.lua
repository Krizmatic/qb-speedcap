QBCore = exports['qb-core']:GetCoreObject()
local vehiclerecognized = false

function DrawDebug(txt) ---This is just for debug stuff.
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.3)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)

	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(0.75, 0.055)
end

---Main thread that handles... everything.
CreateThread(function()
  while true do
        Wait(0)
			local ped = PlayerPedId() --Get the player's ped ID.

			
		if IsPedInAnyVehicle(ped,false) then
					local veh = GetVehiclePedIsIn(ped,false) --Get a reference to the specific vehicle the client ped is in.
					local vehhash = GetHashKey(GetEntityModel(veh)) --Grab the hash of the vehicle the player is in to compare to our config list.
					local vehtype = GetVehicleClass(veh) --Get the vehicle class in case. Not really needed anymore but keeping it just in case.
			--if vehtype ~= 18 then --This used to check if the vehicle is an emergency vehicle, but it isn't needed. the 'end' that is commented out is the end of this if.
                for k,v in pairs (Config.VehicleList) do --Go through the array of vehicles from the config
                    if GetHashKey(v.hash) == vehhash then --Compare the player's vehicle's hash to the hash defined for each car in the config.
									if v.speed then
										local maxspeed = v.speed/3.6 --Do math to convert KPH from config to GTA garbage numbers.
										SetVehicleMaxSpeed(veh, maxspeed) --Sets the max speed the vehicle can possibly achieve if the other physic's allow it to get that far.
									end
									--These are setting all the handling data defined in the config file. If the car in question doesn't have a variable defined it won't throw an error because it checks if it exists first.
									if v.fMass then SetVehicleHandlingFloat(veh, 'CHandlingData', 'fMass', tonumber(v.fMass)+.0) end
									if v.InitialDragCoeff then SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDragCoeff', tonumber(v.InitialDragCoeff)+.0) end
									if v.fInitialDriveForce then SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', tonumber(v.fInitialDriveForce)+.0) end
									if v.fDriveInertia then SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveInertia', tonumber(v.fDriveInertia)+.0) end
									if v.fDriveBiasFront then SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveBiasFront', tonumber(v.fDriveBiasFront)+.0) end

									vehiclerecognized = true --Tells the script that the player vehicle is in the config array.
									
									--[[ This section is just for debugging, isn't needed for functionality. Just pulls the variables back out from the handling file to make sure they are actually set, and displays them.
									fmass = GetVehicleHandlingFloat(veh,'CHandlingData','fMass')
									drag =  GetVehicleHandlingFloat(veh,'CHandlingData','fInitialDragCoeff')
									driveforce = GetVehicleHandlingFloat(veh,'CHandlingData','fInitialDriveForce')
									inertia = GetVehicleHandlingFloat(veh,'CHandlingData','fDriveInertia')
									
									DrawDebug('Next gear: ' .. GetVehicleNextGear(veh) .. '\nDrag Coefficient: ' .. drag .. '\nfInitialDriveForce: ' .. driveforce .. '\nfDriveInertia: ' .. inertia)
							]]--
                    elseif not vehiclerecognized and Config.GovernAllCars then --If the vehicle isn't in the config BUT we have a global max speed, this happens.
                                SetVehicleMaxSpeed(veh, Config.MaxSpeed/3.6)
								--print('couldnt find vehicle in list')
						
                    end
                end
			--end
			if Config.NoBurnouts then SetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult', 0.0) end --This gets rid of tire spin when first accelerating, so you aren't constantly doing burnouts. I should turn this into something that can be toggled by the player but... meh.
			
		else
			vehiclerecognized = false --If the player leaves or just isn't in a car, we tell the script we aren't in a recognized vehicle anymore.

		end
				
			
	end
end)
