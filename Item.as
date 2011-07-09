﻿/*The Item Class handles the spawning and movement of all items (items are objects that can be interacted with and picked up)*/package{	import flash.display.*	import flash.events.*		public class Item extends MovieClip	{		//the list is an array of all items on stage		static public var list:Array= [];		static public var main;		static public var oldSpotX, oldSpotY:int; //holds current coords when an item is picked up (so it can be returned or swapped)		static public var iMarker:int; //used to reference a mouseevent object against the list of objects 		static public var isDragging:Boolean;						public function Item(x_, y_, iType:int)		{			main=this;			//add the item to the list of all items			list.push(this);			//set iType (item type)			gotoAndStop(iType);			x = x_;			y = y_;			isDragging = false;			//add event listeners for mouse up and down			addEventListener(MouseEvent.MOUSE_DOWN, dragDropDn);			addEventListener(MouseEvent.MOUSE_UP, dragDropUp);			addEventListener(MouseEvent.ROLL_OVER, itemOver);			addEventListener(MouseEvent.ROLL_OUT, itemOut);		}				public function dragDropDn(e:MouseEvent)		{			var object = e.target;			for(var i:int=0; i<list.length; i++) //check to see which item was drug			{				if (object == list[i]){ //items match					iMarker = i;					trace ("*Item: imarker: " + iMarker);				}			}			oldSpotX = list[iMarker].x;			oldSpotY = list[iMarker].y;			if (object.y<370){ //not in item grid				placeItems(object); //put in the first available space			}			else			{				object.startDrag(); //if the item is already in the inventory, start the drag drop				isDragging = true;			}		}				public function dragDropUp(e:MouseEvent)		{			var obj = e.target;			obj.stopDrag();			isDragging = false;			if (e.stageY <= 370){				Hotbar.main.collapseBars();				return;			}			list[iMarker].x -= 18; //subtract the offset			if (list[iMarker].x >= 1){ //if it's in an acceptable range, 			var xtemp:Number;			//divide by 52 (width of a square+spacer)				xtemp = list[iMarker].x / 52;			} 			else {				xtemp = 0; //if it's a negative x value, assume it goes it slot 1			}			if (xtemp > 11){xtemp = 11;} //if it's outside the screen on the right, put it in slot 11			xtemp = Math.round(xtemp); //round to the nearest int			xtemp = Math.floor(xtemp); //round down if .5			xtemp = xtemp * 52; //multiply back out to slots			list[iMarker].x = xtemp + 18; //add back the offset			//done for x, start y			if (list[iMarker].y <= 404){list[iMarker].y = 378;}else{list[iMarker].y = 429;} //if it's above the middle (378 + 26), move it up, otherwise, move it down			//check for overlaps			for(var i:int=0; i<list.length; i++) //check for collisions with other items			{				//trace ("*Item(" + i + "): before, x: " + list[i].x);				if (list[i].x == list[iMarker].x && list[i].y == list[iMarker].y && iMarker != i){ //items are on top of each other					list[i].x = oldSpotX; //put them where obj came from					list[i].y = oldSpotY;				}				//trace ("*Item(" + i + "): after, x: " + list[i].x);			}					}				public function itemOver(e:MouseEvent){			var obj = e.target;			Tooltip.main.displayText(Tooltip.main.translateItems(obj.currentFrame, true));		}				public function itemOut(e:MouseEvent){			Tooltip.main.clearText();		}				public function hideItems(){ //hides all items in item bar			for(var i:int=0; i<Item.list.length; i++) //check for collisions with all items			{				if (Item.list[i].y == 378 || Item.list[i].y == 429){					Item.list[i].visible=false;				}			}		}				public function showItems(){ //shows all items in item bar			for(var i:int=0; i<Item.list.length; i++) //check for collisions with all items			{				if (Item.list[i].y == 378 || Item.list[i].y == 429){					Item.list[i].visible=true;				}			}		}				public function checkItems(iType:int){ //checks to see if an item of the specified type already exists (one time spawning checks)			for(var i:int=0; i<Item.list.length; i++) //check for collisions with all items			{				if (Item.list[i].currentFrame == iType){					return true;				}			}			return false;		}				public function useItems(iType:int){ //checks to see if an item of the specified type exists, and if it does, gets rid of it			for(var i:int=0; i<Item.list.length; i++) //check for collisions with all items			{				if (Item.list[i].currentFrame == iType){					Item.list[i].kill();					return true;				}			}			return false;		}				public function placeItems(item:Object){ //places specified object in the first available slot for items			var d:int = 0; // set "d" counter to 0. loops twice, once for y378, and another time for y429			list[iMarker].y=378; //start in y378			while (d<2)			{				list[iMarker].x = 590; //set new object to far right slot				for(var c:int=0; c<12; c++) //check all 12 slots				{					for(var i:int=0; i<Item.list.length; i++) //check for collisions with all items					{						var flag:Boolean = false; //no collision found set						trace ("*Item(c:" + c + "): placeItems: ix:" + list[i].x + " = imx:" + list[iMarker].x + " - iy:" + list[i].y + " = imy:" + list[iMarker].y + " - im:" + iMarker + " = i:" + i);						if (list[i].x == list[iMarker].x && list[i].y == list[iMarker].y && iMarker != i)						{							trace ("*Item: placeItems: collision found");							flag = true; //this spot is occupied							break;							break;						}					}					if (flag == false)					{ //no collisions found in new home, get out of here!						hideItems();						return;					}					list[iMarker].x -= 52; //move one to the left, and try again				}			d++;			item.y=429;			}					}				public function spawnItems(x_,y_, iType){ //mostly for use from other classes			MM.main.item = new Item(x_, y_, iType);			MM.main.itemClip.addChild(MM.main.item);		}				public function removeItems(){ //used to remove all items that aren't in the inventory			var i:int=0;			while(i<list.length) //check for collisions with all items			{				if (Item.list[i].y != 378 && Item.list[i].y != 429){					trace ("*Item: removeItems: remove [" + Tooltip.main.translateItems(list[i].currentFrame, false) + "(" + list[i].currentFrame + ")]");					list[i].removeEventListener(MouseEvent.MOUSE_DOWN, dragDropDn);					list[i].removeEventListener(MouseEvent.MOUSE_UP, dragDropUp);					list[i].removeEventListener(MouseEvent.ROLL_OVER, itemOver);					list[i].removeEventListener(MouseEvent.ROLL_OUT, itemOut);					//remove my grpahic from the stage					MM.main.itemClip.removeChild(list[i]);					list.splice(i,1);				}				else				{					trace ("*Item: removeItems: skip [" + Tooltip.main.translateItems(list[i].currentFrame, false) + "(" + list[i].currentFrame + ")]");					i++;				}			}		}						//this method will destory all items in the item list		static public function killAll()		{			//keep killing the fisrt item in the list until the list is empty			while(list.length>0)			{				list[0].kill();			}		}				//this method will kill this item instance		public function kill()		{			trace ("*Item: finding [" + Tooltip.main.translateItems(this.currentFrame, false) + "(" + this.currentFrame + ")]");			for(var i:int = 0;i < list.length; i++)			{				trace ("*Item: kill(list): i:" + i + "/" + list.length + " - currentFrame:" + list[i].currentFrame);				//if this list index is me				if(list[i] == this)				{					// remove me from the item list					trace ("*Item: kill(splice): i:" + i + "/" + list.length + " - currentFrame:" + list[i].currentFrame);					list.splice(i,1);				}			}			//remove my mouse events			removeEventListener(MouseEvent.MOUSE_DOWN, dragDropDn);			removeEventListener(MouseEvent.MOUSE_UP, dragDropUp);			removeEventListener(MouseEvent.ROLL_OVER, itemOver);			removeEventListener(MouseEvent.ROLL_OUT, itemOut);			//remove my grpahic from the stage			MM.main.itemClip.removeChild(this);			trace ("*Item: kill(done)");		}	}}