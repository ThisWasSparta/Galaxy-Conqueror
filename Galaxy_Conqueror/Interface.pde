//Deze class is geschreven door Noah Verburg
class Interface {
  void drawInterface() {
    textSize(25);
    fill(191, 5, 26);
    text("A", width * 0.15 + visuals.maxMagnitudeX, height * 0.05 + visuals.maxMagnitudeY);
    fill(255, 255, 255);
    text("NEXT", width * 0.15 + visuals.maxMagnitudeX, height * 0.1 + visuals.maxMagnitudeY);
    text("WEAPON", width * 0.15 + visuals.maxMagnitudeX, height * 0.15 + visuals.maxMagnitudeY);

    fill(220, 177, 39);
    text("B", width * 0.05 + visuals.maxMagnitudeX, height * 0.05 + visuals.maxMagnitudeY);
    fill(255, 255, 255);
    text("SHOOT", width * 0.05 + visuals.maxMagnitudeX, height * 0.1 + visuals.maxMagnitudeY);

    textSize(15);
    text("HIT THE", width * 0.052 + visuals.maxMagnitudeX, height * 0.91 + visuals.maxMagnitudeY);
    text("METEORITE", width * 0.052 + visuals.maxMagnitudeX, height * 0.93 + visuals.maxMagnitudeY);
    text("FOR +1 HEALTH", width * 0.052 + visuals.maxMagnitudeX, height * 0.95 + visuals.maxMagnitudeY);
  }
}
