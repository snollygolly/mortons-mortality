﻿/*The Door class controls all the doors.  It handles spawning and killing doors and not a whole lot else.*/package{	import flash.display.*	import flash.events.*		public class Door extends MovieClip	{		//the list is an array of all doors on stage		static public var list:Array= [];		static public var destlist:Array= [];						public function Door(x_, y_, orient:String)		{			//add this door to the list of doors			list.push(this);			destlist.push(0);			//determine orientation			switch (orient){				case "u":					gotoAndStop(1);					break;				case "l":					gotoAndStop(2);					break;				case "r":					gotoAndStop(3);					break;				case "front":					gotoAndStop(4);					break;				case "swingin":					gotoAndStop(5);					break;				case "sewer":					gotoAndStop(6);					break;				case "swingout":					gotoAndStop(7);					break;			}			x = x_;			y = y_;			//hide the hitarea			doorHit.mouseEnabled=false;			doorHit.alpha=0;			hitArea=doorHit;		}						static public function killAll()		{			//keep killing the fisrt door in the list until the list is empty			while(list.length>0)			{				list[0].kill();			}		}				public function kill()		{			//cycle through the door list			for(var i:int = 0;i < list.length; i++)			{				//if this list index is me				if(list[i] == this)				{					// remove me form the list					list.splice(i,1);					destlist.splice(i,1);				}			}			//remove my grpahic from the stage			MM.main.mapClip.removeChild(this);		}	}}