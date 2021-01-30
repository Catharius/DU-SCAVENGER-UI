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

databank = nil
screen = nil
-- Init slots
sortSlot()
-- Init state
unit.setTimer("showzone",0.25)
stabilizeShip=false
-- Visuals 
core.hide()
system.showScreen(1)