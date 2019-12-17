//Deze class is geschreven door Noah Verburg
class EnemyShootParticle {
  float x, y;
  float xVelocity, yVelocity;
  float opacity = 255;
  boolean isAlive = false;
  int lifetime;
  float particleColorR;
  float particleColorG;
  float particleColorB;
  float particleSize;
  final int PARTICLES_PER_TURN = 5;
  int particleTurn = 1;

  void firing(float X, float Y, int enemyNr) {
    for (int i = 0; i < enemyShootParticle[0].PARTICLES_PER_TURN; i++) {
      if (!enemyShootParticle[particleTurn].isAlive) { 
        if (particleTurn >= ENEMY_SHOOT_PARTICLE_NUMBER - 5) {
          particleTurn = 0;
        }
        //x = random(width * 0.1, width * 0.9);
        //y = random(height * 0.1, height * 0.9);
        x = X;
        y = Y;
        spawnParticles(enemyNr, particleTurn);
        particleTurn++;
      }
    }
  }

  void spawnParticles(int currentEnemy, int partNr) {
    enemyShootParticle[partNr].particleSize = random(3, 5);
    enemyShootParticle[partNr].lifetime = millis();
    enemyShootParticle[partNr].x = x;
    enemyShootParticle[partNr].y = y;
    enemyShootParticle[partNr].xVelocity = random(-2, 2);
    enemyShootParticle[partNr].yVelocity = random(7, 8);
    enemyShootParticle[partNr].isAlive = true;
    enemyShootParticle[partNr].opacity = 255;
    enemyShootParticle[partNr].particleColorR = random(200, 255);
    enemyShootParticle[partNr].particleColorG = random(80, 200);
    enemyShootParticle[partNr].particleColorB = enemyShootParticle[partNr].particleColorG;
  }

  void updateParticles() {
    for (int i = 0; i < ENEMY_SHOOT_PARTICLE_NUMBER; i++) {
      if (enemyShootParticle[i].isAlive) {
        enemyShootParticle[i].x += enemyShootParticle[i].xVelocity;
        enemyShootParticle[i].y += enemyShootParticle[i].yVelocity;
        if (enemyShootParticle[i].lifetime < millis() - 800) {
          enemyShootParticle[i].isAlive = false;
        }
        enemyShootParticle[i].opacity -= 5;
      }
    }
  }

  void drawParticles() {
    for (int i = 0; i < ENEMY_SHOOT_PARTICLE_NUMBER; i++) {
      fill(enemyShootParticle[i].particleColorR, enemyShootParticle[i].particleColorG, enemyShootParticle[i].particleColorB, enemyShootParticle[i].opacity);
      square(enemyShootParticle[i].x + visuals.magnitudeX, enemyShootParticle[i].y + visuals.magnitudeY, enemyShootParticle[i].particleSize);
    }
  }
}
