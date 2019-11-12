/*This pde file was written by Floris Kuiper*/
int lastSpawn; //time in milliseconds when the last enemy was spawned

class Enemies {
  float eW;    //enemy width
  float eH;    //enemy height
  float eV;    //enemy velocity
  float eX = width/2;    //enemy X-position
  float eY = 0;    //enemy Y-position
  float eSize; //enemy size
  int eHP;     //enemy health value
  
  float orbW; //this code was written by Noah Verburg
  float orbH;
  float shieldW;
  float shieldH;
  float orbSize;    //the size of the energy orb of the goliath
  float orbSizeFactor = 0.0;    //this is used to make the orb pulsate
  float shieldTint;
  float shieldTintFactor = 0.0; //this is used to make the transparency of the shield pulsate
  float inc = TWO_PI/50;        //this is the driving factor for the pulsating things
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
  float scoutEnemyVelocityFactor = 0.0025;
  float courserEnemyVelocityFactor = 0.0015;
  float goliathEnemyVelocityFactor = 0.00085;
  
  PImage scoutEnemy;                    //sprite for the regular enemy
  PImage courserEnemy;
  PImage goliathEnemy;
  PImage goliathOrb;
  PImage goliathShield; //code written by Noah Verburg ends here
  
  //int timing;
  int enemyType;
  
  boolean isAlive; //whether or not the enemy is alive
}

void enemySpawner() { //function that periodically causes enemies to appear on screen
  if (startGame) {
    if (startTime <= timer - 2000) {
      if (lastSpawn <= timer - random(1250, 3500)) {
        lastSpawn = timer;
        createEnemy(typeSelector()); //creates an enemy in the right array according to the type rolled by the type selector
      }
    }
  }
}

void createEnemy(int type) { //function to create an enemy
  int scoutCheck = enemyRecycle();
  int courserCheck = enemyRecycle();
  int goliathCheck = enemyRecycle();
  

  switch(type) {
  case 1:
    if (scoutCheck != -1) { //check to see if the returned element of the array wasn't either in use or something went wrong
      enemy[scoutCheck].enemyType = 1;
      enemy[scoutCheck].eSize = 40;
      enemy[scoutCheck].eW = enemy[scoutCheck].defaultScoutWidth * wScale;
      enemy[scoutCheck].eH = enemy[scoutCheck].defaultScoutHeight * hScale;
      enemy[scoutCheck].eV = enemy[scoutCheck].scoutEnemyVelocityFactor * width;
      enemy[scoutCheck].eX = random(enemy[scoutCheck].eW / 2, width - enemy[scoutCheck].eW);
      enemy[scoutCheck].eY = -enemy[scoutCheck].eH;
      enemy[scoutCheck].eHP = 2;
      enemy[scoutCheck].isAlive = true;
    }
    break;
  case 2:
    if (courserCheck != -1) {
      enemy[courserCheck].enemyType = 2;
      enemy[courserCheck].eSize = 60;
      enemy[courserCheck].eW = enemy[courserCheck].defaultCourserWidth * wScale;
      enemy[courserCheck].eH = enemy[courserCheck].defaultCourserHeight * hScale;
      enemy[courserCheck].eV = enemy[courserCheck].courserEnemyVelocityFactor * width;
      enemy[courserCheck].eX = random(enemy[courserCheck].eW / 2, width - enemy[courserCheck].eW);
      enemy[courserCheck].eY = -enemy[courserCheck].eH;
      enemy[courserCheck].eHP = 4;
      enemy[courserCheck].isAlive = true;
    }
    break;
  case 3:
    if (goliathCheck != -1) {
      enemy[goliathCheck].enemyType = 3;
      enemy[goliathCheck].eSize = 70;
      enemy[goliathCheck].eW = enemy[goliathCheck].defaultGoliathWidth * wScale;
      enemy[goliathCheck].eH = enemy[goliathCheck].defaultGoliathHeight * hScale;
      enemy[goliathCheck].eV = enemy[goliathCheck].goliathEnemyVelocityFactor * width;
      enemy[goliathCheck].eX = random(enemy[goliathCheck].eW / 2, width - enemy[goliathCheck].eW);
      enemy[goliathCheck].eY = -enemy[goliathCheck].eH;
      enemy[goliathCheck].eHP = 12;
      enemy[goliathCheck].isAlive = true;
    }
    break;
  }
}

int enemyRecycle() {                       //function that checks to see which element of the array can be recycled to be used to store another enemy
  for (int counter = 0; counter < 20; counter++) {     //for loop that runs through the array to check each element if it can be recycled or not based on if the enemy has been killed/went offscreen
    if (enemy[counter].isAlive == false) {
      return counter;                                  //returns the number of the element that was found to be suitable
    }
  }
  return -1;                                           //returns -1 if the array is full or something went wrong
}

int typeSelector() { //function that rolls a dice on what enemy type should appear
  int value = (int)random(0, 100);

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
      if (enemy[counter].enemyType == 1 && scoreObj.score >= 200) {
        scoreObj.addScore(-200);
      } else {
        if (enemy[counter].enemyType == 1 && scoreObj.score <= 200) {
          scoreObj.score = 0;
        }
      }
      if (enemy[counter].enemyType == 2 && scoreObj.score >= 400) {
        scoreObj.addScore(-400);
      } else {
        if (enemy[counter].enemyType == 2 && scoreObj.score <= 400) {
          scoreObj.score = 0;
        }
      }
      if (enemy[counter].enemyType == 3 && scoreObj.score >= 600) {
        scoreObj.addScore(-600);
      } else {
        if (enemy[counter].enemyType == 3 && scoreObj.score <= 600) {
          scoreObj.score = 0;
        }
      }
    }
  }
}

void drawEnemies(int counter) { //function that draws enemies on the given x and y coordinates with the right width and height
  if (enemy[counter].isAlive == true) {
    fill(255, 0, 0);
    if (enemy[counter].enemyType == 1) {
      image(enemy[counter].scoutEnemy, enemy[counter].eX, enemy[counter].eY, enemy[counter].eW, enemy[counter].eH);
    }
    if (enemy[counter].enemyType == 2) {
      image(enemy[counter].courserEnemy, enemy[counter].eX, enemy[counter].eY, enemy[counter].eW, enemy[counter].eH);
    }
    if (enemy[counter].enemyType == 3) {
      enemy[counter].orbSize = enemy[counter].orbW + (enemy[counter].orbW * (1 + sin(enemy[counter].orbSizeFactor)))/12;
      enemy[counter].shieldTint = 175 + (200 * (1 + sin(enemy[counter].shieldTintFactor)))/12;
      image(enemy[counter].goliathEnemy, enemy[counter].eX, enemy[counter].eY, enemy[counter].eW, enemy[counter].eH);
      image(enemy[counter].goliathOrb, enemy[counter].eX, enemy[counter].eY + enemy[counter].eH / 4 - enemy[counter].eH / 11, enemy[counter].orbSize, enemy[counter].orbSize);
      tint(255, enemy[counter].shieldTint);
      image(enemy[counter].goliathShield, enemy[counter].eX, enemy[counter].eY + enemy[counter].eH / 1.5 - enemy[counter].eH / 11, enemy[counter].shieldW, enemy[counter].shieldH);
      tint(255, 255);
      enemy[counter].orbSizeFactor += enemy[counter].inc;      //this makes the orb pulsate
      enemy[counter].shieldTintFactor += enemy[counter].inc;   //this makes the shields transparency pulsate
      //println(enemy[counter].orbSizeFactor);
    }
  }
}

void playerEnemyCollision() {
  
}

int enemyShootCheck() {                       //function that checks to see which element of the array can used to fire a projectile
  for (int counter = 0; counter < 20; counter++) {     //for loop that runs through the array to check each element if it can be recycled or not based on if the enemy has been killed/went offscreen
    if (enemy[counter].isAlive == true) {
      return counter;                                  //returns the number of the element that was found to be suitable
    }
  }
  return -1;                                           //returns -1 if the array is full or something went wrong
}

void initializeEnemyArrays() {

  for(int counter = 0; counter < 20; counter++) {
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
