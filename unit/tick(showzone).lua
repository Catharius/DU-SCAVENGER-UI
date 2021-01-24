local closest_scan_distance = -1
local time_of_scan = ""
local totalbm = 0

local closestBookmark = nil
for _, key in ipairs(json.decode(databank.getKeys())) do
    totalbm = totalbm + 1
    local data = databank.getStringValue(key)
    data = split(data, "|")
    time_of_scan = data[1]
    scan_position = vec3({
        tonumber(data[2]), tonumber(data[3]), tonumber(data[4])
    })
    local distanceToScan =
        (scan_position - vec3(core.getConstructWorldPos())):len()
    if closest_scan_distance < 0 then
        closest_scan_distance = distanceToScan
        closestBookmark = key
    elseif closest_scan_distance > distanceToScan then
        closest_scan_distance = distanceToScan
        closestBookmark = key
    end
end

-- Change bookmark if necessary
if currentBookmark == nil and closestBookmark ~= nil then
    currentBookmark = closestBookmark
    currentBookmarkData = databank.getStringValue(currentBookmark)
    currentBookmarkData = split(currentBookmarkData, "|")
    worldCoords = current_planet:convertToMapPosition(
                      vec3({
            tonumber(currentBookmarkData[2]), tonumber(currentBookmarkData[3]),
            tonumber(currentBookmarkData[4])
        }))
    system.setWaypoint([[::pos{0,]] .. current_planet_id .. [[,]] ..
                           worldCoords.latitude * constants.rad2deg .. [[,]] ..
                           worldCoords.longitude * constants.rad2deg .. [[,]] ..
                           worldCoords.altitude .. [[}]])
elseif currentBookmark ~= closestBookmark then
    currentBookmark = closestBookmark
    currentBookmarkData = databank.getStringValue(currentBookmark)
    currentBookmarkData = split(currentBookmarkData, "|")
    worldCoords = current_planet:convertToMapPosition(
                      vec3({
            tonumber(currentBookmarkData[2]), tonumber(currentBookmarkData[3]),
            tonumber(currentBookmarkData[4])
        }))
    system.setWaypoint([[::pos{0,]] .. current_planet_id .. [[,]] ..
                           worldCoords.latitude * constants.rad2deg .. [[,]] ..
                           worldCoords.longitude * constants.rad2deg .. [[,]] ..
                           worldCoords.altitude .. [[}]])
end

-- If we are 5km away, put new bookmark   
if false and closest_scan_distance > bookmark_visited_distance then
    local year, month, day, hour, minute, second, weekDayIndex, weekDayName,
          weekDayShortName, monthName, monthShortName = DUCurrentDateTime()
    local now_str = string.format("%02d/%02d/%04d %02d:%02d:%02d", day, month,
                                  year, hour, minute, second)
    databank.setStringValue(system.getTime(),
                            now_str .. "|" ..
                                system.getPlayerWorldPos(
                                    unit.getMasterPlayerId())[1] .. "|" ..
                                system.getPlayerWorldPos(
                                    unit.getMasterPlayerId())[2] .. "|" ..
                                system.getPlayerWorldPos(
                                    unit.getMasterPlayerId())[3])
    closest_scan_distance = 0
end

local text = "Closest bookmark : " ..
                 getDistanceDisplayString(closest_scan_distance)
local color = bookmark_notvisited_color
local state = "Area not visited yet.(Alt+1 to mark as visited) "
if closest_scan_distance < bookmark_visited_distance then
    color = bookmark_visited_color
    state = "Last visit : " .. time_of_scan
end
local angle = getHeading(vec3(core.getConstructWorldOrientationForward()))
local arrow = ""
local color_angle = "7f0000"
if angle > 87 and angle < 93 then
    color_angle = "0FFF67"
elseif angle > 80 and angle < 100 then
    color_angle = "ffaa56"
end

if angle >= 0 and angle <= 180 then
    -- 0° = 760
    -- 180° = 1120
    local posx = angle * 2
    arrow = [[<g transform="translate(]] .. posx .. [[,0)">
    <path transform="rotate(-90, 758.757, 611.145)" id="svg_7" d="m760.19621,611.14456l-8.44388,-10.80688l5.56096,0l8.44388,10.80688l-8.44388,10.80687l-5.56096,0l8.44388,-10.80687z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#7f0000"/>
    <path transform="rotate(90, 758.757, 584.479)" id="svg_8" d="m760.19621,584.47789l-8.44388,-10.80688l5.56096,0l8.44388,10.80688l-8.44388,10.80687l-5.56096,0l8.44388,-10.80687z" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#7f0000"/>
    <rect id="svg_10" height="10" width="2" y="592.89475" x="757.71946" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#7f0000"/>
    </g>]]
end

system.setScreen(
    [[<svg style="position:absolute;top:0vh" viewBox="0 0 1920 1080" style="width:100%; height:100%">
    <g>
    <rect id="svg_3" height="10" width="360" y="592.89475" x="758" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#ffaa56"/>
    <rect id="svg_5" height="10" width="10" y="592.89475" x="933" stroke-opacity="null" stroke-width="1.5" stroke="#000" fill="#7fff00"/>
    ]] .. arrow .. [[
    <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="18" id="svg_12" y="570.5264" x="917.89381" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#]] ..
        color_angle .. [[">]] .. round(angle, 2) .. [[°</text>
    <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="18" id="svg_13" y="642.10522" x="913.84214" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#]] ..
        color .. [[">]] .. getDistanceDisplayString(closest_scan_distance) ..
        [[</text>
    <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="15" id="svg_14" y="603.15785" x="685.68424" stroke-opacity="null" stroke-width="0" stroke="#000" fill="#ffffff">]] ..
        totalbm .. [[ saved</text>
    </g></svg>]])
