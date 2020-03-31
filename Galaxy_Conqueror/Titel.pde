//This class was made by Lucas van Wonderen
class Titel {

  // Main titel Stats
  //final int textSize = 70;          
  //final int textSizebut = 35;
  //final int titelX = width/2;
  //final int titelY = height/3;

  //Start Button Stats
  //final int staButtonX = width/2;
  //final float staButtonY =  height/3 * 1.3;
  //final int staButtonW = 600;
  //final int staButtonH = 100;
  //final int staButtonWinn = 575;
  //final int staButtonHinn = 75;

  //highscore Button Stats
  //final int hiButtonX = width/2;
  //final float hiButtonY =  height/3 * 1.7;
  //final int hiButtonW = 600;
  //final int hiButtonH = 100;
  //final int hiButtonWinn = 575;
  //final int hiButtonHinn = 75;

  // Settings Button Stats
  //final int setButtonX = width/2;
  //final float setButtonY =  height/3 * 2.1;
  //final int setButtonW = 600;
  //final int setButtonH = 100;
  //final int setButtonWinn = 575;
  //final int setButtonHinn = 75;

  // Quit Button Stats
  //final int qButtonX = width/2;
  //final float qButtonY =  height/3 * 2.5;
  //final int qButtonW = 600;
  //final int qButtonH = 100;
  //final int qButtonWinn = 575;
  //final int qButtonHinn = 75;

  //SoundBar Stats
  //final int sBX = width/2;
  //final float sBY =  height/3 * 1.1;
  //final int sBW = 1010;
  //final int sBH = 20;
  //final int sBWinn = 1000;
  //final int sBHinn = 10;

  //Soundslider Stats
  //int sSX = sBX + sBWinn/2;
  //final float sSY =  sBY;
  //final int sSW = 40;
  //final int sSH = 80;
  //final int sSWinn = 20;
  //final int sSHinn = 60;

  //BrightnessBar Stats
  //final int bBX = width/2;
  //final float bBY =  height/3 * 1.8;
  //final int bBW = 1010;
  //final int bBH = 20;
  //final int bBWinn = 1000;
  //final int bBHinn = 10;

  //BrightnessSlider Stats
  //int bSX = bBX + bBWinn/2;
  //final float bSY =  bBY;
  //final int bSW = 40;
  //final int bSH = 80;
  //final int bSWinn = 20;
  //final int bSHinn = 60;

  //Back button Stats
  //final int bButtonX = width/2;
  //final float bButtonY =  height/3 * 2.3;
  //final int bButtonW = 600;
  //final int bButtonH = 100;
  //final int bButtonWinn = 575;
  //final int bButtonHinn = 75;

  //Left Cursor Stats
  //final float lcX = staButtonX - 400;
  //final float lcY = staButtonY;
  //final float lcH = 20;
  //final float lcW = 80;

  //Right Cursor Stats
  //final float rcX = staButtonX + 400;
  //final float rcY = staButtonY;
  //final float rcH = 20;
  //final float rcW = 80;

  int countCursor = 0;

  boolean StartGame = true;      //Mainscreen status
  boolean HighGame = false;      //Highscorescreen status
  boolean AchGame = false;       //Achievementscreen status
  boolean SettingGame = false;   //Settingscreen status

  boolean CursorStart = true;      //Cursor to start the game status
  boolean CursorHigh = false;      //Cursor to go to highscorescreen status
  boolean CursorHighBack = false;  //Cursor to go back to mainscreen status
  boolean CursorAch = false;       //Cursor to go to achievementscreen status
  boolean CursorAchBack = false;   //Cursor to go back to highscorescreen status
  boolean CursorSetting = false;   //Cursor to go to settingscreen status
  boolean CursorQuit = false;      //Cursor to quit the game status
  boolean CursorSound = false;     //Cursor to select soundbar status
  boolean CursorBright = false;    //Cursor to select brightnessbar status
  boolean CursorBack = false;      //Cursor to go back to mainscreen status

  boolean goLeft;    //      -direction of player movement
  boolean goRight;   //      -direction of player movement
  boolean goUp;      //      -direction of player movement
  boolean goDown;    //      -direction of player movement
  boolean isShooting;  //whether the player is shooting or not

  float soundDigit;        //Number shown underneath soundbar
  float soundBright;       //Nubershown underneath brightnessbar
  final int cTimer = 10;         //Cursor timer to count how many seconds a button is pressed
  final float achS = 40;         //Size for the achievements


  //Font
  void font() {
    PFont font;                                      //Selects font
    font = createFont("PressStart2P.ttf", 64);       //font
    textFont(font);
  }

  void startScreen() {
    maintheme.play();                    //Main menu theme song
    if (StartGame) {                     //Main start screen
      bgm.mute();                                  
      dbqueries.getHighScores = false;
      //Titel
      fill(255);
      textSize(titelvar.textSizeTitel);
      textAlign(CENTER);
      text("Galaxy Conqueror", titelvar.titelX, titelvar.titelY);

      //Start button
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX, titelvar.pos1Y, titelvar.buttonW, titelvar.buttonH);
      fill(0);
      rect(titelvar.posX, titelvar.pos1Y, titelvar.buttonWinn, titelvar.buttonHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text("Start", titelvar.posX, titelvar.pos1Y + titelvar.textButtonOffset);

      //Highscore button
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX, titelvar.pos2Y, titelvar.buttonW, titelvar.buttonH);
      fill(0);
      rect(titelvar.posX, titelvar.pos2Y, titelvar.buttonWinn, titelvar.buttonHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text("Highscores", titelvar.posX, titelvar.pos2Y + titelvar.textButtonOffset);

      //Settings Button
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX, titelvar.pos3Y, titelvar.buttonW, titelvar.buttonH);
      fill(0);
      rect(titelvar.posX, titelvar.pos3Y, titelvar.buttonWinn, titelvar.buttonHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text("Settings", titelvar.posX, titelvar.pos3Y + titelvar.textButtonOffset);

      //Quit button
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX, titelvar.pos4Y, titelvar.buttonW, titelvar.buttonH);
      fill(0);
      rect(titelvar.posX, titelvar.pos4Y, titelvar.buttonWinn, titelvar.buttonHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text("Quit", titelvar.posX, titelvar.pos4Y + titelvar.textButtonOffset);

      //Cursor
      if (CursorStart) {
        rectMode(CENTER);
        rect(titelvar.posX - titelvar.cursorOffset, titelvar.pos1Y, titelvar.cursorW, titelvar.cursorH);
        rect(titelvar.posX + titelvar.cursorOffset, titelvar.pos1Y, titelvar.cursorW, titelvar.cursorH);
        if (keyPressed) {
          if (player.isShooting) {
            StartGame = false;
            startGame = true;
            maintheme.rewind();
            maintheme.mute();
            maintheme.pause();
            if (startGame) {
              bgm.rewind();
              bgm.unmute();
              bgm.play();
            }
          }
          if (player.goDown) {
            countCursor = 0;
            countCursor ++;
            CursorStart = false;
            CursorHigh = true;
          }
        }
      } else if (CursorHigh) {
        rectMode(CENTER);
        rect(titelvar.posX - titelvar.cursorOffset, titelvar.pos2Y, titelvar.cursorW, titelvar.cursorH);
        rect(titelvar.posX + titelvar.cursorOffset, titelvar.pos2Y, titelvar.cursorW, titelvar.cursorH);
        if (keyPressed) {
          if (player.isShooting) {
            countCursor ++;
            if (countCursor >= cTimer) {
              countCursor = 0;
              StartGame = false;
              HighGame = true;
              CursorAch = true;
            }
          }
          if (player.goDown) {
            countCursor ++;
            if (countCursor >= cTimer) {
              countCursor = 0;
              CursorHigh = false;
              CursorSetting = true;
            }
          } else if (player.goUp) {
            countCursor ++;
            if (countCursor >= cTimer) {
              countCursor = 0;
              CursorHigh = false;
              CursorStart = true;
            }
          }
        }
      } else if (CursorSetting) {
        rectMode(CENTER);
        rect(titelvar.posX - titelvar.cursorOffset, titelvar.pos3Y, titelvar.cursorW, titelvar.cursorH);
        rect(titelvar.posX + titelvar.cursorOffset, titelvar.pos3Y, titelvar.cursorW, titelvar.cursorH);
        if (keyPressed) {
          if (player.isShooting) {
            countCursor ++;
            if (countCursor >= cTimer) {
              countCursor = 0;
              StartGame = false;
              SettingGame = true;
              CursorSound = true;
            }
          }
          if (player.goDown) {
            countCursor ++;
            if (countCursor >= cTimer) {
              countCursor = 0;
              CursorSetting = false;
              CursorQuit = true;
            }
          } else if (player.goUp) {
            countCursor ++;
            if (countCursor >= cTimer) {
              countCursor = 0;
              CursorSetting = false;
              CursorHigh = true;
            }
          }
        }
      } else if (CursorQuit) {
        rectMode(CENTER);
        rect(titelvar.posX - titelvar.cursorOffset, titelvar.pos4Y, titelvar.cursorW, titelvar.cursorH);
        rect(titelvar.posX + titelvar.cursorOffset, titelvar.pos4Y, titelvar.cursorW, titelvar.cursorH);
        if (keyPressed) {
          if (player.isShooting) {
            exit();
          } else if (player.goUp) {
            countCursor ++;
            CursorQuit = false;
            CursorSetting = true;
          }
        }
      }
    } else if (HighGame) {
      bgm.mute();

      fill(255);
      rect(width/2, height/2-100, 700, 700);
      fill(0);
      rect(width/2, height/2-100, 690, 690);
      fill(255);
      textSize(titelvar.textSizeButton);
      textAlign(CENTER);
      text("Highscores", width/2, 160);
      highscore.DisplayHighScore();


      //Back button
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX+titelvar.buttonW/4+20, titelvar.pos4Y, titelvar.buttonW/2+5, titelvar.buttonH);
      fill(0);
      rect(titelvar.posX+titelvar.buttonW/4+20, titelvar.pos4Y, titelvar.buttonWinn/2, titelvar.buttonHinn);
      fill(255);
      textSize(20);
      text("Back", titelvar.posX+titelvar.buttonW/4+20, titelvar.pos4Y + 10);

      //Achievement button
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX-titelvar.buttonW/4-20, titelvar.pos4Y, titelvar.buttonW/2+5, titelvar.buttonH);
      fill(0);
      rect(titelvar.posX-titelvar.buttonW/4-20, titelvar.pos4Y, titelvar.buttonWinn/2, titelvar.buttonHinn);
      fill(255);
      textSize(20);
      text("Achievements", titelvar.posX-titelvar.buttonW/4-20, titelvar.pos4Y + 10);

      //Cursor
      if (CursorAch) {
        rectMode(CENTER);
        rect(titelvar.posX-titelvar.buttonW/4-20, titelvar.pos4Y+80, 200, 20);
        if (player.nextWeapon) {
          countCursor ++;
          if (countCursor >= cTimer) {
            countCursor = 0;
            HighGame = false;
            StartGame = true;
          }
        }
        if (player.isShooting) {
          countCursor ++;
          if (countCursor >= cTimer) {
            HighGame = false;
            AchGame = true;
            countCursor = 0;
          }
        }
        if (player.goRight) {
          countCursor++;
          if (countCursor > cTimer) {
            countCursor = 0;
            CursorAch = false;
            CursorHighBack = true;
          }
        }
      }
      if (CursorHighBack) {
        rectMode(CENTER);
        rect(titelvar.posX+titelvar.buttonW/4+20, titelvar.pos4Y+80, 200, 20);
        if (player.nextWeapon) {
          countCursor ++;
          if (countCursor >= cTimer) {
            countCursor = 0;
            HighGame = false;
            StartGame = true;
            CursorHighBack = false;
          }
        }
        if (player.isShooting) {
          countCursor ++;
          if (countCursor >= cTimer) {
            countCursor = 0;
            HighGame = false;
            StartGame = true;
            CursorHighBack = false;
          }
        }
        if (player.goLeft) {
          countCursor++;
          if (countCursor > cTimer) {
            countCursor = 0;
            CursorAch = true;
            CursorHighBack = false;
          }
        }
      }
    } else if (AchGame) {
      bgm.mute();

      fill(255);
      rect(width/2, height/2-60, 1500, 850);
      fill(0);
      rect(width/2, height/2-60, 1490, 840);
      fill(255);
      textSize(titelvar.textSizeButton);
      textAlign(CENTER);
      text("Achievements", width/2, 110);
      image(ach1, width/2-650, 300, achS, achS);
      image(ach2, width/2-650, 364, achS, achS);
      image(ach3, width/2-650, 428, achS, achS);
      image(ach4, width/2-650, 492, achS, achS);
      image(ach5, width/2-650, 556, achS, achS);
      image(ach6, width/2-650, 620, achS, achS);
      image(ach7, width/2-650, 684, achS, achS);
      image(ach8, width/2-650, 748, achS, achS);
      image(ach9, width/2-650, 812, achS, achS);
      image(ach10, width/2-650, 876, achS, achS);
      //image(ach11,width/2-650,918,30,30);
      image(ach12, width/2-650, 940, achS, achS);
      image(ach13, width/2-650, 1004, achS, achS);
      achievements.DisplayAch();


      //Back button
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX, titelvar.pos4Y, titelvar.buttonW, titelvar.buttonH);
      fill(0);
      rect(titelvar.posX, titelvar.pos4Y, titelvar.buttonWinn, titelvar.buttonHinn);
      fill(255);
      textSize(20);
      textAlign(CENTER);
      text("Back", titelvar.posX, titelvar.pos4Y + 10);
      rect(titelvar.posX - titelvar.cursorOffset, titelvar.pos4Y, titelvar.cursorW, titelvar.cursorH);
      rect(titelvar.posX + titelvar.cursorOffset, titelvar.pos4Y, titelvar.cursorW, titelvar.cursorH);

      if (player.nextWeapon) {
        countCursor ++;
        if (countCursor >= cTimer) {
          countCursor = 0;
          AchGame = false;
          HighGame = true;
        }
      }
      if (player.isShooting) {
        countCursor ++;
        if (countCursor >= cTimer) {
          countCursor = 0;
          HighGame = true;
          AchGame = false;
        }
      }
    } else if (SettingGame) {
      bgm.mute();

      //float sSx = constrain(titelvar.sliderX, titelvar.sliderX-titelvar.barWinn/2, titelvar.sliderX+titelvar.barWinn/2);
      //float bSx = constrain(titelvar.sliderX, titelvar.sliderX-titelvar.barWinn/2, titelvar.sliderX+titelvar.barWinn/2);

      float soundDigit = int(dist(titelvar.posX - titelvar.barW/2, titelvar.pos1Y, titelvar.sliderSoundX, titelvar.pos1Y)/10);
      if (soundDigit > 100) {
        soundDigit = 100;
      }

      float soundVolume = soundDigit / 100;

      float brightDigit = int(dist(titelvar.posX - titelvar.barW/2, titelvar.pos2Y, titelvar.sliderBrightX, titelvar.pos2Y)/10);
      if (brightDigit > 100) {
        brightDigit = 100;
      }

      //Soundbar
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX, titelvar.pos1Y, titelvar.barW, titelvar.barH);
      fill(0);
      rect(titelvar.posX, titelvar.pos1Y, titelvar.barWinn, titelvar.barHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text("Sound level", titelvar.posX, titelvar.pos1Y - 80);

      //Soundslider
      rectMode(CENTER);
      fill(255);
      rect(titelvar.sliderSoundX, titelvar.pos1Y, titelvar.sliderW, titelvar.sliderH);
      fill(0);
      rect(titelvar.sliderSoundX, titelvar.pos1Y, titelvar.sliderWinn, titelvar.sliderHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text(int(soundDigit), titelvar.sliderSoundX, titelvar.pos1Y + 80);

      //Brightnessbar
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX, titelvar.pos2Y, titelvar.barW, titelvar.barH);
      fill(0);
      rect(titelvar.posX, titelvar.pos2Y, titelvar.barWinn, titelvar.barHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text("Brightness", titelvar.posX, titelvar.pos2Y - 80);

      //Brightnessslider
      rectMode(CENTER);
      fill(255);
      rect(titelvar.sliderBrightX, titelvar.pos2Y, titelvar.sliderW, titelvar.sliderH);
      fill(0);
      rect(titelvar.sliderBrightX, titelvar.pos2Y, titelvar.sliderWinn, titelvar.sliderHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text(int(brightDigit), titelvar.sliderBrightX, titelvar.pos2Y + 80);


      //Back button
      rectMode(CENTER);
      fill(255);
      rect(titelvar.posX, titelvar.pos4Y, titelvar.buttonW, titelvar.buttonH);
      fill(0);
      rect(titelvar.posX, titelvar.pos4Y, titelvar.buttonWinn, titelvar.buttonHinn);
      fill(255);
      textSize(titelvar.textSizeButton);
      text("Back", titelvar.posX, titelvar.pos4Y + 20);

      //Cursor
      if (CursorSound) {
        rectMode(CENTER);
        rect(titelvar.posX - titelvar.barW/2 - 70, titelvar.pos1Y, titelvar.cursorW, titelvar.cursorH);
        rect(titelvar.posX + titelvar.barW/2 + 70, titelvar.pos1Y, titelvar.cursorW, titelvar.cursorH);    
        if (keyPressed) {
          if (player.nextWeapon) {
            countCursor ++;
            if (countCursor >= cTimer) {
              countCursor = 0;
              SettingGame = false;
              StartGame = true;
            }
          }
          if (player.goLeft) {
            titelvar.sliderSoundX -= 10;
          } else if (player.goRight) {
            titelvar.sliderSoundX += 10;
          }
          if (player.goDown) {
            countCursor ++;
            CursorSound = false;
            CursorBright = true;
          }
        }
        if (titelvar.sliderSoundX > titelvar.posX + titelvar.barW/2) {
          titelvar.sliderSoundX = titelvar.posX + titelvar.barW/2;
        } else if (titelvar.sliderSoundX < titelvar.posX - titelvar.barW/2) {
          titelvar.sliderSoundX = titelvar.posX - titelvar.barW/2;
        }
      } else if (CursorBright) {
        rectMode(CENTER);
        rect(titelvar.posX - titelvar.barW/2 - 70, titelvar.pos2Y, titelvar.cursorW, titelvar.cursorH);
        rect(titelvar.posX + titelvar.barW/2 + 70, titelvar.pos2Y, titelvar.cursorW, titelvar.cursorH);
        if (keyPressed) {
          if (player.goLeft) {
            titelvar.sliderBrightX -= 10;
          } else if (player.goRight) {
            titelvar.sliderBrightX += 10;
          }
          if (player.goDown) {
            countCursor ++;
            if (countCursor >= cTimer) {
              countCursor = 0;
              CursorBright = false;
              CursorBack = true;
            }
          } else if (player.goUp) {
            countCursor ++;
            if (countCursor >= 12) {
              countCursor = 0;
              CursorBright = false;
              CursorSound = true;
            }
          }
        }
        if (titelvar.sliderBrightX > titelvar.posX + titelvar.barW/2) {
          titelvar.sliderBrightX = titelvar.posX + titelvar.barW/2;
        } else if (titelvar.sliderBrightX < titelvar.posX - titelvar.barW/2) {
          titelvar.sliderBrightX = titelvar.posX - titelvar.barW/2;
        }
      } else if (CursorBack) {
        rectMode(CENTER);
        rect(titelvar.posX - titelvar.cursorOffset, titelvar.pos4Y, titelvar.cursorW, titelvar.cursorH);
        rect(titelvar.posX + titelvar.cursorOffset, titelvar.pos4Y, titelvar.cursorW, titelvar.cursorH);
        if (player.isShooting) {
          SettingGame = false;
          StartGame = true;
          countCursor = 0;
        }
        if (keyPressed) {
          if (player.goUp) {
            countCursor ++;
            CursorBack = false;
            CursorBright = true;
          }
        }
      }
    }
  }
  void bright() {
    float bright = dist(titelvar.posX+titelvar.barW/2, titelvar.pos2Y, titelvar.sliderBrightX, titelvar.pos2Y)/4.2;
    fill(0, 0, 0, bright);
    rectMode(CENTER);
    rect(width/2, height/2, width, height);
  }
}
