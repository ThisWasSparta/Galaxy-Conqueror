//This class was written by Lucas van Wonderen
class BackgroundStars {

  int aSter = 300;                     //Number of stars in the background

  float []x = new float[aSter];        //X coordinate of stars
  float []y = new float[aSter];        //Y coordinate of stars
  float []yspeed = new float[aSter];   //Speed of stars
  float []rad = new float[aSter];      //Radius of stars
  float []tran = new float[aSter];     //Transparency of stars

  void sterrenProp () {
    for (int i = 0; i < aSter; i++) {
      x[i] = random(0, width);     //X coordinate of stars
      y[i] = random(0, height);    //Y coordinate of stars
      yspeed[i] = random(1, 5);    //Speed of stars
      rad[i] = random(1, 10);      //Radius of stars
      tran[i] = random(0, 255);    //Transparency of stars
    }
  }
  void sterrenShow() {
    for (int i = 0; i < aSter; i++) {
      fill(255, 255, 255, tran[i]);
      noStroke();    
      square(x[i], y[i], rad[i]);  //Draw stars
      y[i] = y[i] + yspeed[i];
      if (y[i] > height) {         //Checks if star has surpassed lower border
        y[i] = -5;                 //Resets starts to the top
        x[i] = random(0, width);   //Gives stars new position
      }
    }
  }
}
