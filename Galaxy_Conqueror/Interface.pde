//Deze class is geschreven door Noah Verburg
class Interface {
  void drawInterface() {
    textSize(25);
    fill(191, 5, 26);
    text("A", width * 0.15 + visuals.magnitudeX, height * 0.05 + visuals.magnitudeY);
    fill(255, 255, 255);
    text("NEXT", width * 0.15 + visuals.magnitudeX, height * 0.1 + visuals.magnitudeY);
    text("WEAPON", width * 0.15 + visuals.magnitudeX, height * 0.15 + visuals.magnitudeY);

    fill(220, 177, 39);
    text("B", width * 0.05 + visuals.magnitudeX, height * 0.05 + visuals.magnitudeY);
    fill(255, 255, 255);
    text("SHOOT", width * 0.05 + visuals.magnitudeX, height * 0.1 + visuals.magnitudeY);

    textSize(15);
    text("HIT THE", width * 0.052 + visuals.magnitudeX, height * 0.91 + visuals.magnitudeY);
    text("METEORITE", width * 0.052 + visuals.magnitudeX, height * 0.93 + visuals.magnitudeY);
    text("FOR +1 HEALTH", width * 0.052 + visuals.magnitudeX, height * 0.95 + visuals.magnitudeY);

    //Tutorial made by Sam Spronk
    if (!tutorial) {
      fill(255, 255, 255);
      textSize(35);
      text("↓", width * 0.05 + visuals.magnitudeX, height * 0.87 + visuals.magnitudeY);
      text("Health", width * 0.07 + visuals.magnitudeX, height * 0.83 + visuals.magnitudeY);

      text("↑", width * 0.10 + visuals.magnitudeX, height * 0.21 + visuals.magnitudeY);
      text("Weapons", width * 0.10 + visuals.magnitudeX, height * 0.25 + visuals.magnitudeY);

      text("↑", width * 0.95 + visuals.magnitudeX, height * 0.25 + visuals.magnitudeY);
      text("Weapon", width * 0.95 + visuals.magnitudeX, height * 0.29 + visuals.magnitudeY);
      text("Wheel", width * 0.95 + visuals.magnitudeX, height * 0.33 + visuals.magnitudeY);

      text("↑", width * 0.46 + visuals.magnitudeX, height * 0.46 + visuals.magnitudeY);
      text("Up", width * 0.51 + visuals.magnitudeX, height * 0.46 + visuals.magnitudeY);
      text("→", width * 0.46 + visuals.magnitudeX, height * 0.50 + visuals.magnitudeY);
      text("Right", width * 0.539 + visuals.magnitudeX, height * 0.50 + visuals.magnitudeY);
      text("↓", width * 0.46 + visuals.magnitudeX, height * 0.54 + visuals.magnitudeY);
      text("Down", width * 0.53 + visuals.magnitudeX, height * 0.54 + visuals.magnitudeY);
      text("←", width * 0.46 + visuals.magnitudeX, height * 0.58 + visuals.magnitudeY);
      text("Left", width * 0.5285 + visuals.magnitudeX, height * 0.58 + visuals.magnitudeY);
      fill(191, 5, 26);
      text("A", width * 0.46 + visuals.magnitudeX, height * 0.62 + visuals.magnitudeY);
      fill(255, 255, 255);
      text("Next weapon", width * 0.595 + visuals.magnitudeX, height * 0.62 + visuals.magnitudeY);
      fill(220, 177, 39);
      text("B", width * 0.46 + visuals.magnitudeX, height * 0.66 + visuals.magnitudeY);
      fill(255, 255, 255);
      text("Shoot", width * 0.54 + visuals.magnitudeX, height * 0.66 + visuals.magnitudeY);
    }
  }
}
