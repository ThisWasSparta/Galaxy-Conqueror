class Variable {
  void loadGameValues() {                    //This function was written by Noah Verburg
    if (!startGame) {
      player.pX = width/2;                        //here are all the variables that
      player.pY = height - height / 5;            //can't be defined in setup() or are
      wScale = width/1920;                           //easier to find in here than in setup()
      hScale = height/1080;
      player.pW = player.defaultPlayerWidth * wScale;
      player.pH = player.defaultPlayerHeight * hScale;
      player.pV = player.playerVelocityFactor * width;
      player.isShooting = false;
      tX= width/2;
      tY= height/2;
      for (int i = 0; i < enemyNumber; i++) {
        enemy[i].orbW = enemy[i].defaultGoliathOrbSize * wScale;
        enemy[i].orbH = enemy[i].defaultGoliathOrbSize * hScale;
        enemy[i].shieldW = enemy[i].defaultGoliathShieldWidth * wScale;
        enemy[i].shieldH = enemy[i].defaultGoliathShieldHeight * hScale;
        enemy[i].scoutEnemy = loadImage("Scout Enemy.png");
        enemy[i].courserEnemy = loadImage("Courser Enemy.png");
        enemy[i].goliathEnemy = loadImage("Goliath Enemy.png");
        enemy[i].goliathOrb = loadImage("Energy Orb.png");
        enemy[i].goliathShield = loadImage("Goliath Shield.png");
      } 
      for (int i = 0; i < heartNumber; i++) {
        heart[i].heartW = heart[i].defaultHeartWidth * wScale;
        heart[i].heartH = heart[i].defaultHeartHeight * hScale;
      }
  
      for (int i = 0; i < playerBulletNumber; i++) {
        bullet[i].lightBullet = loadImage("LightBullet.png");
        bullet[i].bX = width/2;
        bullet[i].bY = height * -2;
        wScale = width/1920;
        hScale = height/1080;
        bullet[i].bW = bullet[i].defaultBulletWidth * wScale;
        bullet[i].bH = bullet[i].defaultBulletHeight * hScale;
        bullet[i].bV = bullet[i].bulletVelocityFactor * width;
      }
      for (int i = 0; i < enemyBulletNumber; i++) {
        enemyBullets[i].bW = bullet[i].defaultBulletWidth * wScale * 1.2;
        enemyBullets[i].bH = bullet[i].defaultBulletHeight * hScale * 1.2;
        enemyBullets[i].bV = bullet[i].bulletVelocityFactor * width;
        enemyBullets[i].enemyBullet = loadImage("EnemyBullet.png");
      }
  
      player.weapon1 = loadImage("Spaceship Weapon 1-1.png");
      //player.weapon2 = loadImage("Spaceship Weapon 2-1.png");
      //player.weapon3 = loadImage("Spaceship Weapon 3-1.png");
    }
  }
}
