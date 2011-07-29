﻿/*The Morton class handles the main sprite, Morton.  It does the following:*Handles arrow and space key input*Checks for door collisions (with Morton)*Draws doors*Moves Morton and checks for map collisions*/package{	import flash.display.*	import flash.events.*	import flash.ui.*	import flash.filters.*	import flash.utils.Timer;    import flash.events.TimerEvent;    import flash.text.TextField;	public class Morton extends MovieClip	{		//morton has this static property so he can be referenced from any class easily 		static public var main;				//morton's move speed		public var v:Number;				//north,south,west,east locks to prevent movement		public var nl:Boolean;		public var sl:Boolean;		public var el:Boolean;		public var wl:Boolean;				//buffers to keep morton from walking too far off screen		public var xBuffer:int;		public var yBuffer:int;				//used to check for space bar use.          public var spaceLocked:Boolean; //may be able to remove 		public function Morton(x_, y_)		{				main = this;			x = x_;			y = y_;			//set morton's movement speed			v = 5;			//set the spaceLocked boolean to false, the spacebar is not being pressed			spaceLocked=false;			name="morton";			mortonHit.mouseEnabled=false;			mortonHit.alpha=0;			hitArea=mortonHit; //for collisions			clearLocks();			gotoAndStop(1); //start morton idle, and facing left			//add an ENTER_FRAME event so we can do some logic at frame rate			addEventListener(Event.ENTER_FRAME, enterFrame);			//add some listeners for key presses			MM.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);			MM.main.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);			//this just optimizes performance			cacheAsBitmap = true;		}								//event for key press		public function keyDownHandler(e:KeyboardEvent)		{						//if spacebar is pressed and is not currently, fire			if(e.keyCode == Keyboard.SPACE && spaceLocked==false)			{				//trace ("*Morton: down!");				spaceLocked=true;			}				}				//event for when a key is released		public function keyUpHandler(e:KeyboardEvent)		{			if (Scoreboard.main.visible == true && currentFrame == 1 || currentFrame == 31){return;}			switch(e.keyCode){				case Keyboard.LEFT:					gotoAndStop(1);					break;				case Keyboard.RIGHT:					gotoAndStop(31);					break;				case Keyboard.UP:					gotoAndStop(62);					break;				case Keyboard.DOWN:					gotoAndStop(92);					break;			}			//when the spacebar is released			if(e.keyCode == Keyboard.SPACE)			{				spaceLocked=false;			}		}								//do this at frame rate		public function enterFrame(e:Event)		{			//MM.mmCounter++; //global counter for debugging			if (MM.main.elevatorgui.visible == false && Scoreboard.main.visible == false){move();} //checks for key presses and move morton if able (and elevator gui isn't  visible)			if (hitArea.hitTestObject(Elevator.main.hitArea) && Elevator.main.visible == true && MM.main.elevatorgui.visible == false){					trace ("*Morton: elevator/morton hit!");					MM.main.elevatorgui.visible=true;					Hotbar.main.collapseBars();					y+=25;				}			for(var i:int=0; i<Door.list.length; i++) //check for collisions with all dors			{				if(hitArea.hitTestObject(Door.list[i].hitArea)) //if there's a collision				{					trace ("*Morton: door collision, current frame: " + Door.list[i].currentFrame);					switch (Door.list[i].currentFrame){						case 1:							//door facing top or bottom							Map.main.changeMap(Door.destlist[i], "o"); //cycle the map to where the door's "destlist" var is pointing and send "o" for door							break;						case 2:							//door on the left							Map.main.changeMap(Door.destlist[i], "e"); //door left							break;						case 3:							//door on the right							Map.main.changeMap(Door.destlist[i], "w"); //door right							break;						case 4:						case 5:						case 6:						case 7:						case 8:							//front door							Map.main.changeMap(Door.destlist[i], "x");							break;					}									}			}		}				public function checkAssets(dir:String){			clearLocks();			//check for collisions			for(var i:int=0; i<Asset.list.length; i++) //check for collisions with all items			{					if (this.hitArea.hitTestObject(Asset.list[i].hitArea))					{						switch (dir){							case "n":								y += v;								nl = true;								break;							case "s":								y -= v;								sl = true;								break;							case "e":								x -= v;								el = true;								break;							case "w":								x += v;								wl = true;								break;						}					}			}		}				public function clearLocks(){			nl = false;			sl = false;			el = false;			wl = false;		}		//at frame rate see if any of the arrows keys are being pressed		public function move()		{			//if the LEFT arrow key is being pressed and the map's west boundry (wb) isn't stopping us			if(Key.isDown(Keyboard.LEFT) && (this.x > Map.wb) && wl == false)			{				//update its position, move it left				if (currentFrame < 2 || currentFrame > 29) {gotoAndPlay(2);} //play left walk animation, image 1				x -= v;				checkAssets("w");			}			//if the RIGHT arrow key is being pressed and the map's east boundry (eb) isn't stopping us			else if(Key.isDown(Keyboard.RIGHT) && (this.x < Map.eb) && el == false)			{ 				//update its position, move it right				if (currentFrame < 32 || currentFrame > 60) {gotoAndPlay(32);} //play right walk animation, image 1				x += v;				checkAssets("e");			}						//if the UP arrow key is being pressed and the map's north boundry (nb) isn't stopping us			if(Key.isDown(Keyboard.UP) && (this.y > Map.nb) && nl == false)			{				//update its position, move it up				if (currentFrame < 63 || currentFrame > 90) {gotoAndPlay(63);} //play right walk animation, image 1				y -= v;				checkAssets("n");			}			//if the DOWN arrow key is being pressed and the map's south boundry (sb) isn't stopping us			else if(Key.isDown(Keyboard.DOWN) && (this.y < Map.sb) && sl == false)			{				//update its position, move it down				if (currentFrame < 93 || currentFrame > 121) {gotoAndPlay(93);} //play right walk animation, image 1				y += v;				checkAssets("s");			}			clearLocks();		}	}}