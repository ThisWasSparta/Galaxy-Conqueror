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
    letterX1 = letterX2-100;
    letterX3 = letterX2+100;
    letterY = height/2;
    highLightY = letterY+100;
    highLightX = letterX1;
    letterpicker = new Letterpicker();
  }

  void DrawNamePicker() {
    if (keyPressed) {
      if (key == 'd') {
        highLightX += 200;
      } else if (key == 'a') {
        highLightX -= 200;
      }
    }

    if (highLightX > letterX1 && highLightX < letterX2) {
      first = false;
      second = true;
      third = false;
      letterpicker.Alphabet[letterpicker.num] = letter2;
    } else if (highLightX > 442) {
      first = false;
      second = false;
      third = true;
      letterpicker.Alphabet[letterpicker.num] = letter3;
    } else if (highLightX <= 241) {
      first = true;
      second = false;
      third = false;
      letterpicker.Alphabet[letterpicker.num] = letter1;
    }

    if (first) {
      
      ellipse(highLightX, highLightY, 20, 20);
      letterpicker.DrawLetterpicker();
      letter1 = letterpicker.Alphabet[letterpicker.num];
      //letterpicker.num = 0;
    } 
    
    else if (second) {
      ellipse(highLightX, highLightY, 20, 20);
      letterpicker.DrawLetterpicker();
      letter2 = letterpicker.Alphabet[letterpicker.num];
      //letterpicker.num = 0;
    } 
    
    else if (third) {
      ellipse(highLightX, highLightY, 20, 20);
      letterpicker.DrawLetterpicker();
      letter3 = letterpicker.Alphabet[letterpicker.num];
      //letterpicker.num = 0;
    }
    
    textSize(40);
    text(letter1, letterX1, letterY);
    text(letter2, letterX2, letterY);
    text(letter3, letterX3, letterY);
    name = ""+letter1+letter2+letter3+"";
    keyPressed = false;
  }
}