/* This code is written by group 3 of IG-101 FYS project. It is a game called
 Space Conqueror, and is similar to space invaders and galaga. Where possible it is shown which
 student made the code.*/

int isShot = 0;
int starsNumber = 200;                //Star number
int playerBulletNumber = 100;
int playerBulletPerSalvo = 2;
int playerBulletTurn = 0;
int playerBulletFireRate = 100;
int reloadTime = 0;                   //time it takes for the ship to be able to shoot again
int enemyNumber = 20;
int enemyBulletNumber = 20;
int tX;
int tY;
int lastBulletSpawn;
int lives = 3;
int stopGameTime;

int timer = millis();                 //contains the time from when the game was launched in milliseconds
int startTime;                        //contains the time when start was pressed in milliseconds

boolean salvoDone;                    //when the player is done shooting the salvo of bullets
boolean startGame = false;            //whether the game has started or not
boolean stopGame = false;

float sizeFactor = 0.8;
float wScale;                         //width scale used to adjust the width of images
float hScale;                         //height scale used to adjust the height of images
float orbW;
float orbH;
float heartW;
float heartH;
float shieldW;
float shieldH;
float shootStart;                     //alternative framecount of the moment the shooting starts
float playerVelocityFactor = 0.006;   //factor which is used to get the desired player velocity compared to the width of the screen
float bulletVelocityFactor = 0.01;    //factor which is used to get the desired bullet velocity compared to the width of the screen
float scoutEnemyVelocityFactor = 0.0025;
float courserEnemyVelocityFactor = 0.0015;
float goliathEnemyVelocityFactor = 0.00085;
float defaultHeartWidth = 54 * sizeFactor;
float defaultHeartHeight = 42 * sizeFactor;
float defaultPlayerWidth = 128 * sizeFactor;
float defaultPlayerHeight = 118 * sizeFactor;
float defaultBulletWidth = 10 * sizeFactor;
float defaultBulletHeight = 20 * sizeFactor;
float defaultScoutWidth = 110 * sizeFactor;
float defaultScoutHeight = 98 * sizeFactor;
float defaultCourserWidth = 142 * sizeFactor;
float defaultCourserHeight = 200 * sizeFactor;
float defaultGoliathWidth = 182 * sizeFactor;
float defaultGoliathHeight = 272 * sizeFactor;
float defaultGoliathOrbSize = 42 * sizeFactor;
float defaultGoliathShieldWidth = 206 * sizeFactor;
float defaultGoliathShieldHeight = 72 * sizeFactor;
float scoutHitboxX = defaultScoutWidth / 2 + 2;
float scoutHitboxY = defaultScoutHeight / 2 + 2;
float courserHitboxX = defaultCourserWidth / 2 + 2;
float courserHitboxY = defaultCourserHeight / 2 + 2;
float goliathHitboxX = defaultGoliathWidth / 2 + 2;
float goliathHitboxY = defaultGoliathHeight / 2 + 2;

PImage weapon1;                       //weapon1, weapon2 and weapon3 are the sprites for the player depending on what gun they are using
PImage weapon2;
PImage weapon3;
PImage lightBullet;                   //sprite for the regular bullet of weapon1
PImage enemyBullet;
PImage scoutEnemy;                    //sprite for the regular enemy
PImage courserEnemy;
PImage goliathEnemy;
PImage goliathOrb;
PImage goliathShield;

Obstakel obstakel;                    //Dit is de meteoriet
SpaceShip player;                     //Dit is de player
Titel titel;
Score scoreObj;

//Aantal sterren
BackgroundStars[] Star = new BackgroundStars[starsNumber];  //the stars for the background
PlayerBullets[] bullet = new PlayerBullets[playerBulletNumber];              //the bullets for the player
Enemies[] enemy = new Enemies[enemyNumber];                     //three arrays to store data about the 3 different enemy types
EnemyBullets[] enemyBullets = new EnemyBullets[enemyBulletNumber];
Health[] heart = new Health[lives];

void setup() {
  fullScreen(P3D);             //fullscreen and hardware acceleration
  imageMode(CENTER);           //the image is at the center of the given coordinates
  frameRate(30);
  //Font
  player = new SpaceShip();
  scoreObj = new Score();
  obstakel = new Obstakel();
  initializeEnemyArrays();
  titel = new Titel();
  titel.font();
  for (int i = 0; i < starsNumber; i ++) {
    Star[i] = new BackgroundStars();
  }
  for (int i = 0; i < playerBulletNumber; i++) {
    bullet[i] = new PlayerBullets();
  }
  for (int i = 0; i < enemyNumber; i++) {
    enemy[i] = new Enemies();
  }
  for (int i = 0; i < enemyBulletNumber; i++) {
    enemyBullets[i] = new EnemyBullets();
  }
  for (int i = 0; i < lives; i++){
    heart[i] = new Health();
  }
}

void loadGameValues() {                    //This function was written by Noah Verburg
  if (!startGame) {
    player.pX = width/2;                        //here are all the variables that
    player.pY = height - height / 5;            //can't be defined in setup() or are
    wScale = width/1920;                           //easier to find in here than in setup()
    hScale = height/1080;
    player.pW = defaultPlayerWidth * wScale;
    player.pH = defaultPlayerHeight * hScale;
    player.pV = playerVelocityFactor * width;
    player.isShooting = false;
    tX= width/2;
    tY= height/2;
    orbW = defaultGoliathOrbSize * wScale;
    orbH = defaultGoliathOrbSize * hScale;
    heartW = defaultHeartWidth * wScale;
    heartH = defaultHeartHeight * hScale;
    shieldW = defaultGoliathShieldWidth * wScale;
    shieldH = defaultGoliathShieldHeight * hScale;

    for (int i = 0; i < playerBulletNumber; i++) {
      bullet[i].bX = width/2;
      bullet[i].bY = height * -2;
      wScale = width/1920;
      hScale = height/1080;
      bullet[i].bW = defaultBulletWidth * wScale;
      bullet[i].bH = defaultBulletHeight * hScale;
      bullet[i].bV = bulletVelocityFactor * width;
    }
    for (int i = 0; i < enemyBulletNumber; i++) {
      enemyBullets[i].bW = defaultBulletWidth * wScale * 1.2;
      enemyBullets[i].bH = defaultBulletHeight * hScale * 1.2;
      enemyBullets[i].bV = bulletVelocityFactor * width;
    }

    weapon1 = loadImage("Spaceship Weapon 1-1.png");
    //weapon2 = loadImage("Spaceship Weapon 2-1.png");
    //weapon3 = loadImage("Spaceship Weapon 3-1.png");
    lightBullet = loadImage("LightBullet.png");
    enemyBullet = loadImage("EnemyBullet.png");

    scoutEnemy = loadImage("Scout Enemy.png");
    courserEnemy = loadImage("Courser Enemy.png");
    goliathEnemy = loadImage("Goliath Enemy.png");
    goliathOrb = loadImage("Energy Orb.png");
    goliathShield = loadImage("Goliath Shield.png");
  }
}

void spawnPlayerBullets() {                          //This function was written by Noah Verburg
  if (player.isShooting && !bullet[playerBulletTurn].bulletIsOnScreen && millis() - playerBulletFireRate > reloadTime) {  //if the shot-button is pressed and the bullet that is supposed to
    reloadTime = millis();                                                                                                //shoot out isnt on screen and the reload timer is done, it fires a bullet
    for (int i = 0; i < playerBulletPerSalvo; i++) {
      if (playerBulletTurn%2 == 0) {                                                     //if the current bullet's number is an even number, it spawns  in the
        bullet[playerBulletTurn].bX = player.pX + defaultPlayerWidth / 2 * 0.891;        //left gun, otherwise it spawns in the right turret
      } else {
        bullet[playerBulletTurn].bX = player.pX - defaultPlayerWidth / 2 * 0.891;
      }
      bullet[playerBulletTurn].bY = player.pY - defaultPlayerHeight / 2 * 0.678;
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
      if (enemy[t].enemyType == 1 && bullet[i].bX < enemy[t].eX + scoutHitboxX && bullet[i].bX > enemy[t].eX - scoutHitboxX && bullet[i].bY < enemy[t].eY + scoutHitboxY && bullet[i].bY > enemy[t].eY - scoutHitboxY && enemy[t].isAlive == true) {
        bullet[i].bY -= height;
        enemy[t].eHP = enemy[t].eHP - 1;
          if (enemy[t].eHP == 0){
            enemy[t].isAlive = false;
            scoreObj.addScore(50);
          }
      }
      if (enemy[t].enemyType == 2 && bullet[i].bX < enemy[t].eX + courserHitboxX && bullet[i].bX > enemy[t].eX - courserHitboxX && bullet[i].bY < enemy[t].eY + courserHitboxY && bullet[i].bY > enemy[t].eY - courserHitboxY && enemy[t].isAlive == true) {
        bullet[i].bY -= height;
        enemy[t].eHP = enemy[t].eHP - 1;
          if (enemy[t].eHP == 0){
            enemy[t].isAlive = false;
            scoreObj.addScore(100);
          }
      }
      if (enemy[t].enemyType == 3 && bullet[i].bX < enemy[t].eX + goliathHitboxX && bullet[i].bX > enemy[t].eX - goliathHitboxX && bullet[i].bY < enemy[t].eY + goliathHitboxY && bullet[i].bY > enemy[t].eY - goliathHitboxY && enemy[t].isAlive == true) {
        bullet[i].bY -= height;
        enemy[t].eHP = enemy[t].eHP - 1;
          if (enemy[t].eHP == 0){
            enemy[t].isAlive = false;
            scoreObj.addScore(150);
          }
      }
    }
  }
}

void drawPlayerBullets() {                            //drawing the player's bullets
  for (int i = 0; i < playerBulletNumber; i++) {
    if (bullet[i].bulletIsOnScreen) {
      image(lightBullet, bullet[i].bX, bullet[i].bY, bullet[i].bW, bullet[i].bH);
    }
  }
}

void movement() {    //This function was written by Noah Verburg
  if (player.goLeft && player.pX > player.pW/2) {
    player.pX -= player.pV;
  }
  if (player.goRight && player.pX < width - player.pW/2) {
    player.pX += player.pV;
  }
  if (player.goUp && player.pY > height * 0.75) {
    player.pY -= player.pV;
  }
  if (player.goDown && player.pY < height/1.01 - player.pH/2) {
    player.pY += player.pV;
  }
}

void frameRateDisplay() {        //This function was written by Noah Verburg
  textSize(40);
  fill(255);
  text(int(frameRate), width/20, 50);
  if (player.stop == true) {
    stop();
  }
}

void starsAndStartMenu() {      //This function was written by Lucas van Wonderen
  //Sterren tekenen
  for (int i = 0; i < starsNumber; i ++) {    //this for loop draws the stars on the background
    Star[i].show();
  }
  if (!startGame) {                           //this if-statement draws the menu if the game hasn't started yet
    //Titel
    titel.textShow();
    //Start button
    titel.startGame();
    titel.settingGame();
    titel.quitGame();
  }
}

void gameOver() {      //this function was made by Dylan Kleton
  fill(255, 0, 0);     //if the player is dead, the game over screen shows.
  textSize(150);
  textAlign(CENTER);
  text("Game Over", tX, tY);

  scoreObj.countScore(0, 0, 0);
}

void playerHealth() {     //Function written by Sam Spronk
  if(lives == 3) {                                                //displays the number of lives you have left
    for (int i = 0; i < 3; i++) {
      heart[i].x = width/60 + width/100 * 3 * i;
      image(heart[i].texture, heart[i].x, heart[i].y, heartW, heartH);
    }
  }
  if(lives == 2) {
    for (int i = 0; i < 2; i++) {
      heart[i].x = width/60 + width/100 * 3 * i;
      image(heart[i].texture, heart[i].x, heart[i].y, heartW, heartH);
    }
  }
  if(lives == 1) {
    heart[0].x = width/60 + width/100 * 3;
    image(heart[0].texture, heart[0].x, heart[0].y, heartW, heartH);
  }
}

void keyReleased() {         //This function was written by Noah Verburg
  player.setAction(key, false);  //detects if a key has been released
}

void keyPressed() {          //This function was written by Noah Verburg
  player.setAction(key, true);  //detects if a key has been pressed
}

//Collision Buttons click
void mouseClicked() {        //This function was written by Lucas van Wonderen
  //Start Button Detection
  if (mouseX > titel.staButtonX - titel.staButtonW/2 && mouseX < titel.staButtonX + titel.staButtonW/2 && mouseY > titel.staButtonY - titel.staButtonH/2 && mouseY < titel.staButtonY + titel.staButtonH/2) {
    startTime = timer;
    startGame = true;
    //Settings Button Detection
  } else if (mouseX > titel.setButtonX - titel.setButtonW/2 && mouseX < titel.setButtonX + titel.setButtonW/2 && mouseY > titel.setButtonY - titel.setButtonH/2 && mouseY < titel.setButtonY + titel.setButtonH/2) {
    //Quit Button Detection
  } else if (mouseX > titel.qButtonX - titel.qButtonW/2 && mouseX < titel.qButtonX + titel.qButtonW/2 && mouseY > titel.qButtonY - titel.qButtonH/2 && mouseY < titel.qButtonY + titel.qButtonH/2) {
    exit();
  }
}

void draw() {
  //fill(0, 220);
  //rect(0, 0, width, height);
  background(0);
  starsAndStartMenu();
  //frameRateDisplay();
  loadGameValues();
  
  timer = millis();
  
  if (startGame && !stopGame) {    //if the player has pressed start on the menu, the game will start
    obstakel.drawObstakel();
    for (int i = 0; i < enemyNumber; i++) {      //updates, spawns and draws the enemies
      enemyUpdatePosition(i);    //made by Noah Verburg
      enemySpawner(i);
      drawEnemies(i);
    }
    for (int i = 0; i< enemyBulletNumber; i++) {      //updates, spawns and draws the bullets
      enemyBullets[i].enemyBulletUpdatePosition(i);
      enemyBullets[i].drawEnemyBullet(i);
      enemyBullets[i].enemyBulletSpawner();
    }
    scoreObj.countScore(0, 0, 0); //made by Dylan Kleton
    spawnPlayerBullets();        //spawns player bullets using a for-loop built into the function
    updatePlayerBullets();       //updates player bullets using a for-loop built into the function
    drawPlayerBullets();         //draws player bullets using a for-loop built into the function
    movement();                  //updates the position of the player
    player.player();             //draws the player
    playerHealth();
    if (lives <= 0) {gameOver(); stop();}
  }
  
  if (player.testBoolean) {
    
  }
  if (player.stop) {stop();}
}
