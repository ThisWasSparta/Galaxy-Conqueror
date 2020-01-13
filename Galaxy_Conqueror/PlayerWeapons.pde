//This class was written by Noah Verburg

int gatkills = 0;
int laserkills = 0;
int rockkills = 0;

class PlayerWeapons {
  float bulletWidth;          //bullet width
  float bulletHeight;          //bullet height
  float bulletVelocity;          //bullet velocity
  float bulletXposition;          //bullet X-position
  float bulletYposition;          //bullet Y-position

  float laserWidth;
  float laserHeight;
  float laserXposition;
  float laserYposition1;
  float laserYposition2;

  float rocketWidth;          //rocket width
  float rocketHeight;          //rocket height
  float rocketVelocity;          //rocket velocity
  float rocketXposition;          //rocket X-position
  float rocketYposition;          //rocket Y-position
  float rocketVelocityFactorX;
  float rocketVelocityFactorY;

  int laserStrength = 1;
  int laserStrengthTimer = 0;

  int projectileType;

  boolean bulletIsOnScreen = false;
  boolean laserIsAlive = false;
  boolean rocketIsOnScreen = false;

  final float DEFAULT_BULLET_WIDTH = 10 * sizeFactor;
  final float DEFAULT_BULLET_HEIGHT = 20 * sizeFactor;

  final float DEFAULT_LASER_WIDTH = 10 * sizeFactor;
  final float DEFAULT_LASER_HEIGHT = 60 * sizeFactor;

  final float DEFAULT_ROCKET_WIDTH = 20 * sizeFactor;
  final float DEFAULT_ROCKET_HEIGHT = 72 * sizeFactor;  

  PImage lightBullet;                   //sprite for the regular bullet of weapon1
  PImage laser;
  PImage rocket;

  final int PLAYER_BULLET_PER_SALVO = 1;
  final int PLAYER_BULLET_FIRERATE = 50;
  final int PLAYER_BULLET_DAMAGE = 10;
  int playerProjectileTurn = 0;
  float reloadTime = 0;                   //time it takes for the ship to be able to shoot again
  float bulletVelocityFactor = 0.01;    //factor which is used to get the desired bullet velocity compared to the width of the screen

  final int PLAYER_LASER_PER_SALVO = 2;
  final int PLAYER_LASER_FIRERATE = 1400;
  final int PLAYER_LASER_DAMAGE_PER_FRAME = 6;
  int playerLaserTurn = 0;

  final int PLAYER_ROCKET_PER_SALVO = 2;
  final int PLAYER_ROCKET_FIRERATE = 700;
  final int PLAYER_ROCKET_DAMAGE = 55;
  int lowestEnemy;
  int enemyTarget;
  float shortestDistance = 100000;
  float rocketVelocityFactor = 0.01;
  float distanceX;
  float distanceY;
  float distanceXandY;

  float reloadTimerBarWidth;
  float reloadTimerBarHeight;
  float reloadTimerBarXposition;
  float reloadTimerBarYposition;
  //float reloadTimerBarStartTime;

  //Player bullet functions

  void reloadTimerBar() {        //this function draws and updates the reloadbar which is used to display when you can fire a weapon again.
    rectMode(CORNER);            //it uses the remaining time from the reloadTime variable to calculate the length of the yellow part of the bar.
    switch (player.weapon) {
    case 1:
      if (reloadTime + PLAYER_BULLET_FIRERATE > millis()) {
        reloadTimerBarWidth = 80 * ((millis() - reloadTime) / PLAYER_BULLET_FIRERATE);
        reloadTimerBarHeight = 5;
        reloadTimerBarXposition = player.playerXposition - 40;
        reloadTimerBarYposition = player.playerYposition + player.playerHeight * 0.6;
        fill(200);
        rect(reloadTimerBarXposition, reloadTimerBarYposition, 80, reloadTimerBarHeight);
        fill(255, 242, 56);
        rect(reloadTimerBarXposition, reloadTimerBarYposition, reloadTimerBarWidth, reloadTimerBarHeight);
      }
      break;
    case 2:
      if (reloadTime + PLAYER_LASER_FIRERATE > millis()) {
        reloadTimerBarWidth = 80 * ((millis() - reloadTime) / PLAYER_LASER_FIRERATE);
        reloadTimerBarHeight = 5;
        reloadTimerBarXposition = player.playerXposition - 40;
        reloadTimerBarYposition = player.playerYposition + player.playerHeight * 0.8;
        fill(200);
        rect(reloadTimerBarXposition, reloadTimerBarYposition, 80, reloadTimerBarHeight);
        fill(255, 248, 148);
        rect(reloadTimerBarXposition, reloadTimerBarYposition, reloadTimerBarWidth, reloadTimerBarHeight);
      }
      break;
    case 3:
      if (reloadTime + PLAYER_ROCKET_FIRERATE > millis()) {
        reloadTimerBarWidth = 80 * ((millis() - reloadTime) / PLAYER_ROCKET_FIRERATE);
        reloadTimerBarHeight = 5;
        reloadTimerBarXposition = player.playerXposition - 40;
        reloadTimerBarYposition = player.playerYposition + player.playerHeight * 0.8;
        fill(200);
        rect(reloadTimerBarXposition, reloadTimerBarYposition, 80, reloadTimerBarHeight);
        fill(26, 30, 153);
        rect(reloadTimerBarXposition, reloadTimerBarYposition, reloadTimerBarWidth, reloadTimerBarHeight);
      }
      break;
    }
    rectMode(CENTER);
  }

  void spawnPlayerBullets() {//This function was written bulletYposition Noah Verburg
    if (player.isShooting && !weapon[playerProjectileTurn].bulletIsOnScreen && millis() - PLAYER_BULLET_FIRERATE > reloadTime) {  //if the shot-button is pressed and the bullet that is supposed to
      reloadTime = millis();                                                                                                //shoot out isnt on screen and the reload timer is done, it fires a bullet
      for (int i = 0; i < PLAYER_BULLET_PER_SALVO; i++) {
        if (playerProjectileTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
          weapon[playerProjectileTurn].bulletXposition = player.playerXposition + player.DEFAULT_PLAYER_WIDTH / 2 * 0.891;        //left gun, otherocketWidthise it spawns in the right turret
        } else {
          weapon[playerProjectileTurn].bulletXposition = player.playerXposition - player.DEFAULT_PLAYER_WIDTH / 2 * 0.891;
        }
        weapon[playerProjectileTurn].bulletYposition = player.playerYposition - player.DEFAULT_PLAYER_HEIGHT / 2 * 0.678;
        weapon[playerProjectileTurn].projectileType = 1;
        weapon[playerProjectileTurn].bulletIsOnScreen = true;
        playerProjectileTurn++;
        playergatshoot.play((int)random(110,130));
      }
      if (playerProjectileTurn > 49) {
        playerProjectileTurn = 0;
      }
    }
  }

  void updatePlayerBullets() {                      //this function updates the player's bullets position, detect if they are on screen, and if they hit an enemy
    for (int i = 0; i < PLAYER_BULLET_NUMBER; i++) {
      if (weapon[i].projectileType == 1) {    //this if statement makes sure the object that is being updated is the right projectile type, as to not wrongly update a rocket like its a bullet.
        if (weapon[i].bulletYposition < 0 - weapon[i].bulletHeight) {
          weapon[i].bulletIsOnScreen = false;
        } else {
          weapon[i].bulletIsOnScreen = true;
        }
        if (weapon[i].bulletIsOnScreen) {
          weapon[i].bulletYposition -= weapon[i].bulletVelocity;
        }
        if (!weapon[i].bulletIsOnScreen) {
          weapon[i].bulletYposition = height * -2;
        }
        
        //this is the hitbox detection of the boss.
        if (weapon[i].bulletXposition < boss.bossX + boss.bossW/2 && weapon[i].bulletXposition > boss.bossX - boss.bossW/2 && weapon[i].bulletYposition < boss.bossY + boss.bossH/2 && weapon[i].bulletYposition > boss.bossY - boss.bossH/2 && boss.bossAlive == true) {
          weapon[i].bulletYposition -= height;
          boss.bossHealth -= PLAYER_BULLET_DAMAGE;
          if (boss.bossHealth <= 0) {
            boss.deathHandler();
          }
        }
        for (int t = 0; t < ENEMY_NUMBER; t++) {
          //this is the hitbox detection of scouts.
          if (enemy[t].enemyType == 1 && weapon[i].bulletXposition < enemy[t].eX + enemy[t].scoutHitboxX && weapon[i].bulletXposition > enemy[t].eX - enemy[t].scoutHitboxX && weapon[i].bulletYposition < enemy[t].eY + enemy[t].scoutHitboxY && weapon[i].bulletYposition > enemy[t].eY - enemy[t].scoutHitboxY && enemy[t].isAlive == true) {
            weapon[i].bulletYposition -= height;
            enemy[t].eHP -= PLAYER_BULLET_DAMAGE;
            enemy[t].damageFlashTint = 255;
            if (enemy[t].eHP <= 0) {
              enemy[t].isAlive = false;
              killcount++;
              gatkills++;
              scoreObj.addScore(enemy[t].score * scoreMultiplier);
              particle[0].particlesPerTurn = 20;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
              visuals.screenShake(15, 20, true);
            }
          }
          
          //this is the hitbox detection of coursers.
          if (enemy[t].enemyType == 2 && weapon[i].bulletXposition < enemy[t].eX + enemy[t].courserHitboxX && weapon[i].bulletXposition > enemy[t].eX - enemy[t].courserHitboxX && weapon[i].bulletYposition < enemy[t].eY + enemy[t].courserHitboxY && weapon[i].bulletYposition > enemy[t].eY - enemy[t].courserHitboxY && enemy[t].isAlive == true) {
            weapon[i].bulletYposition -= height;
            enemy[t].eHP -= PLAYER_BULLET_DAMAGE;
            enemy[t].damageFlashTint = 255;
            if (enemy[t].eHP <= 0) {
              enemy[t].isAlive = false;
              killcount++;
              gatkills++;
              scoreObj.addScore(enemy[t].score * scoreMultiplier);
              particle[0].particlesPerTurn = 40;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
              visuals.screenShake(25, 30, true);
            }
          }
          
          //this is the hitbox detection of the goliath shield.
          if (enemy[t].shieldAlive) {
            if (enemy[t].enemyType == 3 && weapon[i].bulletXposition < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].bulletXposition > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].bulletYposition < enemy[t].eY + enemy[t].goliathHitboxY  * 1.4 && weapon[i].bulletYposition > enemy[t].eY + enemy[t].goliathHitboxY * -1 && enemy[t].isAlive == true) {
              weapon[i].bulletYposition -= height;
              enemy[t].shieldHP -= PLAYER_BULLET_DAMAGE;
              if (enemy[t].shieldHP <= 0) {
                enemy[t].shieldAlive = false;
              }
            }
          } else {  //this is the hitbox detection of the goliath, which is only active when the boolean variable shieldAlive is set to false (the shield has no hitpoints).
            if (enemy[t].enemyType == 3 && weapon[i].bulletXposition < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].bulletXposition > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].bulletYposition < enemy[t].eY + enemy[t].goliathHitboxY && weapon[i].bulletYposition > enemy[t].eY - enemy[t].goliathHitboxY && enemy[t].isAlive == true) {
              weapon[i].bulletYposition -= height;
              enemy[t].eHP -= PLAYER_BULLET_DAMAGE;
              enemy[t].damageFlashTint = 255;
              if (enemy[t].eHP <= 0) {
                enemy[t].isAlive = false;
                killcount++;
                gatkills++;
                scoreObj.addScore(enemy[t].score * scoreMultiplier);
                goliathOnScreen--;
                particle[0].particlesPerTurn = 60;
                particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
                visuals.screenShake(35, 40, true);
              }
            }
          }
        }
      }
    }
  }


  void drawPlayerBullets() {
    for (int i = 0; i < PLAYER_BULLET_NUMBER; i++) {
      if (weapon[i].projectileType == 1) {
        if (weapon[i].bulletIsOnScreen) {
          image(lightBullet, weapon[i].bulletXposition + visuals.magnitudeX, weapon[i].bulletYposition + visuals.magnitudeY, weapon[i].bulletWidth, weapon[i].bulletHeight);
        }
      }
    }
  }


  //Player laser functions

  void spawnPlayerLaser() {
    for (int i = 0; i < 2; i++) {
      if (player.isShooting && reloadTime + PLAYER_LASER_FIRERATE < millis() && !weapon[i].laserIsAlive) {
        reloadTime = millis();
        laserStrengthTimer = millis();
        for (int e = 0; e < PLAYER_LASER_PER_SALVO; e++) {
          if (playerLaserTurn%2 == 0) {            //if the current bullet's number is an even number, it spawns  in the left gun, otherwise it spawns in the right gun
            weapon[playerLaserTurn].laserXposition = player.playerXposition + player.DEFAULT_PLAYER_WIDTH / 2 * 0.891;
          } else {
            weapon[playerLaserTurn].laserXposition = player.playerXposition - player.DEFAULT_PLAYER_WIDTH / 2 * 0.891;
          }
          weapon[playerLaserTurn].laserYposition1 = player.playerYposition - player.DEFAULT_PLAYER_HEIGHT / 2 * 0.758;
          weapon[playerLaserTurn].laserYposition2 = weapon[playerLaserTurn].laserYposition1 - laserHeight;
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
        if (i%2 == 0) {          //if the current laser's number is an even number, it spawns  in the left gun, otherwise it spawns in the right gun
          weapon[i].laserXposition = player.playerXposition + player.DEFAULT_PLAYER_WIDTH / 2 * 0.891;
        } else {
          weapon[i].laserXposition = player.playerXposition - player.DEFAULT_PLAYER_WIDTH / 2 * 0.891;
        }
        weapon[i].laserYposition1 = player.playerYposition - player.DEFAULT_PLAYER_HEIGHT / 2 * 0.758;
        weapon[i].laserYposition2 = weapon[i].laserYposition1 - laserHeight;

        if (weapon[i].laserStrengthTimer + 100 < millis()) {  //these are the different states (thickness) of the lasers. It goes from thin to thick, then thick to thin.
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
      //this if statement detects if the laser collides with the boss' hitbox.
      if (weapon[i].laserXposition - weapon[i].laserWidth/2 < boss.bossX + boss.bossX/2 && weapon[i].laserXposition + weapon[i].laserWidth/2 > boss.bossX - boss.bossX/2 && boss.bossAlive && weapon[i].laserIsAlive) {
        weapon[i].bulletYposition -= height;
        boss.bossHealth -= 15;
        if (boss.bossHealth <= 0) {
          boss.deathHandler();
        }
      }
      
      //this if statement detects if the laser collides with the scouts' hitbox.
      for (int t = 0; t < ENEMY_NUMBER; t++) {
        if (enemy[t].enemyType == 1 && weapon[i].laserXposition - weapon[i].laserWidth/2 < enemy[t].eX + enemy[t].scoutHitboxX && weapon[i].laserXposition + weapon[i].laserWidth/2 > enemy[t].eX - enemy[t].scoutHitboxX && enemy[t].isAlive && weapon[i].laserIsAlive) {
          weapon[i].bulletYposition -= height;
          enemy[t].eHP = enemy[t].eHP - PLAYER_LASER_DAMAGE_PER_FRAME;
          enemy[t].damageFlashTint = 100;
          if (enemy[t].eHP <= 0) {
            enemy[t].isAlive = false;
            killcount++;
            laserkills++;
            scoreObj.addScore(enemy[t].score * scoreMultiplier);
            particle[0].particlesPerTurn = 20;
            particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            visuals.screenShake(15, 20, true);
          }
        }
        
        //this if statement detects if the laser collides with the coursers' hitbox.
        if (enemy[t].enemyType == 2 && weapon[i].laserXposition - weapon[i].laserWidth/2 < enemy[t].eX + enemy[t].courserHitboxX && weapon[i].laserXposition + weapon[i].laserWidth/2 > enemy[t].eX - enemy[t].courserHitboxX && enemy[t].isAlive && weapon[i].laserIsAlive) {
          weapon[i].bulletYposition -= height;
          enemy[t].eHP = enemy[t].eHP - PLAYER_LASER_DAMAGE_PER_FRAME;
          enemy[t].damageFlashTint = 100;
          if (enemy[t].eHP <= 0) {
            enemy[t].isAlive = false;
            killcount++;
            laserkills++;
            scoreObj.addScore(enemy[t].score * scoreMultiplier);
            particle[0].particlesPerTurn = 40;
            particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            visuals.screenShake(25, 30, true);
          }
        } 
        
        //this if statement detects if the laser collides with the goliaths' hitbox. Not the shields', because the laser pierces the shield.
        if (enemy[t].enemyType == 3 && weapon[i].laserXposition - weapon[i].laserWidth/2 < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].laserXposition + weapon[i].laserWidth/2 > enemy[t].eX - enemy[t].goliathHitboxX && enemy[t].isAlive && weapon[i].laserIsAlive) {
          weapon[i].bulletYposition -= height;
          enemy[t].eHP = enemy[t].eHP - PLAYER_LASER_DAMAGE_PER_FRAME;
          enemy[t].damageFlashTint = 100;
          if (enemy[t].eHP <= 0) {
            enemy[t].isAlive = false;
            killcount++;
            laserkills++;
            scoreObj.addScore(enemy[t].score * scoreMultiplier);
            particle[0].particlesPerTurn = 60;
            particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
            visuals.screenShake(35, 40, true);
          }
        }
      }
    }
  }

  void drawPlayerLaser() {
    for (int i = 0; i < 2; i++) {
      if (weapon[i].laserIsAlive) {
        image(weapon[i].laser, weapon[i].laserXposition + visuals.magnitudeX, weapon[i].laserYposition1 - weapon[i].laserHeight/2 + visuals.magnitudeY, weapon[i].laserWidth, weapon[i].laserHeight);
      }
    }
  }

  //Player rockets functions here

  void spawnPlayerRockets() {//This function was written bulletYposition Noah Verburg
    if (player.isShooting && !weapon[playerProjectileTurn].rocketIsOnScreen && millis() - PLAYER_ROCKET_FIRERATE > reloadTime) {  //if the shot-button is pressed and the bullet that is supposed to
      reloadTime = millis();                                                                                                //shoot out isnt on screen and the reload timer is done, it fires a bullet
      //for (int i = 0; i < PLAYER_ROCKET_PER_SALVO; i++) {
      if (playerProjectileTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
        weapon[playerProjectileTurn].rocketXposition = player.playerXposition + player.DEFAULT_PLAYER_WIDTH / 2 * 0.891;        //left gun, otherocketWidthise it spawns in the right turret
      } else {
        weapon[playerProjectileTurn].rocketXposition = player.playerXposition - player.DEFAULT_PLAYER_WIDTH / 2 * 0.891;
      }
      weapon[playerProjectileTurn].rocketYposition = player.playerYposition - player.DEFAULT_PLAYER_HEIGHT / 2 * 0.678;
      weapon[playerProjectileTurn].projectileType = 2;
      weapon[playerProjectileTurn].rocketIsOnScreen = true;
      weapon[playerProjectileTurn].shortestDistance = 100000;

      for (int t = 0; t < ENEMY_NUMBER; t++) {    //this is a very important if-statement. It detects which enemy has the shortest distance to the player rocket when it spawns.
        if (enemy[t].isAlive) {
          enemy[t].individualRocketEnemyDistance = dist(weapon[playerProjectileTurn].rocketXposition, weapon[playerProjectileTurn].rocketYposition, enemy[t].eX, enemy[t].eY);
          if (enemy[t].individualRocketEnemyDistance < weapon[playerProjectileTurn].shortestDistance && enemy[t].individualRocketEnemyDistance < width/3) {
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
    for (int i = 0; i < PLAYER_BULLET_NUMBER; i++) {
      if (weapon[i].projectileType == 2) {
        if (weapon[i].rocketYposition < 0 - weapon[i].rocketHeight || weapon[i].rocketYposition > height + weapon[i].rocketHeight || weapon[i].rocketXposition < 0 - weapon[i].rocketWidth || weapon[i].rocketXposition > width + weapon[i].rocketWidth) {
          weapon[i].rocketIsOnScreen = false;
        }
        
        //this if-statement is very important, it keeps track of the distance between the target enemy and the rocket, and adjusts the rockets' course according to it.
        if (weapon[i].rocketIsOnScreen) {
          if (enemy[weapon[i].enemyTarget].isAlive) {
            weapon[i].distanceX = dist(enemy[weapon[i].enemyTarget].eX, 0, weapon[i].rocketXposition, 0);
            weapon[i].distanceY = dist(0, enemy[weapon[i].enemyTarget].eY, 0, weapon[i].rocketYposition);
            if (weapon[i].distanceX < 0) {
              weapon[i].distanceX *= -1;
            }
            if (weapon[i].distanceY < 0) {
              weapon[i].distanceY *= -1;
            }
            weapon[i].distanceXandY = weapon[i].distanceX + weapon[i].distanceY;

            weapon[i].rocketVelocityFactorX = weapon[i].distanceX / weapon[i].distanceXandY;  //these calculate the velocity of the rocket on each axis.
            weapon[i].rocketVelocityFactorY = weapon[i].distanceY / weapon[i].distanceXandY;

            if (weapon[i].rocketVelocityFactorY < 0.2) {
              weapon[i].rocketVelocityFactorY = 0.2;
            }

            if (enemy[weapon[i].enemyTarget].eX < weapon[i].rocketXposition) {
              weapon[i].rocketXposition -= weapon[i].rocketVelocity * weapon[i].rocketVelocityFactorX;
            }
            if (enemy[weapon[i].enemyTarget].eX > weapon[i].rocketXposition) {
              weapon[i].rocketXposition += weapon[i].rocketVelocity * weapon[i].rocketVelocityFactorX;
            }
            weapon[i].rocketYposition -= weapon[i].rocketVelocity * weapon[i].rocketVelocityFactorY;
          } else {
            weapon[i].rocketYposition -= weapon[i].rocketVelocity;
          }
        }
        
        if (!weapon[i].rocketIsOnScreen) {
          weapon[i].rocketYposition = height * -2;
        }
        
        //this if-statement detects if the rocket hits the boss' hitbox.
        if (weapon[i].rocketXposition < boss.bossX + boss.bossW/2 && weapon[i].rocketXposition > boss.bossX - boss.bossW/2 && weapon[i].rocketYposition < boss.bossY + boss.bossH/2 && weapon[i].rocketYposition > boss.bossY - boss.bossH/2 && boss.bossAlive == true) {
          weapon[i].rocketYposition -= height;
          boss.bossHealth -= PLAYER_ROCKET_DAMAGE;
          if (boss.bossHealth <= 0) {
            boss.deathHandler();
          }
        }
        for (int t = 0; t < ENEMY_NUMBER; t++) {
          //this if-statement detects if the rocket hits the scouts' hitbox.
          if (enemy[t].enemyType == 1 && weapon[i].rocketXposition < enemy[t].eX + enemy[t].scoutHitboxX && weapon[i].rocketXposition > enemy[t].eX - enemy[t].scoutHitboxX && weapon[i].rocketYposition < enemy[t].eY + enemy[t].scoutHitboxY && weapon[i].rocketYposition > enemy[t].eY - enemy[t].scoutHitboxY && enemy[t].isAlive == true) {
            weapon[i].rocketYposition -= height;
            enemy[t].eHP -= PLAYER_ROCKET_DAMAGE;
            enemy[t].damageFlashTint = 255;
            if (enemy[t].eHP <= 0) {
              enemy[t].isAlive = false;
              killcount++;
              rockkills++;
              scoreObj.addScore(enemy[t].score * scoreMultiplier);
              particle[0].particlesPerTurn = 20;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
              visuals.screenShake(15, 20, true);
            }
          }
          
          //this if-statement detects if the rocket hits the coursers' hitbox.
          if (enemy[t].enemyType == 2 && weapon[i].rocketXposition < enemy[t].eX + enemy[t].courserHitboxX && weapon[i].rocketXposition > enemy[t].eX - enemy[t].courserHitboxX && weapon[i].rocketYposition < enemy[t].eY + enemy[t].courserHitboxY && weapon[i].rocketYposition > enemy[t].eY - enemy[t].courserHitboxY && enemy[t].isAlive == true) {
            weapon[i].rocketYposition -= height;
            enemy[t].eHP -= PLAYER_ROCKET_DAMAGE;
            enemy[t].damageFlashTint = 255;
            if (enemy[t].eHP <= 0) {
              enemy[t].isAlive = false;
              killcount++;
              rockkills++;
              scoreObj.addScore(enemy[t].score * scoreMultiplier);
              particle[0].particlesPerTurn = 40;
              particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
              visuals.screenShake(25, 30, true);
            }
          }
          
          //this if-statement detects if the rocket hits the goliath shields' hitbox.
          if (enemy[t].shieldAlive) {
            if (enemy[t].enemyType == 3 && weapon[i].rocketXposition < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].rocketXposition > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].rocketYposition < enemy[t].eY + enemy[t].goliathHitboxY  * 1.4 && weapon[i].rocketYposition > enemy[t].eY + enemy[t].goliathHitboxY * -1 && enemy[t].isAlive == true) {
              weapon[i].rocketYposition -= height;
              enemy[t].shieldHP -= PLAYER_ROCKET_DAMAGE;
              if (enemy[t].shieldHP <= 0) {
                enemy[t].shieldAlive = false;
              }
            }
          } else {  //this if-statement detects if the rocket hits the goliath hitbox, which only activates when the shield has 0 hitpoints.
            if (enemy[t].enemyType == 3 && weapon[i].rocketXposition < enemy[t].eX + enemy[t].goliathHitboxX && weapon[i].rocketXposition > enemy[t].eX - enemy[t].goliathHitboxX && weapon[i].rocketYposition < enemy[t].eY + enemy[t].goliathHitboxY && weapon[i].rocketYposition > enemy[t].eY - enemy[t].goliathHitboxY && enemy[t].isAlive == true) {
              weapon[i].rocketYposition -= height;
              enemy[t].eHP -= PLAYER_ROCKET_DAMAGE;
              enemy[t].damageFlashTint = 255;
              if (enemy[t].eHP <= 0) {
                enemy[t].isAlive = false;
                killcount++;
                rockkills++;
                scoreObj.addScore(enemy[t].score * scoreMultiplier);
                goliathOnScreen--;
                particle[0].particlesPerTurn = 60;
                particle[0].explosion(enemy[t].eX, enemy[t].eY, t);
                visuals.screenShake(35, 40, true);
              }
            }
          }
        }
      }
    }
  }


  void drawPlayerRockets() {
    for (int i = 0; i < PLAYER_BULLET_NUMBER; i++) {
      if (weapon[i].projectileType == 2) {
        if (weapon[i].rocketIsOnScreen) {
          image(rocket, weapon[i].rocketXposition + visuals.magnitudeX, weapon[i].rocketYposition + visuals.magnitudeY, weapon[i].rocketWidth, weapon[i].rocketHeight);
        }
      }
    }
  }
}
