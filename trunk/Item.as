﻿/*Item Class*/package{	import flash.display.*	import flash.events.*		public class Item extends MovieClip	{		//the list is an array of all men on stage		static public var list:Array= [];		static public var main;		static public var oldSpotX, oldSpotY:int;		static public var iMarker:int;						public function Item(x_, y_, iType:int)		{			main=this;			//add the item to the list of all items			list.push(this);			//set iType (item type)			gotoAndStop(iType);			//we pass in the x and y position of the alien when it's created. This is the position of the ship			//that it ejected from			x = x_;			y = y_;			//we want to control the alien's movement logic at frame rate using an ENTER_FRAME event			addEventListener(MouseEvent.MOUSE_DOWN, dragDropDn);			addEventListener(MouseEvent.MOUSE_UP, dragDropUp);		}				public function dragDropDn(e:MouseEvent)		{			var object = e.target;			oldSpotX = object.x; //back up the positions			oldSpotY = object.y;			for(var i:int=0; i<list.length; i++) //check to see which item was drug			{				if (object == list[i]){ //items match					iMarker = i;					trace ("*Item: imarker: " + iMarker);				}			}			if (object.y<370){ //not in item grid				placeItems(object);			}			else			{				object.startDrag();			}		}				public function dragDropUp(e:MouseEvent)		{			var obj = e.target;			obj.stopDrag();			list[iMarker].x -= 18; //subtract the offset			if (list[iMarker].x >= 1){ //if it's in an acceptable range, 			//divide by 52 (width of a square+spacer)				var xtemp = list[iMarker].x / 52;			} 			else {				var xtemp = 0; //if it's a negative x value, assume it goes it slot 1			}			if (xtemp > 11){xtemp = 11;} //if it's outside the screen on the right, put it in slot 11			xtemp = Math.round(xtemp); //round to the nearest int			xtemp = Math.floor(xtemp); //round down if .5			xtemp = xtemp * 52; //multiply back out to slots			list[iMarker].x = xtemp + 18; //add back the offset			trace ("*Item: obj.x: " + list[iMarker].x);			//done for x, start y			if (list[iMarker].y <= 404){list[iMarker].y = 378;}else{list[iMarker].y = 429;} //if it's above the middle (378 + 26), move it up, otherwise, move it down			//check for overlaps			for(var i:int=0; i<list.length; i++) //check for collisions with other items			{				//trace ("*Item(" + i + "): before, x: " + list[i].x);				if (list[i].x == list[iMarker].x && list[i].y == list[iMarker].y && iMarker != i){ //items are on top of each other					list[i].x = oldSpotX; //put them where obj came from					list[i].y = oldSpotY;				}				//trace ("*Item(" + i + "): after, x: " + list[i].x);			}					}				public function hideItems(){ //hides all items in item bar			for(var i:int=0; i<Item.list.length; i++) //check for collisions with all dors			{				if (Item.list[i].y == 378 || Item.list[i].y == 429){					Item.list[i].visible=false;				}			}		}				public function showItems(){ //shows all items in item bar			for(var i:int=0; i<Item.list.length; i++) //check for collisions with all dors			{				if (Item.list[i].y == 378 || Item.list[i].y == 429){					Item.list[i].visible=true;				}			}		}				public function checkItems(iType:int){ //checks to see if an item of the specified type already exists (one time spawning checks)			for(var i:int=0; i<Item.list.length; i++) //check for collisions with all dors			{				if (Item.list[i].currentFrame == iType){					return true;				}			}			return false;		}				public function placeItems(item:Object){ //places specified object in the first available slot for items			var d:int = 0; // set "d" counter to 0. loops twice, once for y378, and another time for y429			list[iMarker].y=378; //start in y378			while (d<2)			{				list[iMarker].x = 590; //set new object to far right slot				for(var c:int=0; c<12; c++) //check all 12 slots				{					for(var i:int=0; i<Item.list.length; i++) //check for collisions with all items					{						var flag:Boolean = false; //no collision found set						trace ("*Item(c:" + c + "): placeItems: ix:" + list[i].x + " = imx:" + list[iMarker].x + " - iy:" + list[i].y + " = imy:" + list[iMarker].y + " - im:" + iMarker + " = i:" + i);						if (list[i].x == list[iMarker].x && list[i].y == list[iMarker].y && iMarker != i)						{							trace ("*Item: placeItems: collision found");							flag = true; //this spot is occupied							break;							break;						}					}					if (flag == false)					{ //no collisions found in new home, get out of here!						hideItems();						return;					}					list[iMarker].x -= 52; //move one to the left, and try again				}			d++;			item.y=429;			}					}				public function spawnItems(x_,y_, iType){			MM.main.item = new Item(x_, y_, iType);			MM.main.itemClip.addChild(MM.main.item);		}								//this method will destory all aliens in the alien list		static public function killAll()		{			//keep killing the fisrt alien in the list until the list is empty			while(list.length>0)			{				list[0].kill();			}		}				//this method will kill this alien instance		public function kill()		{			//cycle through the alien list			for(var i:int = 0;i < list.length; i++)			{				//if this list index is me				if(list[i] == this)				{					// remove me form the alien list					list.splice(i,1);				}			}			//remove my ENTER_FRAME event			removeEventListener(MouseEvent.MOUSE_DOWN, dragDropDn);			removeEventListener(MouseEvent.MOUSE_UP, dragDropUp);			//remove my grpahic from the stage			MM.main.itemClip.removeChild(this);		}	}}