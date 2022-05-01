-- Add this at the end of the unit start
--Init
vec3  = require('cpml.vec3')
utils = require('cpml.utils')
planetRef = require('planetref')
referenceTableSource = require('atlas')
galaxyReference = planetRef(referenceTableSource)
helios = galaxyReference[0]
currentBookmark = nil
current_planet_id = 2
current_planet = helios[current_planet_id] -- See atlas for ref

databank = nil
screen = nil
-- Init slots
sortSlot()
-- if databank is null print error
if databank == nil then
    system.setScreen([[<svg style="position:absolute;top:0vh" viewBox="0 0 1920 1080" style="width:100%; height:100%">
    <g>
     <text xml:space="preserve" text-anchor="start" font-family="sans-serif" font-size="24" id="svg_1" y="548.5" x="571.29999" stroke-width="0" stroke="#000" fill="#bf0000">NO DATABANK FOUND, PLEASE PLUG A DATABANK TO YOUR SEAT</text>
    </g>
   </svg>]])
else     
    -- Init state
    unit.setTimer("showzone",0.25)
    stabilizeShip=false
    TargetAltitude = 0
    -- Visuals 
    core.hide()
end
system.showScreen(1)
