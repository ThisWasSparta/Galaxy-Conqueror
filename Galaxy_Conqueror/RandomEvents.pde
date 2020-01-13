//This class was written by Noah Verburg
class RandomEvents {
  int eventTimer = 0;    //timer between events
  int activeEventTimer = 0;    //timer that keeps track of the duration of an event
  int currentEvent;
  int randomTimeBetweenEvents;
  int timeBetweenEventsMin = 20000;
  int timeBetweenEventsMax = 30000;

  boolean randomEventsHappen = false;
  boolean eventActive = false;

  void selectEvent() {
    if (!randomEventsHappen && scoreObj.score >= 1000 && !boss.bossAlive) {  //determines wether random events are supposed to happen (yet).
      randomEventsHappen = true;
      eventTimer = millis();
    }
    if (scoreObj.score < 1000 || boss.bossAlive) {
      randomEventsHappen = false;
    }
    if (events.randomEventsHappen) {    //selects a random event. (only 1 event exists as of right now but it's build to support multiple.)
      if (millis() - randomTimeBetweenEvents > eventTimer * 0.7) {
        eventActive = true;
      }
      if  (millis() - randomTimeBetweenEvents > eventTimer) {
        currentEvent = int(random(1, 3));
        activeEventTimer = millis();
        currentEvent = 1;
        randomTimeBetweenEvents = int(random(timeBetweenEventsMin, timeBetweenEventsMax));
        eventTimer = millis();
      }
    }
  }

  void executeEvent() {    //calls a function to execute the chosen event.
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
    }
  }
}
