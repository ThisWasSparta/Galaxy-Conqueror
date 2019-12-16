 class HighScore {

  HighScore() {
  }

  void GetHighScore() {
    if (dbqueries.getHighScores == false) {
      dbqueries.dbSelectHighScores();
      for(int i = 0; i < 10; i ++){
        text(dbqueries.names[i] + " " + dbqueries.highScores[i], 200, i*100);
      }
      dbqueries.getHighScores = true;
    }
  }
}
