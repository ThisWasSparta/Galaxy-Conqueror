/*This pde file was written by Floris Kuiper*/
int lastSpawn; //time in milliseconds when the last enemy was spawned
int lastCollision = 0; //time in miliseconds of last time the player collided with an enemy
int collisionFlag = 0; //flag to keep track of if an enemy player collision has happened yet or not
int killcount = 0;
float minTime = 1250;
float maxTime = 3500;
int goliathOnScreen = 0;
int defaultPenalty = -100;

class Enemies {
  float eW;    //enemy width
  float eH;    //enemy height
  float eV;    //enemy velocity
  float eX = width/2;    //enemy X-position
  float eY = 0;    //enemy Y-position
  float eSize; //enemy size
  int eHP;     //enemy health value


  float shieldMaxHP;
  float shieldHP;
  float orbW; //this code was written by Noah Verburg
  float orbH;
  float shieldW;
  float shieldH;
  float orbSize;    //the size of the energy orb of the goliath
  float orbSizeFactor = 0.0;    //this is used to make the orb pulsate
  float shieldTint;
  float shieldTintMinimum;
  float shieldTintFactor = 0.0; //this is used to make the transparency of the shield pulsate
  float inc = TWO_PI/50;        //this is the driving factor for the pulsating things
  float individualRocketEnemyDistance;
  float defaultScoutWidth = 110 * sizeFactor;
  float defaultScoutHeight = 98 * sizeFactor;
  float defaultCourserWidth = 142 * sizeFactor;
  float defaultCourserHeight = 200 * sizeFactor;
  float defaultGoliathWidth = 182 * sizeFactor;
  float defaultGoliathHeight = 272 * sizeFactor;
  float defaultGoliathOrbSize = 42 * sizeFactor;
  float defaultGoliathShieldWidth = 206 * sizeFactor;
  float defaultGoliathShieldHeight = 72 * sizeFactor;
  float scoutHitboxX = defaultScoutWidth / 2 + 2;
  float scoutHitboxY = defaultScoutHeight / 2 + 2;
  float courserHitboxX = defaultCourserWidth / 2 + 2;
  float courserHitboxY = defaultCourserHeight / 2 + 2;
  float goliathHitboxX = defaultGoliathWidth / 2 + 2;
  float goliathHitboxY = defaultGoliathHeight / 2 + 2;
  float shieldHitboxX = shieldW / 2;
  float shieldHitboxY = shieldH / 2;
  float scoutEnemyVelocityFactor = 0.0025;
  float courserEnemyVelocityFactor = 0.0015;
  float goliathEnemyVelocityFactor = 0.00085;



  PImage scoutEnemy;                    //sprite for the regular enemy
  PImage courserEnemy;
  PImage goliathEnemy;
  PImage goliathOrb;
  PImage goliathShield; //code written by Noah Verburg

  //int timing;
  int enemyType;
  int damageFlashTint = 0;
  int score;
  int penalty;

  boolean isAlive; //whether or not the enemy is alive
  boolean shieldAlive;
}

void enemySpawner() { //function that periodically causes enemies to appear on screen
  if (startGame && boss.bossAlive == false) {
    if (startTime <= timer - 10000) {// wait 10 seconds until enemies spawn
      if (lastSpawn <= timer - random(minTime, maxTime)) {
        lastSpawn = timer;
        createEnemy(typeSelector()); //creates an enemy in the right array according to the type rolled by the type generator
      }
    }
  }
}

void bossScoutSpawner() { //function called by the boss' backup state to spawn convoys of scouts
  int arrayIndex = enemyRecycle();
  int convoyOriginX = (int)random(0, width - enemy[arrayIndex].eSize);
  for (int spawnCounter = 0; spawnCounter < 3; spawnCounter++) {
    if (arrayIndex != -1) {
      enemy[arrayIndex].enemyType = 1;
      enemy[arrayIndex].eSize = 40;
      enemy[arrayIndex].eW = enemy[arrayIndex].defaultScoutWidth * wScale;
      enemy[arrayIndex].eH = enemy[arrayIndex].defaultScoutHeight * hScale;
      enemy[arrayIndex].eV = enemy[arrayIndex].scoutEnemyVelocityFactor * width;
      enemy[arrayIndex].eX = convoyOriginX + spawnCounter * 50; 
      enemy[arrayIndex].eY = -enemy[arrayIndex].eH;
      enemy[arrayIndex].eHP = 30;
      enemy[arrayIndex].penalty = defaultPenalty;
      enemy[arrayIndex].isAlive = true;
    }
  }
}

void createEnemy(int type) { //function to create an enemy
  int scoutCheck = enemyRecycle();
  int courserCheck = enemyRecycle();
  int goliathCheck = enemyRecycle();


  switch(type) {
  case 1:
    if (scoutCheck != -1 && scoreObj.score >= 500) { //check to see if the returned element of the array wasn't either in use or something went wrong
      enemy[scoutCheck].enemyType = 1;
      enemy[scoutCheck].eSize = 40;
      enemy[scoutCheck].eW = enemy[scoutCheck].defaultScoutWidth * wScale;
      enemy[scoutCheck].eH = enemy[scoutCheck].defaultScoutHeight * hScale;
      enemy[scoutCheck].eV = enemy[scoutCheck].scoutEnemyVelocityFactor * width;
      enemy[scoutCheck].eX = random(enemy[scoutCheck].eW / 2, width - enemy[scoutCheck].eW);
      enemy[scoutCheck].eY = -enemy[scoutCheck].eH;
      enemy[scoutCheck].eHP = 30;
      enemy[scoutCheck].score = 50;
      enemy[scoutCheck].penalty = defaultPenalty;
      enemy[scoutCheck].isAlive = true;
    }
    break;
  case 2:
    if (courserCheck != -1 && scoreObj.score >= 0) {
      enemy[courserCheck].enemyType = 2;
      enemy[courserCheck].eSize = 60;
      enemy[courserCheck].eW = enemy[courserCheck].defaultCourserWidth * wScale;
      enemy[courserCheck].eH = enemy[courserCheck].defaultCourserHeight * hScale;
      enemy[courserCheck].eV = enemy[courserCheck].courserEnemyVelocityFactor * width;
      enemy[courserCheck].eX = random(enemy[courserCheck].eW / 2, width - enemy[courserCheck].eW);
      enemy[courserCheck].eY = -enemy[courserCheck].eH;
      enemy[courserCheck].eHP = 110;
      enemy[courserCheck].score = 100;
      enemy[courserCheck].penalty = -100;
      enemy[courserCheck].isAlive = true;
    }
    break;
  case 3:
    if (goliathCheck != -1 && scoreObj.score >= 1000) {
      enemy[goliathCheck].enemyType = 3;
      enemy[goliathCheck].eSize = 70;
      enemy[goliathCheck].eW = enemy[goliathCheck].defaultGoliathWidth * wScale;
      enemy[goliathCheck].eH = enemy[goliathCheck].defaultGoliathHeight * hScale;
      enemy[goliathCheck].eV = enemy[goliathCheck].goliathEnemyVelocityFactor * width;
      enemy[goliathCheck].eX = random(enemy[goliathCheck].eW / 2, width - enemy[goliathCheck].eW);
      enemy[goliathCheck].eY = -enemy[goliathCheck].eH;
      enemy[goliathCheck].eHP = 300;
      enemy[goliathCheck].isAlive = true;
      enemy[goliathCheck].shieldAlive = true;
      enemy[goliathCheck].shieldHP = 300;
      enemy[goliathCheck].shieldMaxHP = 300;
      enemy[goliathCheck].score = 150;
      enemy[goliathCheck].penalty = defaultPenalty;
      enemy[goliathCheck].shieldTintMinimum = 175;
    }
    break;
  }
}

int enemyRecycle() {                       //function that checks to see which element of the array can be recycled to be used to store another enemy
  for (int counter = 0; counter < ENEMY_NUMBER; counter++) {     //for loop that runs through the array to check each element if it can be recycled or not based on if the enemy has been killed/went offscreen
    if (enemy[counter].isAlive == false) {
      return counter;                                  //returns the number of the element that was found to be suitable
    }
  }
  return -1;                                           //returns -1 if the array is full or something went wrong
}

int typeSelector() { //function that rolls a dice on what enemy type should appear
  int value = (int)random(0, 100);
  if (goliathOnScreen <= 3) {
    value = (int)random(0, 90);
  }
  if (value >= 0 && value <= 50) {
    return 1;
  }
  if (value > 50 && value < 80) {
    return 2;
  }
  if (value >= 80 && value <= 100) {
    return 3;
  }
  return 0;
}

void enemyUpdatePosition(int counter) { //function that updates enemy positions accordingly to their given speed values and "kills" them when they cross the bottom of the screen
  if (enemy[counter].isAlive == true) {
    enemy[counter].eY = enemy[counter].eY + enemy[counter].eV;
    if (enemy[counter].eY > height + enemy[counter].eH) {
      enemy[counter].isAlive = false;
      scoreObj.addScore(enemy[counter].penalty);
      if (enemy[counter].enemyType == 3) {
        goliathOnScreen--;
      }
    }
  }
}

void drawEnemies(int counter) { //function that draws enemies on the given x and y coordinates with the right width and height
  if (enemy[counter].isAlive == true) {
    fill(255, 0, 0);
    if (enemy[counter].enemyType == 1) {
      if (enemy[counter].damageFlashTint > 0) {
        tint(255, enemy[counter].damageFlashTint, enemy[counter].damageFlashTint);
        enemy[counter].damageFlashTint -= 30;
      }
      image(enemy[counter].scoutEnemy, enemy[counter].eX + visuals.maxMagnitudeX, enemy[counter].eY + visuals.maxMagnitudeY, enemy[counter].eW, enemy[counter].eH);
      tint(255, 255, 255);
    }
    if (enemy[counter].enemyType == 2) {
      if (enemy[counter].damageFlashTint > 0) {
        tint(255, enemy[counter].damageFlashTint, enemy[counter].damageFlashTint);
        enemy[counter].damageFlashTint -= 30;
      }
      image(enemy[counter].courserEnemy, enemy[counter].eX + visuals.maxMagnitudeX, enemy[counter].eY + visuals.maxMagnitudeY, enemy[counter].eW, enemy[counter].eH);
      tint(255, 255, 255);
    }
    if (enemy[counter].enemyType == 3) {
      if (enemy[counter].damageFlashTint > 0) {
        tint(255, enemy[counter].damageFlashTint, enemy[counter].damageFlashTint);
        enemy[counter].damageFlashTint -= 30;
      }
      enemy[counter].shieldTintMinimum = 175 * (enemy[counter].shieldHP / enemy[counter].shieldMaxHP);
      enemy[counter].orbSize = enemy[counter].orbW + (enemy[counter].orbW * (1 + sin(enemy[counter].orbSizeFactor)))/12;
      enemy[counter].shieldTint = enemy[counter].shieldTintMinimum + (200 * (1 + sin(enemy[counter].shieldTintFactor)))/12;
      image(enemy[counter].goliathEnemy, enemy[counter].eX + visuals.maxMagnitudeX, enemy[counter].eY + visuals.maxMagnitudeY, enemy[counter].eW, enemy[counter].eH);
      image(enemy[counter].goliathOrb, enemy[counter].eX + visuals.maxMagnitudeX, enemy[counter].eY + enemy[counter].eH / 4 - enemy[counter].eH / 11 + visuals.maxMagnitudeY, enemy[counter].orbSize, enemy[counter].orbSize);
      if (enemy[counter].shieldAlive) {
        tint(255, enemy[counter].shieldTint);
        image(enemy[counter].goliathShield, enemy[counter].eX + visuals.maxMagnitudeX, enemy[counter].eY + enemy[counter].eH / 1.5 - enemy[counter].eH / 11 + visuals.maxMagnitudeY, enemy[counter].shieldW, enemy[counter].shieldH);
      }
      tint(255, 255);
      enemy[counter].orbSizeFactor += enemy[counter].inc;      //this makes the orb pulsate
      enemy[counter].shieldTintFactor += enemy[counter].inc;   //this makes the shields transparency pulsate
      //println(enemy[counter].orbSizeFactor);
      tint(255, 255, 255);
    }
  }
}

/*void playerEnemyCollision() {
 for (int i = 0; i < enemy.length; i++) {
 if (player.pX > enemy[i].eX && player.pX < enemy[i].eX + enemy[i].eSize && player.pY > enemy[i].eY && player.pY < enemy[i].eY + enemy[i].eSize) {
 if (collisionFlag == 0) {
 lastCollision = millis();
 heartNumber -= 1;
 collisionFlag = 1;
 if (lastCollision >= (timer - 2000) && collisionFlag == 1) {
 lastCollision = millis();
 heartNumber -= 1;
 }
 }
 }
 }
 }*/

int enemyShootCheck() {                       //function that checks to see which element of the array can used to fire a projectile
  for (int counter = enemy.length - 1; counter >= 0; counter--) {     //for loop that runs through the array to check each element if it can be recycled or not based on if the enemy has been killed/went offscreen
    if (enemy[counter].isAlive == true && enemy[counter].enemyType == 1) {
      return counter;                                  //returns the number of the element that was found to be suitable
    }
  }
  return -1;                                           //returns -1 if the array is full or something went wrong
}

void initializeEnemyArrays() {

  for (int counter = 0; counter < ENEMY_NUMBER; counter++) {
    enemy[counter] = new Enemies();    
    enemy[counter].eW = 0;
    enemy[counter].eH = 0;
    enemy[counter].eV = 0;
    enemy[counter].eX = 0;
    enemy[counter].eY = 0;
    enemy[counter].eHP = 0;
    enemy[counter].isAlive = false;
  }
}

void groupSpawner() { //function that will be used to spawn groups of enemies
  int type1 = typeSelector();
  int type2 = typeSelector();
  int type3 = typeSelector();
}
