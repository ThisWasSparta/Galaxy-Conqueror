//this class was mainly written by Noah Verburg
class Variable {

  void loadGameValues() {   
    if (!valuesLoaded) {
      player.pX = width/2;                        //here are all the variables that
      player.pY = height - height / 5;            //can't be defined in setup() or are
      wScale = width/1920;                           //easier to find in here than in setup()
      hScale = height/1080;
      player.pW = player.DEFAULT_PLAYER_WIDTH * wScale;
      player.pH = player.DEFAULT_PLAYER_HEIGHT * hScale;
      player.pMaxV = player.playerVelocityFactor * width;
      player.isShooting = false;
      tX= width/2;
      tY= height/2;
      player.weaponWheelX = 0.95 * width;
      player.weaponWheelY = 0.1 * height;
      events.randomTimeBetweenEvents = int(random(events.timeBetweenEventsMin, events.timeBetweenEventsMax));
      meteoriet.meteorite = loadImage("Meteorite 1.png");
      for (int i = 0; i < ENEMY_NUMBER; i++) {
        enemy[i].orbW = enemy[i].defaultGoliathOrbSize * wScale;
        enemy[i].orbH = enemy[i].defaultGoliathOrbSize * hScale;
        enemy[i].shieldW = enemy[i].defaultGoliathShieldWidth * wScale;
        enemy[i].shieldH = enemy[i].defaultGoliathShieldHeight * hScale;
        enemy[i].scoutEnemy = loadImage("Scout Enemy.png");
        enemy[i].courserEnemy = loadImage("Courser Enemy.png");
        enemy[i].goliathEnemy = loadImage("Goliath Enemy.png");
        enemy[i].goliathOrb = loadImage("Energy Orb.png");
        enemy[i].goliathShield = loadImage("Goliath Shield.png");
        bossSprite = loadImage("Boss.png");
      } 
      for (int i = 0; i < heartNumber; i++) {
        heart[i].heartW = heart[i].defaultHeartWidth * wScale;
        heart[i].heartH = heart[i].defaultHeartHeight * hScale;
      }

      for (int i = 0; i < PLAYER_BULLET_NUMBER; i++) {
        weapon[i].lightBullet = loadImage("LightBullet.png");
        weapon[i].laser = loadImage("Player Laser 1.png");
        weapon[i].rocket = loadImage("Player Rocket.png");
        wScale = width/1920;
        hScale = height/1080;
        weapon[i].bX = width/2;
        weapon[i].bY = height * -2;
        weapon[i].bW = weapon[i].DEFAULT_BULLET_WIDTH * wScale;
        weapon[i].bH = weapon[i].DEFAULT_BULLET_HEIGHT * hScale;
        weapon[i].bV = weapon[i].bulletVelocityFactor * width;

        weapon[i].lW = weapon[i].DEFAULT_LASER_WIDTH * wScale;
        weapon[i].lH = height;
        weapon[i].lX = width * 2;
        weapon[i].lY1 = height;
        weapon[i].lY2 = 0;

        weapon[i].rX = width/2;
        weapon[i].rY = height * -2;
        weapon[i].rW = weapon[i].DEFAULT_ROCKET_WIDTH * wScale;
        weapon[i].rH = weapon[i].DEFAULT_ROCKET_HEIGHT * hScale;
        weapon[i].rV = weapon[i].rocketVelocityFactor * width;
      }
      for (int i = 0; i < ENEMY_BULLET_NUMBER; i++) {
        enemyBullets[i].bW = weapon[i].DEFAULT_BULLET_WIDTH * wScale * 1.5;
        enemyBullets[i].bH = weapon[i].DEFAULT_BULLET_HEIGHT * hScale * 1.5;
        enemyBullets[i].bV = enemyBullets[0].enemyBulletVelocityFactor * width;
        enemyBullets[i].enemyBullet = loadImage("EnemyBullet.png");
      }

      player.weapon1 = loadImage("Spaceship Weapon 1-1.png");
      player.weapon2 = loadImage("Spaceship Weapon 2-1.png");
      //player.weapon3 = loadImage("Spaceship Weapon 3-1.png");
      doublepointsPowerup = loadImage("Doublepoints_Powerup_Line.png");
      speedPowerup = loadImage("Speed_Powerup_Line.png");
      screenwipePowerup = loadImage("Energy Orb.png");
      valuesLoaded = true;
    }
  }
}
