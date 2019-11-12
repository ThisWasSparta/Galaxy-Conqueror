//This class was written by Lucas van Wonderen

class Titel {
  // Main titel
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

  //Font
  void font() {
    PFont font;
    font = createFont("PressStart2P.ttf", 64);
    textFont(font);
  }
  //Titel
  void textShow() {
    fill(255);
    textSize(textSize);
    textAlign(CENTER);
    text("Galaxy Conquerer", titelX, titelY);
  }
  //Start Button
  void startGame() {
    rectMode(CENTER);
    fill(255);
    rect(staButtonX, staButtonY, staButtonW, staButtonH);
    fill(0);
    rect(staButtonX, staButtonY, staButtonWinn, staButtonHinn);
    fill(255);
    textSize(textSizebut);
    text("Start", staButtonX, staButtonY + 20);
  }
  //Settings Button
  void settingGame() {
    rectMode(CENTER);
    fill(255);
    rect(setButtonX, setButtonY, setButtonW, setButtonH);
    fill(0);
    rect(setButtonX, setButtonY, setButtonWinn, setButtonHinn);
    fill(255);
    textSize(textSizebut);
    text("Settings", setButtonX, setButtonY + 20);
  }
  //Quit Button
  void quitGame() {
    rectMode(CENTER);
    fill(255);
    rect(qButtonX, qButtonY, qButtonW, qButtonH);
    fill(0);
    rect(qButtonX, qButtonY, qButtonWinn, qButtonHinn);
    fill(255);
    textSize(textSizebut);
    text("Quit", qButtonX, qButtonY + 20);
  }
}
