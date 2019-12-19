//deze class is geschreven door Dennis
class DBQueries {

  boolean insertQuerieDone = false;
  boolean getHighScores = false;
  boolean getAch = false;
  int highScoreSize = 10;
  int achievementSize = 13;
  String highScores[] = new String[highScoreSize];
  String names[] = new String[highScoreSize];
  String killCount[] = new String[highScoreSize];
  String name;
  String score;
  String namesAch[] = new String[achievementSize];
  String descsAch[] = new String[achievementSize];
  String nameAch;
  String descAch;
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
        dbconnect.sql.query("SELECT Players.Playername, Highscores.Score, Highscores.playerkillCount FROM Players INNER JOIN Highscores ON Players.Playernumber = Highscores.Playernumber ORDER BY Score DESC LIMIT 10");
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
  void dbSelectAch() {
    if (getAch == false) {
      if (dbconnect.sql.connect()) {
        dbconnect.sql.query("SELECT achievementName, achievementDescription FROM Achievements");
        i = 0;
        while (dbconnect.sql.next()) {
          namesAch[i] = dbconnect.sql.getString("achievementName");
          descsAch[i] = dbconnect.sql.getString("achievementDescription");
          i++;
        }
      }
      getAch = true;
    }
  }
}

void GetHighScore() {
  dbqueries.dbSelectHighScores();
  for (int i = 0; i < dbqueries.highScoreSize; i ++) {
    if (dbqueries.names[i] == null) {
      dbqueries.names[i] = "--";
    }
    if (dbqueries.highScores[i] == null) {
      dbqueries.highScores[i] = "--";
    }
    text(dbqueries.names[i] + " " + dbqueries.highScores[i], width/2, dbqueries.textStartPosition+i*dbqueries.Distance);
  }
}

void GetAch() {
  dbqueries.dbSelectAch();
  for (int i = 0; i < dbqueries.achievementSize; i ++) {
    if (dbqueries.namesAch[i] == null) {
      dbqueries.namesAch[i] = "--";
    }
    if (dbqueries.descsAch[i] == null) {
      dbqueries.descsAch[i] = "--";
    }
    text(dbqueries.namesAch[i] + " " + dbqueries.descsAch[i], width/2, dbqueries.textStartPosition+i*dbqueries.Distance);
  }
}
