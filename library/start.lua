-- Configuration variables
ship_align_angle = 90 --export: Target angle to maintain
bookmark_range_alert_distance = 7500 --export: Distance in meter, if a bookmark is closer than this it will be shown with the "in range" color 
bookmark_in_range_color = "0FFF67" --export: Bookmark color when the bookmark is in range
bookmark_outof_range_color = "bf5f00" --export: Bookmark color when the bookmark is not in range
alignment_precision = 0.3 --export: Number in degrees, for example if your chosen angle is 90° the autopilot will stop aligning between 90-theprecision and 90+theprecision
alignment_strength = 2 --export: Force applied to align, tweak this with caution, if too big it will make your ship spin

-- Functions
function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result
end

function getDistanceDisplayString(distance)
    local su = distance > 100000
    local result = ""
    if su then
        -- Convert to SU
        result = round(distance / 1000 / 200, 1) .. " SU"
    elseif distance < 1000 then
        result = round(distance, 1) .. " M"
    else
        -- Convert to KM
        result = round(distance / 1000, 1) .. " KM"
    end

    return result
end

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function sortSlot()
    for key, slot in pairs(unit) do
        if type(slot) == "table" and type(slot.export) == "table" then
            if slot.getElementIdList then
                core = slot
            elseif slot.setHTML then
                screen = slot
            elseif slot.getKeys then    
                databank = slot    
            end
        end
    end
end

-- code provided by tomisunlucky
-- Will give the ship heading in degree
function getHeading(forward)   
    local up = -vec3(core.getWorldVertical())
    forward = forward - forward:project_on(up)
    local north = vec3(0, 0, 1)
    north = north - north:project_on(up)
    local east = north:cross(up)
    local angle = north:angle_between(forward) * constants.rad2deg
    if forward:dot(east) < 0 then
        angle = 360-angle
    end
    return angle
end

function computeBookmarkAge(bookmarkkey)
    local formated_time=""
    if bookmarkkey then
        local age = (system.getTime()-bookmarkkey)
        -- DAYS (86 400 seconds are one day)
        local days = age // 86400
        -- Modulus to get hours lefts
        age = age % 86400
        -- HOURS (3600 seconds are one hour)
        local hours = age // 3600
        -- Modulus again to get minutes lefts
        age = age % 3600
        -- MINUTES (60 seconds are 1 minute) 
        local minutes = age // 60
        -- Modulus again to get minutes lefts
        age = age % 60
        local seconds = age
        if days > 0 then
            formated_time = tonumber(string.format("%."..(0).."f",days)).."d:"..tonumber(string.format("%."..(0).."f",hours)).."h:"..tonumber(string.format("%."..(0).."f",minutes)).."m:"..tonumber(string.format("%."..(0).."f", seconds)).."s"  
        elseif hours>0 then
            formated_time = tonumber(string.format("%."..(0).."f",hours)).."h:"..tonumber(string.format("%."..(0).."f",minutes)).."m:"..tonumber(string.format("%."..(0).."f", seconds)).."s"         
        elseif minutes>0 then
            formated_time = tonumber(string.format("%."..(0).."f",minutes)).."m:"..tonumber(string.format("%."..(0).."f", seconds)).."s"            
        elseif seconds>0 then
            formated_time = tonumber(string.format("%."..(0).."f",minutes)).."m:"..tonumber(string.format("%."..(0).."f", seconds)).."s"                
        end        	 
    end
    return formated_time
end
