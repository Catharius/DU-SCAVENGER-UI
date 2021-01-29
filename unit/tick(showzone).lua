local closest_scan_distance = -1
local totalbm = 0
local closestBookmark = nil

-- First we are going to check every bookmarks in the databank
-- For every one of them we are computing the ship's distance to them 
-- We keed the closest one in the end
for _, key in ipairs(json.decode(databank.getKeys())) do
    totalbm = totalbm + 1 --Counting nb of bookmarks
    local data = databank.getStringValue(key)
    data = split(data,"|")
    scan_position = vec3({tonumber(data[1]),tonumber(data[2]),tonumber(data[3])})
    local distanceToScan = (scan_position - vec3(core.getConstructWorldPos())):len()
    if closest_scan_distance < 0 then
        closest_scan_distance = distanceToScan
        closestBookmark = key
    elseif  closest_scan_distance > distanceToScan then
        closest_scan_distance = distanceToScan
        closestBookmark = key
    end 
end

-- Change bookmark if necessary (Used to avoid making a setDestination at every tick)
if currentBookmark == nil and closestBookmark ~= nil then
    -- Executed once if there is no bookmarks in the databank
    currentBookmark = closestBookmark
    currentBookmarkData = databank.getStringValue(currentBookmark)
    currentBookmarkData = split(currentBookmarkData,"|")
    worldCoords = current_planet:convertToMapPosition(vec3({tonumber(currentBookmarkData[1]),tonumber(currentBookmarkData[2]),tonumber(currentBookmarkData[3])}))
    system.setWaypoint([[::pos{0,]]..current_planet_id..[[,]]..worldCoords.latitude*constants.rad2deg..[[,]]..worldCoords.longitude*constants.rad2deg..[[,]]..worldCoords.altitude..[[}]])
elseif currentBookmark ~= closestBookmark then
    -- Executed when we find a bookmark closer than the current one
    currentBookmark = closestBookmark
    currentBookmarkData = databank.getStringValue(currentBookmark)
    currentBookmarkData = split(currentBookmarkData,"|") -- Getting data (We could register more data like radar contacts at the time of the bookmark for example, or fuel level of your ship)
    -- We are converting raw coordinates into a map coordinate so we can make a setDestination
    worldCoords = current_planet:convertToMapPosition(vec3({tonumber(currentBookmarkData[1]),tonumber(currentBookmarkData[2]),tonumber(currentBookmarkData[3])}))
    system.setWaypoint([[::pos{0,]]..current_planet_id..[[,]]..worldCoords.latitude*constants.rad2deg..[[,]]..worldCoords.longitude*constants.rad2deg..[[,]]..worldCoords.altitude..[[}]])
end    

-- Experimental automatic mode to put waypoint every x km 
--if false and closest_scan_distance>bookmark_visited_distance then  
--    databank.setStringValue(system.getTime(),system.getPlayerWorldPos(unit.getMasterPlayerId())[1].."|"..system.getPlayerWorldPos(unit.getMasterPlayerId())[2].."|"..system.getPlayerWorldPos(unit.getMasterPlayerId())[3])
--    closest_scan_distance = 0
--end 

local color = bookmark_outof_range_color
if closest_scan_distance<bookmark_range_alert_distance then
    color = bookmark_in_range_color
end    

-- Computing heading angle to show in the HUD
local angle = getHeading(vec3(core.getConstructWorldOrientationForward()))
local arrow = ""
local color_angle = "7f0000"
if angle>(ship_align_angle-3) and angle <(ship_align_angle+3) then
    color_angle = "0FFF67"
elseif angle>(ship_align_angle-10) and angle <(ship_align_angle+10) then
    color_angle = "ffaa56"
end    

local stabmessage = [[<text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="603.15785" x="1126.68424" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">Turn the ship slowly to the green zone</text>]]
if stabilizeShip and angle>(ship_align_angle-5) and angle<(ship_align_angle+5) then
    stabmessage = [[<text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="603.15785" x="1126.68424" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#0FFF67">Aligned</text>]]
elseif not stabilizeShip and angle>(ship_align_angle-5) and angle<(ship_align_angle+5) then     
    stabmessage = [[<text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="603.15785" x="1126.68424" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">Press Alt+1 to align</text>]]     
end

-- We make an arrow that moves from 0° to 360°
arrow = [[<g transform="translate(]]..angle..[[,0)">
<path transform="rotate(-90, 758.757, 611.145)" id="svg_7" d="m760.19621,611.14456l-8.44388,-10.80688l5.56096,0l8.44388,10.80688l-8.44388,10.80687l-5.56096,0l8.44388,-10.80687z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#7f0000"/>
<path transform="rotate(90, 758.757, 584.479)" id="svg_8" d="m760.19621,584.47789l-8.44388,-10.80688l5.56096,0l8.44388,10.80688l-8.44388,10.80687l-5.56096,0l8.44388,-10.80687z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#7f0000"/>
<rect id="svg_10" height="10" width="2" y="592.89475" x="757.71946" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#7f0000"/>
</g>]]  

--Show HUD
system.setScreen([[<svg style="position:absolute;top:0vh" viewBox="0 0 1920 1080" style="width:100%; height:100%">
    <g transform="translate(0,-435)">
    <g>
    <rect id="svg_3" height="10" width="360" y="592.89475" x="758" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#ffaa56"/>
    <g transform="translate(]]..ship_align_angle..[[,0)"><rect id="svg_5" height="10" width="10" y="592.69475" x="754" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#7fff00"/></g>
    ]]..arrow..[[
    <g transform="translate(0,0)"><text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="590.69475" x="754" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">N</text></g>
    <g transform="translate(90,0)"><text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="590.69475" x="754" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">E</text></g>
    <g transform="translate(180,0)"><text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="590.69475" x="754" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">S</text></g>
    <g transform="translate(270,0)"><text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="590.69475" x="754" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">W</text></g>
    <g transform="translate(360,0)"><text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="590.69475" x="754" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">N</text></g>
    <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="18" id="svg_12" y="570.5264" x="917.89381" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#]]..color_angle..[[">]]..round(angle,2)..[[°</text>
    <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_13" y="641.10522" x="810.84214" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">Nearest bookmark (created ]]..computeBookmarkAge(closestBookmark)..[[ ago)</text>
    <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="18" id="svg_13" y="662.10522" x="913.84214" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#]]..color..[[">]]..getDistanceDisplayString(closest_scan_distance)..[[</text>
    <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_14" y="603.15785" x="683.68424" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">]]..totalbm..[[/350</text>
    <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_15" y="617.15785" x="683.68424" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">Bookmarks</text>]]..stabmessage..[[
    </g></g></svg>]])