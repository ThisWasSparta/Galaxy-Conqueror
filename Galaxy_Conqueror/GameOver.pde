class GameOver {

  boolean gameover = false;
  
  GameOver()
  {
  }

  void GameOverDraw() {
    //this function was made by Dylan Kleton
    fill(255, 0, 0);     //if the player is dead, the game over screen shows.
    textSize(150);
    textAlign(CENTER);
    text("Game Over", tX, tY);

    scoreObj.countScore(0, 0, 0);
  }
  
  void GameOverTakeName(){
     
  }
  
  
}
