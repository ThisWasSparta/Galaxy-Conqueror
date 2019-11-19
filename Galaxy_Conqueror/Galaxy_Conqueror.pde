/* This code is written by group 3 of IG-101 FYS project. It is a game called
 Space Conqueror, and is similar to space invaders and galaga. Where possible it is shown which
 student made the code.*/

int starsNumber = 200;                //Star number
int playerBulletNumber = 100;
int enemyNumber = 20;
int enemyExplosionParticleNumber = 500;
int enemyBulletNumber = 20;
int enemyShootParticleNumber = 50;
int tX;    //x-waarde van game over text
int tY;    //y-waarde van game over text
int heartNumber = 3;
int stopGameTime;

int timer = millis();                 //contains the time from when the game was launched in milliseconds
int startTime;                        //contains the time when start was pressed in milliseconds

boolean startGame = false;            //whether the game has started or not
boolean stopGame = false;

float sizeFactor = 0.8;
float wScale;                         //width scale used to adjust the width of images
float hScale;                         //height scale used to adjust the height of images

Obstakel obstakel;                    //Dit is de meteoriet
SpaceShip player;                     //Dit is de player
Titel titel;
Score scoreObj;
Variable variables;

//Aantal sterren
BackgroundStars[] Star = new BackgroundStars[starsNumber];  //the stars for the background
PlayerBullets[] bullet = new PlayerBullets[playerBulletNumber];              //the bullets for the player
Enemies[] enemy = new Enemies[enemyNumber];                     //three arrays to store data about the 3 different enemy types
EnemyBullets[] enemyBullets = new EnemyBullets[enemyBulletNumber];
Health[] heart = new Health[heartNumber];
ExplosionPart[] particle = new ExplosionPart[enemyExplosionParticleNumber];
EnemyShootParticle[] enemyShootParticle = new EnemyShootParticle[enemyShootParticleNumber];

void setup() {
  fullScreen(P3D);             //fullscreen and hardware acceleration
  imageMode(CENTER);           //the image is at the center of the given coordinates
  frameRate(60);
  //Font
  player = new SpaceShip();
  scoreObj = new Score();
  obstakel = new Obstakel();
  initializeEnemyArrays();
  titel = new Titel();
  variables = new Variable();
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
  for (int i = 0; i < heartNumber; i++){
    heart[i] = new Health();
  }
  for (int i = 0; i < enemyExplosionParticleNumber; i++) {
    particle[i] = new ExplosionPart();
  }
  for (int i = 0; i < enemyShootParticleNumber; i++) {
    enemyShootParticle[i] = new EnemyShootParticle();
  }
}

/*void frameRateDisplay() {        //This function was written by Noah Verburg
  textSize(40);
  fill(255);
  text(int(frameRate), width/20, 50);
  if (player.stop == true) {
    stop();
  }
}*/

void gameOver() {      //this function was made by Dylan Kleton
  fill(255, 0, 0);     //if the player is dead, the game over screen shows.
  textSize(150);
  textAlign(CENTER);
  text("Game Over", tX, tY);

  scoreObj.countScore(0, 0, 0);
}

void keyReleased() {         //This function was written by Noah Verburg
  player.setAction(key, false);  //detects if a key has been released
}

void keyPressed() {          //This function was written by Noah Verburg
  player.setAction(key, true);  //detects if a key has been pressed
}

//Collision Buttons click
void mousePressed() {        //This function was written by Lucas van Wonderen
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
  Star[0].starsAndStartMenu();
  //frameRateDisplay();
  variables.loadGameValues();
  
  timer = millis();
  
  if (startGame && !stopGame) {    //if the player has pressed start on the menu, the game will start
    obstakel.drawObstakel();
    for (int i = 0; i < enemyNumber; i++) {      //updates, spawns and draws the enemies
      enemyUpdatePosition(i);    //made by Noah Verburg
      enemySpawner(i);
      drawEnemies(i);
    }
    /*for (int i = 0; i< enemyBulletNumber; i++) {      //updates, spawns and draws the bullets
      enemyBullets[i].enemyBulletUpdatePosition(i);
      enemyBullets[i].drawEnemyBullet(i);
      enemyBullets[i].enemyBulletSpawner();
    }*/
    scoreObj.countScore(0, 0, 0); //made by Dylan Kleton
    bullet[0].spawnPlayerBullets();        //spawns player bullets using a for-loop built into the function
    bullet[0].updatePlayerBullets();       //updates player bullets using a for-loop built into the function
    bullet[0].drawPlayerBullets();         //draws player bullets using a for-loop built into the function
    player.movement();                  //updates the position of the player
    player.player();             //draws the player
    heart[0].playerHealth();
    for (int i = 0; i < enemyExplosionParticleNumber; i++) {
      if (particle[i].isAlive) {
        particle[i].updateParticles(i);
        particle[i].drawParticles(i);
      }
    }
    if (heartNumber <= 0) {gameOver(); stop();}
  }
  
  if (player.testBoolean) {
    
  }
  if (player.stop) {stop();}
}
