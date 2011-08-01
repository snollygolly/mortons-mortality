﻿/*The Tooltip class does the following:*Controls tooltip fading (in and out)*Sound (functions for starting and stopping)*Delayed fades of tooltip text*Does ID to friendly name for NPCs*Does ID to friendly name/description/score for Death*Does ID to friendly name for Assets*Does ID to friendly name/description for Items*Displays "got item" tooltip (and sound)*Controls all dialog*/package{	import flash.display.*	import flash.events.*	import flash.net.*	import flash.utils.Timer;	import flash.text.TextFieldAutoSize;	import flash.media.Sound;	import flash.media.SoundChannel;	import flash.media.SoundTransform;	import flashx.textLayout.elements.InlineGraphicElement;	import fl.controls.progressBarClasses.IndeterminateBar;		public class Tooltip extends MovieClip	{		//the list is an array of all men on stage		static public var main;		static public var fade:Boolean;		static public var fadeDir:String;				static public var mySound:Sound;		static public var myChannel:SoundChannel;		static public var myMusic:Sound;		static public var musicChannel:SoundChannel;		static public var volDown:SoundTransform;		static public var volDownMore:SoundTransform;		static public var musicPosition:Number = 0;				static public var dialogOn:Boolean;		static public var curStep:int;		static public var curNPC:int; //itype		static public var delay:Boolean;		public function Tooltip()		{			main = this;			fade = false;			dialogOn = false;			delay = false;			curStep = 0;			volDown = new SoundTransform(0.5);			volDownMore = new SoundTransform(0.3);			addEventListener(Event.ENTER_FRAME, enterFrame);					}				//this logic will happen at frame rate		public function enterFrame(e:Event)		{			if (fade == true){				switch (fadeDir){					case "d":						if (this.alpha <= 0){fade=false;musicChannel.soundTransform = volDown;break;}						this.alpha = this.alpha - .05;						break;					case "u":						if (this.alpha >= 1){fade=false;break;}						this.alpha = this.alpha + .05;						break;				}			}		}				public function playSound(filename:String){			mySound = new Sound(new URLRequest ("FX/" + filename + ".mp3"));			myChannel = mySound.play();		}				public function playMusic(musicPos:Number, filename:String){			myMusic = new Sound(new URLRequest ("Music/" + filename + ".mp3"));			musicChannel = myMusic.play(musicPos);			musicChannel.soundTransform = volDown;			if (filename == "MainTheme"){				musicChannel.addEventListener(Event.SOUND_COMPLETE, loopMusic);			}		}				public function loopMusic(e:Event):void		{			if (musicChannel != null)			{				musicChannel.removeEventListener(Event.SOUND_COMPLETE, loopMusic);				playMusic(0, "MainTheme");			}		}				public function stopMusic(){			var pos:Number = musicChannel.position;			musicChannel.stop();			musicChannel.removeEventListener(Event.SOUND_COMPLETE, loopMusic);			return pos;		}						public function stopSound(){			myChannel.stop();		}				public function displayText(textType:String){			if (dialogOn == true || delay == true){return;}			tooltipText.text = textType;			this.alpha = 1;			fade = true;			fadeDir = "u";		}				public function clearTextDelay(delayN:Number){			var myTimer:Timer = new Timer(delayN, 1);			myTimer.addEventListener(TimerEvent.TIMER, delayClear);			delay = true;			myTimer.start();		}				public function delayClear(event:TimerEvent):void {			delay = false;			clearText();		}				public function clearText(){			if (dialogOn == true || delay == true){return;}			fade = true;			fadeDir = "d";		}				public function translateNPCs(iType:Number, mapFrame:Number, fullText:Boolean)		{			var shortName:String;			var desc:String;			switch (iType){				case 1: 					shortName = "Bob";					desc = "Morton's Boss";					break;				case 2: 					shortName = "Matthew";					desc = "Morton's Best Friend";					break;				case 3: 					shortName = "Maria";					desc = "Morton's Crush";					break;				case 4: 					shortName = "Cristophe";					desc = "The Chef";					break;				case 5: 					shortName = "Brenda";					desc = "The Smokers";					break;				case 6: 					shortName = "Mimi";					desc = "The Cat Lady";					break;				case 7: 					shortName = "Scruffy";					desc = "The Janitor";					break;				case 8:					shortName = "Rat";					desc = "The Pest";			}			if (fullText == true){return (shortName + " - " + desc);}else{return shortName;}		}				public function translateDeath(iType:Number, textAmount:int) // 1= name only, 2= desc only, 3= score		{			var textType:String;			var descType:String;			var score:int;			switch (iType)			{				case 1:					textType="Cut It Out";					descType="Remember, it's up, not across.";					score = 1;					break;				case 2:					textType="Hit And Run";					descType="Cross the street longways to be a true champion.";					score = 2;					break;				case 3:					textType="Drink The Kool-Aid";					descType="Sugar, water, purple, and poison.  Delicious.";					score = 3;					break;				case 4:					textType="Hang In There";					descType="When the world gets to be too much, just hang in there!";					score = 1;					break;				case 5:					textType="Swan Dive";					descType="It's not flying, it's jumping with style.";					score = 1;					break;				case 6:					textType="Burn Baby Burn";					descType="When you're hot, you're HOT.";					score = 4;					break;				case 7:					textType="Boom Headshot";					descType="They say happiness is a warm gun.";					score = 3;					break;				case 8:					textType="Cross Me, I'll Cross-Cut You";					descType="1. Operate device made for cutting 2. ??? 3. Profit";					score = 5;					break;				case 9:					textType="Going down, next floor, dead";					descType="It's the fastest way to the bottom.";					score = 4;					break;				case 10:					textType="You're a fish";					descType="Fish can breath underwater, I'm sure you can too.";					score = 3;					break;				case 11:					textType="Shocking Conclusion";					descType="I'm amped up and can't wait to see watt happens next.";					score = 3;					break;				case 12:					textType="Tiny Snake Bites";					descType="Don't tread on it over and over and over and over.";					score = 6;					break;				case 13:					textType="Cheesy Title";					descType="Something is cheesy and delicious around here.";					score = 7;					break;				case 14:					textType="Blunt Trauma";					descType="It has very little to do with cigars.";					score = 6;					break;				case 15:					textType="Crush Crush Crush";					descType="It would be perfectly natural if you were a box.";					score = 8;					break;				case 16:					textType="Bags Aren't Toys";					descType="They are a whole lot of fun to play with though.";					score = 4;					break;				case 17:					textType="Murder Mystery";					descType="If you have the gun, it's not really much of a mystery.";					score = 9;					break;				case 18:					textType="Tail Gas";					descType="You've got too much carbon in your oxygen.";					score = 7;					break;				case 19:					textType="Cheesy Title Pt. 2";					descType="Cheesier! More Delicious! HOT HOT HOT!";					score = 15;					break;				case 20:					textType="Just Cool Off";					descType="You're going to be so chill after this.";					score = 10;					break;				case 50:					textType="Video Game Exposure";					descType="This is what happens when you play Morton's Mortality too long.";					score = 10;					break;			}			switch (textAmount){				case 1:					return (textType);				case 2:					return (descType);				case 3:					return (score);			}		}				public function translateAssets(iType:Number, mapFrame:Number) //4 - shredder, 5 - car, 6 - servers, 7- freezer door, 8 - power outlet, 9 - rest. table, 10 - rest. table + chairs		{ //11 - vending machine, 12 - elevator control, 13 - baler			switch (mapFrame)			{				case 2:					if (iType == 100){return "Lower Level: Parking garage, sewers, general yuckiness, and ABSOLUTELY no rats."};				case 11:					if (iType == 101){return "1st Floor: Front door, lobby, cafe, definitely no rats."};				case 21:					if (iType == 102){return "2nd Floor: Internal Revenue Service Offices"};				case 31:					if (iType == 103){return "3rd Floor: Internal Revenue Service Offices"};				case 41:					if (iType == 104){return "Roof: Lots and lots of air."};				case 1:					if (iType == 5){						if (Item.main.checkItems(2) == true && NPC.npcFlags[2][1] > 0){							return "Matthew's lovely red car which you have the keys to";						}						return "A lovely red car.  I wonder who it belongs to.";					}				case 3:					if (iType == 13){return "A cardboard baler.  It looks like a good way to get thin, fast.";}				case 14:					if (iType == 7){return "A deep freeze.  You wouldn't last very long in there.";}				case 22:					if (iType == 17){return "That's a depressing looking desk.";}					if (iType == 43){return "That's a depressing looking plant.";}				case 26:					if (iType == 4){return "A very sharp industrial paper shredder.  This thing looks like it means business.";}				case 37:					if (iType == 6){return "A server rack.  This thing looks expensive and high tech.";}					if (iType == 8){return "A 110VAC electrical outlet.  You shouldn't mess with this.";}					if (iType == 12){						var tempString:String;						if (Item.main.checkItems(15) == true){tempString = "You need a paperclip and ";}else{tempString = "You need some bendy wire and ";}						if (Item.main.checkItems(17) == true){tempString = tempString + "a screwdriver to hack this box."; if (Elevator.isHacked == false && Item.main.checkItems(15) == true){tempString = tempString + " (click to hack)";}}else{tempString = tempString + "a stronger straight thing to hack this box.";}												return "The elevator control box.  This box controls all the elevators' functionality.\n" + tempString;					}			}			return "x";		}				public function translateItems(iType:Number, fullText:Boolean)		{			var textType:String;			var descType:String;			switch (iType)			{				case 1:					textType="Knife";					descType="A very sharp french chef's knife.";					break;				case 2:					textType="Key (Car)";					descType="This key looks to fit a car.";					break;				case 3:					textType="Key (Interior)";					descType="This key looks to fit a door.";					break;				case 4:					textType="Belt";					descType="A brown leather belt that seems to excel at holding pants up.";					break;				case 5:					textType="Rat Poison";					descType="Kills rats dead.";					break;				case 6:					textType="Cigarette";					descType="Delicious sticks of tobacco made for smoking.";					break;				case 7:					textType="Lighter";					descType="Excellent for lighting things on fire.";					break;				case 8:					textType="Can Of Gas";					descType="A gallon of gasoline in a red plastic container."					break;				case 9:					textType="Powdered Lemonade";					descType="Delicious lemonaide mix.  Just add water!"					break;				case 10:					textType="Necktie";					descType="A silk necktie with a lovely pattern on it."					break;				case 11:					textType="Gun";					descType="A 9mm handgun.  Dangerous in the wrong hands.";					break;				case 12:					textType="Bullets";					descType="These fit a 9mm handgun.";					break;				case 13:					textType="Stapler";					descType="A wonderful device used to bind pages together with metal.";					break;				case 14:					textType="Staples";					descType="Tiny bits of sharp metal that fit in a stapler.";					break;				case 15:					textType="Paperclip";					descType="A bent piece of metal meant to hold paper together.";					break;				case 16:					textType="Bucket";					descType="This bucket will hold fluids and non-fluids alike.  Truly a wonder!";					break;				case 17:					textType="Screwdriver";					descType="Used to secure fasteners into various materials.";					break;				case 18:					textType="Cheese";					descType="A delicious smoked gouda.";					break;				case 19:					textType="Flute";					descType="A beautiful woodwind instrument.";					break;				case 20:					textType="Paperweight";					descType="A very heavy piece of glass used to hold papers down. ";					break;				case 21:					textType="Wad Of Cash";					descType="A bunch of bills in a money clip.";					break;				case 22:					textType="Blood Thinners";					descType="These pills will thin out your blood.  You probably shouldn't take them.";					break;				case 23:					textType="Tape";					descType="This clear tape is great for sticking things to other things.";					break;				case 24:					textType="Plastic Bag";					descType="This airtight bag will hold all sorts of things.";					break;				case 25:					textType="Garden Hose";					descType="Liquids and gases flow through this long tube.";					break;				case 26:					textType="Stack Of Papers";					descType="A bunch of papers in a stack.";					break;				case 27:					textType="Taco";					descType="Because our artist drew it, and it looks delicious.";					break;				case 40:					textType="Antimatter Cube";					descType="A cube of solid antimatter.  It's probably valuable, or worthless.  One of those.";					break;			}			if (fullText == true){return (textType + " - " + descType);}else{return textType;}		}				public function gotItem(iType:int, alert:String){			Item.main.spawnItems(200,200,iType);			Item.iMarker = Item.list.length -1;			Item.main.placeItems(Item.list[Item.list.length -1]);			dialogOn = false;			playSound("Get-Item");			displayText (alert);			clearTextDelay(2000);		}				public function killedRat(){			dialogOn = false;			NPC.main.removeNPCs();			NPC.npcFlags[0][1]++;			var ratString:String = " rat";			if (NPC.npcFlags[0][1] >= 2){ratString = " rats";}			if (Item.main.checkItems(11) == true && Item.main.checkItems(12) == true){				//has gun and bulets				NPC.npcFlags[0][2]++; //rats shot				displayText ("\tYou just shot a rat!\nYou have killed " + NPC.npcFlags[0][1] + ratString + " and shot " + NPC.npcFlags[0][2] + ".");				playSound("Gunshot");			}			else			{				displayText ("\tYou just killed a rat!\nYou have killed " + NPC.npcFlags[0][1] + ratString + ".");				playSound("Rat");			}			clearTextDelay(2000);		}				public function drawDialog(npcType:int, mapframe:int){			var dialogString:String = dialog(npcType, mapframe);			if (dialogOn == true){				tooltipText.text = dialogString;				this.alpha = 1;				trace ("*Tooltip: drawDialog: ON");				musicChannel.soundTransform = volDownMore;			}			else{				trace ("*Tooltip: drawDialog: OFF");				musicChannel.soundTransform = volDown;			}		}				public function dialog(npcType:int, mapframe:int){			if (npcType == 8){				killedRat();			}			switch (mapframe){				case 3:					switch (curStep){						case 1:							playSound("Scruffy-Talk"); //1 - got bucket 2- got key 3. told shoot 10 rats 4. shoot 10 rats							if (NPC.npcFlags[npcType][1] == 0){return "Scruffy: Man, when I find out who stole my screwdriver, they're really going to get it."}							if (NPC.npcFlags[npcType][2] == 0){return "Scruffy: Those damn rats again, they've taken my house key!"}							if (NPC.npcFlags[npcType][3] == 0){return "Scruffy: That's the last straw, those rats are going to be sorry they messed with me."}							if (NPC.npcFlags[npcType][4] == 0){return "Scruffy: Have you shot 10 of them through their little heads yet?"}							return "Scruffy: Morton, keep an eye on those rats, I think they've been ploting against you.";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0){								if (Item.main.checkItems(17) == true){return "Morton: Uh, well I didn't steal it, but I did find it.";}else{return "Morton: You're a crazy old man, who would steal a screwdriver?";}							}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(3) == true){return "Morton: I don't know that the rats took it, but I found it in the sewer";}else{return "Morton: I think you're giving rats entirely too much credit.";}							}							if (NPC.npcFlags[npcType][3] == 0){return "Morton: Do I even want to know why?"}							if (NPC.npcFlags[npcType][4] == 0){								if (NPC.npcFlags[0][2] >= 10){return "Morton: Yep, I shot " + NPC.npcFlags[0][2] + " of them.";}else{return "Morton: No, I've shot " + NPC.npcFlags[0][2] + " of them.";}							}							curStep=6;							return "Morton: Uh, sure thing Scruffy.";						case 3:							if (NPC.npcFlags[npcType][1] == 0){								if (Item.main.checkItems(17) == true){return "Scruffy: Well put it back in the maintenance closet!  I'll even give you my prize bucket as thanks.";}else{curStep=6;return "Scruffy: Probably those rats, they've been eying it for ages.";}							}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(3) == true){return "Scruffy: Oh, the rats took it alright.  Give it back and I'll give you something better.";}else{curStep=6;return "Scruffy: I think you don't give them enough credit.  Just wait until you turn your back on them.";}							}							if (NPC.npcFlags[npcType][3] == 0){return "Scruffy: Because you're going to take that gun I gave you, get some bullets, and shoot 10 of them."}							if (NPC.npcFlags[npcType][4] == 0){								if (NPC.npcFlags[0][2] >= 10){return "Scruffy: Good work soldier!  Take this to finish them off."}else{curStep=6;return "Scruffy: Well why are you still standing here? Get to it!";}							}						case 4:							if (NPC.npcFlags[npcType][1] == 0){								if (Item.main.checkItems(17) == true){									gotItem(16, "You got: SCRUFFY'S PRIZE BUCKET");									NPC.npcFlags[npcType][1] = 2;									return "x";								}							}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(3) == true){									Item.main.useItems(3);									gotItem(11, "You got: A HANDGUN");									NPC.npcFlags[npcType][2] = 4;									return "x";								}							}							if (NPC.npcFlags[npcType][3] == 0){NPC.npcFlags[npcType][3] = 1;return "Morton: Oh, sounds lovely."}							if (NPC.npcFlags[npcType][4] == 0){								if (NPC.npcFlags[0][2] >= 10){									gotItem(8, "You got: A CAN OF GASOLINE");									NPC.npcFlags[npcType][4] = 4;									return "x";								}							}					}					break;				case 14:					switch (curStep){						case 1:							playSound("Chef-Talk"); //1-told about rats 2- killed rats 3- told to kill rats 4 -actually killed rats							if (NPC.npcFlags[npcType][1] == 0){return "Cristophe: Sacrebleu! These rats are scaring away all my patrons!  Can you help me, Morton?"}							if (NPC.npcFlags[npcType][2] == 0){return "Cristophe: Any luck on ze rat poison Morton?"}							if (NPC.npcFlags[npcType][3] == 0){return "Cristophe: Well that killed a few, but they still aren't gone!"}							if (NPC.npcFlags[npcType][4] == 0){return "Cristophe: Have you killed the 15 rats yet?"}							return "Cristophe: Thanks for all your help Morton, it looks like things are back to normal around here.";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0){return "Morton: Uh, maybe?";}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(5) == true){return "Morton: Well I found some earlier, but I still don't think you should use it.";}else{return "Morton: No, and I'm not sure you having rat poison is a good idea.";}							}							if (NPC.npcFlags[npcType][3] == 0){return "Morton: Maybe if you kill enough of them, the others will get the hint and leave."}							if (NPC.npcFlags[npcType][4] == 0){								if (NPC.npcFlags[0][1] >= 15){return "Morton: Yeah, I've killed " + NPC.npcFlags[0][1] + " of them so far.";}else{return "Morton: Um, not quite.  I'm " + (15 - NPC.npcFlags[0][1]) + " short.";}							}							curStep=6;							return "Morton: I don't know that I'd go that far.";						case 3:							if (NPC.npcFlags[npcType][1] == 0){return "Cristophe: I need to get some rat poison so I can kill them once and for all.";}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(5) == true){return "Cristophe: Tell you what, I'll give you my best french chef's knife for it.";}else{curStep=6;return "Cristophe: I'm not sure I like your tone Morton.";}							}							if (NPC.npcFlags[npcType][3] == 0){return "Cristophe: That's a pretty stupid idea, but go for it.  Kill 15 rats and report back."}							if (NPC.npcFlags[npcType][4] == 0){								if (NPC.npcFlags[0][1] >= 15){curStep=4;return "Cristophe: Excellent!  Enjoy this food from my homeland that I've prepared for you.";}else{curStep=6;return "Cristophe: Well get to it, sissy!";}							}						case 4:							if (NPC.npcFlags[npcType][1] == 0){return "Morton: Is that really a good idea around food?";}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(5) == true){return "Morton: Uh, I guess."}							}							if (NPC.npcFlags[npcType][3] == 0){								if (NPC.npcFlags[0][1] >= 15){return "Cristophe: Wow, you've already killed " + NPC.npcFlags[0][1] + " of them? Amazing!";}else{curStep=6;NPC.npcFlags[npcType][3] = 1;return "Morton: What are you, my boss?";}							}						case 5:							if (NPC.npcFlags[npcType][1] == 0){NPC.npcFlags[npcType][1] = 1;return "Cristophe: What do you know, short man?";}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(5) == true){									Item.main.useItems(5);									gotItem(1, "You got: THE CHEF'S BEST KNIFE");									NPC.npcFlags[npcType][2] = 2;									return "x";								}							}							if (NPC.npcFlags[npcType][3] == 0 || NPC.npcFlags[npcType][4] == 0){								if (NPC.npcFlags[0][1] >= 15){									gotItem(27, "You got: A POSSIBLY POISONED TACO");									NPC.npcFlags[npcType][3] = 1;									NPC.npcFlags[npcType][4] = 4;									return "x";								}							}					}					break;				case 21: //new					switch (curStep){						case 1:							playSound("Mimi-Talk");//npcflags - Mimi[1] [1: talked to 2: got lighter 3. started q 4. finish q. (give taco/get flute]							if (NPC.npcFlags[npcType][1] == 0){return "Mimi: Hi Morton, have you talked to Bob yet?\n(click to continue)";}							if (NPC.npcFlags[npcType][2] == 0){return "Mimi: Any news from Bob about me?\n(click to continue)";}							if (NPC.npcFlags[npcType][3] == 0){return "Mimi: Man I'm starving.  I could really go for some tacos\n(click to continue)";}							if (NPC.npcFlags[npcType][4] == 0){return "Mimi: Any luck on those tacos?  My stomach isn't going to feed itself.\n(click to continue)";}							return "Mimi: Mmm, a fully tummy is a happy tummy\n(click to continue)";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0 || NPC.npcFlags[npcType][2] == 0){								if (NPC.npcFlags[1][2] > 0){return "Morton: No, but he said he needed a smoke.  What in the world does a cat have to be stressed about?";}								if (NPC.npcFlags[1][1] > 0){return "Morton: No, I'm not even sure he knows who you are.";}								return "Morton: No.";							}							if (NPC.npcFlags[npcType][3] == 0 || NPC.npcFlags[npcType][4] == 0){								if (Item.main.checkItems(27) == true){									return "Morton: I did find a taco earlier.";								}								else{return "Morton: I haven't exactly been looking for tacos.";}							}							curStep = 7;							return "Morton: Nice of you to share.";							case 3:							if (NPC.npcFlags[npcType][1] == 0 || NPC.npcFlags[npcType][2] == 0){								if (NPC.npcFlags[1][2] > 0){return "Mimi: My poor snuggle wuggle! I don't smoke, but I do have a lighter you can have.";}								if (NPC.npcFlags[1][1] > 0){return "Mimi: We have a special connection you couldn't begin to understand.";}								return "Mimi: Well when you do, tell me if he says anything about me.  He's just so cute with his little cheeks, and his ears!";							}							if (NPC.npcFlags[npcType][3] == 0 || NPC.npcFlags[npcType][4] == 0){								if (Item.main.checkItems(27) == true){									return "Mimi: Oh yes!  I've been holding on to this for a while, but you can have it.  I hear it's magic.";								}								else{return "Mimi: Well put yourself to use and find me a taco!  I'll make it worth your while.";}							}						case 4:							if (NPC.npcFlags[npcType][1] == 0 || NPC.npcFlags[npcType][2] == 0){								curStep = 7;								NPC.npcFlags[npcType][1] = 1;								if (NPC.npcFlags[1][2] > 0){									gotItem(7, "You got: A LIGHTER");									NPC.npcFlags[npcType][2] = 2;									return "x";								}								return "Morton: Whatever you say crazy lady.";								}							if (NPC.npcFlags[npcType][3] == 0 || NPC.npcFlags[npcType][4] == 0){								NPC.npcFlags[npcType][3] = 1;								if (Item.main.checkItems(27) == true){									Item.main.useItems(27);									gotItem(19, "You got: A MAGIC FLUTE");									NPC.npcFlags[npcType][4] = 4;									return "x";								}								return "Morton: That sounds gross.";								}																	}					break;				case 24: //new					switch (curStep){						case 1:							playSound("BossCat-Talk");//npcflags - boss[1] [1: got raise 2: boss wants smoke 3. smoked out boss]							if (NPC.npcFlags[npcType][1] == 0){return "Boss: Morton! I'm glad you're here.  I want to talk to you about your purrformance.\n(click to continue)";}							if (NPC.npcFlags[npcType][2] == 0){return "Boss: Hey Morton, please tell me you have some smokes.\n(click to continue)";}							if (NPC.npcFlags[npcType][3] == 0){return "Boss: Any luck on those smokes?\n(click to continue)";}							return "Boss: Ahh, much better\n(click to continue)";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0){return "Morton: I'm really sorry, I've just had a lot on my mind lately.  It won't happen again...";}							if (NPC.npcFlags[npcType][2] == 0 || NPC.npcFlags[npcType][3] == 0){								if(Item.main.checkItems(6) == true && Item.main.checkItems(7) == true){return "Morton: Yeah, but are you sure you should be smoking?";}								if(Item.main.checkItems(6) == true){return "Morton: Yeah, but I don't have a light.";}								if(NPC.npcFlags[npcType][2] == 1){return "Morton: Yeah, I still don't smoke";}								return "Morton: No?  I don't even smoke.";							}							return "Morton: You sicken me cat.";							case 3:							if (NPC.npcFlags[npcType][1] == 0){return "Boss: No Morton, that's actually not it at all.  You're one of my best workers, and I think you deserve a bonus.";}							if (NPC.npcFlags[npcType][2] == 0 || NPC.npcFlags[npcType][3] == 0){								if(Item.main.checkItems(6) == true && Item.main.checkItems(7) == true){return "Morton: SHUT UP AND GIVE ME THE FUCKING CIGARETTES!";}								if(Item.main.checkItems(6) == true){return "Boss: What do I pay you for Morton? Go find a damn lighter!";}								if(NPC.npcFlags[npcType][2] == 1){return "Boss: Well it's about time you start then, don't you think?";}								return "Boss: Well if you find some, grab them for me.";							}							curStep = 7; 								return "Boss: Whatever man, whatever.";						case 4:							if (NPC.npcFlags[npcType][1] == 0){return "Morton: Really?  What kind of bonus?";}							if (NPC.npcFlags[npcType][2] == 0 || NPC.npcFlags[npcType][3] == 0){								if(Item.main.checkItems(6) == true && Item.main.checkItems(7) == true){									curStep = 7; 									gotItem(20, "You got: A BEAUTIFUL PAPERWEIGHT");									NPC.npcFlags[npcType][2] = 1;									NPC.npcFlags[npcType][3] = 2;									Item.main.useItems(6);									return "x";									}								else{NPC.npcFlags[npcType][2] = 1; curStep = 7;return "Morton: Whatever cat.";}							}						case 5:							return "Boss: Well I couldn't find any dead mice, so I guess a wad of cash will have to do.";						case 6:							gotItem(21, "You got: A WAD OF CASH");							NPC.npcFlags[npcType][1] = 1;							return "x";					}					break;				case 32:					switch (curStep){						case 1:							playSound("Matthew-Talk"); //1 - told about pills 2 - got pills 3. told papers 4. got papers							if (NPC.npcFlags[npcType][1] == 0){return "Matthew: Morton, I'm glad you're here!  I left some pills in my car and I desperately need them.";}							if (NPC.npcFlags[npcType][2] == 0){return "Matthew: Morton! Do you have my pills yet?";}							if (NPC.npcFlags[npcType][3] == 0){return "Matthew: Thank you so much for those pills Morton, my blood is at the right viscosity now and I'm feeling grand.";}							if (NPC.npcFlags[npcType][4] == 0){return "Matthew: Did you find that stack of papers in my car?";}							return "Matthew: Thanks for all your help Morton, you're a good pal.";							break;						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0){return "Morton: Oh?";}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(22) == true){return "Morton: I think so, are these them?";}else{return "Morton: Uh, I haven't gotten around to it yet.";}							}							if (NPC.npcFlags[npcType][3] == 0){return "Morton: That's good to hear.  Blood pudding is awful.";}							if (NPC.npcFlags[npcType][4] == 0){								if (Item.main.checkItems(26) == true){return "Morton: Well I got *a* stack of papers.";}else{return "Morton: I haven't even looked.  I had this thing.";}							}							curStep=6;							return "Morton: And according to the tooltips, you're my best friend.";							break;						case 3:							// first quest dialog							if (NPC.npcFlags[npcType][1] == 0){return "Matthew: Yes, they're very important.  Take my car keys, go down to my car, and get them for me, will you?";}								if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(22) == true){return "Matthew: Thank goodness! My blood was feeling dangerously thick.";}else{return "Morton: You're a pretty shit best friend, you know that?";}							}							if (NPC.npcFlags[npcType][3] == 0){return "Matthew: There's just one more thing, will you check my car again for some papers?  I think I left them in there.";}								if (NPC.npcFlags[npcType][4] == 0){								if (Item.main.checkItems(26) == true){return "Matthew: And they're even the right ones!  Thanks a bunch Morton!";}else{return "Matthew: Besides saving my life, you're beyond useless.";}							}							break;						case 4:							if (NPC.npcFlags[npcType][1] == 0){return "Morton: Sure, I'll try.";}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(22) == true){return "Matthew: Have this screwdriver I stole off Scrufy as my way of saying thanks.  I'm sure he won't miss it.";}else{curStep=6;return "Morton: You're pretty shit at waiting.  I'll get to it.";}							}							if (NPC.npcFlags[npcType][3] == 0){NPC.npcFlags[npcType][3] = 1;curStep=6;return "Morton: Yeah, but I'm going to kill myself in your car later.";}								if (NPC.npcFlags[npcType][4] == 0){								if (Item.main.checkItems(26) == true){return "Matthew: I have some bullets in my pocket.  I'm not sure why, but you should have them.";}else{curStep=6;return "Morton: Says the guy who just stands in one room and wanders around aimlessly.";}							}								break;						case 5:							if (NPC.npcFlags[npcType][1] == 0){gotItem(2, "You got: MATTHEW'S CAR KEYS");NPC.npcFlags[npcType][1] = 1;return "x";}							if (NPC.npcFlags[npcType][2] == 0){								if (Item.main.checkItems(22) == true){Item.main.useItems(22);gotItem(17, "You got: A STOLEN SCREWDRIVER");NPC.npcFlags[npcType][2] = 2;}									return "x";											}							if (NPC.npcFlags[npcType][4] == 0){								if (Item.main.checkItems(26) == true){Item.main.useItems(26);gotItem(12, "You got: OUT OF PLACE BULLETS");NPC.npcFlags[npcType][4] = 4;}								return "x";											}							break;					}					break;				case 33:					switch (curStep){						case 1:							playSound("Maria-Talk");							if (NPC.npcFlags[npcType][2] == 0){return "Maria: Oh hi Morton, sorry, I didn't see you there at first.";}							if (NPC.npcFlags[npcType][4] == 0){return "Maria: Hi Morton.  It's nice to see you here.";}							if (NPC.npcFlags[npcType][6] == 0){return "Maria: It's so good to see you again Morton!";}							return "Maria: Marry me Morton!  I love you!";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][2] == 0){return "Morton: It's alright, I'm used to it.";}							if (NPC.npcFlags[npcType][4] == 0){return "Morton: It's nice to see you too I suppose.";}							if (NPC.npcFlags[npcType][6] == 0){return "Maria: Thanks, it's good to see you too.";}							curStep=6;							return "Morton: OK.";						case 3:							// first quest dialog							if (NPC.npcFlags[npcType][1] == 0 && Item.main.checkItems(9) == true){								return "Maria: It's like you read my mind, I've been craving lemonaide all day!  Here's something for your troubles.  I saw it and thought of you.";}							else if (NPC.npcFlags[npcType][1] == 0 && Item.main.checkItems(9) == false){								NPC.npcFlags[npcType][1] = 1;								return "Maria: I've just been craving lemonaide all day and I really wish I had some.";							}							if (NPC.npcFlags[npcType][2] == 0 && Item.main.checkItems(9) == true){								return "Maria: You brought me lemonaide? That's so nice of you.  Here's something for you troubles.";}							else if (NPC.npcFlags[npcType][2] == 0 && Item.main.checkItems(9) == false){								return "Maria: I'm still just thinking about lemonaide.  I can't get my mind off it for some reason.";							}							//second quest dialog							if (NPC.npcFlags[npcType][3] == 0 && Item.main.checkItems(20) == true){								return "Maria: You got me a paperweight?  It's lovely!  Thank you so much Morton.  Take these, I hope they help you.";}							else if (NPC.npcFlags[npcType][3] == 0 && Item.main.checkItems(20) == false){								NPC.npcFlags[npcType][3] = 1;								return "Maria: Someone stole a paperweight off my desk earlier, can you believe that?";							}							if (NPC.npcFlags[npcType][4] == 0 && Item.main.checkItems(20) == true){								return "Maria: You found my paperweight!  I'm so glad to have it back.  I hope these help you.";}							else if (NPC.npcFlags[npcType][4] == 0 && Item.main.checkItems(20) == false){								return "Maria: I just miss my poor paperweight.  We went through a lot together.";							}						case 4:							// first quest dialog							if (NPC.npcFlags[npcType][2] == 0 && Item.main.checkItems(9) == true){								gotItem(10, "You got: A TIE"); 								Item.main.useItems(9); 								NPC.npcFlags[npcType][1] = 1;								NPC.npcFlags[npcType][2] = 2; 								return "x";							}else if (NPC.npcFlags[npcType][2] == 0 && Item.main.checkItems(9) == false){return "Morton: Yeah, lemonaide...it sure is something";}							// second quest dialog							if (NPC.npcFlags[npcType][4] == 0 && Item.main.checkItems(20) == true){								gotItem(14, "You got: SOME STAPLES"); 								Item.main.useItems(20); 								NPC.npcFlags[npcType][3] = 1; 								NPC.npcFlags[npcType][4] = 4; 								return "x";							}else if (NPC.npcFlags[npcType][4] == 0 && Item.main.checkItems(20) == false){return "Morton: That's too bad.  I'm sure it'll show up though.";}					}					break;				case 42:					switch (curStep){						case 1:							playSound("Brenda-Talk");							if (NPC.npcFlags[npcType][1] == 0){return "Brenda: Oh, hi Morton.  You wouldn't happen to have a light would you?"}							return "Brenda: Surely just one more won't kill me.";						case 2:							playSound("Morton-Talk");							if (NPC.npcFlags[npcType][1] == 0){								if (Item.main.checkItems(7) == true){return "Morton: Yeah, I do";}else{return "Morton: No, I don't smoke and neither should you.";}							}							curStep=6;							return "Morton: This can only end well.";						case 3:							if (NPC.npcFlags[npcType][1] == 0){								if (Item.main.checkItems(7) == true){return "Brenda: You're a lifesaver.  Take the rest, I'm trying to quit.";}else{curStep=6;return "Brenda: I'm trying to quit, I just need one more.  Just one more.";}							}						case 4:							if (NPC.npcFlags[npcType][1] == 0){								if (Item.main.checkItems(7) == true){									gotItem(6, "You got: SOME CIGARETTES");									NPC.npcFlags[npcType][1] = 2;									return "x";								}							}					}					break;								}			dialogOn = false;			clearText();			return "x";		}	}}