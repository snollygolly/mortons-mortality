﻿/*The Map class handles the background (map).  It does the following:*Checks for and handles Morton walking left or right off the stage *Checks for and handles Morton entering and leaving rooms *Draws doors*Spawns assets*Spawns items*Spawns npcs*Spawns death hotspots*Sets boundries for collision*Set all spawning for objects above*Saves Morton (on death trigger, move out of way)*/package{	import flash.display.*	import flash.events.*	import flash.ui.*		public class Map extends MovieClip	{		static public var main;		static public var nb, sb, eb, wb;				public function Map()		{			main = this;			x=0;			y=0;			//start at home [C-2]			changeMap(MM.SPAWNPOINT, "x");			cacheAsBitmap = true;			//Morton.main.mask = mapMask;			//test hits every frame.			addEventListener(Event.ENTER_FRAME, enterFrame);		}				//we want this logic to happen at frame rate		public function enterFrame(e:Event)		{			if (rightHit.hitTestObject(Morton.main.hitArea)) { //off screen to the right				//left = true				changeMap((currentFrame+1), "w");			}			if (leftHit.hitTestObject(Morton.main.hitArea)) { //off screen to the left				changeMap((currentFrame-1), "e");			}		}				public function changeMap(mapframe:int, dir:String) //east, west, other this is the dir that you want morton to be		{						MM.main.blackMask.visible = true; //CUT!			gotoAndStop(mapframe);			trace ("*Map: changeMap: dir: " + dir + " curframe: " + currentFrame);			switch (dir){				case "o": //either n/s exiting/entering doors.  					if (Morton.main.y > 300){						Morton.main.y = 100;					}					else //if you're up, now you're down, and the other way around.					{						Morton.main.y = 300;					}					break;				case "e": //walking left, entering from the east.					Morton.main.x = 550;					break;				case "w": //walking right, entering from the west.					Morton.main.x = 50;					break;				case "x":					switch (currentFrame){ //frame you're arriving at						case 3:							Morton.main.x = 500;							break;						case 4:							Morton.main.x = 70;							break;						case 10:							Morton.main.x = 70;							break;						case 13:							Morton.main.x = 555;							Morton.main.y = 105;							break;						case 14:							Morton.main.x = 55;							Morton.main.y = 325;							break;						case 16:							Morton.main.x = 430;							break;						case 41:							Morton.main.y = 300;							break;					}			}			drawBounds(currentFrame); //draw n,s,e,w bounds for new map tile.			MM.main.elevator.visible = false;			Tooltip.dialogOn = false;			Tooltip.main.clearText();			drawDoors(currentFrame); // draw all doors for new maps tile.			drawAssets(currentFrame); //draw all the assets needed			drawItems(currentFrame); //spawn all needed items for the scene			drawNPCs(currentFrame); //spawn all npcs			drawDeath(currentFrame); //spawn death hotspots			MM.main.blackMask.visible = false; //ACTION!		}				public function drawBounds(mapframe:int){			wb = -50; //set initial default bounds for empty hallways.			eb = 700;			sb = 345;			nb = 70;			switch (mapframe){				//end hallway cases (a/e)				case 1:				case 10:				case 20:				case 30:					//A-1,2,3					wb = 20;					break;				case 5:				case 34:					//E-1,2,3					eb = 580;					break;				case 15:				case 25:				case 35:					//bathrooms					nb = 220;					wb = 190;					eb = 430;					break;				//special cases				case 3: //c-0 sewer entrance					eb = 504;					break;				case 4: //d-0 sewer exit					wb = 40;					break;				case 6: //c-oa maint closet					nb = 170;					eb = 425;					wb = 170;					break;				case 13: //cafe					eb = 580;					break;				case 14: //kitchen					eb = 580;					wb = 20;					break;				case 16: //a-1b outside front door					nb = 0;					sb = 360;					wb = 95;					eb = 465;					break;				case 17: //e-1a pantry					nb = 144;					wb = 177;					eb = 457;					break;				case 23:					//d-2 hallway (outside of boss' office)					eb = 580;					break;				case 24:					//e-2  boss' office					eb = 580;					wb = 20;					break;				case 26:					//d-2a supply room					nb = 140;					wb = 240;					eb = 520;					break;				case 36:					//d-3a supply room					nb = 140;					wb = 240;					eb = 520;					break;				case 37:					//e-3a server room					nb = 140;					wb = 161;					eb = 441;					break;				case 40:					//a-4 roof					nb = 170;					wb = 125;					break;				case 41:				case 42:				case 43:					//bcd-4 roof					nb = 170;					break;				case 44:					//e-4 roof					eb = 455;					nb = 170;					break;			}		}				public function drawDoors(mapframe:int)		{			Door.killAll(); //get rid of all the existing doors.			switch (mapframe){				case 2:				case 11:				case 21:				case 31:					Elevator.main.x = 300; //set to default place					Elevator.main.y = 24;					MM.main.elevator.visible = true;					break;				case 41: //roof elevator					Elevator.main.x = 300; //set to default place					Elevator.main.y = 130;					MM.main.elevator.visible = true;					break;					//start indv. tiles				case 3: //c-0 sewer entrance					MM.main.door = new Door(535, 214 ,"sewer");					Door.destlist[Door.destlist.length - 1] = 4;					MM.main.mapClip.addChild(MM.main.door);					MM.main.door = new Door(286, 36 ,"u");					Door.destlist[Door.destlist.length - 1] = 6;					MM.main.mapClip.addChild(MM.main.door);					break;				case 4: //d-0 sewer exit					MM.main.door = new Door(-15, 216 ,"sewer");					Door.destlist[Door.destlist.length - 1] = 3;					MM.main.mapClip.addChild(MM.main.door);					break;				case 6: //c-0a maint closet					MM.main.door = new Door(286, 415 ,"u");					Door.destlist[Door.destlist.length - 1] = 3;					MM.main.mapClip.addChild(MM.main.door);					break;				case 10: //a-1 front door					MM.main.door = new Door(0,149 ,"frontout");					Door.destlist[Door.destlist.length - 1] = 16;					MM.main.mapClip.addChild(MM.main.door);					//A-1a - Restroom [15]					MM.main.door = new Door(300, 36 ,"u");					Door.destlist[Door.destlist.length - 1] = 15;					MM.main.mapClip.addChild(MM.main.door);					break;				case 13: //d-1 kitchen entrance					MM.main.door = new Door(498,20 ,"swingin");					Door.destlist[Door.destlist.length - 1] = 14;					MM.main.mapClip.addChild(MM.main.door);					break;				case 14: //d-1 kitchen exit					MM.main.door = new Door(263, 36, "u");					Door.destlist[Door.destlist.length - 1] = 17;					MM.main.mapClip.addChild(MM.main.door);					MM.main.door = new Door(36,380,"swingout");					Door.destlist[Door.destlist.length - 1] = 13;					MM.main.mapClip.addChild(MM.main.door);					break;				case 15: //A-1a					//A-1 - Hallway [10]					MM.main.door = new Door(300, 415, "u");					Door.destlist[Door.destlist.length - 1] = 10;					MM.main.mapClip.addChild(MM.main.door);					break;				case 16: //a-1b					MM.main.door = new Door(478,149 ,"frontin");					Door.destlist[Door.destlist.length - 1] = 10;					MM.main.mapClip.addChild(MM.main.door);					break;				case 17: //e-1a pantry					MM.main.door = new Door(263, 415, "u");					Door.destlist[Door.destlist.length - 1] = 14;					MM.main.mapClip.addChild(MM.main.door);					break;				case 20: //A-2					//A-2a - Restroom [25]					MM.main.door = new Door(300, 36 ,"u");					Door.destlist[Door.destlist.length - 1] = 25;					MM.main.mapClip.addChild(MM.main.door);					break;				case 23: //D-2					//D-2a - Supply Room [26]					MM.main.door = new Door(300, 36, "u");					Door.destlist[Door.destlist.length - 1] = 26;					MM.main.mapClip.addChild(MM.main.door);					//E-2 - Boss' Office [24]					MM.main.door = new Door(610, 250, "r");					Door.destlist[Door.destlist.length - 1] = 24;					MM.main.mapClip.addChild(MM.main.door);					break;				case 24: //E-2					//D-2 - Hallway [23]					MM.main.door = new Door(20, 250, "l");					Door.destlist[Door.destlist.length - 1] = 23;					MM.main.mapClip.addChild(MM.main.door);					break;				case 25: //A-2a					//A-2 - Hallway [20]					MM.main.door = new Door(300, 415, "u");					Door.destlist[Door.destlist.length - 1] = 20;					MM.main.mapClip.addChild(MM.main.door);					break;				case 26: //D-2a					//D-2 - Hallway [26]					MM.main.door = new Door(300, 415, "u");					Door.destlist[Door.destlist.length - 1] = 23;					MM.main.mapClip.addChild(MM.main.door);					break;				case 30: //A-3					//A-3a - Restroom [35]					MM.main.door = new Door(300, 36 ,"u");					Door.destlist[Door.destlist.length - 1] = 35;					MM.main.mapClip.addChild(MM.main.door);					break;				case 33: //D-3					//D-3a - Supply Room [36]					MM.main.door = new Door(400, 36, "u");					Door.destlist[Door.destlist.length - 1] = 36;					MM.main.mapClip.addChild(MM.main.door);					break;				case 34: //E-3					//D-3a - Server Room [37]					MM.main.door = new Door(263, 36, "u");					Door.destlist[Door.destlist.length - 1] = 37;					MM.main.mapClip.addChild(MM.main.door);					break;				case 35: //A-3a					//A-3 - Hallway [30]					MM.main.door = new Door(300, 415, "u");					Door.destlist[Door.destlist.length - 1] = 30;					MM.main.mapClip.addChild(MM.main.door);					break;				case 36: //D-3a					//D-2 - Hallway [33]					MM.main.door = new Door(400, 415, "u");					Door.destlist[Door.destlist.length - 1] = 33;					MM.main.mapClip.addChild(MM.main.door);					break;				case 37: //E-3a					//D-3 - Hallway [34]					MM.main.door = new Door(263, 415, "u");					Door.destlist[Door.destlist.length - 1] = 34;					MM.main.mapClip.addChild(MM.main.door);					break;			}		}				public function drawAssets(mapframe:int){			Asset.main.removeAssets();			switch (mapframe){				case 1: //a-0 - parking garage					Asset.main.spawnAssets(62,194,5);					break;				case 3: //c-0 - sewer entrance					Asset.main.spawnAssets(440,30,13);					break;				case 6:					Asset.main.spawnAssets(183,119,6);					Asset.main.spawnAssets(425,156,19);					Asset.main.spawnAssets(393,156,19);					Asset.main.spawnAssets(361,156,19);					break;				case 11: //front desk					Asset.main.spawnAssets(418,53,22);					Asset.main.spawnAssets(196,55,22);					break;				case 13: //d-1 rest.					Asset.main.spawnAssets(130,300,10);					Asset.main.spawnAssets(270,300,10);					Asset.main.spawnAssets(410,300,10);					Asset.main.spawnAssets(130,200,10);					Asset.main.spawnAssets(270,200,10);					Asset.main.spawnAssets(410,200,10);					break;				case 14: //e-1 kitchen					Asset.main.spawnAssets(504,18,7);					break;				case 17: //e-1a - pantry					Asset.main.spawnAssets(260,100,3);					break;				case 20:					Asset.main.spawnAssets(308,231,41);					Asset.main.spawnAssets(210,56,29);					Asset.main.spawnAssets(52,63,17);					Asset.main.spawnAssets(57,219,18);					Asset.main.spawnAssets(122,94,24);					Asset.main.spawnAssets(179,88,28);					Asset.main.spawnAssets(73,95,15);					Asset.main.spawnAssets(23,217,19);					Asset.main.spawnAssets(76,254,16);					Asset.main.spawnAssets(400,75,39);					Asset.main.spawnAssets(442,18,34);					Asset.main.spawnAssets(568,531,40);					Asset.main.spawnAssets(513,77,39);					Asset.main.spawnAssets(280,246,38);					Asset.main.spawnAssets(197,218,17);					Asset.main.spawnAssets(218,252,14);					Asset.main.spawnAssets(167,251,23);					Asset.main.spawnAssets(236,88,28);					Asset.main.spawnAssets(176,86,31);					Asset.main.spawnAssets(396,227,18);					Asset.main.spawnAssets(421,257,15);					break;				case 21:					Asset.main.spawnAssets(413,51,40);					Asset.main.spawnAssets(233,53,40);					Asset.main.spawnAssets(180,286,17);					Asset.main.spawnAssets(114,286,17);					Asset.main.spawnAssets(246,286,17);					Asset.main.spawnAssets(312,286,17);					Asset.main.spawnAssets(378,286,17);					Asset.main.spawnAssets(266,319,15);					Asset.main.spawnAssets(333,317,14);					Asset.main.spawnAssets(134,318,16);					Asset.main.spawnAssets(201,319,15);					Asset.main.spawnAssets(397,319,16);					Asset.main.spawnAssets(444,286,17);					Asset.main.spawnAssets(467,317,15);					Asset.main.spawnAssets(85,317,24);					Asset.main.spawnAssets(508,321,24);					Asset.main.spawnAssets(151,62,26);					Asset.main.spawnAssets(113,91,27);					Asset.main.spawnAssets(116,69,38);					Asset.main.spawnAssets(457,60,32);					Asset.main.spawnAssets(492,162,32);					Asset.main.spawnAssets(583,536,19);					Asset.main.spawnAssets(455,162,19);					Asset.main.spawnAssets(493,60,19);					Asset.main.spawnAssets(77,72,41);					Asset.main.spawnAssets(419,162,32);					Asset.main.spawnAssets(152,197,1);					Asset.main.spawnAssets(169,204,15);					Asset.main.spawnAssets(156,184,37);					break;				case 22: //c-2 - spawn					Asset.main.spawnAssets(400,200,2);					Asset.main.spawnAssets(400,100,1);					Asset.main.spawnAssets(400,300,1);					break;				case 23: //d-2 - supply room hallway and desks					Asset.main.spawnAssets(220,63,17);					Asset.main.spawnAssets(113,63,17);					Asset.main.spawnAssets(475,65,18);					Asset.main.spawnAssets(493,105,15);					Asset.main.spawnAssets(243,91,16);					Asset.main.spawnAssets(136,94,14);					Asset.main.spawnAssets(112,178,1);					Asset.main.spawnAssets(184,61,19);					Asset.main.spawnAssets(565,62,19);					Asset.main.spawnAssets(220,154,17);					Asset.main.spawnAssets(242,183,15);					Asset.main.spawnAssets(288,189,23);					Asset.main.spawnAssets(494,176,17);					Asset.main.spawnAssets(115,276,18);					Asset.main.spawnAssets(137,312,14);					Asset.main.spawnAssets(515,211,15);					Asset.main.spawnAssets(461,209,24);					Asset.main.spawnAssets(417,52,22);					break;				case 24: //e-2 - boss's office					Asset.main.spawnAssets(279,155,33);					Asset.main.spawnAssets(520,64,18);					Asset.main.spawnAssets(541,103,15);					Asset.main.spawnAssets(394,202,15);					Asset.main.spawnAssets(327,283,15);					Asset.main.spawnAssets(246,216,15);					Asset.main.spawnAssets(301,35,42);					Asset.main.spawnAssets(19,55,32);					Asset.main.spawnAssets(50,54,32);					Asset.main.spawnAssets(82,18,34);					Asset.main.spawnAssets(218,54,22);					Asset.main.spawnAssets(405,54,22);					Asset.main.spawnAssets(488,94,23);					Asset.main.spawnAssets(263,143,15);					Asset.main.spawnAssets(151,86,38);					Asset.main.spawnAssets(151,71,37);					Asset.main.spawnAssets(582,174,27);					Asset.main.spawnAssets(583,154,25);					Asset.main.spawnAssets(573,197,41);					break;				case 26: //d-2a - supply room					Asset.main.spawnAssets(400,100,3);					Asset.main.spawnAssets(265,135,4);					break;				case 30:					Asset.main.spawnAssets(100,54,18);					Asset.main.spawnAssets(32,54,17);					Asset.main.spawnAssets(197,47,29);					Asset.main.spawnAssets(369,54,17);					Asset.main.spawnAssets(468,52,32);					Asset.main.spawnAssets(438,52,32);					Asset.main.spawnAssets(505,76,39);					Asset.main.spawnAssets(145,291,17);					Asset.main.spawnAssets(213,291,17);					Asset.main.spawnAssets(281,291,18);					Asset.main.spawnAssets(375,295,26);					Asset.main.spawnAssets(432,349,24);					Asset.main.spawnAssets(111,289,19);					Asset.main.spawnAssets(303,319,14);					Asset.main.spawnAssets(237,319,15);					Asset.main.spawnAssets(166,319,16);					Asset.main.spawnAssets(392,80,16);					Asset.main.spawnAssets(53,80,15);					Asset.main.spawnAssets(123,79,14);					break;				case 31:					Asset.main.spawnAssets(446,47,18);					Asset.main.spawnAssets(409,51,40);					Asset.main.spawnAssets(195,47,17);					Asset.main.spawnAssets(126,47,17);					Asset.main.spawnAssets(263,290,17);					Asset.main.spawnAssets(361,290,17);					Asset.main.spawnAssets(330,303,41);					Asset.main.spawnAssets(430,290,17);					Asset.main.spawnAssets(194,290,17);					Asset.main.spawnAssets(452,319,16);					Asset.main.spawnAssets(384,319,15);					Asset.main.spawnAssets(287,319,15);					Asset.main.spawnAssets(214,319,14);					Asset.main.spawnAssets(147,74,14);					Asset.main.spawnAssets(471,74,14);					Asset.main.spawnAssets(216,74,15);					Asset.main.spawnAssets(141,288,22);					Asset.main.spawnAssets(501,323,23);					break;				case 32:					Asset.main.spawnAssets(130,57,17);					Asset.main.spawnAssets(198,57,17);					Asset.main.spawnAssets(266,57,18);					Asset.main.spawnAssets(358,50,19);					Asset.main.spawnAssets(396,56,26);					Asset.main.spawnAssets(510,55,40);					Asset.main.spawnAssets(372,281,17);					Asset.main.spawnAssets(304,281,17);					Asset.main.spawnAssets(236,281,17);					Asset.main.spawnAssets(440,281,18);					Asset.main.spawnAssets(476,79,38);					Asset.main.spawnAssets(476,65,37);					Asset.main.spawnAssets(204,292,41);					Asset.main.spawnAssets(463,305,15);					Asset.main.spawnAssets(393,305,14);					Asset.main.spawnAssets(326,305,14);					Asset.main.spawnAssets(258,305,15);					Asset.main.spawnAssets(290,84,15);					Asset.main.spawnAssets(219,84,16);					Asset.main.spawnAssets(151,84,16);					break;				case 33:					Asset.main.spawnAssets(313,47,29);					Asset.main.spawnAssets(243,62,17);					Asset.main.spawnAssets(170,62,17);					Asset.main.spawnAssets(97,62,17);					Asset.main.spawnAssets(458,59,18);					Asset.main.spawnAssets(192,88,14);					Asset.main.spawnAssets(119,88,15);					Asset.main.spawnAssets(264,88,15);					Asset.main.spawnAssets(482,88,16);					Asset.main.spawnAssets(343,280,17);					Asset.main.spawnAssets(275,280,17);					Asset.main.spawnAssets(412,292,41);					Asset.main.spawnAssets(444,299,39);					Asset.main.spawnAssets(489,280,17);					Asset.main.spawnAssets(365,303,15);					Asset.main.spawnAssets(297,303,16);					Asset.main.spawnAssets(509,303,16);					Asset.main.spawnAssets(205,280,17);					Asset.main.spawnAssets(227,303,14);					Asset.main.spawnAssets(170,279,32);					break;				case 34:					Asset.main.spawnAssets(336,56,17);					Asset.main.spawnAssets(409,56,17);					Asset.main.spawnAssets(483,56,18);					Asset.main.spawnAssets(356,85,14);					Asset.main.spawnAssets(430,85,14);					Asset.main.spawnAssets(503,85,16);					Asset.main.spawnAssets(561,47,22);					Asset.main.spawnAssets(409,213,17);					Asset.main.spawnAssets(483,213,18);					Asset.main.spawnAssets(367,213,19);					Asset.main.spawnAssets(337,213,19);					Asset.main.spawnAssets(544,293,23);					Asset.main.spawnAssets(506,237,15);					Asset.main.spawnAssets(428,237,16);					Asset.main.spawnAssets(130,57,26);					Asset.main.spawnAssets(95,65,41);					Asset.main.spawnAssets(294,236,39);					break;				case 36: //d-3a - break room					Asset.main.spawnAssets(326,147,1);					Asset.main.spawnAssets(259,102,42);					Asset.main.spawnAssets(501,98,36);					Asset.main.spawnAssets(358,152,31);					Asset.main.spawnAssets(366,148,30);					Asset.main.spawnAssets(328,140,25);					Asset.main.spawnAssets(440,98,11);					Asset.main.spawnAssets(406,135,29);					break;				case 37: //e-3a - server room					Asset.main.spawnAssets(172,100,6);					Asset.main.spawnAssets(300,150,8);					Asset.main.spawnAssets(423,94,12);					break;			}		}				public function drawNPCs(mapframe:int){			NPC.main.removeNPCs();			switch (mapframe){				case 3: //d-0 - sewer1					NPC.main.spawnNPCs(200,300,7);					break;				case 14: //e-1 - kitchen					NPC.main.spawnNPCs(200,300,4);					break;				case 21: //b-2 - elevator hallway					NPC.main.spawnNPCs(300,170,6);					break;				case 32: //b-2 - elevator hallway					NPC.main.spawnNPCs(200,150,2);					break;				case 24: //e-2 - boss's office					NPC.main.spawnNPCs(470,170,1);					break;				case 33: //d-3 - upstairs hallway					NPC.main.spawnNPCs(350,150,3);					break;				case 42: //c-4 - rooftop					NPC.main.spawnNPCs(300,300,5);					break;			}		}				public function drawItems(mapframe:int){			Item.main.removeItems();			switch (mapframe){				case 17:					//D-2a - Supply Room [26]					if (Item.main.checkItems(18) == false){Item.main.spawnItems(270,110,18);}					if (Item.main.checkItems(9) == false){Item.main.spawnItems(310,153,9);}					if (Item.main.checkItems(24) == false){Item.main.spawnItems(350,153,24);}					break;				case 22:					//C-2 - Spawn [22]					break;				case 23:					//D-2 - Hallway [23]					break;				case 24:					//E-2 - Boss' Office [24]					break;				case 26:					//D-2a - Supply Room [26]					if (Item.main.checkItems(13) == false){Item.main.spawnItems(420,153,13);}					if (Item.main.checkItems(23) == false){Item.main.spawnItems(465,153,23);}					if (Item.main.checkItems(15) == false){Item.main.spawnItems(465,110,15);}					break;				case 30:					//A-3 - Hallway [30]					break;			}		}				public function drawDeath(mapframe:int){			MM.main.deathButton.gotoAndStop(1);			Death.killAll();			switch (mapframe){				case 15: //bathrooms				case 25:				case 35:					if (Item.main.checkItems(16) == false || Item.main.checkItems(25) == false){return;}					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(0,0,10,10,"w", 10);					break;				case 21: //elevators				case 31:				case 41:					if (Elevator.isHacked == false){return;}//replace for code to detect elevator hack					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(0,0,10,10,"w", 9);					break;				case 1: //parking garage					if (Item.main.checkItems(2) == false || Item.main.checkItems(25) == false){return;}					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(62,194,128,64,"c", 18);					break;				case 3: //c-0 sewer entrance					if (Item.main.checkItems(23) == false){return;}					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(440,30,94,102,"c", 15);					break;				case 4: //sewer				case 5:					if (Item.main.checkItems(18) == false || Item.main.checkItems(19) == false){return;}					if (Item.main.checkItems(7) == true && Item.main.checkItems(8) == true){						MM.main.deathButton.gotoAndStop(2);						Death.main.spawnDeaths(0,0,10,10,"w", 19);					}					MM.main.deathButton.gotoAndStop(2);					if (Death.list.length == 0){Death.main.spawnDeaths(0,0,10,10,"w", 13);}					break;				case 14: //kitchen					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(504,18,66,82,"c", 20);					break;				case 16: //front door (outside)					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(174,0,200,430,"w", 2);					break;				case 26: //supply room					if (Item.main.checkItems(10) == false){return;}					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(265,135,66,40,"c", 8);					break;				case 37: //server room					if (Item.main.checkItems(17) == false){return;}					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(300,150,10,14,"c", 11)					break;				case 40: //left roof					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(120,200,20,200,"w", 5);					break;				case 44: //right roof					MM.main.deathButton.gotoAndStop(2);					Death.main.spawnDeaths(465,200,20,200,"w", 5);					break;			}		}				public function saveMorton(mapframe:int){			switch (mapframe){				case 16:					Morton.main.x = 428;					break;				case 22:					Morton.main.x = 200;					Morton.main.y = 200;					break;				case 40:				case 44:					Morton.main.x = 320;					break;			}		}				public function disable() //this stops leftHit and rightHit from registering.		{			removeEventListener(Event.ENTER_FRAME, enterFrame);		}		public function reset() //this resumes leftHit and rightHit hit tracking.		{			addEventListener(Event.ENTER_FRAME, enterFrame);		}	}}