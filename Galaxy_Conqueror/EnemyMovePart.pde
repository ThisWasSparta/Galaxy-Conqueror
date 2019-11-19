//This class was written by Noah Verburg
class EnemyMoveParticles {
  float x, y;
  float xVelocity, yVelocity;
  float opacity = 255;
  boolean isAlive = false;
  int lifetime;
  float particleColor;
  float particleSize;
  int particlesPerTurn = 2;
  int particleTurn = 0;
  
  void spawnParticles(int enemyShipNr, int enemyShipType) {
    if (enemyShipType == 1) {
      enemyMoveParticle[particleTurn].x = enemy[enemyShipNr].eX + random(-enemy[enemyShipNr].defaultScoutWidth/4, enemy[enemyShipNr].defaultScoutWidth/4);
      enemyMoveParticle[particleTurn].y = enemy[enemyShipNr].eY - enemy[enemyShipNr].defaultScoutHeight/3;
      enemyMoveParticle[particleTurn].particleColor = random(0, 255);
      enemyMoveParticle[particleTurn].particleSize = random(3, 8);
      enemyMoveParticle[particleTurn].lifetime = millis();
      enemyMoveParticle[particleTurn].xVelocity = random(-0.1, 0.1);
      enemyMoveParticle[particleTurn].yVelocity = random(-2, 0);
      enemyMoveParticle[particleTurn].opacity = 255;
    }
    if (particleTurn > enemyMoveParticleNumber - 5) {
      particleTurn = 0;
    } else {
      particleTurn++;
    }
  }
  
  void updateParticles(int partNr) {
    
  }
  
  void drawParticles(int partNr) {
    
  }
}
