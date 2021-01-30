if screen == nil then
    system.print("Plug a screen to your seat first and type restoredb again")
else
    unit.stopTimer("showzone")
    local html =
        "-- Copy this in a notepad or a text editor, copy paste in system/inputText(restoredb) and type restoredb to load this data into the databank\r\n"
    for _, key in ipairs(json.decode(databank.getKeys())) do
        local data = databank.getStringValue(key)
        data = split(data, "|")
        html = html .. [[databank.setStringValue("]] .. key .. [[","]] ..
                   data[1] .. [[|]] .. data[2] .. [[|]] .. data[3] .. [[")]] .. "\r\n"
    end
    screen.activate()
    screen.setHTML(html)
    system.print(
        "DATA EXPORTED, right click on the screen, advanced/edit html content to view data")
    unit.setTimer("showzone", 1)
end
