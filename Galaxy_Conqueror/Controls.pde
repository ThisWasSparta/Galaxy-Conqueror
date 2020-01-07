class Controls {
  boolean setAction(int keyNumber, boolean completeAction) {    //this boolean function detects the input of keys, and makes the other booleans true or false accordingly
    switch (keyNumber) {
    case 'w':
      return player.goUp = completeAction;

    case 'a':
      return player.goLeft = completeAction;

    case 's':
      return player.goDown = completeAction;

    case 'd':
      return player.goRight = completeAction;

    case 'j':
      return player.isShooting = completeAction;

    case 'l':
      return player.nextWeapon = completeAction;

    case 't':
      return player.stop = completeAction;

    case 'k':
      return player.exitgame = completeAction;

    case 'o':
      return player.suicide = completeAction;

    case 'i':
      return visuals.screenShakeTest = completeAction;
    case 'y':
      return tutorial = true;
    case 'p':
      return pause = true;
    default:
      return completeAction;
    }
  }
}
