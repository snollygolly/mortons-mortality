﻿/*The MM class is the main AS class.  It does the following:*Initializes important vars*Draws sprites needed to start *Contains a random number generator*/package {		import flash.display.MovieClip;	import flash.display.*	import flash.text.*	import flash.events.*	import flash.net.URLRequest;	import flash.sampler.Sample;	import flash.utils.*	import flashx.textLayout.elements.InlineGraphicElement;		public class MM extends MovieClip {		trace("*MM: Form Load");		//this static main property can be used to refer to this game object from anywhere easily using MM.main 		static public var main;		static public var isGameOver:Boolean = false;		static public var isPaused:Boolean = false;		static public var devEnabled:Boolean = true; //not used yet, may be later		static public var revision:int = 2;		public var totalAssets:int;		//set sprite vars for each sprite MM handles		public var morton:Sprite;		public var map:Sprite;		public var door:Sprite;		//these values just store the width and height of the game		static public var WIDTH:int = 640;		static public var HEIGHT:int = 480;		static public var SPEED:int = 2; //unused				public function MM(){			//set the static main property to this game object so we can always just use "MM.main" to refer to our game from other classes			main = this;			blackMask.visible=false; //turns off the black mask, duh.			//fire up the keyboard input logic			Key.initialize(stage);			addEventListener(Event.ENTER_FRAME, enterFrame);			loaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);			loaderInfo.addEventListener(Event.COMPLETE,completeListener);				}				//used to track the progress of this loading swf		public function progressHandler(e:ProgressEvent):void		{			//update the loader bar as all the game sounds and bitmaps load			//loadBar.meter.scaleX = e.bytesLoaded / e.bytesTotal;		}				//when the game is done loading, hide the loading meter, and show the ui buttons		public function completeListener(e:Event):void		{			//insert game starting code here			drawSprites();		}								public function enterFrame(e:Event)		{			//per frame actions go here		}				public function drawSprites()		{					//let's draw morton!			morton = new Morton(200,200);			spriteClip.addChild(morton);						//load the map object (last in zorder stack)			map = new Map();			mapClip.addChild(map);		}				public function randomNumber(low:Number=0, high:Number=1):Number //returns a random number between low and high		{		  return Math.floor(Math.random() * (1+high-low)) + low;		}								}	}