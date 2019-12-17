class Controls {
  boolean setAction(int k, boolean b) {    //this boolean function detects the input of keys, and makes the other booleans true or false accordingly
    switch (k) {
    case 'w':
      return player.goUp = b;

    case 'a':
      return player.goLeft = b;

    case 's':
      return player.goDown = b;

    case 'd':
      return player.goRight = b;

    case 'j':
      return player.isShooting = b;

    case 'l':
      return player.nextWeapon = b;

    case 't':
      return player.stop = b;

    case 'k':
      return player.exitgame = b;

    case 'p':
      return player.suicide = b;

    case 'i':
      return visuals.screenShakeTest = b;

    default:
      return b;
    }
  }
}
