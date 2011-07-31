﻿/*The Scoreboard class controls the death menu, the "are you sure" dialog box, and the "you're dead" menu*/package{	import flash.display.*	import flash.events.*	import flash.net.*	import flash.utils.Timer;	import flash.text.TextFieldAutoSize;	import flashx.textLayout.elements.InlineGraphicElement;	import fl.controls.List; 	import flash.text.TextField; 	import flash.utils.Endian;	import flashx.textLayout.formats.ITabStopFormat;		public class Scoreboard extends MovieClip	{		//the list is an array of all men on stage		static public var main;				static public var deathDone:Array= [];		public function Scoreboard()		{			main = this;			clearWindow();			clearDeaths(); // inits deathdones			mouseEnabled=false;			populateList();			listBox.addEventListener(MouseEvent.CLICK, showData);  //death list box			btnClose.addEventListener(MouseEvent.CLICK, closeWindow); //big white X			goForIt.addEventListener(MouseEvent.CLICK, goingForIt);						confirmationBox.dieButton.addEventListener(MouseEvent.CLICK, doDeath);			confirmationBox.liveButton.addEventListener(MouseEvent.CLICK, doLife);						deadScreen.againButton.addEventListener(MouseEvent.CLICK, tryAgain);			deadScreen.stayDeadButton.addEventListener(MouseEvent.CLICK, stayDead);		}				public function doDeath(e:Event){			showDead(MM.currentDeath);			//die!		}				public function doLife(e:Event){			closeWindow(e);			if (Tooltip.musicPosition > 1){Tooltip.main.playMusic(Tooltip.musicPosition, "MainTheme");}else{Tooltip.main.playMusic(0, "MainTheme");}			//live!		}				public function tryAgain(e:Event){			MM.isGameOver == false;			Map.main.changeMap(MM.SPAWNPOINT, "x");			Map.main.saveMorton(MM.SPAWNPOINT);			closeWindow(e);			Tooltip.main.stopMusic();			Tooltip.main.playMusic(0, "MainTheme");			Tooltip.main.displayText ("You have completed " + countDeaths() + "/" + MM.TOTALDEATHS + " deaths");			Tooltip.main.clearTextDelay(2000);			//live!		}				public function stayDead(e:Event){			Tooltip.main.stopMusic();			closeWindow(e);			MM.main.resetGame();			//stay dead!		}				public function countDeaths(){			var i = 1;			var c:int = 0;			while (i <= MM.TOTALDEATHS)			{				if (deathDone[i] == true){c++;}				i++;			}			return c;		}				public function clearDeaths(){			var i = 1;			while (i <= MM.TOTALDEATHS)			{				deathDone[i] = false;				i++;			}		}				public function populateList(){			listBox.removeAll();			var i = 1;			var c:int = 0;			if (Death.list.length > 0){ //death button is on				c = Death.type[0];			}			while (i <= MM.TOTALDEATHS)			{				if (deathDone[i] == true){listBox.addItem({label:"X " + Tooltip.main.translateDeath(i, 1), data:i});}				else if (i == c){listBox.addItem({label:"* " + Tooltip.main.translateDeath(i, 1), data:i});}				else{listBox.addItem({label:Tooltip.main.translateDeath(i, 1), data:i});} // add short form death name in list until out of deaths}				i++;			}		}				public function clearWindow(){			textDesc.text = "";			textNeed.text = "";			textHave.text = "";			goForIt.visible=false;			labelHave.visible=false;			labelNeed.visible=false;			confirmationBox.visible=false;			deadScreen.visible=false;		}				public function closeWindow(e:Event){			MM.main.scoreboard.visible=false;			stage.focus = Morton.main;		}				public function showWindow(){			clearWindow();			populateList();			MM.main.scoreboard.visible=true;		}				public function goingForIt(e:Event){			showConfirm(listBox.selectedItem.data);		}				public function showConfirm(dType:int){			showWindow();			Tooltip.musicPosition = Tooltip.main.stopMusic();			MM.currentDeath=dType;			confirmationBox.visible=true;			trace ("*Scoreboard: showconfirm: dType:", dType, "deathdone:" , deathDone[dType]);			if (deathDone[dType] == false){confirmationBox.confirmText.text = "Are you sure you want to do this? It could be dangerous...";} //this is the first time they've done this death			else{confirmationBox.confirmText.text = "Are you sure you want to do this? It didn't end so well last time";} //they've done it before		}				public function countPeople(){ //all up the total value of npcflags and return as "number of people attending funeral"			var i = 0;			var h = 0;			var people = 0;			while (i != MM.TOTALNPCS)			{				while (h != 8)				{					people += NPC.npcFlags[i][h];					//trace ("people: " + people + " - i:" + i + " - h:" + h);					h++;				}				h=0;				i++;			}			return people;		}				public function showDead(dType:int){ //populate end game "you're dead" menu			showWindow();			MM.isGameOver == true;			deadScreen.visible=true;			deadScreen.deathText.text = Tooltip.main.translateDeath(dType, 1);			deadScreen.deathScene.gotoAndStop(dType);			if (deathDone[dType] == false){deadScreen.deathText.appendText(" (new)");Tooltip.main.playMusic(0, "Funeral")}			deathDone[dType] = true;			var criers:int = Tooltip.main.translateDeath(dType, 3);			var people:int = countPeople() + 1;			if (people <= 1){deadScreen.deathScore.text = people + " person came to your funeral";}			else{deadScreen.deathScore.text = people + " people came to your funeral";}			if (criers == 1){deadScreen.deathScore.appendText("\n" + criers + " person cried");}			else{deadScreen.deathScore.appendText("\n" + criers + " people cried");}			MM.totalTears += (criers * 5);			deadScreen.deathScore.appendText("\n" + MM.totalTears + " total tears");		}				function showData(event:Event) { //this code happens on list click			clearWindow();			textDesc.text = "Description: " + Tooltip.main.translateDeath(listBox.selectedItem.data, 2);			if (deathDone[listBox.selectedItem.data] == true){textDesc.appendText("\n (already done)");}			switch (listBox.selectedItem.data){				case 1: //kill with knife					if (Item.main.checkItems(1) == true){textHave.appendText (Tooltip.main.translateItems(1, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 2: //hit by car					if (Map.main.currentFrame == 17){textHave.appendText ("The Street, ");}else{textNeed.appendText ("Specific Location, ");}					break;				case 3: //drink poisoned lemonaide					if (Item.main.checkItems(9) == true){textHave.appendText (Tooltip.main.translateItems(9, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(5) == true){textHave.appendText (Tooltip.main.translateItems(5, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 4: //hang with belt					if (Item.main.checkItems(4) == true){textHave.appendText (Tooltip.main.translateItems(4, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 5: //jump off roof					if (Map.main.currentFrame == 40 || Map.main.currentFrame == 44){textHave.appendText ("The Roof, ");}else{textNeed.appendText ("Specific Location, ");}					break;				case 6: //set self on fire					if (Item.main.checkItems(7) == true){textHave.appendText (Tooltip.main.translateItems(7, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(8) == true){textHave.appendText (Tooltip.main.translateItems(8, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 7: //shoot self					if (Item.main.checkItems(11) == true){textHave.appendText (Tooltip.main.translateItems(11, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(12) == true){textHave.appendText (Tooltip.main.translateItems(12, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 8: //paper shredder					if (Map.main.currentFrame == 26){textHave.appendText ("The Supply Room, ");}else{textNeed.appendText ("Specific Location, ");}					if (Item.main.checkItems(10) == true){textHave.appendText (Tooltip.main.translateItems(10, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 9: //fall down elevator shaft					if (Map.main.currentFrame == 21 || Map.main.currentFrame == 31 || Map.main.currentFrame == 41){textHave.appendText ("The Elevator, ");}else{textNeed.appendText ("Specific Location, ");}					if (Elevator.isHacked == true){textHave.text = "A Malfunctioning Elevator, ";}else{textNeed.appendText ("Specific Action, ");}					break;				case 10: //drown					if (Map.main.currentFrame == 15 || Map.main.currentFrame == 25 || Map.main.currentFrame == 35){textHave.appendText ("The Bathroom, ");}else{textNeed.appendText ("Specific Location, ");}					if (Item.main.checkItems(16) == true){textHave.appendText (Tooltip.main.translateItems(16, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(25) == true){textHave.appendText (Tooltip.main.translateItems(25, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 11: //electrocute yourself					if (Map.main.currentFrame == 37){textHave.appendText ("The Server Room, ");}else{textNeed.appendText ("Specific Location, ");}					if (Item.main.checkItems(17) == true){textHave.appendText (Tooltip.main.translateItems(17, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 12: //staple to death					if (Item.main.checkItems(13) == true){textHave.appendText (Tooltip.main.translateItems(13, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(14) == true){textHave.appendText (Tooltip.main.translateItems(14, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 13: //eaten by rats					if (Map.main.currentFrame == 4 || Map.main.currentFrame == 5){textHave.appendText ("The Sewers, ");}else{textNeed.appendText ("Specific Location, ");}					if (NPC.list.length > 0 && NPC.main.currentFrame == 8){textHave.appendText ("Rat, ");}else{textNeed.appendText ("Specific Animal, ");}					if (Item.main.checkItems(18) == true){textHave.appendText (Tooltip.main.translateItems(18, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(19) == true){textHave.appendText (Tooltip.main.translateItems(19, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 14: //blunt trauma					if (Item.main.checkItems(20) == true){textHave.appendText (Tooltip.main.translateItems(20, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(22) == true){textHave.appendText (Tooltip.main.translateItems(22, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 15: //crushed to death					if (Map.main.currentFrame == 3){textHave.appendText ("The Equiment Room, ");}else{textNeed.appendText ("Specific Location, ");}					if (Item.main.checkItems(23) == true){textHave.appendText (Tooltip.main.translateItems(23, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 16: //suffocate					if (Item.main.checkItems(24) == true){textHave.appendText (Tooltip.main.translateItems(24, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(4) == true){textHave.appendText (Tooltip.main.translateItems(4, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 17: //murder?					if (NPC.list.length > 0){textHave.appendText ("" + Tooltip.main.translateNPCs(NPC.main.currentFrame, 1, false) +", ");}else{textNeed.appendText ("Victim, ");}					if (Item.main.checkItems(11) == true){textHave.appendText (Tooltip.main.translateItems(11, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(12) == true){textHave.appendText (Tooltip.main.translateItems(12, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 18: //CO poisoning					if (Map.main.currentFrame == 1){textHave.appendText ("The Parking Garage, ");}else{textNeed.appendText ("Specific Location, ");}					if (Item.main.checkItems(25) == true){textHave.appendText (Tooltip.main.translateItems(25, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(2) == true){textHave.appendText (Tooltip.main.translateItems(2, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 19: //eaten by flaming rats					if (Map.main.currentFrame == 4 || Map.main.currentFrame == 5){textHave.appendText ("The Sewers, ");}else{textNeed.appendText ("Specific Location, ");}					if (NPC.list.length > 0 && NPC.main.currentFrame == 8){textHave.appendText ("Rat, ");}else{textNeed.appendText ("Specific Animal, ");}					if (Item.main.checkItems(18) == true){textHave.appendText (Tooltip.main.translateItems(18, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(19) == true){textHave.appendText (Tooltip.main.translateItems(19, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(7) == true){textHave.appendText (Tooltip.main.translateItems(7, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					if (Item.main.checkItems(8) == true){textHave.appendText (Tooltip.main.translateItems(8, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;				case 20: //frozen					if (Map.main.currentFrame == 14){textHave.appendText ("The Freezer, ");}else{textNeed.appendText ("Specific Location, ");}					if (Item.main.checkItems(4) == true){textHave.appendText (Tooltip.main.translateItems(4, false) + ", ");}else{textNeed.appendText ("???" + ", ");}					break;			}			if (textHave.text != ""){textHave.appendText("*");textHave.text = textHave.text.replace(", *", "");} //this code removes trailing commas			if (textNeed.text != ""){textNeed.appendText("*");textNeed.text = textNeed.text.replace(", *", "");}			if (textNeed.text == ""){labelHave.visible=true;goForIt.visible=true;} //hides unused labels			else if (textHave.text == ""){labelNeed.visible=true;}			else{labelHave.visible=true;labelNeed.visible=true;}		}	}}