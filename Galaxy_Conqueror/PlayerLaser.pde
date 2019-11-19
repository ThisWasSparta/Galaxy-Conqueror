//This class was written by Noah Verburg
class PlayerWeapons {
  float bW;          //bullet width
  float bH;          //bullet height
  float bV;          //bullet velocity
  float bX;          //bullet X-position
  float bY;          //bullet Y-position
  
  float lW;
  float lH;
  float lX;
  float lY1;
  float lY2;
  
  boolean bulletIsOnScreen = false;
  float defaultBulletWidth = 10 * sizeFactor;
  float defaultBulletHeight = 20 * sizeFactor;
  PImage lightBullet;                   //sprite for the regular bullet of weapon1
  
  final int PLAYER_BULLET_PER_SALVO = 2;
  int playerBulletTurn = 0;
  int playerBulletFireRate = 100;
  int reloadTime = 0;                   //time it takes for the ship to be able to shoot again
  float bulletVelocityFactor = 0.01;    //factor which is used to get the desired bullet velocity compared to the width of the screen
  
  final int PLAYER_LASER_PER_SALVO = 2;
  int playerLaserTurn = 0;
  int playerLaserFireRate = 300;
  
  void spawnPlayerBullets() {                          //This function was written by Noah Verburg
      if (player.isShooting && !weapon[playerBulletTurn].bulletIsOnScreen && millis() - playerBulletFireRate > reloadTime) {  //if the shot-button is pressed and the bullet that is supposed to
        reloadTime = millis();                                                                                                //shoot out isnt on screen and the reload timer is done, it fires a bullet
        for (int i = 0; i < PLAYER_BULLET_PER_SALVO; i++) {
          if (playerBulletTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
            weapon[playerBulletTurn].bX = player.pX + player.defaultPlayerWidth / 2 * 0.891;        //left gun, otherwise it spawns in the right turret
          } else {
            weapon[playerBulletTurn].bX = player.pX - player.defaultPlayerWidth / 2 * 0.891;
          }
          weapon[playerBulletTurn].bY = player.pY - player.defaultPlayerHeight / 2 * 0.678;
          playerBulletTurn++;
        }
        if (playerBulletTurn > 49) {playerBulletTurn = 0;}
     }
  }
  
  void updatePlayerBullets() {                      //this function updates the player's bullets position, detect if they are on screen, and if they hit an enemy
    for (int i = 0; i < playerBulletNumber; i++) {
      if (weapon[i].bY < 0 - weapon[i].bH) {
        weapon[i].bulletIsOnScreen = false;
      } else {
        weapon[i].bulletIsOnScreen = true;
      }
      if (weapon[i].bulletIsOnScreen) {
        weapon[i].bY -= weapon[i].bV;
      }
      if (!weapon[i].bulletIsOnScreen) {
        weapon[i].bY = height * -2;
      }
      for (int t = 0; t < enemyNumber; t++) {
        if (enemy[t].enemyType == 1 && weapon[i].bX < enemy[t].eX + enemy[t].scoutHitboxX && weapon[i].bX > enemy[t].eX - enemy[t].scoutHitboxX && weapon[i].bY < enemy[t].eY + enemy[t].scoutHitboxY && weapon[i].bY > enemy[t].eY - enemy[t].scoutHitboxY && enemy[t].isAlive == true) {
          weapon[i].bY -= height;
          enemy[t].eHP = enemy[t].eHP - 1;
            if (enemy[t].eHP == 0){
              enemy[t].isAlive = false;
              scoreObj.addScore(50);
              particle[0].particlesPerTurn = 20;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
        }
        if (enemy[t].enemyType == 2 && weapon[i].bX < enemy[t].eX + enemy[t].courserHitboxX && weapon[i].bX > enemy[t].eX - enemy[t].courserHitboxX && weapon[i].bY < enemy[t].eY + enemy[t].courserHitboxY && weapon[i].bY > enemy[t].eY - enemy[t].courserHitboxY && enemy[t].isAlive == true) {
          weapon[i].bY -= height;
          enemy[t].eHP = enemy[t].eHP - 1;
            if (enemy[t].eHP == 0){
              enemy[t].isAlive = false;
              scoreObj.addScore(100);
              particle[0].particlesPerTurn = 40;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
        }
        if (enemy[t].enemyType == 3 && weapon[i].bX < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].bX > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].bY < enemy[t].eY + enemy[t].goliathHitboxY && weapon[i].bY > enemy[t].eY - enemy[t].goliathHitboxY && enemy[t].isAlive == true) {
          weapon[i].bY -= height;
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
      if (weapon[i].bulletIsOnScreen) {
        image(lightBullet, weapon[i].bX, weapon[i].bY, weapon[i].bW, weapon[i].bH);
      }
    }
  }
  
  void spawnPlayerLaser() {
    if (player.isShooting && reloadTime + playerLaserFireRate == millis()) {
      reloadTime = millis();
      for (int i = 0; i < PLAYER_LASER_PER_SALVO; i++) {
        if (playerLaserTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
          weapon[playerBulletTurn].bX = player.pX + player.defaultPlayerWidth / 2 * 0.891;        //left gun, otherwise it spawns in the right turret
        } else {
          weapon[playerBulletTurn].bX = player.pX - player.defaultPlayerWidth / 2 * 0.891;
        }
        weapon[playerBulletTurn].bY = player.pY - player.defaultPlayerHeight / 2 * 0.678;
        playerBulletTurn++;
      }
      if (playerBulletTurn > 49) {playerBulletTurn = 0;}
    }
  }
  
  void updatePlayerLaser() {
    
  }
  
  void drawPlayerLaser() {
    
  }
}