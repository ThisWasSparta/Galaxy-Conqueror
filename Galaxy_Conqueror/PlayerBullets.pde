//This class was written by Noah Verburg
class PlayerBullets {
  float bW;          //bullet width
  float bH;          //bullet height
  float bV;          //bullet velocity
  float bX;          //bullet X-position
  float bY;          //bullet Y-position
  boolean bulletIsOnScreen = false;
  float defaultBulletWidth = 10 * sizeFactor;
  float defaultBulletHeight = 20 * sizeFactor;
  PImage lightBullet;                   //sprite for the regular bullet of weapon1
  int playerBulletPerSalvo = 2;
  int playerBulletTurn = 0;
  int playerBulletFireRate = 100;
  int reloadTime = 0;                   //time it takes for the ship to be able to shoot again
  float bulletVelocityFactor = 0.01;    //factor which is used to get the desired bullet velocity compared to the width of the screen
  
  void spawnPlayerBullets() {                          //This function was written by Noah Verburg
    if (player.isShooting && !bullet[playerBulletTurn].bulletIsOnScreen && millis() - playerBulletFireRate > reloadTime) {  //if the shot-button is pressed and the bullet that is supposed to
      reloadTime = millis();                                                                                                //shoot out isnt on screen and the reload timer is done, it fires a bullet
      for (int i = 0; i < playerBulletPerSalvo; i++) {
        if (playerBulletTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
          bullet[playerBulletTurn].bX = player.pX + player.defaultPlayerWidth / 2 * 0.891;        //left gun, otherwise it spawns in the right turret
        } else {
          bullet[playerBulletTurn].bX = player.pX - player.defaultPlayerWidth / 2 * 0.891;
        }
        bullet[playerBulletTurn].bY = player.pY - player.defaultPlayerHeight / 2 * 0.678;
        playerBulletTurn++;
      }
      if (playerBulletTurn > 49) {playerBulletTurn = 0;}
    }
  }
  
  void updatePlayerBullets() {                      //this function updates the player's bullets position, detect if they are on screen, and if they hit an enemy
    for (int i = 0; i < playerBulletNumber; i++) {
      if (bullet[i].bY < 0 - bullet[i].bH) {
        bullet[i].bulletIsOnScreen = false;
      } else {
        bullet[i].bulletIsOnScreen = true;
      }
      if (bullet[i].bulletIsOnScreen) {
        bullet[i].bY -= bullet[i].bV;
      }
      if (!bullet[i].bulletIsOnScreen) {
        bullet[i].bY = height * -2;
      }
      for (int t = 0; t < enemyNumber; t++) {
        if (enemy[t].enemyType == 1 && bullet[i].bX < enemy[t].eX + enemy[t].scoutHitboxX && bullet[i].bX > enemy[t].eX - enemy[t].scoutHitboxX && bullet[i].bY < enemy[t].eY + enemy[t].scoutHitboxY && bullet[i].bY > enemy[t].eY - enemy[t].scoutHitboxY && enemy[t].isAlive == true) {
          bullet[i].bY -= height;
          enemy[t].eHP = enemy[t].eHP - 1;
            if (enemy[t].eHP == 0){
              enemy[t].isAlive = false;
              scoreObj.addScore(50);
              particle[0].particlesPerTurn = 20;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
        }
        if (enemy[t].enemyType == 2 && bullet[i].bX < enemy[t].eX + enemy[t].courserHitboxX && bullet[i].bX > enemy[t].eX - enemy[t].courserHitboxX && bullet[i].bY < enemy[t].eY + enemy[t].courserHitboxY && bullet[i].bY > enemy[t].eY - enemy[t].courserHitboxY && enemy[t].isAlive == true) {
          bullet[i].bY -= height;
          enemy[t].eHP = enemy[t].eHP - 1;
            if (enemy[t].eHP == 0){
              enemy[t].isAlive = false;
              scoreObj.addScore(100);
              particle[0].particlesPerTurn = 40;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
        }
        if (enemy[t].enemyType == 3 && bullet[i].bX < enemy[t].eX + enemy[t].goliathHitboxX && bullet[i].bX > enemy[t].eX - enemy[t].goliathHitboxX && bullet[i].bY < enemy[t].eY + enemy[t].goliathHitboxY && bullet[i].bY > enemy[t].eY - enemy[t].goliathHitboxY && enemy[t].isAlive == true) {
          bullet[i].bY -= height;
          enemy[t].eHP = enemy[t].eHP - 1;
            if (enemy[t].eHP == 0){
              enemy[t].isAlive = false;
              scoreObj.addScore(150);
              particle[0].particlesPerTurn = 60;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
        }
      }
    }
  }
  
  void drawPlayerBullets() {
    for (int i = 0; i < playerBulletNumber; i++) {
      if (bullet[i].bulletIsOnScreen) {
        image(lightBullet, bullet[i].bX, bullet[i].bY, bullet[i].bW, bullet[i].bH);
      }
    }
  }
}
