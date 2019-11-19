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
  int particlesPerTurn = 5;
  int particleTurn = 1;

  void firing(float X, float Y, int enemyNr) {
    for (int i = 0; i < enemyShootParticle[0].particlesPerTurn; i++) {
      if (!enemyShootParticle[particleTurn].isAlive) { 
        if (particleTurn >= enemyShootParticleNumber - 5) {particleTurn = 0;}
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
    enemyShootParticle[partNr].yVelocity = random(4, 5);
    enemyShootParticle[partNr].isAlive = true;
    enemyShootParticle[partNr].opacity = 255;
    enemyShootParticle[partNr].particleColorR = random(200, 255);
    enemyShootParticle[partNr].particleColorG = random(80,200);
    enemyShootParticle[partNr].particleColorB = enemyShootParticle[partNr].particleColorG;
    /* for (int i = 0; i < particlesPerTurn; i++) {
      if (!enemyShootParticle[partNr].isAlive) {
        enemyShootParticle[particleTurn].particleColorR = random(200,255);
        enemyShootParticle[particleTurn].particleColorG = random(0,200);
        enemyShootParticle[particleTurn].particleColorB = random(enemyShootParticle[particleTurn].particleColorG);
        enemyShootParticle[particleTurn].particleSize = random(2,5);
        if (enemy[currentEnemy].enemyType == 1) {
          enemyShootParticle[particleTurn].x = enemy[currentEnemy].eX;
          enemyShootParticle[particleTurn].y = enemy[currentEnemy].eY + enemy[currentEnemy].eH/2;
          enemyShootParticle[particleTurn].isAlive = true;
        }
        if (enemy[currentEnemy].enemyType == 2) {
          enemyShootParticle[particleTurn].x = enemy[currentEnemy].eX - enemy[currentEnemy].eW/3;
          enemyShootParticle[particleTurn].y = enemy[currentEnemy].eY;
          enemyShootParticle[particleTurn].isAlive = true;
          particleTurn++;
          if (particleTurn >= enemyShootParticleNumber - 5) {
            particleTurn = 0;
          }
          enemyShootParticle[particleTurn].x = enemy[currentEnemy].eX + enemy[currentEnemy].eW/3;
          enemyShootParticle[particleTurn].y = enemy[currentEnemy].eY + enemy[currentEnemy].eH/2;
          enemyShootParticle[particleTurn].isAlive = true;
        }
        if (enemy[currentEnemy].enemyType == 3) {
          enemyShootParticle[particleTurn].x = enemy[currentEnemy].eX;
          enemyShootParticle[particleTurn].y = enemy[currentEnemy].eY + enemy[currentEnemy].eH/2;
          enemyShootParticle[particleTurn].isAlive = true;
        }
        enemyShootParticle[particleTurn].lifetime = millis();
        enemyShootParticle[particleTurn].opacity = 255;
        
        enemyShootParticle[particleTurn].xVelocity = random(-2, 2);
        enemyShootParticle[particleTurn].yVelocity = random(4, 5);
      }
    }*/
  }

  void updateParticles() {
    for (int i = 0; i < enemyShootParticleNumber; i++) {
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
    for (int i = 0; i < enemyShootParticleNumber; i++) {
      fill(enemyShootParticle[i].particleColorR, enemyShootParticle[i].particleColorG, enemyShootParticle[i].particleColorB, enemyShootParticle[i].opacity);
      square(enemyShootParticle[i].x, enemyShootParticle[i].y, enemyShootParticle[i].particleSize);
    }
  }
}
