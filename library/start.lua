bookmark_visited_distance = 1000 --export: Distance in meter, if a bookmark is closer than this it will be shown as visited area
bookmark_visited_color = "0FFF67" --export: Bookmark color when the bookmark is in range
bookmark_notvisited_color = "bf5f00" --export: Bookmark color when the bookmark is not in range

--[[
    Jericho's time script -- https://github.com/Jericho1060
    Display IRL date and time in game
    https://github.com/Jericho1060/DualUniverse/edit/master/TimeScript/TimeScript.lua
]]--

summer_time = false --export

function DUCurrentDateTime()
    local time = system.getTime()
    local additionnal_hour = 0
    local seconds_to_2018 = 7948800 --from 01-10-2017 (arkship time)
    local secondsInMinute = 60
    local secondsInHour = secondsInMinute * 60
    local secondsInDay = secondsInHour * 24
    local secondsInYear = secondsInDay * 365
    local weekDaysNames = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}
    local weekDaysShortNames = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"}
    local monthNames = {"January", "Febuary", "March", "April", "May", "June", "July", "August", "Septrember", "October", "Novermber", "December"}
    local monthShortNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
    if summer_time then time = time + 1 end
    time = time - seconds_to_2018
    local weekDayIndex = math.floor(time/secondsInDay)%7
    if weekDayIndex == 0 then weekDayIndex = 7 end
    local year = 2018
    local month = 1
    local day = 1
    local daysInFebuary = 28
    while time >= secondsInYear do
        if (year % 4) == 0 then --leap year
            if time >= (secondsInYear - secondsInDay) then
                year = year + 1
                time = time - secondsInYear - secondsInDay
            else
                local daysInFebuary = 29
                break
            end
        else
            year = year + 1
            time = time - secondsInYear
        end
    end
    local daysFromYearStart = math.floor(time/secondsInDay)
    if daysFromYearStart >= 31 then
        month = 2
        daysFromYearStart = daysFromYearStart - 31
    end
    if daysFromYearStart >= daysInFebuary then
        month = 3
        daysFromYearStart = daysFromYearStart - daysInFebuary
    end
    if daysFromYearStart >= 31 then
        month = 4
        daysFromYearStart = daysFromYearStart - 31
    end
    if daysFromYearStart >= 30 then
        month = 5
        daysFromYearStart = daysFromYearStart - 30
    end
    if daysFromYearStart >= 31 then
        month = 6
        daysFromYearStart = daysFromYearStart - 31
    end
    if daysFromYearStart >= 30 then
        month = 7
        daysFromYearStart = daysFromYearStart - 30
    end
    if daysFromYearStart >= 31 then
        month = 8
        daysFromYearStart = daysFromYearStart - 31
    end
    if daysFromYearStart >= 31 then
        month = 9
        daysFromYearStart = daysFromYearStart - 31
    end
    if daysFromYearStart >= 30 then
        month = 10
        daysFromYearStart = daysFromYearStart - 30
    end
    if daysFromYearStart >= 31 then
        month = 11
        daysFromYearStart = daysFromYearStart - 31
    end
    if daysFromYearStart >= 30 then
        month = 12
        daysFromYearStart = daysFromYearStart - 30
    end
    day = daysFromYearStart
    time = time % secondsInDay
    local h = math.floor(time/secondsInHour)%24
    local m = math.floor(time%secondsInHour/60)
    local s = math.floor(time%60)
    return year, month, day, h, m, s, weekDayIndex, weekDaysNames[weekDayIndex], weekDaysShortNames[weekDayIndex], monthNames[month], monthShortNames[month]
end


function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
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
