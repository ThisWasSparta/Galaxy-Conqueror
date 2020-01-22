class GameOver {

  boolean gameover = false;
  final int tY = height - 800;
  final int sAch = 40;
  final float ach1x = width/2-60;
  final float ach1y = height/2+240;
  final float ach2x = width/2;
  final float ach2y = height/2+240;
  final float ach3x = width/2+60;
  final float ach3y = height/2+240;
  final float ach4x = width/2-60;
  final float ach4y = height/2+300;
  final float ach5x = width/2;
  final float ach5y = height/2+300;
  final float ach6x = width/2+60;
  final float ach6y = height/2+300;
  final float ach7x = width/2-60;
  final float ach7y = height/2+360;
  final float ach8x = width/2;
  final float ach8y = height/2+360;
  final float ach9x = width/2+60;
  final float ach9y = height/2+360;
  final float ach10x = width/2-60;
  final float ach10y = height/2+420;
  final float ach12x = width/2;
  final float ach12y = height/2+420;
  final float ach13x = width/2+60;
  final float ach13y = height/2+420;

  GameOver()
  {
  }

  void GameOverDraw() {
    //this function was made by Dylan Kleton
    fill(255, 0, 0);     //if the player is dead, the game over screen shows.
    textSize(150);
    textAlign(CENTER);
    text("Game Over", tX, tY);
    for (int i = 0; i < ENEMY_SHOOT_PARTICLE_NUMBER; i++) {            //loop die door de achievements heen loopt
      enemyShootParticle[i].opacity = 0;
      bgm.mute();
      textSize(50);
      textAlign(CENTER);
      text("Achievements got:", width/2, height/2 + 200);
      image(ach1, ach1x, ach1y, sAch, sAch);
      image(ach2, ach2x, ach2y, sAch, sAch);
      image(ach3, ach3x, ach3y, sAch, sAch);
      image(ach4, ach4x, ach4y, sAch, sAch);
      image(ach5, ach5x, ach5y, sAch, sAch);
      image(ach6, ach6x, ach6y, sAch, sAch);
      image(ach7, ach7x, ach7y, sAch, sAch);
      image(ach8, ach8x, ach8y, sAch, sAch);
      image(ach9, ach9x, ach9y, sAch, sAch);
      image(ach10, ach10x, ach10y, sAch, sAch);
      image(ach12, ach12x, ach12y, sAch, sAch);
      image(ach13, ach13x, ach13y, sAch, sAch);
      fill(0, 0, 0, 245);
      //Hier onder wordt gechecked of de achievements zijn gehaald
      //Zo niet dan wordt er een rect voor getekend
      if (killcount == 0) {
        rect(ach1x, ach1y, sAch, sAch);
      }
      if (killcount < 50) {
        rect(ach2x, ach2y, sAch, sAch);
      }
      if (killcount < 100) {
        rect(ach3x, ach3y, sAch, sAch);
      }
      if (killcount < 500) {
        rect(ach4x, ach4y, sAch, sAch);
      }
      if (killcount < 1000) {
        rect(ach5x, ach5y, sAch, sAch);
      }
      if (killcount < 10000) {
        rect(ach6x, ach6y, sAch, sAch);
      }
      if (gatkills < 10 || laserkills < 10 || rockkills < 10) {
        rect(ach7x, ach7y, sAch, sAch);
      }
      if (gatkills < 50 || laserkills < 50 || rockkills < 50) {
        rect(ach8x, ach8y, sAch, sAch);
      }
      if (survivaltimer < 18000) {
        rect(ach9x, ach9y, sAch, sAch);
      }
      if (survivaltimer < 108000) {
        rect(ach10x, ach10y, sAch, sAch);
      }
      if (scoreObj.score > 0) {
        rect(ach12x, ach12y, sAch, sAch);
      }
      if (!bossKilled) {
        rect(ach13x, ach13y, sAch, sAch);
      }
    }

    if (gameOverTimer == 0) {
      gameOverTimer = millis();
    }

    scoreObj.countScore(/*0, 0, 0*/);
  }

  void GameOverTakeName() {
    namePicker.DrawNamePicker();
  }

  void resetGameValues() {                             //This function resets all gameplay values
    valuesLoaded = false;
    gameOver = false;
    startGame = false;
    valuesLoaded = false;
    titel.StartGame = true;
    tutorial = false;
    heartNumber = 3;
    scoreObj.score = 0;
    globalBossTimer = 11500;
    bgm.mute();
    difficulty.newDifficultyCounter = 0;
    for (int i = 0; i < ENEMY_NUMBER; i++) {           //Cycles through all enemy slots once
      if (enemy[i].isAlive == true) {                  //Checks if there are living enemies
        enemy[i].isAlive = false;                      //Kills living enemies
      }
    }
    setup();
  }
}
