//This class was written by Noah Verburg
class RandomEvents {
  int eventTimer = 0;
  int activeEventTimer = 0;
  int currentEvent;
  int randomTimeBetweenEvents;
  int timeBetweenEventsMin = 20000;
  int timeBetweenEventsMax = 30000;

  boolean randomEventsHappen = false;
  boolean eventActive = false;

  void selectEvent() {
    if (!randomEventsHappen && score >= 1000 && !boss.bossAlive) {
      randomEventsHappen = true;
      eventTimer = millis();
    }
    if (events.randomEventsHappen) {
      if (millis() - randomTimeBetweenEvents > eventTimer * 0.7) {
        eventActive = true;
      }
      if  (millis() - randomTimeBetweenEvents > eventTimer) {
        currentEvent = int(random(1, 4));
        activeEventTimer = millis();
        currentEvent = 1;
        randomTimeBetweenEvents = int(random(timeBetweenEventsMin, timeBetweenEventsMax));
        eventTimer = millis();
      }
    }
  }

  void executeEvent() {
    switch (currentEvent) {
    case 0:
      if (millis() - 2000 > activeEventTimer) {
        eventActive = false;
      }
      break;
    case 1:
      scoutSwarmEventSpawner();
      currentEvent = 0;
    case 2:
      currentEvent = 0;
    case 3:
      currentEvent = 0;
    }
  }
}
