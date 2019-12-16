//this pde file was written by Floris Kuiper

int globalBossTimer = 11500;
int scoutDelay = 3000;

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
  boolean bossAlive = false;
  final int INACTIVE_STATE = -1;
  final int IDLE_STATE = 0;
  final int MISSILE_STATE = 1;
  final int REQUEST_BACKUP_STATE = 2;
  final int DEATHRAY_STATE = 3;
  final int DEATHRAY_VERTICAL_OFFSET = 60;
  final int DEATHRAY_HORIZONTAL_OFFSET = 30;
  final int DEATHRAY_SIZE = 60;
  final int DEATHRAY_TIME = 5000;
  final int BOSS_HEALTH_VALUE = 14000;

  void bossSpawn() {
    bossAlive = true; //marks the boss as being alive, turns off the spawning of random enemies while keeping the drawing of enemies enabled
    currentState = 0;
    bossX = width / 2;
    bossY = -bossH;
    bossHealth = BOSS_HEALTH_VALUE;
    image(bossSprite, bossX, bossY, bossW, bossH);
    //spawn the boss above the screen, slowly move him down into view
    //fade out level music
    //kick in the music
    //
  }

  void bossUpdatePosition() { //function that makes the boss slowly move up and down
    //ang = radians(angle); < probably redundant, just want to be sure before i remove it
    //jbossY = bossY + (10 * sin(dx * inc));
    if (bossY < 121) {
      bossY++;
    }
    //rect(bossX, bossY, bossSize, bossSize);
    //angle += 2; < ditto
  }

  void bossDraw() { //function that draws the boss on the given positions
    if (bossAlive == true) {
      image(bossSprite, bossX, bossY, bossW, bossH);
    }
  }

  void bossUpdateBehaviour() { //function that calls every necessary action for the boss to switch states and act accordingly
    stateHandler();
    stateSwitcher();
  }

  int statePicker() {
    deathrayCooldown--;
    int randomNumber = 0;
    if (deathrayCooldown > 0) {
      randomNumber = (int)random(0, 90);
    }
    randomNumber = (int)random(0, 100);
    if (currentState == 3) {
      currentStateTimer = 5000;
      return IDLE_STATE;
    }
    if (randomNumber >= 0 && randomNumber <= 30 && currentState != IDLE_STATE) {
      currentStateTimer = 5000;
      return IDLE_STATE;
    }
    if (randomNumber >= 30 && randomNumber <= 60) {
      currentStateTimer = 15000;
      return MISSILE_STATE;
    }
    if (randomNumber > 60 && randomNumber < 90) {
      currentStateTimer = 6000;
      return REQUEST_BACKUP_STATE;
    }
    if (randomNumber > 90 && randomNumber <= 100 && deathrayCooldown <= 0) {
      currentStateTimer = 10000;
      startDeathrayTime = timer;
      return DEATHRAY_STATE;
    }
    return 0;
  }

  void stateHandler() { //function that is called every draw to determine what the boss does next
    switch(currentState) {
    case IDLE_STATE:
      if (((startStateTime - millis()) * -1) >= 5000) { //if statement that checks when 5 seconds of idle time have passed upon which a new state is picked. idle time will never occur twice in a row
        statePicker();
      }
      break;

    case MISSILE_STATE:
      //call missilespawner to continuously summon a group of three missiles from the top of the screen
      //do this every 2 seconds until the state ends
      //end the state after... 15 seconds? something like that
      break;

    case REQUEST_BACKUP_STATE:
      if (scoutDelay <= 0) {
        scoutDelay--;
        for (int i = 0; i >= 0; i++) {
          bossScoutSpawner();
          scoutDelay = 3000;
        }
      }
      //call enemyspawner with the scout's enemy type to summon two groups of three scouts on either side of the play area
      //shoot bullets meanwhile?
      //maybe merge this state with the deathray state...
      break;

    case DEATHRAY_STATE:
      if (startDeathrayTime - timer < DEATHRAY_TIME) {
        fill(173, 216, 230);
        rect(bossX + DEATHRAY_HORIZONTAL_OFFSET, bossY + DEATHRAY_VERTICAL_OFFSET, DEATHRAY_SIZE, deathrayLength);
        if (deathrayLength <= height) {
          deathrayLength += 10;
        }
      }
      //play charge sound + have a charging particle effect?
      //time until sound played
      //shoot laser + play laser sound
      //time until laser should stop
      //go to idle state to give the player some time to readjust
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
      startStateFlag = 0;
    }
  }

  void deathHandler() { //function that's called in to do the cleanup after the boss dies
    bossAlive = false;
    currentState = -1;
    bossX = -width;
    bossY = -height;
    bossHealth = BOSS_HEALTH_VALUE;
    globalBossTimer = 11500;
    scoreObj.addScore(2500);
    bgm.rewind();
    bgm.play();
    println("Change da world. My final message. Goodbye.");
  }
}
