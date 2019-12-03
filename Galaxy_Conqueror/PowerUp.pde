//The code present in this file is written by Sam Spronk, based on the Class Enemies
int lastpower; //time in milliseconds since last powerup
int startpowerup;

class PowerUp {
  float pW;        //Powerup width
  float pH;        //Powerup height
  float pV = 1;    //Powerup Velocity
  float pX;        //Powerup X coordinate
  float pY;        //Powerup Y coordinate
  
  int typePowerup;
  final int maxP = 3; //Maximum amount of powerups allowed at a time
  
  boolean isPicked;
  boolean isActivated;
}
void powerupSpawn(int counter) { //function that periodically spawns powerups
  if(startGame) {
    if(startTime <= timer - 1000) {
      if(lastpower <= timer - random(1000, 5000)) {
        lastpower = timer;
        createPowerup(powerSelector());
      }
    }
  }
}

void createPowerup(int powerType){
  int doublepointsCheck = powerRecycle();
  int speedCheck = powerRecycle();
  int screenwipeCheck = powerRecycle();
switch(powerType) {
  case 1:
    if(doublepointsCheck != -1) {
      power[doublepointsCheck].typePowerup = 1;
      power[doublepointsCheck].isPicked = true;
      power[doublepointsCheck].isActivated = false;
      power[doublepointsCheck].pW = doublepointsPowerup.width;
      power[doublepointsCheck].pH = doublepointsPowerup.height;
      power[doublepointsCheck].pV = 1;
      power[doublepointsCheck].pX = random(power[doublepointsCheck].pW /2, width - power[doublepointsCheck].pW);
      power[doublepointsCheck].pY = -power[doublepointsCheck].pH;
    }
  break;
  case 2:
    if(speedCheck != -1) {
      power[speedCheck].typePowerup = 2;
      power[speedCheck].isPicked = true;
      power[speedCheck].isActivated = false;
      power[speedCheck].pW = speedPowerup.width;
      power[speedCheck].pH = speedPowerup.height;
      power[speedCheck].pV = 1;
      power[speedCheck].pX = random(power[speedCheck].pW / 2, width - power[speedCheck].pW);
      power[speedCheck].pY = -power[speedCheck].pH;
    }
  break;
  case 3:
    if(doublepointsCheck != -1) {
      power[screenwipeCheck].typePowerup = 3;
      power[screenwipeCheck].isPicked = true;
      power[screenwipeCheck].isActivated = false;
      power[screenwipeCheck].pW = screenwipePowerup.height;
      power[screenwipeCheck].pH = screenwipePowerup.width;
      power[screenwipeCheck].pV = 1;
      power[screenwipeCheck].pX = random(power[screenwipeCheck].pW / 2, width - power[screenwipeCheck].pW);
      power[screenwipeCheck].pY = -power[screenwipeCheck].pH;
    }
  break;
  }
}

int powerRecycle() {
  for(int counter = 0; counter < maxP; counter++) {
    if(power[counter].isPicked == false) {
      return counter;
    }
  }
  return -1;
}

int powerSelector() { //rolls for powerup
  int firstDice = (int)random(1, 100);
  if(firstDice >= 1 && firstDice <= 70) {
    return 0;
  }
  if(firstDice >= 71 && firstDice <= 100) {
    int secondDice = (int)random(1, 100); {
      if(secondDice >= 1 && secondDice <= 50) {
        return 1;
      }
      if(secondDice >= 51 && secondDice <= 90) {
        return 2;
      }
      if(secondDice >= 91 && secondDice <= 100) {
        return 3;
      }
    }
  }
  return 0;
}

void powerUpdate(int counter) {
  if(power[counter].isPicked == true) {
    power[counter].pY = power[counter].pY + power[counter].pV;
    if(power[counter].pY == height + power[counter].pH) {
      power[counter].isPicked = false;
    }
    if(power[counter].pX > player.pX - player.pW/2 && power[counter].pX < player.pX + player.pW/2 && power[counter].pY > player.pY - player.pH/2 && power[counter].pY < player.pY + player.pH/2) {
      power[counter].isActivated = true;
      power[counter].isPicked = false;
      power[counter].pY = height * 2;
      startpowerup = millis();
    }
  }
  
  println(startpowerup);
  
  if(power[counter].isActivated == true) {
    if(power[counter].typePowerup == 1) {
      if(millis() >= startpowerup) {
        scoreMultiplier = 1;
      }
      else {
        scoreMultiplier = 2;
        power[counter].isActivated = false;
      }
    }
    if(power[counter].typePowerup == 2 && power[counter].isActivated == true) {
      if(millis() >= startpowerup + 10000) {
        playerVelocityFactor = 0.12;
        playerBulletFireRate = 120;
        println(millis());
      }
      else {
        playerVelocityFactor = 0.006;
        playerBulletFireRate = 1200;
        println("Speed powerup activated");
        println(startpowerup);
        println(millis());
        power[counter].isActivated = false;
        }
      }
    if(power[counter].typePowerup == 3 && power[counter].isActivated == true) {
      for(int i = 0; i < 20; i++) {
        if(enemy[i].isAlive == true) {
          if(enemy[i].enemyType == 1) {
            scoreObj.addScore(50 * scoreMultiplier);
            enemy[i].isAlive = false;
          }
          if(enemy[i].enemyType == 2) {
            scoreObj.addScore(100 * scoreMultiplier);
            enemy[i].isAlive = false;
          }
          if(enemy[i].enemyType == 3) {
            scoreObj.addScore(150 * scoreMultiplier);
            enemy[i].isAlive = false;
          }
        }
      }
      power[counter].isActivated = false;
    }
  }
}
void drawPower(int counter) {
  if(power[counter].isPicked == true) {
    fill(255, 0, 0);
    if(power[counter].typePowerup == 1) {
      image(doublepointsPowerup, power[counter].pX, power[counter].pY, power[counter].pW, power[counter].pH);
    }
    if(power[counter].typePowerup == 2) {
      image(speedPowerup, power[counter].pX, power[counter].pY, power[counter].pW, power[counter].pH);
    }
    if(power[counter].typePowerup == 3) {
      image(screenwipePowerup, power[counter].pX, power[counter].pY, power[counter].pW, power[counter].pH);
    }
  }
}

void initializePowerupArrays() {
  for(int i = 0; i < maxP; i++) {
    power[i] = new PowerUp();
    power[i].isPicked = false;
    power[i].pW = 0;
    power[i].pH = 0;
    power[i].pV = 0;
    power[i].pX = 0-10;
    power[i].pY = 0;
  }
}
