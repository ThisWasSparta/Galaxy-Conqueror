class GameOver {

  boolean gameover = false;
  int tY = height - 800;
  int sAch = 40;

  GameOver()
  {
  }

  void GameOverDraw() {
    //this function was made by Dylan Kleton
    fill(255, 0, 0);     //if the player is dead, the game over screen shows.
    textSize(150);
    textAlign(CENTER);
    text("Game Over", tX, tY);
    for (int i = 0; i < ENEMY_SHOOT_PARTICLE_NUMBER; i++) {
      enemyShootParticle[i].opacity = 0;
      textSize(50);
      textAlign(CENTER);
      text("Achievements got:", width/2, height/2 + 200);
      image(ach1, width/2-60, height/2 + 240, sAch, sAch);
      image(ach2, width/2, height/2 + 240, sAch, sAch);
      image(ach3, width/2+60, height/2 + 240, sAch, sAch);
      image(ach4, width/2-60, height/2 + 300, sAch, sAch);
      image(ach5, width/2, height/2 + 300, sAch, sAch);
      image(ach6, width/2+60, height/2 + 300, sAch, sAch);
      image(ach7, width/2-60, height/2 + 360, sAch, sAch);
      image(ach8, width/2, height/2 + 360, sAch, sAch);
      image(ach9, width/2+60, height/2 + 360, sAch, sAch);
      image(ach10, width/2-60, height/2 + 420, sAch, sAch);
      image(ach12, width/2, height/2 + 420, sAch, sAch);
      image(ach13, width/2+60, height/2 + 420, sAch, sAch);
      fill(0, 0, 0, 245);
      if (killcount == 0) {
        rect(width/2-60, height/2+240, sAch, sAch);
      }
      if (killcount < 50) {
        rect(width/2, height/2+240, sAch, sAch);
      }
      if (killcount < 100) {
        rect(width/2+60, height/2+240, sAch, sAch);
      }
      if (killcount < 500) {
        rect(width/2-60, height/2+300, sAch, sAch);
      }
      if (killcount < 1000) {
        rect(width/2, height/2+300, sAch, sAch);
      }
      if (killcount < 10000) {
        rect(width/2+60, height/2+300, sAch, sAch);
      }
      if (gatkills < 10 || laserkills < 10 || rockkills < 10) {
        rect(width/2-60, height/2+360, sAch, sAch);
      }
      if (gatkills < 50 || laserkills < 50 || rockkills < 50) {
        rect(width/2, height/2+360, sAch, sAch);
      }
      if (survivaltimer < 18000) {
        rect(width/2+60, height/2+360, sAch, sAch);
      }
      if (survivaltimer < 108000) {
        rect(width/2-60, height/2+420, sAch, sAch);
      }
      if (scoreObj.score > 0) {
        rect(width/2, height/2+420, sAch, sAch);
      }
      if (!boss.bossAlive) {
        rect(width/2+60, height/2+420, sAch, sAch);
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
}
