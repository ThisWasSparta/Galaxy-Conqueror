//deze class is geschreven door Dennis
class DBQueries {

  boolean insertQuerieDone = false;
  boolean getHighScores = false;
  int highScoreSize = 10;
  String []highScores = new String[highScoreSize];
  String []names = new String[highScoreSize];
  String name;
  String score;
  int i;


  DBQueries() {
  }

  void dbInsert() {
    if (dbconnect.sql.connect()) {
      dbconnect.sql.query("INSERT INTO Players (Playername) VALUES ('"+namePicker.name+"')");
      dbconnect.sql.query("INSERT INTO Highscores (Score, Playername) VALUES ("+ scoreObj.score +", '" + namePicker.name + "')");
      insertQuerieDone = true;
    }
  }

  void dbSelectHighScores() {
    if (dbconnect.sql.connect()) {
      
      dbconnect.sql.query("SELECT Players.Playername, Highscores.Score FROM Players INNER JOIN Highscores ON Players.Playername = Highscores.Playername ORDER BY Score DESC LIMIT 10");
      while (dbconnect.sql.next()) {
        i = 0;
        names[i] = dbconnect.sql.getString("Playername");
        highScores[i] = dbconnect.sql.getString("Score");
        println(names[i] + " - " + highScores[i]);
        i++;
        dbqueries.getHighScores = true;
      }
    }
  }
}
