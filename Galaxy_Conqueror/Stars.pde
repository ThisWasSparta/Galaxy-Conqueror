//This class was written by Lucas van Wonderen
class BackgroundStars {
  float x;
  float y;
  float yspeed = random(1, 5);
  float rad;
  float tran = random(0, 255);

  BackgroundStars () {
    //Locatie en grootte
    x = random(0, width);
    y = random(0, height);
    rad = random(1, 10);
  }
  void show() {
    //Sterren showen
    fill(255, 255, 255, tran);
    noStroke();
    square(x, y, rad);
    y = y + yspeed;
    if (y > height) {
      y = -5;
      x = random(0, width);
    }
  }
  
  void starsAndStartMenu() {      //This function was written by Lucas van Wonderen
    //Sterren tekenen
    for (int i = 0; i < starsNumber; i ++) {    //this for loop draws the stars on the background
      Star[i].show();
    }
    if (!startGame) {                           //this if-statement draws the menu if the game hasn't started yet
      //Titel
      titel.textShow();
      //Start button
      titel.startGame();
      titel.settingGame();
      titel.quitGame();
    }
  }
}
