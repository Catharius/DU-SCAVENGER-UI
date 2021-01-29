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