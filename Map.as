﻿/*The Map class controls the scrolling background. There are four unique background drawings inside a Map movie clip. The background will always scroll by at frame rate until it reaches the end of a drawingat which point the background movie clip will advance to the next frame.*/package{	import flash.display.*	import flash.events.*	import flash.ui.*		public class Map extends MovieClip	{		static public var main;		//This constructor gets called when the background is loaded to the stage		public function Map()		{			main = this;			x=0;			y=0;			gotoAndStop(10);			//add an ENTER_FRAME event so we can update its position at frame rate			addEventListener(Event.ENTER_FRAME, enterFrame);			//stop the background movie clip on frame one			stop();		}				//we want this logic to happen at frame rate		public function enterFrame(e:Event)		{			trace("*Map: Morton x: " + Morton.main.x);			if (Morton.main.x>=MM.WIDTH && currentFrame == 10) { //off screen to the right				//left = true				changeMap(11, true);			}			if (Morton.main.x<=-40 && currentFrame == 11) { //off screen to the left				changeMap(10, false);			}		}				public function changeMap(mapframe:int, left:Boolean) //left = true means that morton will be placed on the left after the map loads.		{			MM.main.blackMask.visible = true;			gotoAndStop(mapframe);			if (left == true) {Morton.main.x = 50;}else{Morton.main.x = 500;}			MM.main.blackMask.visible = false;		}				//this is a handy way to stop the background from scrolling		public function disable()		{			removeEventListener(Event.ENTER_FRAME, enterFrame);		}				//this will set the background back to frame one, reset it's position, and start it scrolling with the ENTER_FRAME event		public function reset()		{			addEventListener(Event.ENTER_FRAME, enterFrame);			gotoAndStop(1);			x=0;		}	}}