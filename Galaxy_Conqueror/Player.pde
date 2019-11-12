//This class was made by Noah Verburg
class SpaceShip {
  boolean goLeft;    //  \
  boolean goRight;   //   \
  boolean goUp;      //    \
  boolean goDown;    //     -direction of player movement
  
  boolean isShooting;  //whether the player is shooting or not
  
  boolean testBoolean;
  
  boolean stop;
  
  float pW;    //player width
  float pH;    //player height
  float pV;    //player velocity
  float pX;    //player X-position
  float pY;    //player Y-position
  float defaultPlayerWidth = 128 * sizeFactor;
  float defaultPlayerHeight = 118 * sizeFactor;
  float playerVelocityFactor = 0.006;   //factor which is used to get the desired player velocity compared to the width of the screen
  
  int weapon = 1;
  int weaponState = 1;
  int skinCycle = 0;
  
  PImage weapon1;                       //weapon1, weapon2 and weapon3 are the sprites for the player depending on what gun they are using
  PImage weapon2;
  PImage weapon3;
  
  boolean setAction(int k, boolean b){    //this boolean function detects the input of keys, and makes the other booleans true or false accordingly
    switch (k) {
    case 'w':
      return goUp = b;
    
    case 'a':
      return goLeft = b;
   
    case 's':
      return goDown = b;
   
    case 'd':
      return goRight = b;
   
   case 'j':
      return isShooting = b;
   case 't':
     return stop = b;
   case 'k':
     return testBoolean = b;
    default:
      return b;
    }
  }
  
  void player() {          //this code detects what weapon the player is currently using
    if (weapon == 1) {
      image(weapon1, pX, pY, pW, pH);
    }
    if (weapon == 2) {
      image(weapon2, pX, pY, pW, pH);
    }
    if (weapon == 3) {
      image(weapon3, pX, pY, pW, pH);
    }
    if (weaponState == 3) {
      weapon1 = loadImage("Spaceship Weapon 1-3.png");
      if (frameCount - skinCycle > 30) {weaponState = 1; skinCycle = frameCount;}
    }
    if (weaponState == 2) {
      weapon1 = loadImage("Spaceship Weapon 1-2.png");
      if (frameCount - skinCycle > 20) {weaponState = 3;}
    }
    if (weaponState == 1) {
      weapon1 = loadImage("Spaceship Weapon 1-1.png");
      if (frameCount - skinCycle > 10) {weaponState = 2;}
    }
  }
  
  void movement() {    //This function was written by Noah Verburg
    if (player.goLeft && player.pX > player.pW/2) {
      player.pX -= player.pV;
    }
    if (player.goRight && player.pX < width - player.pW/2) {
      player.pX += player.pV;
    }
    if (player.goUp && player.pY > height * 0.75) {
      player.pY -= player.pV;
    }
    if (player.goDown && player.pY < height/1.01 - player.pH/2) {
      player.pY += player.pV;
    }
  }
}
