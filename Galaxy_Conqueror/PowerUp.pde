/*The code present in this file is written by Sam Spronk, based on the Class Enemies
 All values of times are given in milliseconds
 1 000 milliseconds is 1 second
 */
int lastpower;                   //time in milliseconds since last powerup

class PowerUp {
  float pW;                      //Powerup width
  float pH;                      //Powerup height
  float pV;                      //Powerup Velocity
  float pX;                      //Powerup X coordinate
  float pY;                      //Powerup Y coordinate
  float timePowerup = 10000;     //Amount of time a powerup will be active in milliseconds
  float spawnTime;

  int startPowerup;
  int timerPowerup;
  int typePowerup;

  boolean isPicked;
  boolean isActivated;
}
void powerupSpawn(int counter) { //function that periodically spawns powerups
  if (startGame) {
    if (tutorial) {
      if (startTime <= timer - 20000) {
        if (lastpower <= timer - random(5000, 10000)) {
          lastpower = timer;
          createPowerup(powerSelector());
        }
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
      power[doublepointsCheck].typePowerup = 1;                                                                    //Double points
      power[doublepointsCheck].isPicked = true;
      power[doublepointsCheck].isActivated = false;
      power[doublepointsCheck].pW = doublepointsPowerup.width;
      power[doublepointsCheck].pH = doublepointsPowerup.height;
      power[doublepointsCheck].pV = random(1, 3);
      power[doublepointsCheck].pX = random(power[doublepointsCheck].pW / 2, width - power[doublepointsCheck].pW);
      power[doublepointsCheck].pY = -power[doublepointsCheck].pH;
      power[doublepointsCheck].startPowerup = 0;
      power[doublepointsCheck].timerPowerup = 0;
    }
    break;
  case 2:
    if (speedCheck != -1) {
      power[speedCheck].typePowerup = 2;                                                                           //Speed
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
      power[screenwipeCheck].typePowerup = 3;                                                                      //Screenwipe
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
  for (int counter = 0; counter < MAX_POWERUPS; counter++) {
    if (power[counter].isPicked == false) {
      return counter;
    }
  }
  return -1;
}

int powerSelector() {                                                          //rolls for powerup
  int firstDice = (int)random(1, 100);                                         //First roll
  if (firstDice >= 1 && firstDice <= 70) {                                     //If first roll is 70 or less, there will be no powerup
    return -1;
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
  return -1;
}

void powerUpdate(int counter) {

  if (power[counter].isPicked == true) {
    power[counter].pY = power[counter].pY + power[counter].pV;
    if (power[counter].pY == height + power[counter].pH) {
      power[counter].isPicked = false;
      resetPowerUp(counter);
    }
    if (power[counter].pX > player.pX - player.pW / 2 && power[counter].pX < player.pX + player.pW / 2 && power[counter].pY > player.pY - player.pH / 2 && power[counter].pY < player.pY + player.pH / 2 && power[counter].isActivated == false) {
      power[counter].isActivated = true;
      power[counter].pY = height * 2;
      power[counter].spawnTime = millis();                                                       //Sets timer whenever a powerup is activated
    }
    if (power[counter].isActivated == true) {                                                    //Check if power is activated
      if (power[counter].typePowerup == 1) {                                                     //Double points
        if (power[counter].spawnTime < millis() - power[counter].timePowerup) {                  //Check if time since activation has not exceeded given time in milliseconds
          scoreMultiplier = 1;                                                                   //Reverts score multiplier
          power[counter].isActivated = false;                                                    //Deactivates powerup
          power[counter].isPicked = false;                                                       //Allows the slot of the powerup to be used again
          resetPowerUp(counter);
          println("Deactivated");
        } else {
          scoreMultiplier = 2;                                                                   //Changes score multiplier for double points
          println("Powerup activated");
        }
      }
      if (power[counter].typePowerup == 2) {                                                     //Speed
        if (power[counter].spawnTime < millis() - power[counter].timePowerup) {                  //Check if time since activation has not exceeded given time in milliseconds
          player.playerVelocityFactor = player.PLAYER_DEFAULT_VELOCITY_FACTOR;                   //Reverts player speed to original value
          player.pMaxV = player.playerVelocityFactor * width;                                    //Reverts player speed to original value
          power[counter].isActivated = false;                                                    //Deactivates powerup
          power[counter].isPicked = false;                                                       //Allows the slot of the powerup to be used again
          resetPowerUp(counter);
          println("Deactivated");
        } else {
          player.playerVelocityFactor = 0.008;                                                   //Increases speed of the player
          player.pMaxV = player.playerVelocityFactor * width;                                    //Reverts player speed to original value
          println("Powerup activated");
        }
      }
      if (power[counter].typePowerup == 3) {                                                     //Screenwipe
        for (int i = 0; i < 20; i++) {                                                           //Cycles through all enemy slots once
          if (enemy[i].isAlive == true) {                                                        //Checks if there are living enemies
            scoreObj.addScore(enemy[i].score * scoreMultiplier);                                 //Adds score for killed enemy based on given variable in Enemies
            enemy[i].isAlive = false;                                                            //Kills living enemies
          }
        }
        power[counter].isActivated = false;                                                      //Deactivates power
        power[counter].isPicked = false;                                                         //Allows the slot of the powerup to be used again
        resetPowerUp(counter);
      }
    }
  }
}
void drawPower(int counter) {                                                                    //Draws powerups
  if (power[counter].isPicked == true) {
    fill(255, 0, 0);
    if (power[counter].typePowerup == 1) {
      image(doublepointsPowerup, power[counter].pX + visuals.magnitudeX, power[counter].pY + visuals.magnitudeY, power[counter].pW, power[counter].pH);
    }
    if (power[counter].typePowerup == 2) {
      image(speedPowerup, power[counter].pX + visuals.magnitudeX, power[counter].pY + visuals.magnitudeY, power[counter].pW, power[counter].pH);
    }
    if (power[counter].typePowerup == 3) {
      image(screenwipePowerup, power[counter].pX + visuals.magnitudeX, power[counter].pY + visuals.magnitudeY, power[counter].pW, power[counter].pH);
    }
  }
}

void resetPowerUp(int count) {
  power[count].typePowerup = 0;
  power[count].pY = -50;
  power[count].pX = 0;
  power[count].pV = 0;
  power[count].pH = 0;
  power[count].pW = 0;
}
