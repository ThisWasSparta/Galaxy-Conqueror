//deze class is geschreven door Dennis
class DBQueries {

  boolean insertQuerieDone = false;
  boolean getHighScores = false;
  int highScoreSize = 10;
  String highScores[] = new String[highScoreSize];
  String names[] = new String[highScoreSize];
  String name;
  String score;
  int i;
  float textStartPosition = 300;
  float Distance = 50;

  DBQueries() {
  }

  void dbInsert() {
    if (dbconnect.sql.connect()) {
      dbconnect.sql.query("INSERT INTO Players (Playername) VALUES ('"+namePicker.name+"')");
      dbconnect.sql.query("INSERT INTO Highscores (Score, Playername, PlayerKillCount) VALUES ("+ scoreObj.score +", '" + namePicker.name + "', '" + killcount + "')");
      insertQuerieDone = true;
    }
  }

  void dbSelectHighScores() {
    if (getHighScores == false) {
      if (dbconnect.sql.connect()) {
        dbconnect.sql.query("SELECT Players.Playername, Highscores.Score FROM Players INNER JOIN Highscores ON Players.Playername = Highscores.Playername ORDER BY Score DESC LIMIT 10");
        i = 0;
        while (dbconnect.sql.next()) {
          names[i] = dbconnect.sql.getString("Playername");
          highScores[i] = dbconnect.sql.getString("Score");
          i++;
        }
      }
      getHighScores = true;
    }
  }
}


void GetHighScore() {
  dbqueries.dbSelectHighScores();
  for (int i = 0; i < 10; i ++) {
    if (dbqueries.names[i] == null) {
      dbqueries.names[i] = "--";
    }
    if (dbqueries.highScores[i] == null) {
      dbqueries.highScores[i] = "--";
    }
    text(dbqueries.names[i] + " " + dbqueries.highScores[i], width/2, dbqueries.textStartPosition+i*dbqueries.Distance);
  }
}
