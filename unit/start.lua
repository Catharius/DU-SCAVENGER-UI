-- Add this at the end of the unit start
--Init
vec3  = require('cpml.vec3')
utils = require('cpml.utils')
planetRef = require('cpml.planetref')
referenceTableSource = require('cpml.atlas')
galaxyReference = planetRef(referenceTableSource)
helios = galaxyReference[0]
currentBookmark = nil
current_planet_id = 2
current_planet = helios[current_planet_id] -- See atlas for ref

unit.setTimer("showzone",0.25)
-- Init slots
sortSlot(slot1)
sortSlot(slot2)
sortSlot(slot3)
sortSlot(slot4)
sortSlot(slot5)
sortSlot(slot6)
sortSlot(slot7)
sortSlot(slot8)
sortSlot(slot9)
sortSlot(slot10)
-- Init state
stabilizeShip=false
-- Visuals 
core.hide()
system.showScreen(1)