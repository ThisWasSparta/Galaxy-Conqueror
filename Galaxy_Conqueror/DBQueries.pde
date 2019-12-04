//deze class is geschreven door Dennis
class DBQueries {
  
  DBQueries(){
    
  }
  
  void dbInsert() {
    if (dbconnect.sql.connect()) {
      dbconnect.sql.query("INSERT INTO Players (Playername) VALUES ('"+namePicker.name+"')");
      dbconnect.sql.query("INSERT INTO Highscores (Score, Playername) VALUES ("+ scoreObj.score +", 'SAS')");
      println("Database Connected");
    }
  }
  
}
