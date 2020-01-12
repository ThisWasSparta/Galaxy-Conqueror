//This code was written by Dylan Kleton


class Score {
  //This is the score that will eventually be shown in the game-over screen
  final int SCORE_SIZE = 100;
  int score = 0;
  
  //This method has the purpose of adding numbers to the score
  void addScore (int scoreAmount) {

    score += scoreAmount;
    if (score < 0) {
      score = 0;
    }
    fill (0);
    rect(tX, tY/0.5, SCORE_SIZE, SCORE_SIZE);
  }

  //Method countScore is meant to display the current score
  void countScore (/*int currentScore1, int currentScore2, int countedScore*/) {


    //Score text that displayes the score the player got and what the highscore is

    fill(255, 255, 0);
    textSize(50);
    text("Score: " +score, tX + visuals.magnitudeX, tY / 0.5 + visuals.magnitudeY);
  }
}
