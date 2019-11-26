//this pde file was written by Floris Kuiper

float bossX = width / 2;
float bossY = height / 2;
float angle;
float bossOriginPointX = width / 2;
float bossOriginPointY = height / 2;
float dx = 30;
float inc = TWO_PI/75.0;
int bossSize = 70;
int initialState = 0;
int lastStateSwitch = 0;
int currentState = 0;
int currentStateTimer = 0;
int deathrayCooldown = 3;
int startStateFlag = 0;
int startStateTime = 0;
boolean bossAlive = false;
final int IDLE_STATE = 0;
final int MISSILE_STATE = 1;
final int REQUEST_BACKUP_STATE = 2;
final int DEATHRAY_STATE = 3;

void bossUpdatePosition() { //function that makes the boss slowly move up and down
  //ang = radians(angle); < probably redundant, just want to be sure before i remove it
  bossY = bossOriginPointX + (10 * sin(dx * inc));
  rect(bossX, bossY, bossSize, bossSize);
  //angle += 2; < ditto
}

void bossDraw() { //function that draws the boss on the given positions
  if (bossAlive == true) {
    rect(bossX, bossY, bossSize, bossSize);
  }
}

void bossUpdateBehaviour() { //function that calls every necessary action for the boss to switch states and act accordingly
  stateHandler();
  stateSwitcher();
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
    //call enemyspawner with the scout's enemy type to summon two groups of three scouts on either side of the play area
    //shoot bullets meanwhile?
    //maybe merge this state with the deathray state...
    break;
  case DEATHRAY_STATE:
    //play charge sound + have a charging particle effect?
    //time until sound played
    //shoot laser + play laser sound
    //time until laser should stop
    //go to idle state to give the player some time to readjust
    break;
  }
}

int statePicker() {
  deathrayCooldown--;
  int randomNumber = (int)random(0, 100);
  if (deathrayCooldown > 0) {
    randomNumber = (int)random(0, 90);
  }
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
    return DEATHRAY_STATE;
  }
  return 0;
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
