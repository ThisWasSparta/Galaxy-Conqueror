//This class was written by Lucas van Wonderen
class BackgroundStars {

  int aSter = 300;

  float []x = new float[aSter];
  float []y = new float[aSter];
  float []yspeed = new float[aSter];
  float []rad = new float[aSter];
  float []tran = new float[aSter];

  void sterrenProp () {
    for (int i = 0; i < aSter; i++) {
      x[i] = random(0, width);
      y[i] = random(0, height);
      yspeed[i] = random(1, 5);
      rad[i] = random(1, 10);
      tran[i] = random(0, 255);
    }
  }
  void sterrenShow() {
    //Sterren showen
    for (int i = 0; i < aSter; i++) {
      fill(255, 255, 255, tran[i]);
      noStroke();    
      square(x[i], y[i], rad[i]);
      y[i] = y[i] + yspeed[i];
      if (y[i] > height) {
        y[i] = -5;
        x[i] = random(0, width);
      }
    }
  }
}
