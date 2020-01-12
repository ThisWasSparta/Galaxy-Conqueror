//this class was mainly written by Noah Verburg
class Variable {

  void loadGameValues() {   
    if (!valuesLoaded) {
      bgm = minim.loadFile("./sound/stagethemefix.wav");
      playergatshoot = minim.loadFile("./sound/gattlingweapon_noise.wav");
      enemyshoot = minim.loadFile("./sound/scout_shootnoise.wav");
      maintheme = minim.loadFile("./sound/main_theme.wav");
      player.playerXposition = width/2;                        //here are all the variables that
      player.playerYposition = height - height / 5;            //can't be defined in setup() or are
      wScale = width/1920;                           //easier to find in here than in setup()
      hScale = height/1080;
      player.playerWidth = player.DEFAULT_PLAYER_WIDTH * wScale;
      player.playerHeight = player.DEFAULT_PLAYER_HEIGHT * hScale;
      player.playerMaxVelocity = player.playerVelocityFactor * width;
      player.isShooting = false;
      tX= width/2;
      tY= height/2;
      player.weaponWheelX = 0.925 * width;
      player.weaponWheelY = 0.1 * height;
      player.weaponWheelSelectorY = player.weaponWheelY - 0.2 * player.weaponWheelSize;
      player.weaponWheelSize = player.DEFAULT_WEAPON_WHEEL_SIZE * ((wScale + hScale)/2) * 1.8;
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
        weapon[i].bulletXposition = width/2;
        weapon[i].bulletYposition = height * -2;
        weapon[i].bulletWidth = weapon[i].DEFAULT_BULLET_WIDTH * wScale;
        weapon[i].bulletHeight = weapon[i].DEFAULT_BULLET_HEIGHT * hScale;
        weapon[i].bulletVelocity = weapon[i].bulletVelocityFactor * width;

        weapon[i].laserWidth = weapon[i].DEFAULT_LASER_WIDTH * wScale;
        weapon[i].laserHeight = height;
        weapon[i].laserXposition = width * 2;
        weapon[i].laserYposition1 = height;
        weapon[i].laserYposition2 = 0;

        weapon[i].rocketXposition = width/2;
        weapon[i].rocketYposition = height * -2;
        weapon[i].rocketWidth = weapon[i].DEFAULT_ROCKET_WIDTH * wScale;
        weapon[i].rocketHeight = weapon[i].DEFAULT_ROCKET_HEIGHT * hScale;
        weapon[i].rocketVelocity = weapon[i].rocketVelocityFactor * width;
      }
      for (int i = 0; i < ENEMY_BULLET_NUMBER; i++) {
        enemyBullets[i].bulletWidth = weapon[i].DEFAULT_BULLET_WIDTH * wScale * 1.5;
        enemyBullets[i].bulletHeight = weapon[i].DEFAULT_BULLET_HEIGHT * hScale * 1.5;
        enemyBullets[i].bulletVelocity = enemyBullets[0].enemyBulletVelocityFactor * width;
        enemyBullets[i].enemyBullet = loadImage("EnemyBullet.png");
      }

      player.weapon1 = loadImage("Spaceship Weapon 1-1.png");
      player.weapon2 = loadImage("Spaceship Weapon 2-1.png");
      player.weapon3 = loadImage("Spaceship Weapon 3-1.png");
      player.weaponWheel = loadImage("Weapon Wheel 1.png");
      player.weaponWheelSelector = loadImage("Weapon Wheel 2.png");
      doublepointsPowerup = loadImage("Doublepoints_Powerup_Line.png");
      speedPowerup = loadImage("Speed_Powerup_Line.png");
      screenwipePowerup = loadImage("Energy Orb.png");
      enemyBullet = loadImage("EnemyBullet.png");
      bossRocketSprite = loadImage("BossRocket.png");
      ach1 = loadImage("./1kill.png");
      ach2 = loadImage("./50kill.png");
      ach3 = loadImage("./100kill.png");
      ach4 = loadImage("./500kill.png");
      ach5 = loadImage("./1kkill.png");
      ach6 = loadImage("./10kkill.png");
      ach7 = loadImage("./jack.png");
      ach8 = loadImage("./master.png");
      ach9 = loadImage("./diehard.png");
      ach10 = loadImage("./eternity.png");
      ach11 = loadImage("./1die.png");
      ach12 = loadImage("./loser.png");
      ach13 = loadImage("./killboss.png");
      ach14 = loadImage("./killboss3.png");
      valuesLoaded = true;
    }
  }
}
