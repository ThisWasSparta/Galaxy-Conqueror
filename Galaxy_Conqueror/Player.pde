//This class was made by Noah Verburg
class SpaceShip {
  boolean goLeft;    //  \
  boolean goRight;   //   \
  boolean goUp;      //    \
  boolean goDown;    //     -direction of player movement

  boolean isShooting;  //wether the player is shooting or not

  boolean testBoolean;

  boolean stop;  //used for debug stop button

  boolean nextWeapon;  //wether the button for the next weapon is pressed

  boolean exitgame;

  boolean suicide;

  final float DEFAULT_PLAYER_WIDTH = 128 * sizeFactor;
  final float DEFAULT_PLAYER_HEIGHT = 118 * sizeFactor;
  final float PLAYER_DEFAULT_VELOCITY_FACTOR = 0.006;            //Default velocity factor
  final float DEFAULT_WEAPON_WHEEL_SIZE = 198 * sizeFactor;
  float playerWidth;
  float playerHeight;
  float playerXvelocity = 0;
  float playerYvelocity = 0;
  float playerMaxVelocity = 0;
  float playerXposition;    //player X-position
  float playerYposition;    //player Y-position
  float playerVelocityFactor = PLAYER_DEFAULT_VELOCITY_FACTOR;   //factor which is used to get the desired player velocity compared to the width of the screen

  float weaponWheelX;
  float weaponWheelY;
  float weaponWheelSelectorX;
  float weaponWheelSelectorY;
  float weaponWheelSize;

  int weapon = 1;
  int weaponState = 1;
  int skinCycle = 0;
  int weaponCycleCooldown = 0;
  int damageFlashTint = 0;

  PImage weapon1;                       //weapon1, weapon2 and weapon3 are the sprites for the player depending on what gun they are using
  PImage weapon2;
  PImage weapon3;

  PImage weaponWheel;
  PImage weaponWheelSelector;

  void player() {          //this code detects what weapon the player is currently using
    if (weapon == 1) {
      if (player.damageFlashTint > 0) {
        tint(255, player.damageFlashTint, player.damageFlashTint);
        player.damageFlashTint -= 10;
      }
      image(weapon1, playerXposition + visuals.magnitudeX, playerYposition + visuals.magnitudeY, playerWidth, playerHeight);
      tint(255, 255, 255);
    }
    if (weapon == 2) {
      if (player.damageFlashTint > 0) {
        tint(255, player.damageFlashTint, player.damageFlashTint);
        player.damageFlashTint -= 10;
      }
      image(weapon2, playerXposition + visuals.magnitudeX, playerYposition + visuals.magnitudeY, playerWidth, playerHeight);
      tint(255, 255, 255);
    }
    if (weapon == 3) {
      if (player.damageFlashTint > 0) {
        tint(255, player.damageFlashTint, player.damageFlashTint);
        player.damageFlashTint -= 10;
      }
      image(weapon3, playerXposition + visuals.magnitudeX, playerYposition + visuals.magnitudeY, playerWidth, playerHeight);
      tint(255, 255, 255);
    }
    if (weaponState == 3) {
      weapon1 = loadImage("Spaceship Weapon 1-3.png");
      weapon2 = loadImage("Spaceship Weapon 2-3.png");
      weapon3 = loadImage("Spaceship Weapon 3-3.png");
      if (frameCount - skinCycle > 30) {
        weaponState = 1; 
        skinCycle = frameCount;
      }
    }
    if (weaponState == 2) {
      weapon1 = loadImage("Spaceship Weapon 1-2.png");
      weapon2 = loadImage("Spaceship Weapon 2-2.png");
      weapon3 = loadImage("Spaceship Weapon 3-2.png");
      if (frameCount - skinCycle > 20) {
        weaponState = 3;
      }
    }
    if (weaponState == 1) {
      weapon1 = loadImage("Spaceship Weapon 1-1.png");
      weapon2 = loadImage("Spaceship Weapon 2-1.png");
      weapon3 = loadImage("Spaceship Weapon 3-1.png");
      if (frameCount - skinCycle > 10) {
        weaponState = 2;
      }
    }
  }

  void playerUpdate() {    //This function was written by Noah Verburg
    if (player.goLeft || player.goRight || player.goUp || player.goDown) {
      if (player.goLeft && player.playerXposition > player.playerWidth/2) {
        if (player.playerXvelocity > -player.playerMaxVelocity ) {
          player.playerXvelocity -= 0.1 * playerMaxVelocity;
        }
      }
      if (player.goRight && player.playerXposition < width - player.playerWidth/2) {
        if (player.playerXvelocity < player.playerMaxVelocity ) {
          player.playerXvelocity += 0.1 * player.playerMaxVelocity;
        }
      }
      if (player.goUp && player.playerYposition > height * 0.75) {
        if (player.playerYvelocity > -player.playerMaxVelocity ) {
          player.playerYvelocity -= 0.1 * player.playerMaxVelocity;
        }
      }
      if (player.goDown && player.playerYposition < height/1.01 - player.playerHeight/2) {
        if (player.playerYvelocity < player.playerMaxVelocity ) {
          player.playerYvelocity += 0.1 * player.playerMaxVelocity;
        }
      }
    } else {
      if (player.playerXvelocity < 0) {
        player.playerXvelocity += 0.1 * playerMaxVelocity;
      }
      if (player.playerXvelocity > 0) {
        player.playerXvelocity -= 0.1 * playerMaxVelocity;
      }
      if (player.playerXvelocity < 0.99 && player.playerXvelocity > -0.09) {
        player.playerXvelocity = 0;
      }
      if (player.playerYvelocity < 0) {
        player.playerYvelocity += 0.1 * playerMaxVelocity;
      }
      if (player.playerYvelocity > 0 ) {
        player.playerYvelocity -= 0.1 * playerMaxVelocity;
      }
      if (player.playerYvelocity < 0.09 && player.playerYvelocity > -0.09) {
        player.playerYvelocity = 0;
      }
    }

    if (playerXvelocity < 0 && player.playerXposition < player.playerWidth/2) {
      playerXvelocity = 0;
    }
    if (playerXvelocity > 0 && player.playerXposition > width - player.playerWidth/2) {
      playerXvelocity = 0;
    }
    if (playerYvelocity < 0 && player.playerYposition < height * 0.75) {
      playerYvelocity = 0;
    }
    if (playerYvelocity > 0 && player.playerYposition > height/1.01 - player.playerHeight/2) {
      playerYvelocity = 0;
    }

    player.playerXposition += player.playerXvelocity;
    player.playerYposition += player.playerYvelocity;

    if (player.nextWeapon) {
      if (weaponCycleCooldown + 250 < millis()) {
        if (weapon == 3) {
          weapon = 1;
        } else {
          weapon++;
        }
        weaponCycleCooldown = millis();
      }
    }
    if (player.suicide) {
      heartNumber = 0;
    }
    if (exitgame) {
      exit();
    }
  }

  void updateWeaponWheel() {
    switch (weapon) {
    case 1:
      weaponWheelSelectorX = weaponWheelX;
      if (weaponWheelSelectorY > weaponWheelY - 0.2 * weaponWheelSize) {
        weaponWheelSelectorY -= 5;
      }
      if (weaponWheelSelectorY < weaponWheelY - 0.199 * weaponWheelSize) {
        weaponWheelSelectorY = weaponWheelY - 0.2 * weaponWheelSize;
      }
      // weaponWheelSelectorY = weaponWheelY - 0.2 * weaponWheelSize;
      break;
    case 2:
      weaponWheelSelectorX = weaponWheelX;
      if (weaponWheelSelectorY < weaponWheelY) {
        weaponWheelSelectorY += 4;
      }
      if (weaponWheelSelectorY > weaponWheelY - 0.001 * weaponWheelSize) {
        weaponWheelSelectorY = weaponWheelY;
      }
      //weaponWheelSelectorY = weaponWheelY;
      break;
    case 3:
      weaponWheelSelectorX = weaponWheelX;
      if (weaponWheelSelectorY < weaponWheelY + 0.2 * weaponWheelSize) {
        weaponWheelSelectorY += 4;
      }
      if (weaponWheelSelectorY > weaponWheelY + 0.199 * weaponWheelSize) {
        weaponWheelSelectorY = weaponWheelY + 0.2 * weaponWheelSize;
      }
      //weaponWheelSelectorY = weaponWheelY + 0.2 * weaponWheelSize;
      break;
    }
  }

  void drawWeaponWheel() {
    image(weaponWheel, weaponWheelX + visuals.magnitudeX, weaponWheelY + visuals.magnitudeY, weaponWheelSize, weaponWheelSize);
    image(weaponWheelSelector, weaponWheelSelectorX + visuals.magnitudeX, weaponWheelSelectorY + visuals.magnitudeY, weaponWheelSize, weaponWheelSize);
  }
}
