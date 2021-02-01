# DU-SCAVENGER-UI

The scavenger UI is dedicated to exploration, precise radar zone scanning and salvage operations. 
![image](https://raw.githubusercontent.com/Catharius/DU-SCAVENGER-UI/main/hud.jpg?token=ARIPOLEXBVDDYHCKPJSYEQDACR5IU)

If you want to support me you can visit my museum in surrogate (search for "Salvage Museum") and make a small donation at the dispenser. All the ships you will see at the museum have been salvaged with the help of this script.


## What it does :
* It can save up to 350 bookmarks
* It will always show you the closest bookmark and make a setDestination to it so you can see it ingame. Your distance to the bookmark and the bookmark age is displayed.
* You can specify a range to help you scan with the radar. I recommand 7.5km in atmo or 200km in space (yes it works in space too)
* Getting out of the range of a bookmark will change the color of the text so you can put another bookmark if needed to mark the area that you have explored
* It will also allow you to fly in a straight line to the angle you specify in the lua parameters (0 North, 90 East, 180 South, 270 WEST) using alt+1 to stabilize your ship (You can relax and control the pitch, the rest will be taken care of)

## Requirements
* A databank linked to you seat
* You will need planetref.lua and atlas.lua from JayleBreak, you can download them at https://gitlab.com/JayleBreak/dualuniverse/-/tree/master/DUflightfiles/autoconf/custom

Copy paste these files into your DU directory into \Dual Universe\Game\data\lua\cpml and you are good to go


## How is it working ?

This script will let you store where your ship is currently located and will also store the date of the record. You can do so by pressing ALT+2 (Option2)

When piloting, the script will look every seconds where is the nearest bookmark and will show it on your HUD by using a setWaypoint command (setDestination). The HUD will also show you the age of the bookmark.

Using ALT+1(option1) when aligned  in the green zone will maintain altitude and keep the ship pointing toward the chosen azimuth.

**Warning : Before using ALT+1, be sure to be at an altitude of 1000m or deactivate the maintain altitude parameter

## How to use this script

The goal of the script is to tell you if you have been to a place or not

* **ALT+1 (Option1)** : To be used when the ship is near the "green zone", it will activate the stabilization and will align the ship to the chosen angle.

* **ALT+2 (Option2)** : Create a new bookmark on your position

* **LUA COMMANDS** : Type them in the lua console to activate functions

**exportdb** : Require to link a screen to your seat, type exportdb into the lua console to export the databank content, then right click on the screen, edit HTML and copy paste the content

**restoredb** : Before typing this command, copy the exported data into the lua in system / inputText(restoredb). It will then import all the saved data into the databank. Please note that the data already in the databank will be left untouched.

**resetdb** : Will clear the databank of all records

## Pro tips for planet salvaging
* Start by putting a bookmark
* While on the bookmark, turn your ship east (set the lua parameter ship_align_angle to 90°)
* Press alt+1 to lock the ship in this direction and start the engines (You can control the pitch of the ship to gain altitude or lower your altitude)
* if you see something of interest, press alt+2 to put another bookmark then go to what you have seen.
* To get back to your initial trajectory, go back to the bookmark, head east again and repeat
* When you have made a full turn of the planet you will see the old bookmark that you made when you started. Go to it then head south or north and stop when you are 7-8 km away from it.
* Put a new bookmark.. rinse and repeat !


### List of lua parameters
* **ship_align_angle** : The azimuth angle that you want the ship to maintain
* **bookmark_range_alert_distance** : Distance in meter, if a bookmark is closer than this it will be shown with the "in range" color 
* **bookmark_in_range_color** : Bookmark color when the bookmark is in range
* **bookmark_outof_range_color** : Bookmark color when the bookmark is not in range
* **alignment_precision** : Number in degrees, for example if your chosen angle is 90° the autopilot will stop aligning between 90-theprecision and 90+theprecision
* **alignment_strength** : Force applied to align, tweak this with caution, if too big it will make your ship spin
* **maintain_altitude** : On by default, maintain altitude when you have pressed ALT+1 (Option1)

### My todo list for the future
* Add a function to stop the bookmark setDestination function if we want to set our own bookmark

### Disclaimer
This script is in beta and have been tested on a small XS ship, using it on a bigger ship will require testing and tweaking of the lua parameters

### Credits
Dimencia https://github.com/Dimencia/DU-Orbital-Hud

JayleBreak https://gitlab.com/JayleBreak/dualuniverse/-/tree/master/DUflightfiles/autoconf/custom

FoolsFolly https://github.com/FoolsFolly/DU-Auto-Pitch
