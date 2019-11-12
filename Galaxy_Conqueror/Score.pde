//This code was written by Dylan Kleton

class Score {
  //This is the score that will eventually be shown in the game-over screen
  int score = 0;
  final int SCORE_SIZE = 100;
  //This method has the purpose of adding numbers to the score

  void addScore (int score) {

    this.score += score;
    fill (0);
    rect(tX, tY/0.5, SCORE_SIZE, SCORE_SIZE);
    int currentScore1;
    int currentScore2;
    int countedScore = 0;
    currentScore1 = 0;
    currentScore2 = score;
    if (currentScore1 > 0) {
      currentScore1 = countedScore;
    }
    countScore(currentScore1, currentScore2, countedScore);
  }
  //Method countScore is meant to display the current score
  void countScore (int currentScore1, int currentScore2, int countedScore) {

    countedScore = currentScore1;
    countedScore = countedScore + currentScore2;


    //Score text that displays the score the player got and what the highscore is

    fill(255, 255, 0);
    textSize(50);
    text("Score: " +score, tX, tY/0.5);
  }
}
