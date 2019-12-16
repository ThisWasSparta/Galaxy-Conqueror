//Deze class is geschreven door Noah Verburg
class ExplosionPart {
  float x, y;
  float xVelocity, yVelocity;
  float opacity = 255;
  boolean isAlive = false;
  int lifetime;
  float particleColor;
  float particleSize;
  int particlesPerTurn = 10;
  int particleTurn = 0;

  void spawnParticles(int partNr) {
    particle[partNr].particleSize = random(10, 15);
    particle[partNr].lifetime = millis();
    particle[partNr].x = x;
    particle[partNr].y = y;
    particle[partNr].xVelocity = random(-3, 3);
    particle[partNr].yVelocity = random(-3, 3);
    particle[partNr].isAlive = true;
    particle[partNr].opacity = 255;
    particle[partNr].particleColor = random(0, 255);
  }

  void updateParticles(int counter) {
    particle[counter].x += particle[counter].xVelocity;
    particle[counter].y += particle[counter].yVelocity;
    particle[counter].opacity -= 5;
    if (particle[counter].lifetime < millis() - 1000) {
      particle[counter].isAlive = false;
    }
    particle[counter].particleSize *= 0.975;

    if (particle[counter].x <= 0 || particle[counter].x >= width) {
      particle[counter].xVelocity *= -0.8;
    }
    if (particle[counter].y <= 0 || particle[counter].y >= height) {
      particle[counter].yVelocity *= -0.8;
    }
  }

  void drawParticles(int counter) {
    fill(255, particle[counter].particleColor, 0, particle[counter].opacity);
    square(particle[counter].x, particle[counter].y, particle[counter].particleSize);
  }

  void explosion(float X, float Y, int enemyNr) {
    for (int i = 0; i < particle[0].particlesPerTurn; i++) {
      if (particleTurn >= ENEMY_EXPLOSION_PARTICLE_NUMBER-10) {
        particleTurn = 0;
      }
      if (!enemy[enemyNr].isAlive) {
        //x = random(width * 0.1, width * 0.9);
        //y = random(height * 0.1, height * 0.9);
        x = X;
        y = Y;
        spawnParticles(particleTurn);
        particleTurn++;
      }
    }
  }
}
