﻿/*The Morton class handles the main sprite, Morton.  It does the following:*Handles arrow and space key input*Checks for door collisions (with Morton)*Draws doors*Moves Morton and checks for map collisions*/package{	import flash.display.*	import flash.events.*	import flash.ui.*	import flash.filters.*	import flash.utils.Timer;    import flash.events.TimerEvent;    import flash.text.TextField;	public class Morton extends MovieClip	{		//morton has this static property so he can be referenced from any class easily 		static public var main;				//morton's move speed		public var v:Number;				//buffers to keep morton from walking too far off screen		public var xBuffer:int;		public var yBuffer:int;				//used to check for space bar use.          public var spaceLocked:Boolean; //may be able to remove 		public function Morton(x_, y_)		{				main = this;			x = x_;			y = y_;			//set morton's movement speed			v = 5;			//set the spaceLocked boolean to false, the spacebar is not being pressed			spaceLocked=false;			name="morton";			mortonHit.mouseEnabled=false;			mortonHit.alpha=0;			hitArea=mortonHit; //for collisions			gotoAndStop(1); //start morton idle, and facing left			//add an ENTER_FRAME event so we can do some logic at frame rate			addEventListener(Event.ENTER_FRAME, enterFrame);			//add some listeners for key presses			MM.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);			MM.main.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);			//this just optimizes performance			cacheAsBitmap = true;		}								//event for key press		public function keyDownHandler(e:KeyboardEvent)		{						//if spacebar is pressed and is not currently, fire			if(e.keyCode == Keyboard.SPACE && spaceLocked==false)			{				//trace ("*Morton: down!");				spaceLocked=true;			}				}				//event for when a key is released		public function keyUpHandler(e:KeyboardEvent)		{			switch(e.keyCode){				case Keyboard.LEFT:					gotoAndStop(1);					break;				case Keyboard.RIGHT:					gotoAndStop(50);					break;			}			//when the spacebar is released			if(e.keyCode == Keyboard.SPACE)			{				spaceLocked=false;			}		}								//do this at frame rate		public function enterFrame(e:Event)		{			if (MM.main.elevatorgui.visible == false){move();} //checks for key presses and move morton if able (and elevator gui isn't  visible)			if (this.hitTestObject(Elevator.main.hitArea) && Elevator.main.visible == true && MM.main.elevatorgui.visible == false){					trace ("*Morton: elevator/morton hit!");					MM.main.elevatorgui.visible=true;					Hotbar.main.collapseBars();					y=100;				}			for(var i:int=0; i<Door.list.length; i++) //check for collisions with all dors			{				if(this.hitTestObject(Door.list[i].hitArea)) //if there's a collision				{					trace ("*Morton: door collision, current frame: " + Door.list[i].currentFrame);					switch (Door.list[i].currentFrame){						case 1:							//door facing top or bottom							Map.main.changeMap(Door.destlist[i], "o"); //cycle the map to where the door's "destlist" var is pointing and send "o" for door							break;						case 2:							//door on the left							Map.main.changeMap(Door.destlist[i], "e"); //door left							break;						case 3:							//dor on the right							Map.main.changeMap(Door.destlist[i], "w"); //door right					}									}			}		}								//at frame rate see if any of the arrows keys are being pressed		public function move()		{			//if the LEFT arrow key is being pressed and the map's west boundry (wb) isn't stopping us			if(Key.isDown(Keyboard.LEFT) && (this.x > Map.wb))			{				//update its position, move it left				if (currentFrame >= 49 || currentFrame == 1) {gotoAndPlay(20);} //play left walk animation, image 1				x -= v;			}			//if the RIGHT arrow key is being pressed and the map's east boundry (eb) isn't stopping us			else if(Key.isDown(Keyboard.RIGHT) && (this.x < Map.eb))			{ 				//update its position, move it right				if (currentFrame <= 49 || currentFrame == 50) {gotoAndPlay(70);} //play right walk animation, image 1				x += v;			}						//if the UP arrow key is being pressed and the map's north boundry (nb) isn't stopping us			if(Key.isDown(Keyboard.UP) && (this.y > Map.nb))			{				//update its position, move it up				y -= v;			}			//if the DOWN arrow key is being pressed and the map's south boundry (sb) isn't stopping us			else if(Key.isDown(Keyboard.DOWN) && (this.y < Map.sb))			{				//update its position, move it down				y += v;			}		}	}}