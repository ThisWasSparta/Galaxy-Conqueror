//This pde file was written by Floris Kuiper
class EnemyBullets {
  float bulletWidth;          //bullet width
  float bulletHeight;          //bullet height
  float bulletVelocity;          //bullet velocity
  float bulletXposition;          //bullet X-position
  float bulletYposition;          //bullet Y-position
  float bSize;       //bullet size
  float enemyBulletVelocityFactor = 0.008;
  boolean isOnScreen; //whether or not a bullet is on screen and should be used in calculations


  PImage enemyBullet;
  int lastBulletSpawn;
  int reloadingTime = 0;

  void initializeEnemyBulletArray() {
    for (int counter = 0; counter < 20; counter++) {
      enemyBullets[counter] = new EnemyBullets();    
      enemyBullets[counter].bulletWidth = 5;
      enemyBullets[counter].bulletHeight = 10;
      enemyBullets[counter].bulletVelocity = 0;
      enemyBullets[counter].bulletXposition = width * -2;
      enemyBullets[counter].bulletYposition = width * -2;
      enemyBullets[counter].isOnScreen = false; //whether or not a bullet is "alive" or not
    }
  }

  void enemyBulletUpdatePosition(int counter) { //function that updates bullet positions accordingly to their given speed values and "kills" them when they cross the bottom of the screen
    if (enemyBullets[counter].isOnScreen == true) {
      enemyBullets[counter].bulletYposition = enemyBullets[counter].bulletYposition + enemyBullets[counter].bulletVelocity;
      playerCollisionCheck(counter);
    }
  }

  void playerCollisionCheck(int counter) {
    if (lastCollision <= (timer - 3000)) {
      if (enemyBullets[counter].bulletXposition - enemyBullets[counter].bulletWidth/2 > player.pX - player.pW/2
        && enemyBullets[counter].bulletXposition + enemyBullets[counter].bulletWidth/2 < player.pX + player.pW/2
        && enemyBullets[counter].bulletYposition - enemyBullets[counter].bulletHeight/2 > player.pY - player.pH/2
        && enemyBullets[counter].bulletYposition + enemyBullets[counter].bulletHeight/2 < player.pY + player.pH/2
        && enemyBullets[counter].isOnScreen == true) {
        player.damageFlashTint = 200;
        visuals.screenShake(8, 40, true);
        enemyBullets[counter].bulletYposition = height * -2;
        enemyBullets[counter].bulletXposition = -1 * width;
        enemyBullets[counter].isOnScreen = false;
        lastCollision = millis();
        heartNumber -= 1;
      }
      if (enemyBullets[counter].bulletYposition > height + enemyBullets[counter].bulletHeight && enemyBullets[counter].isOnScreen == true) {
        enemyBullets[counter].bulletXposition = -1 * width;
        enemyBullets[counter].bulletYposition = height * -2;
        enemyBullets[counter].isOnScreen = false;
      }
    }
  }

  void drawEnemyBullet(int counter) { //function that draws enemies on the given x and y coordinates with the right width and height
    if (enemy[counter].isAlive == true && enemyBullets[counter].isOnScreen == true) {
      fill(255, 0, 0);
      image(enemyBullet, enemyBullets[counter].bulletXposition + visuals.magnitudeX, enemyBullets[counter].bulletYposition + visuals.magnitudeY, enemyBullets[counter].bulletWidth, enemyBullets[counter].bulletHeight);
    }
  }

  void enemyBulletSpawner() { //function that periodically causes enemies to appear on screen
    if (startGame) {
      if (startTime <= timer - 2000) {
        if (lastBulletSpawn <= timer - 2000) {
          lastBulletSpawn = timer;
          createEnemyBullet(); //creates an enemy in the right array according to the type rolled by the type generator
          //sounds.scoutshoot.play();
          //enemyshoot.loop();
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
      enemyBullets[bulletCheck].bulletXposition = enemy[enemyShooter].eX;
      enemyBullets[bulletCheck].bulletYposition = enemy[enemyShooter].eY;
      enemyBullets[bulletCheck].isOnScreen = true;
      enemyShootParticle[0].firing(enemy[enemyShooter].eX, enemy[enemyShooter].eY, enemyShooter);
      enemyshoot.play(30);
    }
  }
}
