local year, month, day, hour, minute, second, weekDayIndex, weekDayName, weekDayShortName, monthName, monthShortName = DUCurrentDateTime()
local now_str = string.format("%02d/%02d/%04d %02d:%02d:%02d",day,month,year,hour,minute,second)
databank.setStringValue(system.getTime(),now_str.."|"..system.getPlayerWorldPos(unit.getMasterPlayerId())[1].."|"..system.getPlayerWorldPos(unit.getMasterPlayerId())[2].."|"..system.getPlayerWorldPos(unit.getMasterPlayerId())[3])
