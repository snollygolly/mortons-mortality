﻿/*The Map class handles the background (map).  It does the following:*Checks for and handles Morton walking left or right off the stage *Checks for and handles Morton entering and leaving rooms *Draws doors*Sets boundries for collision*/package{	import flash.display.*	import flash.events.*	import flash.ui.*		public class Map extends MovieClip	{		static public var main;		static public var nb, sb, eb, wb;				public function Map()		{			main = this;			x=0;			y=0;			//start at home [C-2]			changeMap(22, "x");			cacheAsBitmap = true;			//Morton.main.mask = mapMask;			//test hits every frame.			addEventListener(Event.ENTER_FRAME, enterFrame);		}				//we want this logic to happen at frame rate		public function enterFrame(e:Event)		{			if (rightHit.hitTestObject(Morton.main.hitArea)) { //off screen to the right				//left = true				changeMap((currentFrame+1), "w");			}			if (leftHit.hitTestObject(Morton.main.hitArea)) { //off screen to the left				changeMap((currentFrame-1), "e");			}		}				public function changeMap(mapframe:int, dir:String) //east, west, other this is the dir that you want morton to be		{						MM.main.blackMask.visible = true; //CUT!			gotoAndStop(mapframe);			trace ("*Map: changeMap: dir: " + dir + " curframe: " + currentFrame);			switch (dir){				case "o": //either n/s exiting/entering doors.  					if (Morton.main.y > 300){						Morton.main.y = 100;					}					else //if you're up, now you're down, and the other way around.					{						Morton.main.y = 300;					}					break;				case "e": //walking left, entering from the east.					Morton.main.x = 550;					break;				case "w": //walking right, entering from the west.					Morton.main.x = 50;					break;				case "x":					if (currentFrame == 41) {Morton.main.y=300;}			}			drawBounds(currentFrame); //draw n,s,e,w bounds for new map tile.			MM.main.elevator.visible = false;			Tooltip.dialogOn = false;			Tooltip.main.clearText();			drawDoors(currentFrame); // draw all doors for new maps tile.			drawAssets(currentFrame); //draw all the assets needed			drawItems(currentFrame); //spawn all needed items for the scene			drawNPCs(currentFrame); //spawn all npcs			MM.main.blackMask.visible = false; //ACTION!		}				public function drawBounds(mapframe:int){			wb = -50; //set initial default bounds for empty hallways.			eb = 700;			sb = 345;			nb = 70;			switch (mapframe){				//end hallway cases (a/e)				case 1:				case 10:				case 20:				case 30:					//A-1,2,3					wb = 20;					break;				case 5:				case 14:				case 34:					//E-1,2,3					eb = 580;					break;				//special cases				case 23:					//d-2 hallway (outside of boss' office)					eb = 580;					break;				case 24:					//e-2  boss' office					eb = 580;					wb = 20;					break;				case 25:					//a-2a bathroom					nb = 220					wb = 190;					eb = 450;					break;				case 26:					//d-2a supply room					nb = 140;					wb = 240;					eb = 520;					break;				case 40:					//a-4 roof					nb = 170;					wb = 125;					break;				case 41:				case 42:				case 43:					//bcd-4 roof					nb = 170;					break;				case 44:					//e-4 roof					eb = 455;					nb = 170;					break;			}		}				public function drawDoors(mapframe:int)		{			Door.killAll(); //get rid of all the existing doors.			switch (mapframe){				case 2:				case 11:				case 21:				case 31:					Elevator.main.x = 300; //set to default place					Elevator.main.y = 24;					MM.main.elevator.visible = true;					break;				case 41: //roof elevator					Elevator.main.x = 300; //set to default place					Elevator.main.y = 130;					MM.main.elevator.visible = true;					break;									case 20: //A-2					//A-2a - Restroom [25]					MM.main.door = new Door(300, 36 ,"u");					Door.destlist[Door.destlist.length - 1] = 25;					MM.main.mapClip.addChild(MM.main.door);					break;				case 23: //D-2					//D-2a - Supply Room [26]					MM.main.door = new Door(300, 36, "u");					Door.destlist[Door.destlist.length - 1] = 26;					MM.main.mapClip.addChild(MM.main.door);					//E-2 - Boss' Office [24]					MM.main.door = new Door(610, 250, "r");					Door.destlist[Door.destlist.length - 1] = 24;					MM.main.mapClip.addChild(MM.main.door);					break;				case 24: //E-2					//D-2 - Hallway [23]					MM.main.door = new Door(20, 250, "l");					Door.destlist[Door.destlist.length - 1] = 23;					MM.main.mapClip.addChild(MM.main.door);					break;				case 25: //A-2a					//A-2 - Hallway [20]					MM.main.door = new Door(300, 415, "u");					Door.destlist[Door.destlist.length - 1] = 20;					MM.main.mapClip.addChild(MM.main.door);					break;				case 26: //D-2a					//D-2 - Hallway [26]					MM.main.door = new Door(300, 415, "u");					Door.destlist[Door.destlist.length - 1] = 23;					MM.main.mapClip.addChild(MM.main.door);					break;			}		}				public function drawAssets(mapframe:int){			Asset.main.removeAssets();			switch (mapframe){				case 22:					Asset.main.spawnAssets(400,200,2);					Asset.main.spawnAssets(400,100,1);					Asset.main.spawnAssets(400,300,1);					break;				case 23:					Asset.main.spawnAssets(200,100,1);					Asset.main.spawnAssets(200,200,1);					Asset.main.spawnAssets(200,300,1);					Asset.main.spawnAssets(400,100,1);					Asset.main.spawnAssets(400,300,1);					Asset.main.spawnAssets(400,200,1);					break;				case 24:					Asset.main.spawnAssets(450,125,1);					break;				case 26:					Asset.main.spawnAssets(400,100,3);					break;			}		}				public function drawNPCs(mapframe:int){			NPC.main.removeNPCs();			switch (mapframe){				case 4:					NPC.main.spawnNPCs(200,300,7);					break;				case 21:					NPC.main.spawnNPCs(200,300,2);					break;				case 24:					NPC.main.spawnNPCs(500,150,1);					break;				case 33:					NPC.main.spawnNPCs(300,300,3);					break;			}		}				public function drawItems(mapframe:int){			Item.main.removeItems();			switch (mapframe){				case 22:					//C-2 - Spawn [22]					if (Item.main.checkItems(11) == false && Item.main.checkItems(3) == true){						Item.main.spawnItems(250,250,11);					}					break;				case 23:					//D-2 - Hallway [23]					if (Item.main.checkItems(9) == false && Item.main.checkItems(6) == false){						Item.main.spawnItems(420,300,6);					}					break;				case 24:					//E-2 - Boss' Office [24]					break;				case 26:					//D-2a - Supply Room [26]					if (Item.main.checkItems(7) == false){Item.main.spawnItems(420,153,7);}					if (Item.main.checkItems(3) == false){Item.main.spawnItems(465,153,3);}					if (Item.main.checkItems(15) == false){Item.main.spawnItems(465,110,15);}					break;				case 30:					//A-3 - Hallway [30]					Item.main.spawnItems(400,200,15);					break;			}		}						public function disable() //this stops leftHit and rightHit from registering.		{			removeEventListener(Event.ENTER_FRAME, enterFrame);		}		public function reset() //this resumes leftHit and rightHit hit tracking.		{			addEventListener(Event.ENTER_FRAME, enterFrame);		}	}}