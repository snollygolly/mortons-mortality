﻿/*The MM class is the main AS class.  It does the following:*Initializes important vars*Draws sprites needed to start *Contains a random number generator*/package {		import flash.display.MovieClip;	import flash.display.*	import flash.text.*	import flash.events.*	import flash.net.URLRequest;	import flash.sampler.Sample;	import flash.utils.*		import flashx.textLayout.elements.InlineGraphicElement;		public class MM extends MovieClip {		trace("*MM: Form Load");		//this static main property can be used to refer to this game object from anywhere easily using MM.main 		static public var main;		static public var isGameOver:Boolean = false;		static public var isPaused:Boolean = false;		static public var devEnabled:Boolean = true;		static public var revision:int = 160;		public var totalAssets:int;		static public var currentDeath;		static public var totalTears:int;		//set sprite vars for each sprite MM handles		public var morton:Sprite;		public var map:Sprite;		public var door:Sprite;		public var elevator:Sprite;		public var item:Sprite;		public var npc:Sprite;		public var asset:Sprite;		public var death:Sprite;		//constants		static public var WIDTH:int = 640;		static public var HEIGHT:int = 480;		static public var SPAWNPOINT:int = 22; //which mapframe to start the game at		static public var TOTALDEATHS:int = 20;		static public var TOTALNPCS:int = 8;		static public var TOTALITEMS:int = 27;				public function MM(){			//set the static main property to this game object so we can always just use "MM.main" to refer to our game from other classes			main = this;			splashStatus.text = "Revision: " + revision + "\nDev Console: " + devEnabled;			blackMask.visible=false; //turns off the black mask, duh.			playButton.visible=false;			scoreboard.visible=false;			stage.stageFocusRect = false;			//fire up the keyboard input logic			Key.initialize(stage);			addEventListener(Event.ENTER_FRAME, enterFrame);			loaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);			loaderInfo.addEventListener(Event.COMPLETE,completeListener);			playButton.addEventListener(MouseEvent.MOUSE_DOWN, playMM);						deathButton.addEventListener(MouseEvent.CLICK, toggleWindow);		}				public function toggleWindow(e:Event){			Scoreboard.main.showWindow();		}				//used to track the progress of this loading swf		public function progressHandler(e:ProgressEvent):void		{			//update the loader bar as all the game sounds and bitmaps load			//loadBar.meter.scaleX = e.bytesLoaded / e.bytesTotal;		}				//when the game is done loading, hide the loading meter, and show the ui buttons		public function completeListener(e:Event):void		{			//insert game starting code here			playButton.visible = true;		}				public function playMM(e:Event):void		{			totalTears = 0;			if (!morton){drawSprites();} 			playButton.visible = false;			splashScreen.visible=false;			splashStatus.visible=false;		}								public function enterFrame(e:Event)		{			//per frame actions go here		}				public function drawSprites()		{					//let's draw morton!			morton = new Morton(200,200);			spriteClip.addChild(morton);						//Toss in a cat for good luck (or to init the symbol)			npc = new NPC(120,300, 1);			spriteClip.addChild(npc);			//NPC.main.populateFlags(); //populate  blank flags						//draw a death hotspot to init symbol			death = new Death(100,100,100,100,"c", 1);			deathClip.addChild(death);						//Draw a desk.			asset = new Asset(120,300, 1);			assetClip.addChild(asset);						//give morton a belt			item = new Item(226, 378, 4); //or 429 for bottom row			itemClip.addChild(item);			item = new Item(18, 378, 1); //or 429 for bottom row			itemClip.addChild(item);			Item.main.hideItems();						//make an elevator and then hide it			elevator = new Elevator(300,24);			mapClip.addChild(elevator);			elevator.visible = false;			//load the map object			map = new Map();			mapClip.addChild(map);			mapClip.swapChildren(elevator,map)			tooltip.alpha=0;		}				public function resetGame(){			Elevator.main.visible=false;			tooltip.alpha=0;			playButton.visible = true;			splashScreen.visible=true;			splashStatus.visible=true;			Map.main.changeMap(MM.SPAWNPOINT, "x");			Map.main.saveMorton(MM.SPAWNPOINT);		}				public function randomNumber(low:Number=0, high:Number=1):Number //returns a random number between low and high		{		  return Math.floor(Math.random() * (1+high-low)) + low;		}								}	}