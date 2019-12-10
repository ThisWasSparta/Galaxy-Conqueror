//This class was made by Noah Verburg
class SpaceShip {
  boolean goLeft;    //  \
  boolean goRight;   //   \
  boolean goUp;      //    \
  boolean goDown;    //     -direction of player movement
  
  boolean isShooting;  //whether the player is shooting or not
  
  boolean testBoolean;
  
  boolean stop;
  
  boolean nextWeapon;
  
  boolean exitgame;
  
  boolean suicide;
  
  float pW;    //player width
  float pH;    //player height
  float pXV = 0;   //player X velocity
  float pYV = 0;   //player Y velocity
  float pMaxV = 0; //player maximal velocity
  float pX;    //player X-position
  float pY;    //player Y-position
  float defaultPlayerWidth = 128 * sizeFactor;
  float defaultPlayerHeight = 118 * sizeFactor;
  float playerVelocityFactor = 0.006;   //factor which is used to get the desired player velocity compared to the width of the screen
  
  float weaponWheelX;
  float weaponWheelY;
  
  int weapon = 1;
  int weaponState = 1;
  int skinCycle = 0;
  int weaponCycleCooldown = 0;
  int damageFlashTint = 0;
  
  PImage weapon1;                       //weapon1, weapon2 and weapon3 are the sprites for the player depending on what gun they are using
  PImage weapon2;
  PImage weapon3;
  
  void player() {          //this code detects what weapon the player is currently using
    if (weapon == 1) {
      if (player.damageFlashTint > 0) {
        tint(255, player.damageFlashTint, player.damageFlashTint);
        player.damageFlashTint -= 10;
      }
      image(weapon1, pX, pY, pW, pH);
      tint(255, 255, 255);
    }
    if (weapon == 2) {
      if (player.damageFlashTint > 0) {
        tint(255, player.damageFlashTint, player.damageFlashTint);
        player.damageFlashTint -= 10;
      }
      image(weapon2, pX, pY, pW, pH);
      tint(255, 255, 255);
    }
    if (weapon == 3) {
      if (player.damageFlashTint > 0) {
        tint(255, player.damageFlashTint, player.damageFlashTint);
        player.damageFlashTint -= 10;
      }
      image(weapon3, pX, pY, pW, pH);
      tint(255, 255, 255);
    }
    if (weaponState == 3) {
      weapon1 = loadImage("Spaceship Weapon 1-3.png");
      weapon2 = loadImage("Spaceship Weapon 2-3.png");
      weapon3 = loadImage("Spaceship Weapon 3-3.png");
      if (frameCount - skinCycle > 30) {weaponState = 1; skinCycle = frameCount;}
    }
    if (weaponState == 2) {
      weapon1 = loadImage("Spaceship Weapon 1-2.png");
      weapon2 = loadImage("Spaceship Weapon 2-2.png");
      weapon3 = loadImage("Spaceship Weapon 3-2.png");
      if (frameCount - skinCycle > 20) {weaponState = 3;}
    }
    if (weaponState == 1) {
      weapon1 = loadImage("Spaceship Weapon 1-1.png");
      weapon2 = loadImage("Spaceship Weapon 2-1.png");
      weapon3 = loadImage("Spaceship Weapon 3-1.png");
      if (frameCount - skinCycle > 10) {weaponState = 2;}
    }
  }
  
  void playerUpdate() {    //This function was written by Noah Verburg
      if (player.goLeft && player.pX > player.pW/2) {
        if (player.pXV > -player.pMaxV ) {
          player.pXV -= 0.1 * pMaxV;
        }
      }
      if (player.goRight && player.pX < width - player.pW/2) {
        if (player.pXV < player.pMaxV ) {
          player.pXV += 0.1 * player.pMaxV;
        }
      }
      if (player.goUp && player.pY > height * 0.75) {
        if (player.pYV > -player.pMaxV ) {
          player.pYV -= 0.1 * player.pMaxV;
        }
      }
      if (player.goDown && player.pY < height/1.01 - player.pH/2) {
        if (player.pYV < player.pMaxV ) {
          player.pYV += 0.1 * player.pMaxV;
        }
      }
    } else {
      if (player.pXV < 0) {
        player.pXV += 0.1 * pMaxV;
      }
      if (player.pXV > 0) {
        player.pXV -= 0.1 * pMaxV;
      }
      if (player.pXV < 0.99 && player.pXV > -0.09) {
        player.pXV = 0;
      }
      if (player.pYV < 0) {
        player.pYV += 0.1 * pMaxV;
      }
      if (player.pYV > 0 ) {
        player.pYV -= 0.1 * pMaxV;
      }
      if (player.pYV < 0.09 && player.pYV > -0.09) {
        player.pYV = 0;
      }
    }
    
    if (pXV < 0 && player.pX < player.pW/2) {
      pXV = 0;
    }
    if (pXV > 0 && player.pX > width - player.pW/2) {
      pXV = 0;
    }
    if (pYV < 0 && player.pY < height * 0.75) {
      pYV = 0;
    }
    if (pYV > 0 && player.pY > height/1.01 - player.pH/2) {
      pYV = 0;
    }
    
    player.pX += player.pXV;
    player.pY += player.pYV;
    
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
  
  void drawWeaponWheel() {
    switch (weapon) {
      case 1:
        fill(0, 0, 255, 255);
        rect(weaponWheelX, weaponWheelY, width * 0.1, height * 0.05);
        fill(50, 50, 255, 255);
        rect(weaponWheelX, weaponWheelY, width * 0.095, height * 0.04);
        fill(255, 255);
        textSize(10);
        text("GATLING GUN", weaponWheelX, weaponWheelY + height * 0.006);
        
        fill(0, 0, 255, 128);
        rect(weaponWheelX, weaponWheelY - height * 0.046, width * 0.1, height * 0.05);
        fill(50, 50, 255, 128);
        rect(weaponWheelX, weaponWheelY - height * 0.046, width * 0.095, height * 0.04);
        fill(255, 128);
        textSize(10);
        text("ROCKET LAUNCHER", weaponWheelX, weaponWheelY - height * 0.04);
        
        fill(0, 0, 255, 128);
        rect(weaponWheelX, weaponWheelY + height * 0.046, width * 0.1, height * 0.05);
        fill(50, 50, 255, 128);
        rect(weaponWheelX, weaponWheelY + height * 0.046, width * 0.095, height * 0.04);
        fill(255, 128);
        textSize(10);
        text("LASER BEAM", weaponWheelX, weaponWheelY + height * 0.052);
        break;
      case 2:
        fill(0, 0, 255, 255);
        rect(weaponWheelX, weaponWheelY, width * 0.1, height * 0.05);
        fill(50, 50, 255, 255);
        rect(weaponWheelX, weaponWheelY, width * 0.095, height * 0.04);
        fill(255, 255);
        textSize(10);
        text("LASER BEAM", weaponWheelX, weaponWheelY + height * 0.006);
        
        fill(0, 0, 255, 128);
        rect(weaponWheelX, weaponWheelY - height * 0.046, width * 0.1, height * 0.05);
        fill(50, 50, 255, 128);
        rect(weaponWheelX, weaponWheelY - height * 0.046, width * 0.095, height * 0.04);
        fill(255, 128);
        textSize(10);
        text("GATLING GUN", weaponWheelX, weaponWheelY - height * 0.04);
        
        fill(0, 0, 255, 128);
        rect(weaponWheelX, weaponWheelY + height * 0.046, width * 0.1, height * 0.05);
        fill(50, 50, 255, 128);
        rect(weaponWheelX, weaponWheelY + height * 0.046, width * 0.095, height * 0.04);
        fill(255, 128);
        textSize(10);
        text("ROCKET LAUNCHER", weaponWheelX, weaponWheelY + height * 0.052);
        break;
      case 3:
        fill(0, 0, 255, 255);
        rect(weaponWheelX, weaponWheelY, width * 0.1, height * 0.05);
        fill(50, 50, 255, 255);
        rect(weaponWheelX, weaponWheelY, width * 0.095, height * 0.04);
        fill(255, 255);
        textSize(10);
        text("ROCKET LAUNCHER", weaponWheelX, weaponWheelY + height * 0.006);
        
        fill(0, 0, 255, 128);
        rect(weaponWheelX, weaponWheelY - height * 0.046, width * 0.1, height * 0.05);
        fill(50, 50, 255, 128);
        rect(weaponWheelX, weaponWheelY - height * 0.046, width * 0.095, height * 0.04);
        fill(255, 128);
        textSize(10);
        text("LASER BEAM", weaponWheelX, weaponWheelY - height * 0.04);
        
        fill(0, 0, 255, 128);
        rect(weaponWheelX, weaponWheelY + height * 0.046, width * 0.1, height * 0.05);
        fill(50, 50, 255, 128);
        rect(weaponWheelX, weaponWheelY + height * 0.046, width * 0.095, height * 0.04);
        fill(255, 128);
        textSize(10);
        text("GATLING GUN", weaponWheelX, weaponWheelY + height * 0.052);
        break;
    }
  }
}
