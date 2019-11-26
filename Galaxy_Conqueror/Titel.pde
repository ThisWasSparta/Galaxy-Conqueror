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

  // Settings Button
  int setButtonX = width/2;
  float setButtonY =  height/3 * 1.8;
  int setButtonW = 600;
  int setButtonH = 100;
  int setButtonWinn = 575;
  int setButtonHinn = 75;

  // Quit Button
  int qButtonX = width/2;
  float qButtonY =  height/3 * 2.3;
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
  boolean SettingGame = false;

  boolean CursorStart = true;
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


  //Font
  void font() {
    PFont font;
    font = createFont("PressStart2P.ttf", 64);
    textFont(font);
  }

  void startScreen() {
    if (StartGame) {

      //Titel
      fill(255);
      textSize(textSize);
      textAlign(CENTER);
      text("Galaxy Conquerer", titelX, titelY);

      //Start button
      rectMode(CENTER);
      fill(255);
      rect(staButtonX, staButtonY, staButtonW, staButtonH);
      fill(0);
      rect(staButtonX, staButtonY, staButtonWinn, staButtonHinn);
      fill(255);
      textSize(textSizebut);
      text("Start", staButtonX, staButtonY + 20);

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
        if (keyPressed) {
          if (player.isShooting) {
            StartGame = false;
            startGame = true;
          }
          if (player.goDown) {
            countCursor ++;
            CursorStart = false;
            CursorSetting = true;
          }
        }
      } else if (CursorSetting) {
        rectMode(CENTER);
        rect(lcX, setButtonY, lcW, lcH);
        rect(rcX, setButtonY, rcW, rcH);
        if (keyPressed) {
          if (player.isShooting) {
            countCursor ++;
            if (countCursor >= 9) {
              countCursor = 0;
              StartGame = false;
              SettingGame = true;
              CursorSound = true;
            }
          }
          if (player.goDown) {
            countCursor ++;
            if (countCursor >= 12) {
              countCursor = 0;
              CursorSetting = false;
              CursorQuit = true;
            }
          } else if (player.goUp) {
            countCursor ++;
            if (countCursor >= 12) {
              countCursor = 0;
              CursorSetting = false;
              CursorStart = true;
            }
          }
        }
      } else if (CursorQuit) {
        rectMode(CENTER);
        rect(lcX, qButtonY, lcW, lcH);
        rect(rcX, qButtonY, rcW, rcH);
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
    } else if (SettingGame) {

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
            if (countCursor >= 12) {
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
    float bright = dist(bBX+bBW/2, bBY, bSX, bSY)/5;
    fill(0, 0, 0, bright);
    rectMode(CENTER);
    rect(width/2, height/2, width, height);
  }
}
