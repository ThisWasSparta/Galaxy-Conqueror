class Difficulty { //This class is supposed to add a difficulty to the game, by changing the statistics of the enemies according to the difficulty meter. This class was written by Dylan Kleton.
  int difficultyCounter = 0;
  int newDifficultyCounter = 0;
  
  void checkScore(){ //This function is supposed to check the score height and then change the difficulty according to the score height.
  if (scoreObj.score >= 500)
    changeDifficulty(1);
    if(scoreObj.score >= 1000)
    changeDifficulty(2);
    if(scoreObj.score >= 1500)
    changeDifficulty(3);
  }
  
  
  void changeDifficulty(int difficultyCounter) {
    newDifficultyCounter = difficultyCounter;
  }
}
