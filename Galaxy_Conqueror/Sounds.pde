class Sounds {
  boolean cache = false;
  SoundFile bgm;
  SoundFile playergatshoot;
  SoundFile deathraydis;
  SoundFile deathraycharge;
  SoundFile enemydeath2;
  SoundFile enemydeath1;
  SoundFile scoutshoot;
  
  Sounds(PApplet app) {
    bgm = new SoundFile(app, "./sound/stagethemefix.wav");
    playergatshoot = new SoundFile(app,"./sound/gattlingweapon_noise.wav");
    deathraydis = new SoundFile(app,"./sound/boss_deathray_discharge.wav");
    deathraycharge = new SoundFile(app,"./sound/deathray_charge.wav");
    enemydeath1 = new SoundFile(app,"./sound/enemy_deathsound1.wav");
    enemydeath2 = new SoundFile(app,"./sound/enemy_deahtsound2.wav");
    playergatshoot = new SoundFile(app,"./sound/scout_shootnoise.wav");
  }
}
