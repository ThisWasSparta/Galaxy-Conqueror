class Letterpicker {

  String Alphabet1[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
  String Alphabet2[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
  String Alphabet3[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
  int num;
  

  Letterpicker() {
    num = 0;
  }

  void DrawLetterpicker() {
    if (keyPressed) {
      if (key == 's') {//if key 's' is pressed
        num++;
      } else if (key == 'w') {//if key 'w' is pressed
        num--;
      }
      if (num >= 26) {
        num = 0;
      }
      if (num < 0) {
        num = 25;
      }
    }
    keyPressed = false;
  }
}
