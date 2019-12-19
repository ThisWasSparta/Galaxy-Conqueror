class Titel {

  // Main titel180
  int textSize = 70;
  int textSizebut = 35;
  int titelX = width/2;
  int titelY = height/3;

  //Start Button
  int staButtonX = width/2;
  float staButtonY =  height/3 * 1.3;
  int staButtonW = 600;
  int staButtonH = 100;
  int staButtonWinn = 575;
  int staButtonHinn = 75;

  //highscore Button
  int hiButtonX = width/2;
  float hiButtonY =  height/3 * 1.7;
  int hiButtonW = 600;
  int hiButtonH = 100;
  int hiButtonWinn = 575;
  int hiButtonHinn = 75;

  // Settings Button
  int setButtonX = width/2;
  float setButtonY =  height/3 * 2.1;
  int setButtonW = 600;
  int setButtonH = 100;
  int setButtonWinn = 575;
  int setButtonHinn = 75;

  // Quit Button
  int qButtonX = width/2;
  float qButtonY =  height/3 * 2.5;
  int qButtonW = 600;
  int qButtonH = 100;
  int qButtonWinn = 575;
  int qButtonHinn = 75;

  //SoundBar
  int sBX = width/2;
  float sBY =  height/3 * 1.1;
  int sBW = 1010;
  int sBH = 20;
  int sBWinn = 1000;
  int sBHinn = 10;

  //Soundslider
  int sSX = sBX + sBWinn/2;
  float sSY =  sBY;
  int sSW = 40;
  int sSH = 80;
  int sSWinn = 20;
  int sSHinn = 60;

  //BrightnessBar
  int bBX = width/2;
  float bBY =  height/3 * 1.8;
  int bBW = 1010;
  int bBH = 20;
  int bBWinn = 1000;
  int bBHinn = 10;

  //BrightnessSlider
  int bSX = bBX + bBWinn/2;
  float bSY =  bBY;
  int bSW = 40;
  int bSH = 80;
  int bSWinn = 20;
  int bSHinn = 60;

  //Back button
  int bButtonX = width/2;
  float bButtonY =  height/3 * 2.3;
  int bButtonW = 600;
  int bButtonH = 100;
  int bButtonWinn = 575;
  int bButtonHinn = 75;

  //Left Cursor
  float lcX = staButtonX - 400;
  float lcY = staButtonY;
  float lcH = 20;
  float lcW = 80;

  //Right Cursor
  float rcX = staButtonX + 400;
  float rcY = staButtonY;
  float rcH = 20;
  float rcW = 80;

  int countCursor = 0;

  boolean StartGame = true;
  boolean HighGame = false;
  boolean AchGame = false;
  boolean SettingGame = false;

  boolean CursorStart = true;
  boolean CursorHigh = false;
  boolean CursorHighBack = false;
  boolean CursorAch = false;
  boolean CursorAchBack = false;
  boolean CursorSetting = false;
  boolean CursorQuit = false;
  boolean CursorSound = false;
  boolean CursorBright = false;
  boolean CursorBack = false;

  boolean goLeft;    //  \
  boolean goRight;   //   \
  boolean goUp;      //    \
  boolean goDown;    //     -direction of player movement
  boolean isShooting;  //whether the player is shooting or not

  float soundDigit;
  float soundBright;
  int cTimer = 9;
  
  PImage ach1;
  PImage ach2;
  PImage ach3;
  PImage ach4;
  PImage ach5;
  PImage ach6;
  PImage ach7;
  PImage ach8;
  PImage ach9;
  PImage ach10;
  PImage ach11;
  PImage ach12;
  PImage ach13;
  PImage ach14;
  
  float achS = 40;


  //Font
  void font() {
    PFont font;
    font = createFont("PressStart2P.ttf", 64);
    textFont(font);
  }

  void startScreen() {
    maintheme.play();
    if (StartGame) {

      dbqueries.getHighScores = false;
      playergatshoot.mute();
      //Titel
      fill(255);
      textSize(textSize);
      textAlign(CENTER);
      text("Galaxy Conqueror", titelX, titelY);

      //Start button
      rectMode(CENTER);
      fill(255);
      rect(staButtonX, staButtonY, staButtonW, staButtonH);
      fill(0);
      rect(staButtonX, staButtonY, staButtonWinn, staButtonHinn);
      fill(255);
      textSize(textSizebut);
      text("Start", staButtonX, staButtonY + 20);

      //Highscore button
      rectMode(CENTER);
      fill(255);
      rect(hiButtonX, hiButtonY, hiButtonW, hiButtonH);
      fill(0);
      rect(hiButtonX, hiButtonY, hiButtonWinn, hiButtonHinn);
      fill(255);
      textSize(textSizebut);
      text("Highscores", hiButtonX, hiButtonY + 20);

      //Settings Button
      rectMode(CENTER);
      fill(255);
      rect(setButtonX, setButtonY, setButtonW, setButtonH);
      fill(0);
      rect(setButtonX, setButtonY, setButtonWinn, setButtonHinn);
      fill(255);
      textSize(textSizebut);
      text("Settings", setButtonX, setButtonY + 20);

      //Quit button
      rectMode(CENTER);
      fill(255);
      rect(qButtonX, qButtonY, qButtonW, qButtonH);
      fill(0);
      rect(qButtonX, qButtonY, qButtonWinn, qButtonHinn);
      fill(255);
      textSize(textSizebut);
      text("Quit", qButtonX, qButtonY + 20);

      //Cursor
      if (CursorStart) {
        rectMode(CENTER);
        rect(lcX, staButtonY, lcW, lcH);
        rect(rcX, staButtonY, rcW, rcH);
        textSize(20);
        textAlign(CENTER);
        text("PRESS B", lcX - width * 0.1, staButtonY);
        if (keyPressed) {
          if (player.isShooting) {
            StartGame = false;
            startGame = true;
            maintheme.mute();
            bgm.play();
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
        rect(lcX, hiButtonY, lcW, lcH);
        rect(rcX, hiButtonY, rcW, rcH);
        textSize(20);
        textAlign(CENTER);
        text("PRESS B", lcX - width * 0.1, hiButtonY);
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
        rect(lcX, setButtonY, lcW, lcH);
        rect(rcX, setButtonY, rcW, rcH);
        textSize(20);
        textAlign(CENTER);
        text("PRESS B", lcX - width * 0.1, setButtonY);
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
        rect(lcX, qButtonY, lcW, lcH);
        rect(rcX, qButtonY, rcW, rcH);
        textSize(20);
        textAlign(CENTER);
        text("PRESS B", lcX - width * 0.1, qButtonY);
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

      playergatshoot.mute();

      fill(255);
      rect(width/2, height/2-100, 700, 700);
      fill(0);
      rect(width/2, height/2-100, 690, 690);
      fill(255);
      textSize(textSizebut);
      textAlign(CENTER);
      text("Highscores", width/2, 160);
      highscore.DisplayHighScore();


      //Back button
      rectMode(CENTER);
      fill(255);
      rect(qButtonX+bButtonW/4+20, qButtonY, bButtonW/2+5, bButtonH);
      fill(0);
      rect(qButtonX+bButtonW/4+20, qButtonY, bButtonWinn/2, bButtonHinn);
      fill(255);
      textSize(20);
      text("Back", qButtonX+bButtonW/4+20, qButtonY + 10);

      //Achievement button
      rectMode(CENTER);
      fill(255);
      rect(qButtonX-bButtonW/4-20, qButtonY, bButtonW/2+5, bButtonH);
      fill(0);
      rect(qButtonX-bButtonW/4-20, qButtonY, bButtonWinn/2, bButtonHinn);
      fill(255);
      textSize(20);
      text("Achievements", qButtonX-bButtonW/4-20, qButtonY + 10);

      //Cursor
      if (CursorAch) {
        rectMode(CENTER);
        rect(qButtonX-bButtonW/4-20, qButtonY+80, 200, 20);
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
        rect(qButtonX+bButtonW/4+20, qButtonY+80, 200, 20);
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

      playergatshoot.mute();

      fill(255);
      rect(width/2, height/2-60, 1500, 850);
      fill(0);
      rect(width/2, height/2-60, 1490, 840);
      fill(255);
      textSize(textSizebut);
      textAlign(CENTER);
      text("Achievements", width/2, 110);
      achievements.DisplayAch();
      ach1 = loadImage("./1kill.png");
      ach2 = loadImage("./50kill.png");
      ach3 = loadImage("./100kill.png");
      ach4 = loadImage("./500kill.png");
      ach5 = loadImage("./1kkill.png");
      ach6 = loadImage("./10kkill.png");
      ach7 = loadImage("./jack.png");
      ach8 = loadImage("./master.png");
      ach9 = loadImage("./diehard.png");
      ach10 = loadImage("./eternity.png");
      ach11 = loadImage("./1die.png");
      ach12 = loadImage("./loser.png");
      ach13 = loadImage("./killboss.png");
      ach14 = loadImage("./killboss3.png");
      image(ach1,width/2-650,150,achS,achS);
      image(ach2,width/2-650,214,achS,achS);
      image(ach3,width/2-650,278,achS,achS);
      image(ach4,width/2-650,342,achS,achS);
      image(ach5,width/2-650,406,achS,achS);
      image(ach6,width/2-650,470,achS,achS);
      image(ach7,width/2-650,534,achS,achS);
      image(ach8,width/2-650,598,achS,achS);
      image(ach9,width/2-650,662,achS,achS);
      image(ach10,width/2-650,726,achS,achS);
      image(ach12,width/2-650,790,achS,achS);
      image(ach13,width/2-650,854,achS,achS);
      //image(ach11,width/2-650,918,30,30);


      //Back button
      rectMode(CENTER);
      fill(255);
      rect(qButtonX, qButtonY+100, bButtonW, bButtonH);
      fill(0);
      rect(qButtonX, qButtonY+100, bButtonWinn, bButtonHinn);
      fill(255);
      textSize(20);
      textAlign(CENTER);
      text("Back", qButtonX, qButtonY + 110);
      rect(lcX, qButtonY+100, lcW, lcH);
      rect(rcX, qButtonY+100, rcW, rcH);

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

      playergatshoot.mute();


      float sSx = constrain(sSX, sBX-sBWinn/2, sBX+sBWinn/2);
      float bSx = constrain(bSX, bBX-bBWinn/2, bBX+bBWinn/2);

      float soundDigit = int(dist(sBX - sBW/2, sBY, sSX, sSY)/10);
      if (soundDigit > 100) {
        soundDigit = 100;
      }

      float soundVolume = soundDigit / 100;

      float brightDigit = int(dist(bBX - bBW/2, bBY, bSX, bSY)/10);
      if (brightDigit > 100) {
        brightDigit = 100;
      }

      //Soundbar
      rectMode(CENTER);
      fill(255);
      rect(sBX, sBY, sBW, sBH);
      fill(0);
      rect(sBX, sBY, sBWinn, sBHinn);
      fill(255);
      textSize(textSizebut);
      text("Sound level", sBX, sBY - 80);

      //Soundslider
      rectMode(CENTER);
      fill(255);
      rect(sSx, sSY, sSW, sSH);
      fill(0);
      rect(sSx, sSY, sSWinn, sSHinn);
      fill(255);
      textSize(textSizebut);
      text(int(soundDigit), sSX, sSY + 80);

      //Brightnessbar
      rectMode(CENTER);
      fill(255);
      rect(bBX, bBY, bBW, bBH);
      fill(0);
      rect(bBX, bBY, bBWinn, bBHinn);
      fill(255);
      textSize(textSizebut);
      text("Brightness", bBX, bBY - 80);

      //Brightnessslider
      rectMode(CENTER);
      fill(255);
      rect(bSx, bSY, bSW, bSH);
      fill(0);
      rect(bSx, bSY, bSWinn, bSHinn);
      fill(255);
      textSize(textSizebut);
      text(int(brightDigit), bSX, bSY + 80);


      //Back button
      rectMode(CENTER);
      fill(255);
      rect(bButtonX, bButtonY, bButtonW, bButtonH);
      fill(0);
      rect(bButtonX, bButtonY, bButtonWinn, bButtonHinn);
      fill(255);
      textSize(textSizebut);
      text("Back", bButtonX, bButtonY + 20);

      //Cursor
      if (CursorSound) {
        rectMode(CENTER);
        rect(sBX - sBW/2 - 70, sBY, lcW, lcH);
        rect(sBX + sBW/2 + 70, sBY, rcW, rcH);    
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
            sSX -= 10;
          } else if (player.goRight) {
            sSX += 10;
          }
          if (player.goDown) {
            countCursor ++;
            CursorSound = false;
            CursorBright = true;
          }
        }
        if (sSX > sBX + sBW/2) {
          sSX = sBX + sBW/2;
        } else if (sSX < sBX - sBW/2) {
          sSX = sBX - sBW/2;
        }
      } else if (CursorBright) {
        rectMode(CENTER);
        rect(sBX - sBW/2 - 70, bBY, lcW, lcH);
        rect(sBX + sBW/2 + 70, bBY, rcW, rcH);
        if (keyPressed) {
          if (player.goLeft) {
            bSX -= 10;
          } else if (player.goRight) {
            bSX += 10;
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
        if (bSX > bBX + bBW/2) {
          bSX = bBX + bBW/2;
        } else if (bSX < bBX - bBW/2) {
          bSX = bBX - bBW/2;
        }
      } else if (CursorBack) {
        rectMode(CENTER);
        rect(lcX, bButtonY, lcW, lcH);
        rect(rcX, bButtonY, rcW, rcH);
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
    float bright = dist(bBX+bBW/2, bBY, bSX, bSY)/4.2;
    fill(0, 0, 0, bright);
    rectMode(CENTER);
    rect(width/2, height/2, width, height);
  }
}
