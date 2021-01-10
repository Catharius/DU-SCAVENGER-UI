# DU-SCAVENGER-UI

The scavenger UI allow you to bookmark tiles and will remember when you visited them.
It also should work in space and will tell you if you have been to this area.

Useful when doing a planet scan in search of abandonned constructs or simply tell you if you have already been to a specific place

if you are more than 1km away of the last bookmark : 
![image](https://raw.githubusercontent.com/Catharius/DU-SCAVENGER-UI/main/example1.jpg?token=ARIPOLDCGDEUK7S26BEWZIC77N2DG)

if you are near a bookmark :
![image](https://raw.githubusercontent.com/Catharius/DU-SCAVENGER-UI/main/example2.jpg?token=ARIPOLCAEOPJOWHFQNEQAF277N3PC)

## How to use this script





### List of lua parameters
* **bookmark_visited_distance** : Distance in meter, adjust to increase or decrease the visited area. 1000 meter by default to mark tiles as visited, 5000 meter for atmo  radar zone scan, 400000 for space radar.
* **bookmark_visited_color** : Bookmark color when the bookmark is in range
* **bookmark_notvisited_color** : Bookmark color when the bookmark is not in range
