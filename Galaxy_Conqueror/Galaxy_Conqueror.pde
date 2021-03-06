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


final int PLAYER_BULLET_NUMBER = 100;
final int ENEMY_NUMBER = 40;
final int ENEMY_EXPLOSION_PARTICLE_NUMBER = 500;
final int ENEMY_BULLET_NUMBER = 20;
final int BOSS_BULLET_NUMBER = 20;
final int BOSS_ROCKET_NUMBER = 10;
final int ENEMY_MOVE_PARTICLE_NUMBER = 200;
final int ENEMY_SHOOT_PARTICLE_NUMBER = 25;
final int MAX_POWERUPS = 3; 
int tX;                                           //x-waarde van game over text
int tY;                                           //y-waarde van game over text
int heartNumber = 3;
int stopGameTime;
int gameOverTimer = 0;                            //maximum amount of powerups present at the same time
int scoreMultiplier = 1;
int tutorialTimer = 0;
int survivaltimer = 0;

int timer = millis();                             //contains the time from when the game was launched in milliseconds
int startTime;                                    //contains the time when start was pressed in milliseconds
int endTime;                                      //contains the time when player dies
int survivalTime;                                 //contains the time how long the player has played

boolean startGame = false;                        //whether the game has started or not

boolean valuesLoaded = false;

boolean gameOver = false;

boolean tutorial = false;

boolean pause = false;

boolean nameScreen;

boolean getStartTime = false;

boolean getEndTime = false;

final float sizeFactor = 0.8;
float wScale;                                     //width scale used to adjust the width of images
float hScale;                                     //height scale used to adjust the height of images

PImage bossSprite;
PImage doublepointsPowerup;
PImage speedPowerup;
PImage screenwipePowerup;
PImage enemyBullet;
PImage bossRocketSprite;
PImage ach1;
PImage ach2;
PImage ach3;
PImage ach4;
PImage ach5;
PImage ach6;
PImage ach7;
PImage ach8;
PImage ach9;
PImage ach10;
PImage ach11;
PImage ach12;
PImage ach13;
PImage ach14;

Obstakel obstakel;                                //Dit is de meteoriet
SpaceShip player;                                 //Dit is de player
BackgroundStars Star;
Titel titel;
TitelVar titelvar;
Score scoreObj;
Variable variables;
Controls controls;
Meteoriet meteoriet;
Interface userInterface;
VisualEffects visuals;
RandomEvents events;
Difficulty difficulty;

Minim minim;
AudioPlayer bgm;
AudioPlayer playergatshoot;
AudioPlayer enemyshoot;
AudioPlayer maintheme;
AudioPlayer bossMusic;

Boss boss;
NamePicker namePicker;
Letterpicker letterPicker;
DBConnect dbconnect;
DBQueries dbqueries;
GameOver gameover;
HighScore highscore;
Achievements achievements;

Text_Particles textParticles;

//Aantal sterren
PlayerWeapons[] weapon = new PlayerWeapons[PLAYER_BULLET_NUMBER];              //the bullets for the player
Enemies[] enemy = new Enemies[ENEMY_NUMBER];                                   //three arrays to store data about the 3 different enemy types
EnemyBullets[] enemyBullets = new EnemyBullets[ENEMY_BULLET_NUMBER];
BossBullet[] bossBullets = new BossBullet[BOSS_BULLET_NUMBER];
BossRocket[] bossRockets = new BossRocket[BOSS_ROCKET_NUMBER];
Health[] heart = new Health[heartNumber];
ExplosionPart[] particle = new ExplosionPart[ENEMY_EXPLOSION_PARTICLE_NUMBER];
EnemyShootParticle[] enemyShootParticle = new EnemyShootParticle[ENEMY_SHOOT_PARTICLE_NUMBER];
EnemyMoveParticles[] enemyMoveParticle = new EnemyMoveParticles[ENEMY_MOVE_PARTICLE_NUMBER];
PowerUp[] power = new PowerUp[MAX_POWERUPS];


void setup() {
  fullScreen(P3D);             //fullscreen and hardware acceleration
  imageMode(CENTER);           //the image is at the center of the given coordinates
  rectMode(CENTER);
  frameRate(60);
  //Font
  player = new SpaceShip();
  scoreObj = new Score();
  obstakel = new Obstakel();
  initializeEnemyArrays();
  titel = new Titel();
  titelvar = new TitelVar();
  variables = new Variable();
  controls = new Controls();
  Star = new BackgroundStars();
  boss = new Boss();
  minim = new Minim(this);
  dbconnect = new DBConnect(this);
  dbqueries = new DBQueries();
  namePicker = new NamePicker();
  letterPicker = new Letterpicker();
  gameover = new GameOver();
  highscore = new HighScore();
  achievements = new Achievements();
  userInterface = new Interface();
  visuals = new VisualEffects();
  events = new RandomEvents();
  difficulty = new Difficulty();

  textParticles = new Text_Particles();

  titel.font();
  Star.sterrenProp();
  for (int i = 0; i < PLAYER_BULLET_NUMBER; i++) {
    weapon[i] = new PlayerWeapons();
  }
  for (int i = 0; i < ENEMY_NUMBER; i++) {
    enemy[i] = new Enemies();
  }
  for (int i = 0; i < ENEMY_BULLET_NUMBER; i++) {
    enemyBullets[i] = new EnemyBullets();
  }
  for (int i = 0; i < BOSS_BULLET_NUMBER; i++) {
    bossBullets[i] = new BossBullet();
  }
  for (int i = 0; i < BOSS_ROCKET_NUMBER; i++) {
    bossRockets[i] = new BossRocket();
  }
  for (int i = 0; i < heartNumber; i++) {
    heart[i] = new Health();
  }
  for (int i = 0; i < ENEMY_EXPLOSION_PARTICLE_NUMBER; i++) {
    particle[i] = new ExplosionPart();
  }
  for (int i = 0; i < ENEMY_SHOOT_PARTICLE_NUMBER; i++) {
    enemyShootParticle[i] = new EnemyShootParticle();
  }
  for (int i = 0; i < ENEMY_MOVE_PARTICLE_NUMBER; i++) {
    enemyMoveParticle[i] = new EnemyMoveParticles();
  }
  for (int i = 0; i < MAX_POWERUPS; i++) {
    power[i] = new PowerUp();
  }
}



void keyReleased() {               //This function was written by Noah Verburg
  controls.setAction(key, false);  //detects if a key has been released
}

void keyPressed() {               //This function was written by Noah Verburg
  controls.setAction(key, true);  //detects if a key has been pressed
}

void draw() {
  variables.loadGameValues();
  background(0);
  Star.sterrenShow();
  titel.startScreen();
  timer = millis();
  textParticles.drawText();

  if (player.stop) {
    stop();
  }

  if (startGame) {                                //if the player has pressed start on the menu, the game will start
    visuals.screenShake(0, 0, false);
    visuals.testScreenShake();
    events.selectEvent();
    events.executeEvent();
    obstakel.drawObstakel();
    survivaltimer++;

    if (!tutorial) {
      tutorialTimer++;
    }
    if (tutorialTimer >= 1000) {
      tutorial = true;
    }
    if (tutorial) {
      tutorialTimer = 0;
      for (int i = 0; i < ENEMY_NUMBER; i++) {      //updates, spawns and draws the enemies
        enemyUpdatePosition(i);                     //made by Noah Verburg
        enemySpawner();
        drawEnemies(i);
      }

      for (int i = 0; i < ENEMY_BULLET_NUMBER; i++) {      //updates, spawns and draws the bullets
        enemyBullets[i].enemyBulletUpdatePosition(i);
        enemyBullets[i].drawEnemyBullet(i);
        enemyBullets[i].enemyBulletSpawner();
      }
    }
    scoreObj.countScore(/*0, 0, 0*/); //made by Dylan Kleton

    userInterface.drawInterface();

    player.playerUpdate();                 //updates the position of the player
    player.player();                       //draws the player
    if (tutorial) {
      if (globalBossTimer <= 0 && boss.currentState == -1) {
        boss.bossSpawn();
      }

      globalBossTimer--;

      if (boss.currentState != -1) {
        boss.bossUpdatePosition();
        boss.bossUpdateBehaviour();
        boss.bossDraw();
        for (int i = 0; i < BOSS_ROCKET_NUMBER; i++) {
          boss.playerBossRocketCollisionCheck(i);
        }
        for (int i = 0; i < BOSS_BULLET_NUMBER; i++) {
          boss.playerBossBulletCollisionCheck(i);
        }
      }
    }
    if (player.weapon == 1) {
      weapon[0].spawnPlayerBullets();        //spawns player bullets using a for-loop built into the function
    }
    weapon[0].updatePlayerBullets();         //updates player bullets using a for-loop built into the function
    weapon[0].drawPlayerBullets();           //draws player bullets using a for-loop built into the function

    if (player.weapon == 2) {
      weapon[0].spawnPlayerLaser();
    }
    weapon[0].updatePlayerLaser();
    weapon[0].drawPlayerLaser();

    if (player.weapon == 3) {
      weapon[0].spawnPlayerRockets();
    }
    weapon[0].updatePlayerRockets();
    weapon[0].drawPlayerRockets();

    weapon[0].reloadTimerBar();

    player.updateWeaponWheel();
    player.drawWeaponWheel();

    heart[0].playerHealth();

    for (int i = 0; i < ENEMY_EXPLOSION_PARTICLE_NUMBER; i++) {
      if (particle[i].isAlive) {
        particle[i].updateParticles(i);
        particle[i].drawParticles(i);
      }
    }
    if (tutorial) {
      for (int i = 0; i < MAX_POWERUPS; i++) {
        powerUpdate(i);
        powerupSpawn(i);
        drawPower(i);
      }
    }
    enemyShootParticle[0].updateParticles();
    enemyShootParticle[0].drawParticles();

    if (heartNumber <= 0) {
      startGame = false;
      gameOver = true;
      gameOverTimer = millis();
    }
  }

  // Als de player dood is komt de gameover scherm
  if (gameOver) {
    if (!getEndTime) {
      endTime = timer;
      getEndTime = true;
    }
    survivalTime = endTime - startTime;

    if (millis() >= gameOverTimer + 500) {        //na 500 ms nadat je dood bent komt de game over tekst in beeld
      gameover.GameOverDraw();                    //na 1 sec nadat je dood bent komt de takename functie en kan de player zijn/haar naam invullen
      if (millis() >= gameOverTimer + 1000) {
        gameover.GameOverTakeName();
      }

      if (millis() >= gameOverTimer+3000) {      //pas 3 sec nadat je dood bent kun je verder klikken
        if (player.isShooting) {                 //als de player schiet worden de volgende functies uitgevoerd
          dbqueries.dbInsert();                  //functie die de insert queries uitvoert
          gameover.resetGameValues();            //functie die de gameplay values reset
        }
      }
    }
  }
  titel.bright();
}
