-- Activate auto align
if stabilizeShip==true then
    stabilizeShip = false
else
    stabilizeShip = true
    TargetAltitude = core.getAltitude()--We take the current one
end    
-- restore yaw to zero
yawInput = 0