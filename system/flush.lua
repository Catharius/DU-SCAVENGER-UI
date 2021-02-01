-- FoolsFolly autopitch (Put this code between Axis and rotation)
if stabilizeShip==true and maintain_altitude==true then
    local currentPitchDeg = math.max(math.min(getRoll(worldVertical, constructRight, -constructForward)/60, 1), -1) -- Angle of construct's current pitch, expressed as a value between -1 and 1, up to 60 degrees
    local heightDiff = math.max(math.min((TargetAltitude - core.getAltitude())/1000, 1), -1) -- Difference between current and target altitude; values expressed between -1 and 1, up to 1000m
    local verticalSpeed = vec3(core.getWorldVelocity()):dot(-vec3(core.getWorldVertical()))*3.6/2500 -- Speed moving up/down, in km/h, divided by 1000
    finalPitchInput = (heightDiff - currentPitchDeg) - verticalSpeed -- Increase pitch relative to needed altitude change, decrease relative to current pitch, decrease relative to current vertical speed
end

-- Find this code near line 47
-- Rotation
local constructAngularVelocity = vec3(core.getWorldAngularVelocity())
local targetAngularVelocity = finalPitchInput * pitchSpeedFactor * constructRight
                                + finalRollInput * rollSpeedFactor * constructForward
                                + finalYawInput * yawSpeedFactor * constructUp

-- then copy paste this after
-- START OF SCAVENGER SCRIPT CODE
if stabilizeShip==true then
    local targetRollDeg = utils.clamp(0, currentRollDegAbs - 30, currentRollDegAbs + 30); -- we go back to 0 within a certain limit
    if (rollPID == nil) then
        rollPID = pid.new(autoRollFactor * 0.01, 0, autoRollFactor * 0.1) -- magic number tweaked to have a default factor in the 1-10 range
    end
    rollPID:inject(targetRollDeg - currentRollDeg)
    local autoRollInput = rollPID:get()
    targetAngularVelocity = targetAngularVelocity + autoRollInput * constructForward
    -- align script
    local angle = getHeading(vec3(core.getConstructWorldOrientationForward()))
    if angle>(ship_align_angle-5) and angle<(ship_align_angle+5) then
        if angle<ship_align_angle-alignment_precision then
            --Turn right very slowly
            yawInput = yawInput - (alignment_strength/1000)  
        elseif angle>ship_align_angle+alignment_precision then
            --Turn left very slowly
            yawInput = yawInput + (alignment_strength/1000)
        else
            --We are aligned, no need to turn anymore
            yawInput = 0
        end    
    end
end      
-- END OF SCAVENGER SCRIPT CODE