﻿/*The Tooltip class does the following:*Controls tooltip fading (in and out)*Sound (functions for starting and stopping)*Delayed fades of tooltip text*Does ID to friendly name for NPCs*Does ID to friendly name/description/score for Death*Does ID to friendly name for Assets*Does ID to friendly name/description for Items*Displays "got item" tooltip (and sound)*Controls all dialog*/package{	import flash.display.*	import flash.events.*	import flash.net.*	import flash.utils.Timer;	import flash.text.TextFieldAutoSize;	import flash.media.Sound;	import flash.media.SoundChannel;	import flash.media.SoundTransform;	import flashx.textLayout.elements.InlineGraphicElement;	import fl.controls.progressBarClasses.IndeterminateBar;		public class Tooltip extends MovieClip	{		//the list is an array of all men on stage		static public var main;		static public var fade:Boolean;		static public var fadeDir:String;				static public var mySound:Sound;		static public var myChannel:SoundChannel;		static public var myMusic:Sound;		static public var musicChannel:SoundChannel;		static public var volDown:SoundTransform;		static public var musicPosition:Number = 0;				static public var dialogOn:Boolean;		static public var curStep:int;		static public var curNPC:int; //itype		static public var delay:Boolean;		public function Tooltip()		{			main = this;			fade = false;			dialogOn = false;			delay = false;			curStep = 0;			volDown = new SoundTransform(0.5);			addEventListener(Event.ENTER_FRAME, enterFrame);					}				//this logic will happen at frame rate		public function enterFrame(e:Event)		{			if (fade == true){				switch (fadeDir){					case "d":						if (this.alpha <= 0){fade=false;break;}						this.alpha = this.alpha - .05;						break;					case "u":						if (this.alpha >= 1){fade=false;break;}						this.alpha = this.alpha + .05;						break;				}			}		}				public function playSound(filename:String){			mySound = new Sound(new URLRequest ("FX/" + filename + ".mp3"));			myChannel = mySound.play();		}				public function playMusic(musicPos:Number, filename:String){			myMusic = new Sound(new URLRequest ("Music/" + filename + ".mp3"));			musicChannel = myMusic.play(musicPos);			musicChannel.soundTransform = volDown;			if (filename == "MainTheme"){				musicChannel.addEventListener(Event.SOUND_COMPLETE, loopMusic);			}		}				public function loopMusic(e:Event):void		{			if (musicChannel != null)			{				musicChannel.removeEventListener(Event.SOUND_COMPLETE, loopMusic);				playMusic(0, "MainTheme");			}		}				public function stopMusic(){			var pos:Number = musicChannel.position;			musicChannel.stop();			musicChannel.removeEventListener(Event.SOUND_COMPLETE, loopMusic);			return pos;		}						public function stopSound(){			myChannel.stop();		}				public function displayText(textType:String){			if (dialogOn == true || delay == true){return;}			tooltipText.text = textType;			this.alpha = 1;			fade = true;			fadeDir = "u";		}				public function clearTextDelay(delayN:Number){			var myTimer:Timer = new Timer(delayN, 1);			myTimer.addEventListener(TimerEvent.TIMER, delayClear);			delay = true;			myTimer.start();		}				public function delayClear(event:TimerEvent):void {			delay = false;			clearText();		}				public function clearText(){			if (dialogOn == true || delay == true){return;}			fade = true;			fadeDir = "d";		}				public function translateNPCs(iType:Number, mapFrame:Number, fullText:Boolean)		{			var shortName:String;			var desc:String;			switch (iType){				case 1: 					shortName = "Bob";					desc = "Morton's Boss";					break;				case 2: 					shortName = "Matthew";					desc = "Morton's Friend";					break;				case 3: 					shortName = "Maria";					desc = "Morton's Crush";					break;				case 4: 					shortName = "Cristophe";					desc = "The Chef";					break;				case 5: 					shortName = "Brenda";					desc = "The Smokers";					break;				case 6: 					shortName = "Mimi";					desc = "The Cat Lady";					break;				case 7: 					shortName = "Scruffy";					desc = "The Janitor";					break;			}			if (fullText == true){return (shortName + " - " + desc);}else{return shortName;}		}				public function translateDeath(iType:Number, textAmount:int) // 1= name only, 2= desc only, 3= score		{			var textType:String;			var descType:String;			var score:int;			switch (iType)			{				case 1:					textType="Cut It Out";					descType="Remember, it's up, not across.";					score = 1;					break;				case 2:					textType="Hit And Run";					descType="Cross the street longways to be a true champion.";					score = 2;					break;				case 3:					textType="Drink The Kool-Aid";					descType="Sugar, water, purple, and poison.  Delicious.";					score = 3;					break;				case 4:					textType="Hang In There";					descType="When the world gets to be too much, just hang in there!";					score = 1;					break;				case 5:					textType="Swan Dive";					descType="It's not flying, it's jumping with style.";					score = 1;					break;				case 6:					textType="Burn Baby Burn";					descType="When you're hot, you're HOT.";					score = 4;					break;				case 7:					textType="Boom Headshot";					descType="They say happiness is a warm gun.";					score = 3;					break;				case 8:					textType="Cross Me, I'll Cross-Cut You";					descType="1. Operate device made for cutting 2. ??? 3. Profit";					score = 5;					break;				case 9:					textType="Going down, next floor, dead";					descType="It's the fastest way to the bottom.";					score = 4;					break;				case 10:					textType="You're a fish";					descType="Fish can breath underwater, I'm sure you can too.";					score = 3;					break;				case 11:					textType="Shocking Conclusion";					descType="I'm amped up and can't wait to see watt happens next.";					score = 3;					break;				case 12:					textType="Tiny Snake Bites";					descType="Don't tread on it over and over and over and over.";					score = 6;					break;				case 13:					textType="Cheesy Title";					descType="Something is cheesy and delicious around here.";					score = 7;					break;				case 14:					textType="Blunt Trauma";					descType="It has very little to do with cigars.";					score = 6;					break;				case 15:					textType="Crush Crush Crush";					descType="It would be perfectly natural if you were a box.";					score = 8;					break;				case 16:					textType="Bags Aren't Toys";					descType="They are a whole lot of fun to play with though.";					score = 4;					break;				case 17:					textType="Murder Mystery";					descType="If you have the gun, it's not really much of a mystery.";					score = 9;					break;				case 18:					textType="Tail Gas";					descType="You've got too much carbon in your oxygen.";					score = 7;					break;				case 19:					textType="Cheesy Title Pt. 2";					descType="Cheesier! More Delicious! HOT HOT HOT!";					score = 15;					break;				case 20:					textType="Just Cool Off";					descType="You're going to be so chill after this.";					score = 10;					break;			}			switch (textAmount){				case 1:					return (textType);				case 2:					return (descType);				case 3:					return (score);			}		}				public function translateAssets(iType:Number, mapFrame:Number) //4 - shredder, 5 - car, 6 - servers, 7- freezer door, 8 - power outlet, 9 - rest. table, 10 - rest. table + chairs		{ //11 - vending machine, 12 - elevator control, 13 - baler			switch (mapFrame)			{				case 2:					if (iType == 100){return "Lower Level: Parking garage, sewers, general yuckiness, and ABSOLUTELY no rats."};				case 11:					if (iType == 101){return "1st Floor: Front door, lobby, cafe, definiately no rats."};				case 21:					if (iType == 102){return "2nd Floor: Internal Revenue Service Offices"};				case 31:					if (iType == 103){return "3rd Floor: Internal Revenue Service Offices"};				case 41:					if (iType == 104){return "Roof: Lots and lots of air."};				case 1:					if (iType == 5){return "That's someone's red car.  It sure is nice";}				case 3:					if (iType == 13){return "A cardboard baler.  It looks like a good way to get thin, fast.";}				case 14:					if (iType == 7){return "A deep freeze.  You wouldn't last very long in there.";}				case 22:					if (iType == 2){return "That's a depressing looking desk.";}				case 26:					if (iType == 4){return "A very sharp industrial paper shredder.  This thing looks like it means business.";}				case 37:					if (iType == 6){return "A server rack.  This thing looks expensive and high tech.";}					if (iType == 8){return "A 110VAC electrical outlet.  You shouldn't mess with this.";}					if (iType == 12){						var tempString:String;						if (Item.main.checkItems(15) == true){tempString = "You need a paperclip and ";}else{tempString = "You need some bendy wire and ";}						if (Item.main.checkItems(17) == true){tempString = tempString + "a screwdriver to hack this box."; if (Elevator.isHacked == false && Item.main.checkItems(15) == true){tempString = tempString + " (click to hack)";}}else{tempString = tempString + "a stronger straight thing to hack this box.";}												return "The elevator control box.  This box controls all the elevators functionality.\n" + tempString;					}			}			return "x";		}				public function translateItems(iType:Number, fullText:Boolean)		{			var textType:String;			var descType:String;			switch (iType)			{				case 1:					textType="Knife";					descType="A very sharp french chef's knife.";					break;				case 2:					textType="Key (Car)";					descType="This key looks to fit a car.";					break;				case 3:					textType="Key (Interior)";					descType="This key looks to fit a door.";					break;				case 4:					textType="Belt";					descType="A brown leather belt that seems to excel at holding pants up.";					break;				case 5:					textType="Rat Poison";					descType="Kills rats dead.";					break;				case 6:					textType="Cigarette";					descType="Delicious sticks of tobacco made for smoking.";					break;				case 7:					textType="Lighter";					descType="Excellent for lighting things on fire.";					break;				case 8:					textType="Can Of Gas";					descType="A gallon of gasoline in a red plastic container."					break;				case 9:					textType="Powdered Lemonaide";					descType="Delicious lemonaide mix.  Just add water!"					break;				case 10:					textType="Necktie";					descType="A silk necktie with a lovely pattern on it."					break;				case 11:					textType="Gun";					descType="A 9mm handgun.  Dangerous in the wrong hands.";					break;				case 12:					textType="Bullets";					descType="These fit a 9mm handgun.";					break;				case 13:					textType="Stapler";					descType="A wonderful device used to bind pages together with metal.";					break;				case 14:					textType="Staples";					descType="Tiny bits of sharp metal that fit in a stapler.";					break;				case 15:					textType="Paperclip";					descType="A bent piece of metal meant to hold paper together.";					break;				case 16:					textType="Bucket";					descType="This bucket will hold fluids and non-fluids alike.  Truly a wonder!";					break;				case 17:					textType="Screwdriver";					descType="Used to secure fasteners into various materials.";					break;				case 18:					textType="Cheese";					descType="A delicious smoked gouda.";					break;				case 19:					textType="Flute";					descType="A beautiful woodwind instrument.";					break;				case 20:					textType="Paperweight";					descType="A very heavy piece of glass used to hold papers down. ";					break;				case 21:					textType="Wad Of Cash";					descType="A bunch of bills in a money clip.";					break;				case 22:					textType="Blood Thinners";					descType="These pills will thin out your blood.  You probably shouldn't take them.";					break;				case 23:					textType="Tape";					descType="This clear tape is great for sticking things to other things.";					break;				case 24:					textType="Plastic Bag";					descType="This airtight bag will hold all sorts of things.";					break;				case 25:					textType="Garden Hose";					descType="Liquids and gasses flow through this long tube.";					break;				case 26:					textType="Stack Of Papers";					descType="A bunch of papers in a stack.";					break;				case 27:					textType="Taco";					descType="Because our artist drew it, and it looks delicious.";					break;				case 40:					textType="Antimatter Cube";					descType="A cube of solid antimatter.  It's probably valuable, or worthless.  One of those.";					break;			}			if (fullText == true){return (textType + " - " + descType);}else{return textType;}		}				public function gotItem(iType:int, alert:String){			Item.main.spawnItems(200,200,iType);			Item.iMarker = Item.list.length -1;			Item.main.placeItems(Item.list[Item.list.length -1]);			dialogOn = false;			playSound("Get-Item");			displayText (alert);			clearTextDelay(2000);		}				public function drawDialog(npcType:int, mapframe:int){			var dialogString:String = dialog(npcType, mapframe);			if (dialogOn == true){				tooltipText.text = dialogString;				this.alpha = 1;				trace ("*Tooltip: drawDialog: ON");			}			else{				trace ("*Tooltip: drawDialog: OFF");			}		}				public function dialog(npcType:int, mapframe:int){			switch (mapframe){				case 3:					switch (curStep){						case 1:							playSound("Scruffy-Talk");							return "Scruffy: You better not make a mess, I just swept this part.";						case 2:							playSound("Morton-Talk");							return "Morton: Why are you sweeping a sewer?";						case 3:							return "Scruffy: Why are you WALKING in a sewer?  Shouldn't you be working?";						case 4:							return "Morton: Yeah whatever.";					}					break;				case 21: //new					switch (curStep){						case 1:							playSound("Mimi-Talk");//npcflags - Mimi[1] [1: talked to 2: got lighter 3. started q 4. finish q. (give taco/get flute]							if (NPC.npcFlags[npcType][1] == 0){return "Mimi: Hi Morton, have you talked to Bob yet?\n(click to continue)";}							if (NPC.npcFlags[npcType][2] == 0){return "Mimi: Any news from Bob about me?\n(click to continue)";}							if (NPC.npcFlags[npcType][3] == 0){return "Mimi: Man I'm starving.  I could really go for some tacos\n(click to continue)";}							if (NPC.npcFlags[npcType][4] == 0){return "Mimi: Any luck on those tacos?  My stomach isn't going to feed itself.\n(click to continue)";}							return "Mimi: Mmm, a fully tummy is a happy tummy\n(click to continue)";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0 || NPC.npcFlags[npcType][2] == 0){								if (NPC.npcFlags[1][2] > 0){return "Morton: No, but he said he needed a smoke.  What in the world does a cat have to be stressed about?";}								if (NPC.npcFlags[1][1] > 0){return "Morton: No, I'm not even sure he knows who you are.";}								return "Morton: No.";							}							if (NPC.npcFlags[npcType][3] == 0 || NPC.npcFlags[npcType][4] == 0){								if (Item.main.checkItems(27) == true){									return "Morton: I did find a taco earlier.";								}								else{return "Morton: I haven't exactly been looking for tacos.";}							}							curStep = 7;							return "Morton: Nice of you to share.";							case 3:							if (NPC.npcFlags[npcType][1] == 0 || NPC.npcFlags[npcType][2] == 0){								if (NPC.npcFlags[1][2] > 0){return "Mimi: My poor snuggle wuggle! I don't smoke, but I do have a lighter you can have.";}								if (NPC.npcFlags[1][1] > 0){return "Mimi: We have a special connection you couldn't begin to understand.";}								return "Mimi: Well when you do, tell me if he says anything about me.  He's just so cute with his little cheeks, and his ears!";							}							if (NPC.npcFlags[npcType][3] == 0 || NPC.npcFlags[npcType][4] == 0){								if (Item.main.checkItems(27) == true){									return "Mimi: Oh yes!  I've been holding on to this for a while, but you can have it.  I hear it's magic.";								}								else{return "Mimi: Well put yourself to use and find me a taco!  I'll make it worth your while.";}							}						case 4:							if (NPC.npcFlags[npcType][1] == 0 || NPC.npcFlags[npcType][2] == 0){								curStep = 7;								NPC.npcFlags[npcType][1] = 1;								if (NPC.npcFlags[1][2] > 0){									gotItem(7, "You got: A LIGHTER");									NPC.npcFlags[npcType][2] = 2;									return "x";								}								return "Morton: Whatever you say crazy lady.";								}							if (NPC.npcFlags[npcType][3] == 0 || NPC.npcFlags[npcType][4] == 0){								NPC.npcFlags[npcType][3] = 1;								if (Item.main.checkItems(27) == true){									Item.main.useItems(27);									gotItem(19, "You got: A MAGIC FLUTE");									NPC.npcFlags[npcType][4] = 4;									return "x";								}								return "Morton: That sounds gross.";								}																	}					break;				case 24: //new					switch (curStep){						case 1:							playSound("BossCat-Talk");//npcflags - boss[1] [1: got raise 2: boss wants smoke 3. smoked out boss]							if (NPC.npcFlags[npcType][1] == 0){return "Boss: Morton! I'm glad you're here.  I want to talk to you about your purrformance.\n(click to continue)";}							if (NPC.npcFlags[npcType][2] == 0){return "Boss: Hey Morton, please tell me you have some smokes.\n(click to continue)";}							if (NPC.npcFlags[npcType][3] == 0){return "Boss: Any luck on those smokes?\n(click to continue)";}							return "Boss: Ahh, much better\n(click to continue)";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0){return "Morton: I'm really sorry, I've just had a lot on my mind lately.  It won't happen again...";}							if (NPC.npcFlags[npcType][2] == 0 || NPC.npcFlags[npcType][3] == 0){								if(Item.main.checkItems(6) == true && Item.main.checkItems(7) == true){return "Morton: Yeah, but are you sure you should be smoking?";}								if(Item.main.checkItems(6) == true){return "Morton: Yeah, but I don't have a light.";}								if(NPC.npcFlags[npcType][2] == 1){return "Morton: Yeah, I still don't smoke";}								return "Morton: No?  I don't even smoke.";							}							return "Morton: You sicken me cat.";							case 3:							if (NPC.npcFlags[npcType][1] == 0){return "Boss: No Morton, that's actually not it at all.  You're one of my best workers, and I think you deserve a bonus";}							if (NPC.npcFlags[npcType][2] == 0 || NPC.npcFlags[npcType][3] == 0){								if(Item.main.checkItems(6) == true && Item.main.checkItems(7) == true){return "Morton: SHUT UP AND GIVE ME THE FUCKING CIGARETTES!";}								if(Item.main.checkItems(6) == true){return "Boss: What do I pay you for Morton? Go find a damn lighter!";}								if(NPC.npcFlags[npcType][2] == 1){return "Boss: Well it's about time you start then, don't you think?";}								return "Boss: Well if you find some, grab them for me.";							}							curStep = 7; 								return "Boss: Whatever man, whatever.";						case 4:							if (NPC.npcFlags[npcType][1] == 0){return "Morton: Really?  What kind of bonus?";}							if (NPC.npcFlags[npcType][2] == 0 || NPC.npcFlags[npcType][3] == 0){								if(Item.main.checkItems(6) == true && Item.main.checkItems(7) == true){									curStep = 7; 									gotItem(20, "You got: A BEAUTIFUL PAPERWEIGHT");									NPC.npcFlags[npcType][2] = 1;									NPC.npcFlags[npcType][3] = 2;									Item.main.useItems(6);									return "x";									}								else{NPC.npcFlags[npcType][2] = 1; curStep = 7;return "Morton: Whatever cat.";}							}						case 5:							return "Boss: Well I couldn't find any dead mice, so I guess a wad of cash will have to do";						case 6:							gotItem(21, "You got: A WAD OF CASH");							NPC.npcFlags[npcType][1] = 1;							return "x";					}					break;				case 32:					switch (curStep){						case 1:							playSound("Matthew-Talk"); //npcflags - matthew[2] [1: told missing keys 2: got missing keys]							return "Matthew: Hey Morton, what's up?";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0){return "Morton: Nothing.";}							if (Item.main.checkItems(22) == true){return "Morton: Who knows?  I think I found your house key though.";}							if (NPC.npcFlags[1][2] != 0){return "Morton: Not much.  Did you know business cat is back off the nip?";}							return "Morton: Nothing.";						case 3:							if (NPC.npcFlags[npcType][1] == 0){return "Matthew: That's cool?  Hey, I seemed to have lost my house key around here somewhere.  If you find it, will you let me know?";}							if (Item.main.checkItems(22) == true && NPC.npcFlags[npcType][1] == 1){return "Matthew: That's great news!  Thanks a lot Morton";}							if (NPC.npcFlags[1][2] != 0){return "Matthew: Oh yeah?  Well I'm glad.  After what he did to that delivery boy, he needs a break";}							if (NPC.npcFlags[npcType][2] != 0 ){return "Matthew: Thanks again for finding my keys, I'd be lost without them";}							return "Matthew: I sure hope someone finds my keys soon";													case 4:							if (NPC.npcFlags[npcType][1] == 0){NPC.npcFlags[npcType][1] = 1; return "Morton: OK.";}							if (Item.main.checkItems(22) == true && NPC.npcFlags[npcType][2] == 0){gotItem(17, "You got: A SCREWDRIVER"); Item.main.useItems(3); NPC.npcFlags[npcType][2] = 3; return "x";}							if (Item.main.checkItems(20) == true && NPC.npcFlags[1][2] != 0){return "Morton: He was asking for it.  Who carries arounds piles of yarn with them?";}							return "Morton: OK.";					}					break;				case 33:					switch (curStep){						case 1:							playSound("Maria-Talk");							if (NPC.npcFlags[npcType][2] == 0){return "Maria: Oh hi Morton, sorry, I didn't see you there at first.";}							if (NPC.npcFlags[npcType][4] == 0){return "Maria: Hi Morton.  It's nice to see you here.";}							if (NPC.npcFlags[npcType][6] == 0){return "Maria: It's so good to see you again Morton!";}							return "Maria: Marry me Morton!  I love you!";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][2] == 0){return "Morton: It's alright, I'm used to it.";}							if (NPC.npcFlags[npcType][4] == 0){return "Morton: It's nice to see you too I suppose.";}							if (NPC.npcFlags[npcType][6] == 0){return "Maria: Thanks, it's good to see you too.";}							return "Morton: OK.";						case 3:							// first quest dialog							if (NPC.npcFlags[npcType][1] == 0 && Item.main.checkItems(9) == true){								return "Maria: It's like you read my mind, I've been craving lemonaide all day!  Here's something for your troubles.  I saw it and thought of you.";}							else if (NPC.npcFlags[npcType][1] == 0 && Item.main.checkItems(9) == false){								NPC.npcFlags[npcType][1] = 1;								return "Maria: I've just been craving lemonaide all day and I really wish I had some.";							}							if (NPC.npcFlags[npcType][2] == 0 && Item.main.checkItems(9) == true){								return "Maria: You brought me lemonaide? That's so nice of you.  Here's something for you troubles.";}							else if (NPC.npcFlags[npcType][2] == 0 && Item.main.checkItems(9) == false){								return "Maria: I'm still just thinking about lemonaide.  I can't get my mind off it for some reason.";							}							//second quest dialog							if (NPC.npcFlags[npcType][3] == 0 && Item.main.checkItems(20) == true){								return "Maria: You got me a paperweight?  It's lovely!  Thank you so much Morton.  Take these, I hope they help you.";}							else if (NPC.npcFlags[npcType][3] == 0 && Item.main.checkItems(20) == false){								NPC.npcFlags[npcType][3] = 1;								return "Maria: Someone stole a paperweight off my desk earlier, can you believe that?";							}							if (NPC.npcFlags[npcType][4] == 0 && Item.main.checkItems(20) == true){								return "Maria: You found my paperweight!  I'm so glad to have it back.  I hope these help you.";}							else if (NPC.npcFlags[npcType][4] == 0 && Item.main.checkItems(20) == false){								return "Maria: I just miss my poor paperweight.  We went through a lot together.";							}						case 4:							// first quest dialog							if (NPC.npcFlags[npcType][2] == 0 && Item.main.checkItems(9) == true){								gotItem(10, "You got: A TIE"); 								Item.main.useItems(9); 								NPC.npcFlags[npcType][2] = 2; 								return "x";							}else if (NPC.npcFlags[npcType][2] == 0 && Item.main.checkItems(9) == false){return "Morton: Yeah, lemonaide...it sure is something";}							// second quest dialog							if (NPC.npcFlags[npcType][4] == 0 && Item.main.checkItems(20) == true){								gotItem(14, "You got: SOME STAPLES"); 								Item.main.useItems(20); 								NPC.npcFlags[npcType][4] = 4; 								return "x";							}else if (NPC.npcFlags[npcType][4] == 0 && Item.main.checkItems(20) == false){return "Morton: That's too bad.  I'm sure it'll show up though.";}					}					break;								}			dialogOn = false;			clearText();			return "x";		}	}}