/*The code present in this file is written by Sam Spronk, based on the Class Enemies
 All values of times are given in milliseconds
 1 000 milliseconds is 1 second
 */
int lastpower;                   //time in milliseconds since last powerup

class PowerUp {
  float playerWidth;                      //Powerup width
  float playerHeight;                      //Powerup height
  float pV;                      //Powerup Velocity
  float playerXposition;                      //Powerup X coordinate
  float playerYposition;                      //Powerup Y coordinate
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
      power[doublepointsCheck].playerWidth = doublepointsPowerup.width;
      power[doublepointsCheck].playerHeight = doublepointsPowerup.height;
      power[doublepointsCheck].pV = random(1, 3);
      power[doublepointsCheck].playerXposition = random(power[doublepointsCheck].playerWidth / 2, width - power[doublepointsCheck].playerWidth);
      power[doublepointsCheck].playerYposition = -power[doublepointsCheck].playerHeight;
      power[doublepointsCheck].startPowerup = 0;
      power[doublepointsCheck].timerPowerup = 0;
    }
    break;
  case 2:
    if (speedCheck != -1) {
      power[speedCheck].typePowerup = 2;                                                                           //Speed
      power[speedCheck].isPicked = true;
      power[speedCheck].isActivated = false;
      power[speedCheck].playerWidth = speedPowerup.width;
      power[speedCheck].playerHeight = speedPowerup.height;
      power[speedCheck].pV = random(1, 3);
      power[speedCheck].playerXposition = random(power[speedCheck].playerWidth / 2, width - power[speedCheck].playerWidth);
      power[speedCheck].playerYposition = -power[speedCheck].playerHeight;
      power[speedCheck].startPowerup = 0;
      power[speedCheck].timerPowerup = 0;
    }
    break;
  case 3:
    if (doublepointsCheck != -1) {
      power[screenwipeCheck].typePowerup = 3;                                                                      //Screenwipe
      power[screenwipeCheck].isPicked = true;
      power[screenwipeCheck].isActivated = false;
      power[screenwipeCheck].playerWidth = screenwipePowerup.height;
      power[screenwipeCheck].playerHeight = screenwipePowerup.width;
      power[screenwipeCheck].pV = random(1, 3);
      power[screenwipeCheck].playerXposition = random(power[screenwipeCheck].playerWidth / 2, width - power[screenwipeCheck].playerWidth);
      power[screenwipeCheck].playerYposition = -power[screenwipeCheck].playerHeight;
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
    power[counter].playerYposition = power[counter].playerYposition + power[counter].pV;
    if (power[counter].playerYposition == height + power[counter].playerHeight) {
      power[counter].isPicked = false;
      resetPowerUp(counter);
    }
    if (power[counter].playerXposition > player.playerXposition - player.playerWidth / 2 && power[counter].playerXposition < player.playerXposition + player.playerWidth / 2 && power[counter].playerYposition > player.playerYposition - player.playerHeight / 2 && power[counter].playerYposition < player.playerYposition + player.playerHeight / 2 && power[counter].isActivated == false) {
      power[counter].isActivated = true;
      power[counter].playerYposition = height * 2;
      power[counter].spawnTime = millis();                                                       //Sets timer whenever a powerup is activated
    }
    if (power[counter].isActivated == true) {                                                    //Check if power is activated
      if (power[counter].typePowerup == 1) {                                                     //Double points
        if (power[counter].spawnTime < millis() - power[counter].timePowerup) {                  //Check if time since activation has not exceeded given time in milliseconds
          scoreMultiplier = 1;                                                                   //Reverts score multiplier
          power[counter].isActivated = false;                                                    //Deactivates powerup
          power[counter].isPicked = false;                                                       //Allows the slot of the powerup to be used again
          resetPowerUp(counter);
        } else {
          scoreMultiplier = 2;                                                                   //Changes score multiplier for double points
        }
      }
      if (power[counter].typePowerup == 2) {                                                     //Speed
        if (power[counter].spawnTime < millis() - power[counter].timePowerup) {                  //Check if time since activation has not exceeded given time in milliseconds
          player.playerVelocityFactor = player.PLAYER_DEFAULT_VELOCITY_FACTOR;                   //Reverts player speed to original value
          player.playerMaxVelocity = player.playerVelocityFactor * width;                                    //Reverts player speed to original value
          power[counter].isActivated = false;                                                    //Deactivates powerup
          power[counter].isPicked = false;                                                       //Allows the slot of the powerup to be used again
          resetPowerUp(counter);
        } else {
          player.playerVelocityFactor = 0.008;                                                   //Increases speed of the player
          player.playerMaxVelocity = player.playerVelocityFactor * width;                                    //Reverts player speed to original value
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
      image(doublepointsPowerup, power[counter].playerXposition + visuals.magnitudeX, power[counter].playerYposition + visuals.magnitudeY, power[counter].playerWidth, power[counter].playerHeight);
    }
    if (power[counter].typePowerup == 2) {
      image(speedPowerup, power[counter].playerXposition + visuals.magnitudeX, power[counter].playerYposition + visuals.magnitudeY, power[counter].playerWidth, power[counter].playerHeight);
    }
    if (power[counter].typePowerup == 3) {
      image(screenwipePowerup, power[counter].playerXposition + visuals.magnitudeX, power[counter].playerYposition + visuals.magnitudeY, power[counter].playerWidth, power[counter].playerHeight);
    }
  }
}

void resetPowerUp(int count) {
  power[count].typePowerup = 0;
  power[count].playerYposition = -50;
  power[count].playerXposition = 0;
  power[count].pV = 0;
  power[count].playerHeight = 0;
  power[count].playerWidth = 0;
}
