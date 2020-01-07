class GameOver {

  boolean gameover = false;
  int tY = height - 800;

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
