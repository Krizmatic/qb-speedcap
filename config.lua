Config = {}
Config.NoBurnouts = true -- Just gets rid of the acceleration burnouts altogether, can still brake+accel to do a burnout, but it won't happen on takeoff.
Config.GovernAllCars = true -- Set true to make Config.MaxSpeed apply to all vehicles not listed in the VehicleList
Config.MaxSpeed = 250 --GLOBAL MAX SPEED for vehicles not listed below (in KPH). This will set a hard cap on all vehicles to this number. Makes it easier to just make sure no cars slip through and go too fast for RP.

--[[
hash is just the spawn name of the vehcle, but it isn't technically stored as a string, so put it in ` not ' (the non-shift tilde key).
speed is just max speed cap of the vehicle. Doesn't mean that it will be reached. It is a hard(ish) cap for the script. usually ends up going 1 KPH over if the physics even let it reach that speed.
InitialDragCoeff is the wind resistance (drag). Matters at all speeds, plays mostly into top speed but somewhat into acceleration. Doesn't matter as much as the other shit. Keep it between like 6-15.
fMass is just the mass of the vehicle in kg. Seems to actually use realistic values, so I just google the IRL car's curb weight and convert to kg. Mostly matters for collisions, don't think it affects speed/accel.
fInitialDriveForc is power output of the trans, 1.0 is normal, below is slower, above is faster.
fDriveInertia is how fast the engine revs. 1.0 is default. lower is slow, higher is faster.
fDriveBiasFront is for FWD,RWD,AWD. FWD is 1.0, RWD is 0.0, AWD is 0.5, not really a reason to split between any of these 3.
]]--


Config.VehicleList = {
    --The only required variable for this is hash. The rest can be left out for a car if not needed to make it work how we want it. Just make sure that the ['spawncode'] and hash are filled in properly.
    --the spawn code in brackets doesn't REALLY matter or have to be the same as the hash. It is never actually used. It is just the name of the entry in the array. It just makes it easier to decipher if they are the same.

    ['GTR'] = {hash = `GTR`, speed = 125, InitialDragCoeff = 5.000000, fMass = 1785.0, fInitialDriveForce = 1.0, fDriveInertia = 1.0, fDriveBiasFront = 0.5},

    ['350z'] = {hash = `350z`, speed = 90, InitialDragCoeff = 4.0, fMass = 1700.0, fInitialDriveForce = 0.750, fDriveInertia = 2.0},

    ['nissantitan17'] = {hash =`nissantitan17`, speed = 120, InitialDragCoeff = 15.0,fInitialDriveForce = 0.015, fDriveInertia = 0.15},

    ['gt17'] = {hash = `gt17`, speed = 200, InitialDragCoeff = 15.0, fMass = 1095.0, fInitialDriveForce = 0.015, fDriveInertia = 0.15},

    ['sanchez'] = {hash = `sanchez`, speed = 125, InitialDragCoeff = 7.000000, fMass = 220.0, fInitialDriveForce = 0.75, fDriveInertia = 1.67},
}