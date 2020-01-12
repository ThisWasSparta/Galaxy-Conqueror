//deze class is geschreven door Dennis
class DBQueries {

  boolean insertQuerieDone = false;
  boolean getHighScores = false;
  boolean getAch = false;
  int highScoreSize = 10;
  int achievementSize = 12;
  String highScores[] = new String[highScoreSize];
  String names[] = new String[highScoreSize];
  String killCount[] = new String[highScoreSize];
  String score;
  String namesAch[] = new String[achievementSize];
  String descsAch[] = new String[achievementSize];
  String nameAch;
  String descAch;
  int i;
  float textStartPosition = 300;
  float Distance = 50;
  float DistanceAch = 64;

  DBQueries() {
  }

  void dbInsert() {
    if (dbconnect.sql.connect()) {      //als er een connectie is met de database worden de queries uitgevoerd
      dbconnect.sql.query("INSERT INTO Players (Playername) VALUES ('"+namePicker.name+"')");                                                                //Insert query voor playertable
      dbconnect.sql.query("INSERT INTO Highscores (Score) VALUES ("+ scoreObj.score +")");                                                                   //Insert query voor Highscorestable
      dbconnect.sql.query("INSERT INTO PlayerStatistics (PlayerkillCount, PlayerSurvivalTime) VALUES (" + killcount + " , " + survivalTime + ")");           //Insert query voor playerstatstable
      insertQuerieDone = true;
    }
  }

  void dbSelectHighScores() {
    if (getHighScores == false) {    //boolean om te checken of de highscores al zijn opgehaald
      if (dbconnect.sql.connect()) {
        dbconnect.sql.query("SELECT Players.Playername, Highscores.Score FROM Players INNER JOIN Highscores ON Players.Playernumber = Highscores.Playernumber ORDER BY Score DESC LIMIT 10");  //Select query om de highscores op te halen
        i = 0;
        while (dbconnect.sql.next()) {                           //deze loop blijft doorgaan zolang er een volgende row gevonden word in de database
          names[i] = dbconnect.sql.getString("Playername");      //bij elke row die gevonden is word Playername in de array names gezet
          highScores[i] = dbconnect.sql.getString("Score");      //hier word score in de array highScores gezet
          i++;
        }
      }
      getHighScores = true;      //boolean word op true gezet zodat de data niet steeds opnieuw word opgehaald terwijl je op de highscore pagina bent
    }
  }
  
  void dbSelectAch() {
    if (getAch == false) {          //boolean om te checken of de achievements al opgehaald zijn
      if (dbconnect.sql.connect()) {
        dbconnect.sql.query("SELECT achievementName, achievementDescription FROM Achievements");      //Select query om de achievements op te halen
        i = 0;
        while (dbconnect.sql.next()) {                                            //deze loop blijft doorgaan zolang er een volgende row gevonden word in de database
          namesAch[i] = dbconnect.sql.getString("achievementName");               //bij elke row word achievementName in de array nameAch gezet
          descsAch[i] = dbconnect.sql.getString("achievementDescription");        //bij elke row word achievementDescription in de array descAch gezet
          i++;
        }
      }
      getAch = true;             //boolean word op true gezet zodat de data niet steeds opnieuw word opgehaald terwijl je op de achievements pagina bent
    }
  }
}

void GetHighScore() {
  dbqueries.dbSelectHighScores();                              //method word aangeroepen die de highscores data ophaald
  for (int i = 0; i < dbqueries.highScoreSize; i ++) {         //hier word door de highscore array geloopt
    if (dbqueries.names[i] == null) {                          //op de plekken waar de array leeg is worden er streepjes gezet
      dbqueries.names[i] = "--";
    }
    if (dbqueries.highScores[i] == null) {                     //op de plekken waar de array leeg is worden er streepjes gezet
      dbqueries.highScores[i] = "--";
    }
    text(dbqueries.names[i] + " " + dbqueries.highScores[i], width/2, dbqueries.textStartPosition+i*dbqueries.Distance);      //hier wordt de highscore text gemaakt die op de highscore pagina word gezet
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
    textSize(25);
    textAlign(LEFT);
    text(dbqueries.namesAch[i] + " - " + dbqueries.descsAch[i], width/2-600, dbqueries.textStartPosition-135+i*dbqueries.DistanceAch);
  }
}
