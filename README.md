# DU-SCAVENGER-UI

The scavenger UI allow you to bookmark tiles and will remember when you visited them. When you return to a bookmarked zone, it will show you the date of your last visit.

It also should work in space and will tell you if you have been to this area.

Useful when doing a planet scan in search of abandonned constructs or simply tell you if you have already been to a specific place

if you are more than 1km away of the last bookmark : 
![image](https://raw.githubusercontent.com/Catharius/DU-SCAVENGER-UI/main/example1.jpg?token=ARIPOLDCGDEUK7S26BEWZIC77N2DG)

if you are near a bookmark :
![image](https://raw.githubusercontent.com/Catharius/DU-SCAVENGER-UI/main/example2.jpg?token=ARIPOLCAEOPJOWHFQNEQAF277N3PC)

## How is it working ?

This script will let you store where your ship is currently located and will also store the date of the record. You can do so by pressing ALT+1 (Option1)

When piloting, the script will look every seconds where is the nearest bookmark and will show it on your HUD. If you are 1km away or less of the bookmark, the UI will show you in green when was the last visit, if you are more than 1km away, the UI will show you the distance to the nearest bookmark.


## How to use this script

The goal of the script is to tell you if you have been to a place or not

* **ALT+1 (Option1)** : Create a new bookmark on your position

* LUA COMMANDS : Type them in the lua console to activate functions

exportdb : Require to plug a screen to your seat, type exportdb into the lua console to export the databank content, then right click on the screen, edit HTML and copy paste the content

restoredb : Before typing this command, copy the exported data into the lua in system / inputText(restoredb). It will then import all the saved data into the databank. Please note that the data already in the databank will be left untouched.

resetdb : Will clear the databank of all records



### List of lua parameters
* **bookmark_visited_distance** : Distance in meter, adjust to increase or decrease the visited area. 1000 meter by default to mark tiles as visited, 5000 meter for atmo  radar zone scan, 400000 for space radar.
* **bookmark_visited_color** : Bookmark color when the bookmark is in range
* **bookmark_notvisited_color** : Bookmark color when the bookmark is not in range
