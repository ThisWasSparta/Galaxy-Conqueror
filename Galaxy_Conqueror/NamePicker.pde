class NamePicker {
  Letterpicker letterpicker;
  float letterX1;
  float letterX2;
  float letterX3;
  float letterY;
  float highLightY;
  float highLightX;
  float highLightSize;
  String letter1 = "A";
  String letter2 = "A";
  String letter3 = "A";
  String temp;
  String name;
  boolean first = true;
  boolean second = false;
  boolean third = false;
  boolean change = false;
  int highLightOffset = 100;

  NamePicker() {
    letterX2 = width/2;
    letterX1 = letterX2-200;
    letterX3 = letterX2+200;
    letterY = height/2;
    highLightY = letterY+100;
    highLightX = letterX1-5;
    highLightSize = 20;
    letterpicker = new Letterpicker();
  }

  void DrawNamePicker() {
    if (keyPressed) {
      if (key == 'd' && highLightX < letterX3-100) {            //als de juiste key wordt ingedrukt en hij staat niet voorbij de laatste letter dan schuift de highlight 200 pixels naar rechts
        highLightX += 200;
      } else if (key == 'a' && highLightX > letterX1) {         //als de juiste key wordt ingedrukt en hij staat niet voorbij de eerste letter dan schuift de highlight 200 pixels naar links
        highLightX -= 200;
      }
    }

    if (highLightX > letterX1 && highLightX < letterX3-highLightOffset) { //boolean to check if you are selecting the second letter
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



    if (first) {                                                            //als first true is dan is de eerste letter geselecteerd en wordt alleen die aangepast
      ellipse(highLightX, highLightY, highLightSize, highLightSize);
      letterpicker.DrawLetterpicker1();
      letter1 = letterpicker.Alphabet1[letterpicker.num1];
    } else if (second) {                                                    //als second true is dan is de tweede letter geselecteerd en wordt alleen die aangepast
      ellipse(highLightX, highLightY, highLightSize, highLightSize);
      letterpicker.DrawLetterpicker2();
      letter2 = letterpicker.Alphabet2[letterpicker.num2];
    } else if (third) {                                                     //als third true is dan is de derde letter geselecteerd en wordt alleen die aangepast
      ellipse(highLightX, highLightY, highLightSize, highLightSize);
      letterpicker.DrawLetterpicker3();
      letter3 = letterpicker.Alphabet3[letterpicker.num3];
    }

    textSize(80);
    text(letter1, letterX1, letterY);                            //letter1 wordt getekend
    text(letter2, letterX2, letterY);                            //letter2 wordt getekend
    text(letter3, letterX3, letterY);                            //letter3 wordt getekend
    name = ""+letter1+letter2+letter3+"";                        //de letters worden als 1 string opgeslagen als name
    keyPressed = false;                                          //keypressed word op false gezet
  }
}
