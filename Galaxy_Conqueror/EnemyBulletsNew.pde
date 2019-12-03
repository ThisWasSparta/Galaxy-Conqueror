//This pde file was written by Floris Kuiper
class EnemyBullets {
  float bW;          //bullet width
  float bH;          //bullet height
  float bV;          //bullet velocity
  float bX;          //bullet X-position
  float bY;          //bullet Y-position
  float bSize;       //bullet size
  boolean isOnScreen; //whether or not a bullet is on screen and should be used in calculations

  PImage enemyBullet;
  int lastBulletSpawn;
  int reloadingTime = 0;

  void initializeEnemyBulletArray() {
    for (int counter = 0; counter < 20; counter++) {
      enemyBullets[counter] = new EnemyBullets();    
      enemyBullets[counter].bW = 5;
      enemyBullets[counter].bH = 10;
      enemyBullets[counter].bV = 0;
      enemyBullets[counter].bX = width * 2;
      enemyBullets[counter].bY = width * 2;
      enemyBullets[counter].isOnScreen = false; //whether or not a bullet is "alive" or not
    }
  }

  void enemyBulletSpawner() { //function that periodically causes enemies to appear on screen
    if (startGame) {
      if (startTime <= timer - 2000) {
        if (lastBulletSpawn <= timer - 2000) {
          lastBulletSpawn = timer;
          createEnemyBullet(); //creates an enemy in the right array according to the type rolled by the type generator
        }
      }
    }
  }

  int bulletRecycle() {                                  //function that checks to see which element of the array can be recycled to be used to store another bullet
    for (int counter = 0; counter < 20; counter++) {     //for loop that runs through the array to check each element if it can be recycled or not based on if the bullet has killed an enemy or gone offscreen
      if (enemyBullets[counter].isOnScreen == false) {
        return counter;                                  //returns the number of the element that was found to be suitable
      }
    }
    return -1;                                           //returns -1 if the array is full or something went wrong
  }

  void createEnemyBullet() { //function to create an enemy bullet
    int bulletCheck = bulletRecycle();
    int enemyShooter = enemyShootCheck();
    if (bulletCheck != -1 && enemyShooter != -1) { //check to see if the returned element of the array wasn't either in use or something went wrong
      enemyBullets[bulletCheck].bX = enemy[enemyShooter].eX;
      enemyBullets[bulletCheck].bY = enemy[enemyShooter].eY;
      enemyBullets[bulletCheck].isOnScreen = true;
      enemyShootParticle[0].firing(enemy[enemyShooter].eX, enemy[enemyShooter].eY, enemyShooter);
    }
  }

  void enemyBulletUpdatePosition(int counter) { //function that updates bullet positions accordingly to their given speed values and "kills" them when they cross the bottom of the screen
    if (enemyBullets[counter].isOnScreen == true) {
      enemyBullets[counter].bY = enemyBullets[counter].bY + enemyBullets[counter].bV;
      playerCollisionCheck(counter);
    }
  }

  void playerCollisionCheck(int counter) {
    if (lastCollision <= (timer - 3000)) {
      if (/*enemyBullets[counter].bSize + enemyBullets[counter].bX > player.pX - player.pW/2 
        && enemyBullets[counter].bSize - enemyBullets[counter].bX < player.pX + player.pW/2 
        && enemyBullets[counter].bSize + enemyBullets[counter].bY > player.pY - player.pH/2 
        && enemyBullets[counter].bSize - enemyBullets[counter].bY < player.pY + player.pH/2*/
        enemyBullets[counter].bX - enemyBullets[counter].bW/2 > player.pX - player.pW/2
        && enemyBullets[counter].bX + enemyBullets[counter].bW/2 < player.pX + player.pW/2
        && enemyBullets[counter].bY - enemyBullets[counter].bH/2 < player.pX - player.pH/2
        && enemyBullets[counter].bY + enemyBullets[counter].bH/2 < player.pX + player.pH/2){
        println("ouchie");
        enemyBullets[counter].bY = height * 2;
        enemyBullets[counter].bX = -1 * width;
        enemyBullets[counter].isOnScreen = false;
        lastCollision = millis();
        heartNumber -= 1;
      }
      if (enemyBullets[counter].bY > height + enemyBullets[counter].bH && enemyBullets[counter].isOnScreen == true) {
        println("my planet doesn't need me anymore");
        enemyBullets[counter].bX = -1 * width;
        enemyBullets[counter].bY = height * 2;
        enemyBullets[counter].isOnScreen = false;
      }
    }
  }

  void drawEnemyBullet(int counter) { //function that draws enemies on the given x and y coordinates with the right width and height
    if (enemy[counter].isAlive == true && enemyBullets[counter].isOnScreen == true) {
      fill(255, 0, 0);
      image(enemyBullet, enemyBullets[counter].bX, enemyBullets[counter].bY, enemyBullets[counter].bW, enemyBullets[counter].bH);
    }
  }
}
