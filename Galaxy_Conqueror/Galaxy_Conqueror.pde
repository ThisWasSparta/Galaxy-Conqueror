import processing.sound.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;



/* This code is written by group 3 of IG-101 FYS project. It is a game called
 Space Conqueror, and is similar to space invaders and galaga. Where possible it is shown which
 student made the code.*/


int playerBulletNumber = 100;
int enemyNumber = 20;
int enemyExplosionParticleNumber = 500;
int enemyBulletNumber = 20;
int enemyMoveParticleNumber = 200;
int enemyShootParticleNumber = 25;
int tX;    //x-waarde van game over text
int tY;    //y-waarde van game over text
int heartNumber = 3;
int stopGameTime;
int gameOverTimer = 0;
int maxP = 3;                         //maximum amount of powerups present at the same time
int scoreMultiplier = 1;

int timer = millis();                 //contains the time from when the game was launched in milliseconds
int startTime;                        //contains the time when start was pressed in milliseconds

boolean startGame = false;            //whether the game has started or not

boolean valuesLoaded = false;

boolean gameOver = false;

boolean nameScreen;

float sizeFactor = 0.8;
float wScale;                         //width scale used to adjust the width of images
float hScale;                         //height scale used to adjust the height of images

PImage bossSprite;
PImage doublepointsPowerup;
PImage speedPowerup;
PImage screenwipePowerup;

Obstakel obstakel;                    //Dit is de meteoriet
SpaceShip player;                     //Dit is de player
BackgroundStars Star;
Titel titel;
Score scoreObj;
Variable variables;
Controls controls;
Meteoriet meteoriet;
//Sounds sounds;

Minim minim;
AudioPlayer bgm;
AudioPlayer playergatshoot;
AudioPlayer enemyshoot;

Boss boss;
NamePicker namePicker;
Letterpicker letterPicker;
DBConnect dbconnect;
DBQueries dbqueries;
GameOver gameover;

//Aantal sterren
PlayerWeapons[] weapon = new PlayerWeapons[playerBulletNumber];              //the bullets for the player
Enemies[] enemy = new Enemies[enemyNumber];                     //three arrays to store data about the 3 different enemy types
EnemyBullets[] enemyBullets = new EnemyBullets[enemyBulletNumber];
Health[] heart = new Health[heartNumber];
ExplosionPart[] particle = new ExplosionPart[enemyExplosionParticleNumber];
EnemyShootParticle[] enemyShootParticle = new EnemyShootParticle[enemyShootParticleNumber];
EnemyMoveParticles[] enemyMoveParticle = new EnemyMoveParticles[enemyMoveParticleNumber];
PowerUp[] power = new PowerUp[maxP];

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
  controls = new Controls();
  Star = new BackgroundStars();
  boss = new Boss();
  //sounds = new Sounds(this);
  minim = new Minim(this);
  bgm = minim.loadFile("./sound/stagethemefix.wav");
  playergatshoot = minim.loadFile("./sound/gattlingweapon_noise.wav");
  enemyshoot = minim.loadFile("./sound/scout_shootnoise.wav");
  dbconnect = new DBConnect(this);
  dbqueries = new DBQueries();
  namePicker = new NamePicker();
  letterPicker = new Letterpicker();
  gameover = new GameOver();
  titel.font();
  Star.sterrenProp();
  for (int i = 0; i < playerBulletNumber; i++) {
    weapon[i] = new PlayerWeapons();
  }
  for (int i = 0; i < enemyNumber; i++) {
    enemy[i] = new Enemies();
  }
  for (int i = 0; i < enemyBulletNumber; i++) {
    enemyBullets[i] = new EnemyBullets();
  }
  for (int i = 0; i < heartNumber; i++) {
    heart[i] = new Health();
  }
  for (int i = 0; i < enemyExplosionParticleNumber; i++) {
    particle[i] = new ExplosionPart();
  }
  for (int i = 0; i < enemyShootParticleNumber; i++) {
    enemyShootParticle[i] = new EnemyShootParticle();
  }
  for (int i = 0; i < enemyMoveParticleNumber; i++) {
    enemyMoveParticle[i] = new EnemyMoveParticles();
  }
  for (int i = 0; i < maxP; i++) {
    power[i] = new PowerUp();
  }
}



void keyReleased() {         //This function was written by Noah Verburg
  controls.setAction(key, false);  //detects if a key has been released
}

void keyPressed() {          //This function was written by Noah Verburg
  controls.setAction(key, true);  //detects if a key has been pressed
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
  Star.sterrenShow();
  titel.startScreen();
  //frameRateDisplay();
  variables.loadGameValues();

  timer = millis();

  if (startGame) {    //if the player has pressed start on the menu, the game will start
    obstakel.drawObstakel();
    for (int i = 0; i < enemyNumber; i++) {      //updates, spawns and draws the enemies
      enemyUpdatePosition(i);    //made by Noah Verburg
      enemySpawner();
      drawEnemies(i);
    }

    for (int i = 0; i < enemyBulletNumber; i++) {      //updates, spawns and draws the bullets
      enemyBullets[i].enemyBulletUpdatePosition(i);
      enemyBullets[i].drawEnemyBullet(i);
      enemyBullets[i].enemyBulletSpawner();
    }

    scoreObj.countScore(0, 0, 0); //made by Dylan Kleton

    player.playerUpdate();                 //updates the position of the player
    player.player();                       //draws the player

    if (scoreObj.score >= 10000) {

      //Boss.bossSpawn();
      boss.bossSpawn();
    }

    globalBossTimer--;
    text(globalBossTimer, 120, 60);

    /*if (boss.currentState != -1) {
     boss.bossUpdatePosition();
     boss.bossUpdateBehaviour();
     boss.bossDraw();
     }*/

    if (player.weapon == 1) {
      weapon[0].spawnPlayerBullets();        //spawns player bullets using a for-loop built into the function
    }
    weapon[0].updatePlayerBullets();       //updates player bullets using a for-loop built into the function
    weapon[0].drawPlayerBullets();         //draws player bullets using a for-loop built into the function

    if (player.weapon == 2) {
      weapon[0].spawnPlayerLaser();
    }
    weapon[0].updatePlayerLaser();
    weapon[0].drawPlayerLaser();

    heart[0].playerHealth();

    for (int i = 0; i < enemyExplosionParticleNumber; i++) {
      if (particle[i].isAlive) {
        particle[i].updateParticles(i);
        particle[i].drawParticles(i);
      }
    }
    for (int i = 0; i < maxP; i++) {
      powerUpdate(i);
      powerupSpawn(i);
      drawPower(i);
    }
    enemyShootParticle[0].updateParticles();
    enemyShootParticle[0].drawParticles();

    if (heartNumber <= 0) {
      startGame = false;
      gameOver = true;
      gameOverTimer = millis();
    }
  }
  if (gameOver) {
    if (millis() >= gameOverTimer+500) {
      gameover.GameOverDraw();
      if (millis() >= gameOverTimer+1000) {
        gameover.GameOverTakeName();
      }
    }
  }
  titel.bright();
  //image(boss, width/2, 121, 1000, 242);
  if (player.testBoolean) {
  }
  if (player.stop) {
    stop();
  }
}
