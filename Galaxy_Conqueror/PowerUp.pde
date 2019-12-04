//The code present in this file is written by Sam Spronk, based on the Class Enemies
int lastpower; //time in milliseconds since last powerup

class PowerUp {
  float pW;        //Powerup width
  float pH;        //Powerup height
  float pV;        //Powerup Velocity
  float pX;        //Powerup X coordinate
  float pY;        //Powerup Y coordinate

  int startPowerup;
  int timerPowerup;

  int typePowerup;
  final int maxP = 3; //Maximum amount of powerups allowed at a time

  boolean isPicked;
  boolean isActivated;

  float timePowerup = 10000;
  float spawnTime;
}
void powerupSpawn(int counter) { //function that periodically spawns powerups
  if (startGame) {
    if (startTime <= timer - 20000) {
      if (lastpower <= timer - random(1000, 5000)) {
        lastpower = timer;
        createPowerup(powerSelector());
      }
    }
  }
}

void createPowerup(int powerType) {
  int doublepointsCheck = powerRecycle();
  int speedCheck = powerRecycle();
  int screenwipeCheck = powerRecycle();
  switch(powerType) {
  case 1:
    if (doublepointsCheck != -1) {
      power[doublepointsCheck].typePowerup = 1;
      power[doublepointsCheck].isPicked = true;
      power[doublepointsCheck].isActivated = false;
      power[doublepointsCheck].pW = doublepointsPowerup.width;
      power[doublepointsCheck].pH = doublepointsPowerup.height;
      power[doublepointsCheck].pV = random(1, 3);
      power[doublepointsCheck].pX = random(power[doublepointsCheck].pW /2, width - power[doublepointsCheck].pW);
      power[doublepointsCheck].pY = -power[doublepointsCheck].pH;
      power[doublepointsCheck].startPowerup = 0;
      power[doublepointsCheck].timerPowerup = 0;
    }
    break;
  case 2:
    if (speedCheck != -1) {
      power[speedCheck].typePowerup = 2;
      power[speedCheck].isPicked = true;
      power[speedCheck].isActivated = false;
      power[speedCheck].pW = speedPowerup.width;
      power[speedCheck].pH = speedPowerup.height;
      power[speedCheck].pV = random(1, 3);
      power[speedCheck].pX = random(power[speedCheck].pW / 2, width - power[speedCheck].pW);
      power[speedCheck].pY = -power[speedCheck].pH;
      power[speedCheck].startPowerup = 0;
      power[speedCheck].timerPowerup = 0;
    }
    break;
  case 3:
    if (doublepointsCheck != -1) {
      power[screenwipeCheck].typePowerup = 3;
      power[screenwipeCheck].isPicked = true;
      power[screenwipeCheck].isActivated = false;
      power[screenwipeCheck].pW = screenwipePowerup.height;
      power[screenwipeCheck].pH = screenwipePowerup.width;
      power[screenwipeCheck].pV = random(1, 3);
      power[screenwipeCheck].pX = random(power[screenwipeCheck].pW / 2, width - power[screenwipeCheck].pW);
      power[screenwipeCheck].pY = -power[screenwipeCheck].pH;
      power[screenwipeCheck].startPowerup = 0;
      power[screenwipeCheck].timerPowerup = 0;
    }
    break;
  }
}

int powerRecycle() {
  for (int counter = 0; counter < maxP; counter++) {
    if (power[counter].isPicked == false) {
      return counter;
    }
  }
  return -1;
}

int powerSelector() {                                                          //rolls for powerup
  int firstDice = (int)random(1, 100);                                         //First roll
  if (firstDice >= 1 && firstDice <= 70) {                                     //If first roll is 70 or less, there will be no powerup
    return 0;
  }
  if (firstDice >= 71 && firstDice <= 100) {                                   //If the first roll is 71 or higher, there will be new powerup
    int secondDice = (int)random(1, 100);                                      //The second dice roll decides the powerup
    {
      if (secondDice >= 1 && secondDice <= 50) {
        return 1;                                                              //Double points
      }
      if (secondDice >= 51 && secondDice <= 90) {
        return 2;                                                              //Speed
      }
      if (secondDice >= 91 && secondDice <= 100) {
        return 3;                                                              //Screenwipe
      }
    }
  }
  return 0;
}

void powerUpdate(int counter) {

  if (power[counter].isPicked == true) {
    power[counter].pY = power[counter].pY + power[counter].pV;
    if (power[counter].pY == height + power[counter].pH) {
      power[counter].isPicked = false;
    }
    if (power[counter].pX > player.pX - player.pW/2 && power[counter].pX < player.pX + player.pW/2 && power[counter].pY > player.pY - player.pH/2 && power[counter].pY < player.pY + player.pH/2 && power[counter].isActivated == false) {
      power[counter].isActivated = true;
      power[counter].pY = height * 2;
      power[counter].spawnTime = millis();  //Sets timer whenever a powerup is activated
    }
    if (power[counter].isActivated == true) {                                                    //Check if power is activated
      if (power[counter].typePowerup == 1) {                                                     //Double points
        if (power[counter].spawnTime < millis() - power[counter].timePowerup) {                  //Check if time since activation has not exceeded given time in milliseconds
          scoreMultiplier = 1;                                                                   //Reverts score multiplier
          power[counter].isActivated = false;                                                    //Deactivates powerup
          power[counter].isPicked = false;                                                       //Allows the slot of the powerup to be used again
          println("Deactivated");
        } else {
          scoreMultiplier = 2;                                                                   //Changes score multiplier for double points
          println("Powerup activated");
        }
      }
      if (power[counter].typePowerup == 2) {                                                     //Speed
        if (power[counter].spawnTime < millis() - power[counter].timePowerup) {                  //Check if time since activation has not exceeded given time in milliseconds
          player.playerVelocityFactor = 0.006;                                                   //Reverts player speed to original value
          player.pV = player.playerVelocityFactor * width;                                       //Reverts player speed to original value
          power[counter].isActivated = false;                                                    //Deactivates powerup
          power[counter].isPicked = false;                                                       //Allows the slot of the powerup to be used again
          println("Deactivated");
        } else {
          player.playerVelocityFactor = 0.012;                                                   //Increases speed of the player
          player.pV = player.playerVelocityFactor * width;                                       //Reverts player speed to original value
          println("Powerup activated");
        }
      }
      if (power[counter].typePowerup == 3) {                                                     //Screenwipe
        for (int i = 0; i < 20; i++) {                                                           //Cycles through all enemy slots once
          if (enemy[i].isAlive == true) {                                                        //Checks if there are living enemies
            if (enemy[i].enemyType == 1) {
              scoreObj.addScore(50 * scoreMultiplier);
              enemy[i].isAlive = false;                                                          //Kills living enemies
            }
            if (enemy[i].enemyType == 2) {
              scoreObj.addScore(100 * scoreMultiplier);
              enemy[i].isAlive = false;                                                          //Kills living enemies
            }
            if (enemy[i].enemyType == 3) {
              scoreObj.addScore(150 * scoreMultiplier);
              enemy[i].isAlive = false;                                                          //Kills living enemies
            }
          }
        }
        power[counter].isActivated = false;                                                     //Deactivates power
        power[counter].isPicked = false;                                                        //Allows the slot of the powerup to be used again
      }
    }
  }
}
void drawPower(int counter) {                                                                   //Draws powerups
  if (power[counter].isPicked == true) {
    fill(255, 0, 0);
    if (power[counter].typePowerup == 1) {
      image(doublepointsPowerup, power[counter].pX, power[counter].pY, power[counter].pW, power[counter].pH);
    }
    if (power[counter].typePowerup == 2) {
      image(speedPowerup, power[counter].pX, power[counter].pY, power[counter].pW, power[counter].pH);
    }
    if (power[counter].typePowerup == 3) {
      image(screenwipePowerup, power[counter].pX, power[counter].pY, power[counter].pW, power[counter].pH);
    }
  }
}

void initializePowerupArrays() {
  for (int i = 0; i < maxP; i++) {
    power[i] = new PowerUp();
    power[i].isPicked = false;
    power[i].pW = 0;
    power[i].pH = 0;
    power[i].pV = 0;
    power[i].pX = 0-10;
    power[i].pY = 0;
  }
}
