class NamePicker {
  Letterpicker letterpicker;
  float letterX;
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
    letterX = 200;
    letterY = height/4;
    highLightY = 400;
    highLightX = 241;
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

    if (highLightX > 241 && highLightX < 442) {
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
    
    text(letter1, letterX, letterY);
    text(letter2, letterX+200, letterY);
    text(letter3, letterX+400, letterY);
    name = ""+letter1+letter2+letter3+"";
    keyPressed = false;
  }
}
