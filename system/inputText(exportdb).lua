for _, key in ipairs(json.decode(databank.getKeys())) do
    local data = databank.getStringValue(key)
    data = split(data,"|")
    system.print([[databank.setStringValue("]]..key..[[","]]..data[1]..[[|]]..data[2]..[[|]]..data[3]..[[|]]..data[4]..[[");]])
end
