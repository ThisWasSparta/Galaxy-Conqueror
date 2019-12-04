class NamePicker {
  Letterpicker letterpicker;
  float letterX1;
  float letterX2;
  float letterX3;
  float letterY;
  float highLightY;
  float highLightX;
  String letter1 = "A";
  String letter2 = "A";
  String letter3 = "A";
  String temp;
  String name;
  boolean first = true;
  boolean second = false;
  boolean third = false;
  boolean change = false;

  NamePicker() {
    letterX2 = width/2;
    letterX1 = letterX2-200;
    letterX3 = letterX2+200;
    letterY = height/2;
    highLightY = letterY+100;
    highLightX = letterX1-5;
    letterpicker = new Letterpicker();
  }

  void DrawNamePicker() {
    if (keyPressed) {
      if (key == 'd' && highLightX < letterX3-100) {
        highLightX += 200;
      } else if (key == 'a' && highLightX > letterX1) {
        highLightX -= 200;
      }   
    }

    if (highLightX > letterX1 && highLightX < letterX3-100) { //boolean to check if you are selecting the second letter
      first = false;
      second = true;
      third = false;
      letterpicker.Alphabet2[letterpicker.num2] = letter2;
    } else if (highLightX > letterX2) { // boolean to check if you are selecting the third letter
      first = false;
      second = false;
      third = true;
      letterpicker.Alphabet3[letterpicker.num3] = letter3;
    } else if (highLightX < letterX2) { // boolean to check if you are selecting the first letter
      first = true;
      second = false;
      third = false;
      letterpicker.Alphabet1[letterpicker.num1] = letter1;
    }

    if (first) {
      
      ellipse(highLightX, highLightY, 20, 20);
      letterpicker.DrawLetterpicker1();
      letter1 = letterpicker.Alphabet1[letterpicker.num1];
    } 
    
    else if (second) {
      ellipse(highLightX, highLightY, 20, 20);
      letterpicker.DrawLetterpicker2();
      letter2 = letterpicker.Alphabet2[letterpicker.num2];
    } 
    
    else if (third) {
      ellipse(highLightX, highLightY, 20, 20);
      letterpicker.DrawLetterpicker3();
      letter3 = letterpicker.Alphabet3[letterpicker.num3];
    }
    
    textSize(80);
    text(letter1, letterX1, letterY);
    text(letter2, letterX2, letterY);
    text(letter3, letterX3, letterY);
    name = ""+letter1+letter2+letter3+"";
    keyPressed = false;
  }
}
