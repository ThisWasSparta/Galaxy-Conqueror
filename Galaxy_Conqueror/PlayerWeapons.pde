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

  float rW;          //rocket width
  float rH;          //rocket height
  float rV;          //rocket velocity
  float rX;          //rocket X-position
  float rY;          //rocket Y-position
  float rocketVelocityFactorX;
  float rocketVelocityFactorY;

  int laserStrength = 1;
  int laserStrengthTimer = 0;
  
  int projectileType;

  boolean bulletIsOnScreen = false;
  boolean laserIsAlive = false;
  boolean rocketIsOnScreen = false;

  float defaultBulletWidth = 10 * sizeFactor;
  float defaultBulletHeight = 20 * sizeFactor;

  float defaultLaserWidth = 10 * sizeFactor;
  float defaultLaserHeight = 60 * sizeFactor;

  float defaultRocketWidth = 10 * sizeFactor;
  float defaultRocketHeight = 36 * sizeFactor;  

  PImage lightBullet;                   //sprite for the regular bullet of weapon1
  PImage laser;
  PImage rocket;

  final int PLAYER_BULLET_PER_SALVO = 2;
  int playerProjectileTurn = 0;
  int playerBulletFireRate = 100;
  int reloadTime = 0;                   //time it takes for the ship to be able to shoot again
  int playerBulletDamage = 10;
  float bulletVelocityFactor = 0.01;    //factor which is used to get the desired bullet velocity compared to the width of the screen

  final int PLAYER_LASER_PER_SALVO = 2;
  int playerLaserTurn = 0;
  int playerLaserFireRate = 1200;
  int playerLaserDamagePerFrame = 6;

  final int PLAYER_ROCKET_PER_SALVO = 2;
  int playerRocketFireRate = 350;
  int playerRocketDamage = 35;
  int lowestEnemy;
  int enemyTarget;
  float shortestDistance = 100000;
  float rocketVelocityFactor = 0.012;
  float distanceX;
  float distanceY;
  float distanceXandY;

  //Player bullet functions

  void spawnPlayerBullets() {//This function was written by Noah Verburg
    playergatshoot.setVolume(0.1);
    if (!player.isShooting) {
      playergatshoot.mute();
    }
    if (player.isShooting && !weapon[playerProjectileTurn].bulletIsOnScreen && millis() - playerBulletFireRate > reloadTime) {  //if the shot-button is pressed and the bullet that is supposed to
      //sounds.playergatshoot.play();
      playergatshoot.unmute();
      playergatshoot.loop();
      reloadTime = millis();                                                                                                //shoot out isnt on screen and the reload timer is done, it fires a bullet
      for (int i = 0; i < PLAYER_BULLET_PER_SALVO; i++) {
        if (playerProjectileTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
          weapon[playerProjectileTurn].bX = player.pX + player.defaultPlayerWidth / 2 * 0.891;        //left gun, otherwise it spawns in the right turret
        } else {
          weapon[playerProjectileTurn].bX = player.pX - player.defaultPlayerWidth / 2 * 0.891;
        }
        weapon[playerProjectileTurn].bY = player.pY - player.defaultPlayerHeight / 2 * 0.678;
        weapon[playerProjectileTurn].projectileType = 1;
        weapon[playerProjectileTurn].bulletIsOnScreen = true;
        playerProjectileTurn++;
      }
      if (playerProjectileTurn > 49) {
        playerProjectileTurn = 0;
      }
    }
  }

  void updatePlayerBullets() {                      //this function updates the player's bullets position, detect if they are on screen, and if they hit an enemy
    for (int i = 0; i < playerBulletNumber; i++) {
      if (weapon[i].projectileType == 1) {
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
        if (weapon[i].bX < boss.bossX + boss.bossW/2 && weapon[i].bX > boss.bossX - boss.bossW/2 && weapon[i].bY < boss.bossY + boss.bossH/2 && weapon[i].bY > boss.bossY - boss.bossH/2 && boss.bossAlive == true) {
          weapon[i].bY -= height;
          boss.bossHealth -= playerBulletDamage;
          if (boss.bossHealth <= 0) {
            boss.deathHandler();
          }
        }
        for (int t = 0; t < enemyNumber; t++) {
          if (enemy[t].enemyType == 1 && weapon[i].bX < enemy[t].eX + enemy[t].scoutHitboxX && weapon[i].bX > enemy[t].eX - enemy[t].scoutHitboxX && weapon[i].bY < enemy[t].eY + enemy[t].scoutHitboxY && weapon[i].bY > enemy[t].eY - enemy[t].scoutHitboxY && enemy[t].isAlive == true) {
            weapon[i].bY -= height;
            enemy[t].eHP -= playerBulletDamage;
            enemy[t].damageFlashTint = 255;
            if (enemy[t].eHP <= 0) {
              enemy[t].isAlive = false;
              killcount++;
              scoreObj.addScore(50 * scoreMultiplier);
              particle[0].particlesPerTurn = 20;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
          }
          if (enemy[t].enemyType == 2 && weapon[i].bX < enemy[t].eX + enemy[t].courserHitboxX && weapon[i].bX > enemy[t].eX - enemy[t].courserHitboxX && weapon[i].bY < enemy[t].eY + enemy[t].courserHitboxY && weapon[i].bY > enemy[t].eY - enemy[t].courserHitboxY && enemy[t].isAlive == true) {
            weapon[i].bY -= height;
            enemy[t].eHP -= playerBulletDamage;
            enemy[t].damageFlashTint = 255;
            if (enemy[t].eHP <= 0) {
              enemy[t].isAlive = false;
              killcount++;
              scoreObj.addScore(100 * scoreMultiplier);
              particle[0].particlesPerTurn = 40;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
          }
          if (enemy[t].shieldAlive) {
            if (enemy[t].enemyType == 3 && weapon[i].bX < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].bX > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].bY < enemy[t].eY + enemy[t].goliathHitboxY  * 1.4 && weapon[i].bY > enemy[t].eY + enemy[t].goliathHitboxY * -1 && enemy[t].isAlive == true) {
              weapon[i].bY -= height;
              enemy[t].shieldHP -= playerBulletDamage;
              if (enemy[t].shieldHP <= 0) {
                enemy[t].shieldAlive = false;
              }
            }
          } else {
            if (enemy[t].enemyType == 3 && weapon[i].bX < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].bX > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].bY < enemy[t].eY + enemy[t].goliathHitboxY && weapon[i].bY > enemy[t].eY - enemy[t].goliathHitboxY && enemy[t].isAlive == true) {
              weapon[i].bY -= height;
              enemy[t].eHP -= playerBulletDamage;
              enemy[t].damageFlashTint = 255;
              if (enemy[t].eHP <= 0) {
                enemy[t].isAlive = false;
                killcount++;
                scoreObj.addScore(150 * scoreMultiplier);
                goliathOnScreen--;
                particle[0].particlesPerTurn = 60;
                particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
              }
            }
          }
        }
      }
    }
  }


  void drawPlayerBullets() {
    for (int i = 0; i < playerBulletNumber; i++) {
      if (weapon[i].projectileType == 1) {
        if (weapon[i].bulletIsOnScreen) {
          image(lightBullet, weapon[i].bX, weapon[i].bY, weapon[i].bW, weapon[i].bH);
        }
      }
    }
  }


  //Player laser functions

  void spawnPlayerLaser() {
    for (int i = 0; i < 2; i++) {
      if (player.isShooting && reloadTime + playerLaserFireRate < millis() && !weapon[i].laserIsAlive) {
        reloadTime = millis();
        laserStrengthTimer = millis();
        for (int e = 0; e < PLAYER_LASER_PER_SALVO; e++) {
          if (playerLaserTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
            weapon[playerLaserTurn].lX = player.pX + player.defaultPlayerWidth / 2 * 0.891;        //left gun, otherwise it spawns in the right turret
          } else {
            weapon[playerLaserTurn].lX = player.pX - player.defaultPlayerWidth / 2 * 0.891;
          }
          weapon[playerLaserTurn].lY1 = player.pY - player.defaultPlayerHeight / 2 * 0.758;
          weapon[playerLaserTurn].lY2 = weapon[playerLaserTurn].lY1 - lH;
          weapon[playerLaserTurn].laserIsAlive = true;
          playerLaserTurn++;
        }
        if (playerLaserTurn > 1) {
          playerLaserTurn = 0;
        }
      }
    }
  }

  void updatePlayerLaser() {
    for (int i = 0; i < 2; i++) {
      if (weapon[i].laserIsAlive) {
        if (i%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
          weapon[i].lX = player.pX + player.defaultPlayerWidth / 2 * 0.891;        //left gun, otherwise it spawns in the right turret
        } else {
          weapon[i].lX = player.pX - player.defaultPlayerWidth / 2 * 0.891;
        }
        weapon[i].lY1 = player.pY - player.defaultPlayerHeight / 2 * 0.758;
        weapon[i].lY2 = weapon[i].lY1 - lH;

        if (weapon[i].laserStrengthTimer + 100 < millis()) {
          if (weapon[i].laserStrength == 1) {
            weapon[i].laser = loadImage("Player Laser 1.png");
          }
          if (weapon[i].laserStrength == 2) {
            weapon[i].laser = loadImage("Player Laser 2.png");
          }
          if (weapon[i].laserStrength == 3) {
            weapon[i].laser = loadImage("Player Laser 3.png");
          }
          if (weapon[i].laserStrength == 4) {
            weapon[i].laser = loadImage("Player Laser 2.png");
          }
          if (weapon[i].laserStrength == 5) {
            weapon[i].laser = loadImage("Player Laser 1.png");
          }
          weapon[i].laserStrengthTimer = millis();
          weapon[i].laserStrength += 1;
          if (weapon[i].laserStrength == 6) {
            weapon[i].laserStrength = 1;
            weapon[i].laserIsAlive = false;
          }
        }
      }
      if (weapon[i].lX - weapon[i].lW/2 < boss.bossX + boss.bossX/2 && weapon[i].lX + weapon[i].lW/2 > boss.bossX - boss.bossX/2 && boss.bossAlive && weapon[i].laserIsAlive) {
        weapon[i].bY -= height;
        boss.bossHealth -= 15;
        if (boss.bossHealth <= 0) {
          boss.deathHandler();
        }
      }
      for (int t = 0; t < enemyNumber; t++) {
        if (enemy[t].enemyType == 1 && weapon[i].lX - weapon[i].lW/2 < enemy[t].eX + enemy[t].scoutHitboxX && weapon[i].lX + weapon[i].lW/2 > enemy[t].eX - enemy[t].scoutHitboxX && enemy[t].isAlive && weapon[i].laserIsAlive) {
          weapon[i].bY -= height;
          enemy[t].eHP = enemy[t].eHP - playerLaserDamagePerFrame;
          enemy[t].damageFlashTint = 100;
          if (enemy[t].eHP <= 0) {
            enemy[t].isAlive = false;
            scoreObj.addScore(50 * scoreMultiplier);
            particle[0].particlesPerTurn = 20;
            particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
          }
        }
        if (enemy[t].enemyType == 2 && weapon[i].lX - weapon[i].lW/2 < enemy[t].eX + enemy[t].courserHitboxX && weapon[i].lX + weapon[i].lW/2 > enemy[t].eX - enemy[t].courserHitboxX && enemy[t].isAlive && weapon[i].laserIsAlive) {
          weapon[i].bY -= height;
          enemy[t].eHP = enemy[t].eHP - playerLaserDamagePerFrame;
          enemy[t].damageFlashTint = 100;
          if (enemy[t].eHP <= 0) {
            enemy[t].isAlive = false;
            scoreObj.addScore(100 * scoreMultiplier);
            particle[0].particlesPerTurn = 40;
            particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
          }
        } 
        if (enemy[t].enemyType == 3 && weapon[i].lX - weapon[i].lW/2 < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].lX + weapon[i].lW/2 > enemy[t].eX - enemy[t].goliathHitboxX && enemy[t].isAlive && weapon[i].laserIsAlive) {
          weapon[i].bY -= height;
          enemy[t].eHP = enemy[t].eHP - playerLaserDamagePerFrame;
          enemy[t].damageFlashTint = 100;
          if (enemy[t].eHP <= 0) {
            enemy[t].isAlive = false;
            scoreObj.addScore(150 * scoreMultiplier);
            particle[0].particlesPerTurn = 60;
            particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
          }
        }
      }
    }
  }

  void drawPlayerLaser() {
    for (int i = 0; i < 2; i++) {
      if (weapon[i].laserIsAlive) {
        image(weapon[i].laser, weapon[i].lX, weapon[i].lY1 - weapon[i].lH/2, weapon[i].lW, weapon[i].lH);
      }
    }
  }

  //Player rockets functions here

  void spawnPlayerRockets() {//This function was written by Noah Verburg
    if (player.isShooting && !weapon[playerProjectileTurn].rocketIsOnScreen && millis() - playerRocketFireRate > reloadTime) {  //if the shot-button is pressed and the bullet that is supposed to
      reloadTime = millis();                                                                                                //shoot out isnt on screen and the reload timer is done, it fires a bullet
      //for (int i = 0; i < PLAYER_ROCKET_PER_SALVO; i++) {
        if (playerProjectileTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
          weapon[playerProjectileTurn].rX = player.pX + player.defaultPlayerWidth / 2 * 0.891;        //left gun, otherwise it spawns in the right turret
        } else {
          weapon[playerProjectileTurn].rX = player.pX - player.defaultPlayerWidth / 2 * 0.891;
        }
        weapon[playerProjectileTurn].rY = player.pY - player.defaultPlayerHeight / 2 * 0.678;
        weapon[playerProjectileTurn].projectileType = 2;
        weapon[playerProjectileTurn].rocketIsOnScreen = true;
        weapon[playerProjectileTurn].shortestDistance = 100000;
        
        for (int t = 0; t < enemyNumber; t++) {
          if (enemy[t].isAlive) {
            enemy[t].individualRocketEnemyDistance = dist(weapon[playerProjectileTurn].rX, weapon[playerProjectileTurn].rY, enemy[t].eX, enemy[t].eY);
            if (enemy[t].individualRocketEnemyDistance < weapon[playerProjectileTurn].shortestDistance) {
              weapon[playerProjectileTurn].shortestDistance = enemy[t].individualRocketEnemyDistance;
              weapon[playerProjectileTurn].enemyTarget = t;
            }
          }
        }
        
        playerProjectileTurn++;
      //}
      if (playerProjectileTurn > 49) {
        playerProjectileTurn = 0;
      }
    }
  }

  void updatePlayerRockets() {                      //this function updates the player's bullets position, detect if they are on screen, and if they hit an enemy
    for (int i = 0; i < playerBulletNumber; i++) {
      if (weapon[i].projectileType == 2) {
        if (weapon[i].rY < 0 - weapon[i].rH || weapon[i].rY > height + weapon[i].rH || weapon[i].rX < 0 - weapon[i].rW || weapon[i].rX > width + weapon[i].rW) {
          weapon[i].rocketIsOnScreen = false;
        }
        if (weapon[i].rocketIsOnScreen) {
          if (enemy[weapon[i].enemyTarget].isAlive) {
            weapon[i].distanceX = dist(enemy[weapon[i].enemyTarget].eX, 0, weapon[i].rX, 0);
            weapon[i].distanceY = dist(0, enemy[weapon[i].enemyTarget].eY, 0, weapon[i].rY);
            if (weapon[i].distanceX < 0) {
              weapon[i].distanceX *= -1;
            }
            if (weapon[i].distanceY < 0) {
              weapon[i].distanceY *= -1;
            }
            weapon[i].distanceXandY = weapon[i].distanceX + weapon[i].distanceY;
            
            weapon[i].rocketVelocityFactorX = weapon[i].distanceX / weapon[i].distanceXandY;
            weapon[i].rocketVelocityFactorY = weapon[i].distanceY / weapon[i].distanceXandY;
            
            if (enemy[weapon[i].enemyTarget].eX < weapon[i].rX) {
              weapon[i].rX -= weapon[i].rV * weapon[i].rocketVelocityFactorX;
            }
            if (enemy[weapon[i].enemyTarget].eX > weapon[i].rX) {
              weapon[i].rX += weapon[i].rV * weapon[i].rocketVelocityFactorX;
            }
            weapon[i].rY -= weapon[i].rV * weapon[i].rocketVelocityFactorY;
          } else {
            weapon[i].rY -= weapon[i].rV;
          }
        }
        if (!weapon[i].rocketIsOnScreen) {
          weapon[i].rY = height * -2;
        }
        if (weapon[i].rX < boss.bossX + boss.bossW/2 && weapon[i].rX > boss.bossX - boss.bossW/2 && weapon[i].rY < boss.bossY + boss.bossH/2 && weapon[i].rY > boss.bossY - boss.bossH/2 && boss.bossAlive == true) {
          weapon[i].rY -= height;
          boss.bossHealth -= playerRocketDamage;
          if (boss.bossHealth <= 0) {
            boss.deathHandler();
          }
        }
        for (int t = 0; t < enemyNumber; t++) {
          if (enemy[t].enemyType == 1 && weapon[i].rX < enemy[t].eX + enemy[t].scoutHitboxX && weapon[i].rX > enemy[t].eX - enemy[t].scoutHitboxX && weapon[i].rY < enemy[t].eY + enemy[t].scoutHitboxY && weapon[i].rY > enemy[t].eY - enemy[t].scoutHitboxY && enemy[t].isAlive == true) {
            weapon[i].rY -= height;
            enemy[t].eHP -= playerRocketDamage;
            enemy[t].damageFlashTint = 255;
            if (enemy[t].eHP <= 0) {
              enemy[t].isAlive = false;
              killcount++;
              scoreObj.addScore(50 * scoreMultiplier);
              particle[0].particlesPerTurn = 20;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
          }
          if (enemy[t].enemyType == 2 && weapon[i].rX < enemy[t].eX + enemy[t].courserHitboxX && weapon[i].rX > enemy[t].eX - enemy[t].courserHitboxX && weapon[i].rY < enemy[t].eY + enemy[t].courserHitboxY && weapon[i].rY > enemy[t].eY - enemy[t].courserHitboxY && enemy[t].isAlive == true) {
            weapon[i].rY -= height;
            enemy[t].eHP -= playerRocketDamage;
            enemy[t].damageFlashTint = 255;
            if (enemy[t].eHP <= 0) {
              enemy[t].isAlive = false;
              killcount++;
              scoreObj.addScore(100 * scoreMultiplier);
              particle[0].particlesPerTurn = 40;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            }
          }
          if (enemy[t].shieldAlive) {
            if (enemy[t].enemyType == 3 && weapon[i].rX < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].rX > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].rY < enemy[t].eY + enemy[t].goliathHitboxY  * 1.4 && weapon[i].rY > enemy[t].eY + enemy[t].goliathHitboxY * -1 && enemy[t].isAlive == true) {
              weapon[i].rY -= height;
              enemy[t].shieldHP -= playerRocketDamage;
              if (enemy[t].shieldHP <= 0) {
                enemy[t].shieldAlive = false;
              }
            }
          } else {
            if (enemy[t].enemyType == 3 && weapon[i].rX < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].rX > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].rY < enemy[t].eY + enemy[t].goliathHitboxY && weapon[i].rY > enemy[t].eY - enemy[t].goliathHitboxY && enemy[t].isAlive == true) {
              weapon[i].rY -= height;
              enemy[t].eHP -= playerRocketDamage;
              enemy[t].damageFlashTint = 255;
              if (enemy[t].eHP <= 0) {
                enemy[t].isAlive = false;
                killcount++;
                scoreObj.addScore(150 * scoreMultiplier);
                goliathOnScreen--;
                particle[0].particlesPerTurn = 60;
                particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
              }
            }
          }
        }
      }
    }
  }


  void drawPlayerRockets() {
    for (int i = 0; i < playerBulletNumber; i++) {
      if (weapon[i].projectileType == 2) {
        if (weapon[i].rocketIsOnScreen) {
          image(rocket, weapon[i].rX, weapon[i].rY, weapon[i].rW, weapon[i].rH);
        }
      }
    }
  }
}
