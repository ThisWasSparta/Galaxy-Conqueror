class Letterpicker {

  String Alphabet1[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
  String Alphabet2[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
  String Alphabet3[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
  int num1;
  int num2;
  int num3;


  Letterpicker() {
    num1 = 0;
    num2 = 0;
    num3 = 0;
  }


  void DrawLetterpicker1() {
    if (keyPressed) {
      if (key == 's') {//if key 's' is pressed
        num1++;
      } else if (key == 'w') {//if key 'w' is pressed
        num1--;
      }
      if (num1 >= 26) {
        num1 = 0;
      }
      if (num1 < 0) {
        num1 = 25;
      }
    }
    keyPressed = false;
  } 
  void DrawLetterpicker2() {
    if (keyPressed) {
      if (key == 's') {//if key 's' is pressed
        num2++;
      } else if (key == 'w') {//if key 'w' is pressed
        num2--;
      }
      if (num2 >= 26) {
        num2 = 0;
      }
      if (num2 < 0) {
        num2 = 25;
      }
    }
    keyPressed = false;
  }
  void DrawLetterpicker3() {
    if (keyPressed) {
      if (key == 's') {//if key 's' is pressed
        num3++;
      } else if (key == 'w') {//if key 'w' is pressed
        num3--;
      }
      if (num3 >= 26) {
        num3 = 0;
      }
      if (num3 < 0) {
        num3 = 25;
      }
    }
    keyPressed = false;
  }
}
