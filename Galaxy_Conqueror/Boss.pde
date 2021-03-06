//this pde file was written by Floris Kuiper
int globalBossTimer = 11500;
int scoutDelay = 3000;
boolean bossKilled = false;

class BossBullet {
  int bossBulletX = -width;
  int bossBulletY = -height;
  int bossBulletW = 12;
  int bossBulletH = 25;
  float bossBulletXV = 0;
  int bossBulletYV = 15;
  boolean isOnScreen = false;
}

class BossRocket {
  int bossRocketX = -width;
  int bossRocketY = -height;
  int bossRocketW = 24;
  int bossRocketH = 50;
  float bossRocketXV = 0;
  int bossRocketYV = 7;
  boolean isOnScreen = false;
}

class Boss {
  float bossX = width / 2;
  float bossY = height / 2;
  float bossW = 1000;
  float bossH = 242;
  float angle;
  float bossOriginPointX = width / 2;
  float bossOriginPointY = height / 2;
  float dx = 30;
  float inc = TWO_PI/75.0;
  int bossSize = 70;
  int initialState = 0;
  int lastStateSwitch = 0;
  int currentState = -1;
  int currentStateTimer = 0;
  int deathrayCooldown = 3;
  int startStateFlag = 0;
  int startStateTime = 0;
  int startDeathrayTime = 0;
  int startIdleTime = 0;
  int bossHealth = 0;
  int deathrayLength = 0;
  int bossBulletCheck = 0;
  int bossBulletCounter = 3;
  int bossRocketCheck = 0;
  int currentGunX = -1;
  int currentGunY = -1;
  int bulletSalvoDelay = 75;
  int rocketSalvoDelay = 100;
  int lastShotTime = 0;
  boolean bossAlive = false;
  boolean bossDied = false;

  final int GUN1_XPOS = width/3 + 8;
  final int GUN2_XPOS = width/3 - 35;
  final int GUN3_XPOS = width/3 - 80;
  final int GUN4_XPOS = width - width/3;
  final int GUN5_XPOS = width - width/3 + 36;
  final int GUN6_XPOS = width - width/3 + 80;
  final int GUN1_YPOS = height/8 - 15;
  final int GUN2_YPOS = height/8 - 25;
  final int GUN3_YPOS = height/8 - 35;
  final int GUN4_YPOS = height/8 - 15;
  final int GUN5_YPOS = height/8 - 25;
  final int GUN6_YPOS = height/8 - 35;

  final int INACTIVE_STATE = -1;
  final int IDLE_STATE = 0;
  final int MISSILE_STATE = 1;
  final int GATLING_GUN_STATE = 2;
  final int DEATHRAY_STATE = 3;
  final int DEATHRAY_VERTICAL_OFFSET = 60;
  final int DEATHRAY_HORIZONTAL_OFFSET = 30;
  final int DEATHRAY_SIZE = 60;
  final int DEATHRAY_TIME = 4000;
  final int DEATHRAY_MAX_LENGTH = height * 2;
  final int BOSS_HEALTH_VALUE = 14000;
  final int BULLET_DELAY = 60;
  final int BULLET_SALVO_DELAY = 100;
  final int ROCKET_SALVO_DELAY = 50;
  final int DEATHRAY_CHARGE_TIME = 500;
  final int BOSS_ROCKET_Y_VELOCITY = 12;
  final int MIDDLE_OF_SCREEN = width / 2;
  final int POSITIVE_BULLET_SPEED = -2;
  final int NEGATIVE_BULLET_SPEED = 2;
  final int NO_HORIZONTAL_SPEED = 0;
  final int BOSS_SPRITE_HEIGHT = 121;
  final int DEATHRAY_LENGTH_INCREMENT = 15;
  final int BOSSTIMER_STARTVALUE = 11500;
  final int BOSS_SPAWN_DELAY = 2000;
  final int IDLE_STATE_TIMER = 4000;
  final int MISSILE_STATE_TIMER = 6000;
  final int GATLINGGUN_STATE_TIMER = 9000;
  final int DEATHRAY_STATE_TIMER = 10000;

  void bossSpawn() {
    bossAlive = true; //marks the boss as being alive, which turns off the spawning of random enemies while keeping the drawing enabled
    currentState = 0;
    bossX = width / 2;
    bossY = -bossH;
    bossHealth = BOSS_HEALTH_VALUE;
    image(bossSprite, bossX, bossY, bossW, bossH); //draws the boss
    bgm.rewind();
    bgm.pause();
  }

  void bossUpdatePosition() { //function that updates the boss' position/position of his projectiles
    if (bossY < BOSS_SPRITE_HEIGHT * 0.9) {
      bossY++;
    }
    bossProjectileUpdatePosition();
  }

  void bossProjectileUpdatePosition() { //updates the position of all of the boss' relevent projectiles
    for (int i = 0; i < bossBullets.length; i++) {
      if (bossBullets[i].isOnScreen == true) {
        bossBullets[i].bossBulletY += bossBullets[i].bossBulletYV; //these lines update the x and y positions of the boss' bullets
        bossBullets[i].bossBulletX += bossBullets[i].bossBulletXV;
      }
      if (bossBullets[i].bossBulletY > height + bossBullets[i].bossBulletH) {
        bossBullets[i].isOnScreen = false;
      }
    }
    for (int i = 0; i < bossRockets.length; i++) {
      if (bossRockets[i].isOnScreen == true) {
        bossRockets[i].bossRocketY += bossRockets[i].bossRocketYV; //these lines update the x and y positions of the boss' rockets
        bossRockets[i].bossRocketX += bossRockets[i].bossRocketXV;
      }
      if (bossRockets[i].bossRocketY > height + bossRockets[i].bossRocketH) {
        bossRockets[i].isOnScreen = false;
      }
    }
  }

  void bossDraw() { //function that draws the boss and his projectiles on the given positions
    if (bossAlive == true) {
      image(bossSprite, bossX + visuals.magnitudeX, bossY + visuals.magnitudeY, bossW, bossH);
      for (int i = 0; i < bossBullets.length; i++) { //two for loops to draw the rockets/bullets
        image(enemyBullet, bossBullets[i].bossBulletX, bossBullets[i].bossBulletY, bossBullets[i].bossBulletW, bossBullets[i].bossBulletH); //this loops through the bullet array and draws them on the given x and y coordinates
      }
      for (int i = 0; i < bossRockets.length; i++) {
        image(bossRocketSprite, bossRockets[i].bossRocketX, bossRockets[i].bossRocketY, bossRockets[i].bossRocketW, bossRockets[i].bossRocketH); //this loops through the rocket array and draws them on the given x and y coordinates
      }
    }
  }

  void bossUpdateBehaviour() { //function that calls every necessary action for the boss to switch states and act accordingly
    stateHandler(); //this function tells the boss what to do on each given frame
    stateSwitcher(); //this functions switches the boss' behaviour when the given timer runs out
  }

  int statePicker() { //function that picks a new state by rolling a dice
    deathrayCooldown--;
    int randomNumber = 0;
    randomNumber = (int)random(0, 100);
    if (bossY < BOSS_SPRITE_HEIGHT * 0.9) {
      currentStateTimer = BOSS_SPAWN_DELAY;
      return IDLE_STATE;
    }
    if (randomNumber >= 0 && randomNumber <= 20 && currentState != IDLE_STATE) { 
      currentStateTimer = IDLE_STATE_TIMER;
      return IDLE_STATE;
    }
    if (randomNumber > 20 && randomNumber <= 50 && currentState != MISSILE_STATE) {
      currentStateTimer = MISSILE_STATE_TIMER;
      return MISSILE_STATE;
    }
    if (randomNumber > 50 && randomNumber <= 90 && currentState != GATLING_GUN_STATE) {
      currentStateTimer = GATLINGGUN_STATE_TIMER;
      return GATLING_GUN_STATE;
    }
    if (randomNumber > 90 && randomNumber <= 100 && deathrayCooldown <= 0) {
      currentStateTimer = DEATHRAY_STATE_TIMER;
      return DEATHRAY_STATE;
    }
    currentStateTimer = IDLE_STATE_TIMER;
    return 0;
  }

  void stateHandler() { //function that is called every draw to determine what the boss does
    switch(currentState) {
    case IDLE_STATE:
      break;

    case MISSILE_STATE: //case that handles firing the boss' missile weapon
      if (rocketSalvoDelay <= 0) {
        createBossRocket();
        rocketSalvoDelay = ROCKET_SALVO_DELAY;
      }
      rocketSalvoDelay--;
      break;

    case GATLING_GUN_STATE: //case that handles the firing of the boss' guns
      if (bulletSalvoDelay <= 0) {
        createBossBulletSalvo();
      }
      bulletSalvoDelay--;
      break;

    case DEATHRAY_STATE: //case that handles the giant laser of death
      if (startDeathrayTime - timer + 3000 < DEATHRAY_TIME && startStateTime <= millis() - DEATHRAY_CHARGE_TIME ) {
        fill(173, 216, 230);
        rect(bossX, bossY + DEATHRAY_VERTICAL_OFFSET, DEATHRAY_SIZE, deathrayLength);
        if (deathrayLength <= DEATHRAY_MAX_LENGTH) {
          deathrayLength += DEATHRAY_LENGTH_INCREMENT;
        }
        playerDeathrayCollisionCheck();
      }
      break;
    }
  }

  void stateSwitcher() { //function that determines when a state has run its course and rolls to determine the next state
    if (startStateFlag == 0) { //flag that checks whether this is the first run through in a new state
      startStateTime = millis();
      startStateFlag = 1;
    }
    if (startStateTime + currentStateTimer <= millis()) {
      currentState = statePicker();
      deathrayLength = 0;
      currentGunX = INACTIVE_STATE;
      currentGunY = INACTIVE_STATE;
      startStateFlag = 0;
    }
  }

  void bossSwarmSpawner() { //spawns scouts on either sides of the screen
    if (scoutDelay <= 0) {
      scoutDelay--;
      for (int i = 0; i >= 0; i++) {
        bossScoutSpawner();
        scoutDelay = (int)random(2000, 3000);
      }
    }
  }

  void deathHandler() { //function that's called in to do the cleanup after the boss dies
    bossAlive = false;
    currentState = -1;
    bossX = -width;
    bossY = -height;
    bossHealth = BOSS_HEALTH_VALUE;
    globalBossTimer = BOSSTIMER_STARTVALUE;
    scoreObj.addScore(2500);

    visuals.screenShake(200, 250, true);
    bossDied = true;
    bossKilled = true;
    bgm.play();
  }

  void createBossBulletSalvo() { //function to create the bullets the boss fires
    for (int i = 0; i < 5; i++) {
      bossBulletCheck = bossBulletRecycle();
      if (lastShotTime < millis() - BULLET_DELAY) {
        if (bossBulletCheck != -1) { //check to see if the returned element of the array wasn't either in use or something went wrong
          if (currentGunY == -1 || currentGunX == -1) {
            currentGunY = 0;
            currentGunX = 0;
          }
          if (bossBullets[bossBulletCheck].isOnScreen == false) {
            bulletXposCoordinator(currentGunX);
            bulletYposCoordinator(currentGunY);
            bossBullets[bossBulletCheck].isOnScreen = true;
            lastShotTime = millis();
          }
        }
      }
    }
  }

  int bossBulletRecycle() {                              //function that checks to see which element of the array can be recycled to be used to store another bullet
    for (int i = 0; i < bossBullets.length; i++) {       //for loop that runs through the array to check each element if it can be recycled or not based on if the bullet has killed an enemy or gone offscreen
      if (bossBullets[i].isOnScreen == false) {
        return i;                                        //returns the number of the element that was found to be suitable
      }
    }
    return -1;                                           //returns -1 if the array is full or something went wrong
  }

  void createBossRocket() {                              //function that creates a rocket in the right spot in the array by picking a slot in the array that is unused and filling it with the right coordinates
    bossRocketCheck = bossRocketRecycle();           
    if (bossRocketCheck != -1) {
      bossRockets[bossRocketCheck].bossRocketX = width / 2;
      bossRockets[bossRocketCheck].bossRocketY = -bossRockets[bossRocketCheck].bossRocketH;
      float playerToRocketDistance = bossRockets[bossRocketCheck].bossRocketX - player.playerXposition;
      bossRockets[bossRocketCheck].bossRocketXV = -(playerToRocketDistance / 120);
      bossRockets[bossRocketCheck].bossRocketYV = BOSS_ROCKET_Y_VELOCITY;
      bossRockets[bossRocketCheck].isOnScreen = true;
    }
  }

  int bossRocketRecycle() {                            //function that checks which element of the array can be used to store the requested rocket's data
    for (int i = 0; i < bossRockets.length; i++) {
      if (bossRockets[i].isOnScreen == false) {
        return i;
      }
    }
    return -1;
  }

  void playerBossRocketCollisionCheck(int counter) { //function that checks if the player is colliding with a rocket
    if (lastCollision <= (timer - 3000)) {
      if (bossRockets[counter].bossRocketX - bossRockets[counter].bossRocketW/2 > player.playerXposition - player.playerWidth/2
        && bossRockets[counter].bossRocketX + bossRockets[counter].bossRocketW/2 < player.playerXposition + player.playerWidth/2
        && bossRockets[counter].bossRocketY - bossRockets[counter].bossRocketH/2 > player.playerYposition - player.playerHeight/2
        && bossRockets[counter].bossRocketY + bossRockets[counter].bossRocketH/2 < player.playerYposition + player.playerHeight/2
        && bossRockets[counter].isOnScreen == true) {
        player.damageFlashTint = 200;
        enemyBullets[counter].bulletYposition = height * -2;
        enemyBullets[counter].bulletXposition = -1 * width;
        enemyBullets[counter].isOnScreen = false;
        lastCollision = millis();
        heartNumber -= 1;
        visuals.screenShake(30, 40, true);
      }
    }
  }

  void playerBossBulletCollisionCheck(int counter) { //function that checks if the player is colliding with a bullet
    if (lastCollision <= (timer - 3000)) {
      if (bossBullets[counter].bossBulletX - bossBullets[counter].bossBulletW/2 > player.playerXposition - player.playerWidth/2
        && bossBullets[counter].bossBulletX + bossBullets[counter].bossBulletW/2 < player.playerXposition + player.playerWidth/2
        && bossBullets[counter].bossBulletY - bossBullets[counter].bossBulletH/2 > player.playerYposition - player.playerHeight/2
        && bossBullets[counter].bossBulletY + bossBullets[counter].bossBulletH/2 < player.playerYposition + player.playerHeight/2
        && bossBullets[counter].isOnScreen == true) {
        player.damageFlashTint = 200;
        enemyBullets[counter].bulletYposition = height * -2;
        enemyBullets[counter].bulletXposition = -1 * width;
        enemyBullets[counter].isOnScreen = false;
        lastCollision = millis();
        heartNumber -= 1;
        visuals.screenShake(30, 40, true);
      }
    }
  }

  void playerDeathrayCollisionCheck() { //function that checks if the player is colliding with the boss' deathray
    if (lastCollision <= (timer - 3000)) {
      if (player.playerXposition > MIDDLE_OF_SCREEN - (DEATHRAY_SIZE / 2) 
        && player.playerXposition < MIDDLE_OF_SCREEN + (DEATHRAY_SIZE / 2)
        && player.playerYposition < deathrayLength) {
        player.damageFlashTint = 200;
        lastCollision = millis();
        heartNumber -= 1;
      }
    }
  }  

  void bulletXposCoordinator(int arrayElement) { //function that supplies the "create bullet" function with the right x positions to put the bullet based on which gun is the current one that's suppsed to be firing
    switch (currentGunX) {
    case 0:
      bossBullets[arrayElement].bossBulletX = GUN1_XPOS;
      bossBullets[arrayElement].bossBulletXV = NEGATIVE_BULLET_SPEED; //this makes the x velocity of the bullet negative so that it fires in a pattern instead of firing every bullet straight aheaed
      currentGunX++;
      break;
    case 1:
      bossBullets[arrayElement].bossBulletX = GUN2_XPOS;
      bossBullets[arrayElement].bossBulletXV = NO_HORIZONTAL_SPEED;
      currentGunX++;
      break;
    case 2:
      bossBullets[arrayElement].bossBulletX = GUN3_XPOS;
      bossBullets[arrayElement].bossBulletXV = POSITIVE_BULLET_SPEED; //ditto, but this makes the velocity positive so it flies outward
      currentGunX++;
      break;
    case 3:
      bossBullets[arrayElement].bossBulletX = GUN4_XPOS;
      bossBullets[arrayElement].bossBulletXV = NEGATIVE_BULLET_SPEED;
      currentGunX++;
      break;
    case 4:
      bossBullets[arrayElement].bossBulletX = GUN5_XPOS;
      bossBullets[arrayElement].bossBulletXV = NO_HORIZONTAL_SPEED;
      currentGunX++;
      break;
    case 5:
      bossBullets[arrayElement].bossBulletX = GUN6_XPOS;
      bossBullets[arrayElement].bossBulletXV = POSITIVE_BULLET_SPEED;
      currentGunX = -1;
      break;
    }
  }

  void bulletYposCoordinator(int arrayElement) { //function that supplies the "create bullet" function with the right y positions to put the bullet based on which gun is the current gun that's supposed to be firing
    switch (currentGunX) {
    case 0:
      bossBullets[arrayElement].bossBulletY = GUN1_YPOS;
      currentGunY++;
      break;
    case 1:
      bossBullets[arrayElement].bossBulletY = GUN2_YPOS;
      currentGunY++;
      break;
    case 2:
      bossBullets[arrayElement].bossBulletY = GUN3_YPOS;
      currentGunY++;
      break;
    case 3:
      bossBullets[arrayElement].bossBulletY = GUN4_YPOS;
      currentGunY++;
      break;
    case 4:
      bossBullets[arrayElement].bossBulletY = GUN5_YPOS;
      currentGunY++;
      break;
    case 5:
      bossBullets[arrayElement].bossBulletY = GUN6_YPOS;
      bulletSalvoDelay = BULLET_SALVO_DELAY;  //this resets the timer on the bullet salvo causing it to wait a few seconds before firing again
      currentGunY = -1;
      break;
    }
  }
}
