﻿/*The Tooltip class creates controls the falling alien movie clips when enemy ships are destroyed.*/package{	import flash.display.*	import flash.events.*	import flash.net.*	import flash.utils.Timer;	import flash.text.TextFieldAutoSize;	import flash.media.Sound;	import flash.media.SoundChannel;	import flashx.textLayout.elements.InlineGraphicElement;		public class Tooltip extends MovieClip	{		//the list is an array of all men on stage		static public var main;		static public var fade:Boolean;		static public var fadeDir:String;				static public var mySound:Sound;		static public var myChannel:SoundChannel;				static public var dialogOn:Boolean;		static public var curStep:int;		static public var curNPC:int; //itype		static public var delay:Boolean;		public function Tooltip()		{			main = this;			fade = false;			dialogOn = false;			delay = false;			curStep = 0;			addEventListener(Event.ENTER_FRAME, enterFrame);					}				//this logic will happen at frame rate		public function enterFrame(e:Event)		{			if (fade == true){				switch (fadeDir){					case "d":						if (this.alpha <= 0){fade=false;break;}						this.alpha = this.alpha - .05;						break;					case "u":						if (this.alpha >= 1){fade=false;break;}						this.alpha = this.alpha + .05;						break;				}			}		}				public static function playSound(filename:String){			mySound = new Sound(new URLRequest ("FX/" + filename + ".mp3"));			myChannel = mySound.play();		}				public static function stopSound(){			myChannel.stop();		}				public function displayText(textType:String){			if (dialogOn == true || delay == true){return;}			tooltipText.text = textType;			this.alpha = 1;			fade = true;			fadeDir = "u";		}				public function clearTextDelay(delayN:Number){			var myTimer:Timer = new Timer(delayN, 1);			myTimer.addEventListener(TimerEvent.TIMER, delayClear);			delay = true;			myTimer.start();		}				public function delayClear(event:TimerEvent):void {			delay = false;			clearText();		}				public function clearText(){			if (dialogOn == true || delay == true){return;}			fade = true;			fadeDir = "d";		}				public function translateNPCs(iType:Number, mapFrame:Number)		{			var textType:String;			switch (mapFrame)			{				case 4:					textType = "The Janitor: Scruffy\n(click to talk)";					break;				case 21:					textType = "Morton's Friend: Matthew\n(click to talk)";					break;				case 24:					textType = "Morton's Boss: Bob\n(click to talk)";					break;				case 33:					textType = "Morton's Crush: Maria\n(click to talk)";					break;				default:					textType = "x";			}			return textType;		}				public function translateAssets(iType:Number, mapFrame:Number)		{			var textType:String;			textType = "x";			switch (mapFrame)			{				case 2:					if (iType == 100){textType = "Lower Level: Parking garage, sewers, general yuckiness, and ABSOLUTELY no rats."};				case 11:					if (iType == 101){textType = "1st Floor: Front door, lobby, cafe, definiately no rats."};				case 21:					if (iType == 102){textType = "2nd Floor: Internal Revenue Service Offices"};				case 31:					if (iType == 103){textType = "3rd Floor: Internal Revenue Service Offices"};				case 41:					if (iType == 104){textType = "Roof: Lots and lots of air."};					if (iType >= 100){						playSound("Elevator Ding");					}					break;				case 22:					if (iType == 2){textType = "That's a depressing looking desk.";}					break;			}			return textType;		}				public function translateItems(iType:Number, fullText:Boolean)		{			var textType:String;			var descType:String;			switch (iType)			{				case 1:					textType="Knife";					descType="A very sharp french chef's knife.";					break;				case 2:					textType="Key (Car)";					descType="This key looks to fit a car.";					break;				case 3:					textType="Key (Interior)";					descType="This key looks to fit a door.";					break;				case 4:					textType="Belt";					descType="A brown leather belt that seems to excel at holding pants up.";					break;				case 5:					textType="Rat Poison";					descType="Kills rats dead.";					break;				case 6:					textType="Cigarette";					descType="Delicious sticks of tobacco made for smoking.";					break;				case 7:					textType="Lighter";					descType="Excellent for lighting things on fire.";					break;				case 8:					textType="Can Of Gas";					descType="A gallon of gasoline in a red plastic container."					break;				case 9:					textType="Powdered Lemonaide";					descType="Delicious lemonaide mix.  Just add water!"					break;				case 10:					textType="Necktie";					descType="A silk necktie with a lovely pattern on it."					break;				case 11:					textType="Gun";					descType="A 9mm handgun.  Dangerous in the wrong hands.";					break;				case 12:					textType="Bullets";					descType="These fit a 9mm handgun.";					break;				case 13:					textType="Stapler";					descType="A wonderful device used to bind pages together with metal.";					break;				case 14:					textType="Staples";					descType="Tiny bits of sharp metal that fit in a stapler.";					break;				case 15:					textType="Paperclip";					descType="A bent piece of metal meant to hold paper together.";					break;				case 16:					textType="Bucket";					descType="This bucket will hold fluids and non-fluids alike.  Truly a wonder!";					break;				case 17:					textType="Screwdriver";					descType="Used to secure fasteners into various materials.";					break;				case 18:					textType="Cheese";					descType="A delicious smoked gouda.";					break;				case 19:					textType="Flute";					descType="A beautiful woodwind instrument.";					break;				case 20:					textType="Paperweight";					descType="A very heavy piece of glass used to hold papers down. ";					break;				case 21:					textType="Wad Of Cash";					descType="A bunch of bills in a money clip.";					break;				case 22:					textType="Blood Thinners";					descType="These pills will thin out your blood.  You probably shouldn't take them.";					break;				case 23:					textType="Tape";					descType="This clear tape is great for sticking things to other things.";					break;				case 24:					textType="Plastic Bag";					descType="This airtight bag will hold all sorts of things.";					break;				case 25:					textType="Garden Hose";					descType="Liquids and gasses flow through this long tube.";					break;				case 26:					textType="Stack Of Papers";					descType="A bunch of papers in a stack.";					break;				case 40:					textType="Antimatter Cube";					descType="A cube of solid antimatter.  It's probably valuable, or worthless.  One of those.";					break;			}			if (fullText == true){return (textType + " - " + descType);}else{return textType;}		}				public function gotItem(iType:int, alert:String){			Item.main.spawnItems(200,200,iType);			Item.iMarker = Item.list.length -1;			Item.main.placeItems(Item.list[Item.list.length -1]);			dialogOn = false;			playSound("Get-Item");			displayText (alert);			clearTextDelay(2000);		}				public function drawDialog(npcType:int, mapframe:int){			var dialogString:String = dialog(npcType, mapframe);			if (dialogOn == true){				tooltipText.text = dialogString;				this.alpha = 1;				trace ("*Tooltip: drawDialog: ON");			}			else{				trace ("*Tooltip: drawDialog: OFF");			}		}				public function dialog(npcType:int, mapframe:int){			switch (mapframe){				case 4:					switch (curStep){						case 1:							playSound("Scruffy-Talk");							return "Scruffy: You better not make a mess, I just swept this part.";						case 2:							playSound("Morton-Talk");							return "Morton: Why are you sweeping a sewer?";						case 3:							return "Scruffy: Why are you WALKING in a sewer?  Shouldn't you be working?";						case 4:							return "Morton: Yeah whatever.";					}					break;				case 21:					switch (curStep){						case 1:							playSound("Matthew-Talk");							return "Matthew: Hey Morton, what's up?";						case 2:							playSound("Morton-Talk");							if (Item.main.checkItems(3) == true){return "Morton: Who knows?  I found your key though.";}							if (Item.main.checkItems(9) == true){return "Morton: Not much.  Did you know business cat is back off the nip?";}							return "Morton: Nothing.";						case 3:							if (Item.main.checkItems(3) == true){return "Matthew: That's great news!  Thanks a lot Morton";}							if (Item.main.checkItems(9) == true){return "Matthew: Oh yeah?  Well I'm glad.  After what he did to that delivery boy, he needs a break";}							return "Matthew: That's cool?  Hey, I seemed to have lost my keys around here somewhere.  If you find them, will you let me know?";						case 4:							if (Item.main.checkItems(3) == true){gotItem(17, "You got: A SCREWDRIVER"); Item.main.useItems(3); return "x";}							if (Item.main.checkItems(9) == true){return "Morton: He was asking for it.  Who carries arounds piles of yarn with them?";}							return "Morton: Sure thing.";					}					break;				case 24:					switch (curStep){						case 1:							playSound("BossCat-Talk");							if (Item.main.checkItems(6) == true){								if (Item.main.checkItems(7) == true){return "Boss: I know I shouldn't smoke, but I'm trying to quit the nip.  2 hours sober now.";}else{return "Boss: Do you have a light?";}							}							if (Item.main.checkItems(21) == true){return "Boss: What now Morton?  I already gave you a raise, what more do you want?";}							return "Boss: Morton! I'm glad you're here.  I want to talk to you about your performance\n(click to continue)";						case 2:							if (Item.main.checkItems(6) == true){								if (Item.main.checkItems(7) == true){return "Boss: Thanks for the smokes by the way, here's a little something for you";}else{curStep = 7; return "Boss: No? Well I can't very well smoke without a lighter.";}							}							playSound("Morton-Talk");							if (Item.main.checkItems(21) == true){return "Morton: Um...I'm not really sure.";}							return "Morton: I'm really sorry, I've just had a lot on my mind lately.  It won't happen again...";						case 3:							if (Item.main.checkItems(7) == true && Item.main.checkItems(6) == true){								curStep = 7; 								gotItem(9, "You got: POWDERED LEMONAIDE"); 								Item.main.useItems(6);								return "x";							}							if (Item.main.checkItems(21) == true){curStep = 6;return "Boss: Get out of here right meow!";}							return "Boss: No Morton, that's actually not it at all.  You're one of my best workers, and I think you deserve a bonus";						case 4:							return "Morton: Really?  What kind of bonus?";						case 5:							return "Boss: Well I couldn't find any dead mice, so I guess a wad of cash will have to do";						case 6:							gotItem(21, "You got: A WAD OF CASH");							return "x";					}					break;				case 33:					switch (curStep){						case 1:							playSound("Maria-Talk");							return "Maria: Hi Morton, it was nice of you to stop by and see me.";						case 2:							playSound("Morton-Talk");							return "Morton: Uh, yeah, you too.";						case 3:							return "Maria: Um, ok? Take care, OK Morton?";						case 4:							return "Morton: *sighs* Yeah.";					}					break;								}			dialogOn = false;			clearText();			return "x";		}	}}