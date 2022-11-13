class Timer {
  public int startTime;
  public int interval;

  //constructor
  public Timer(int timeInterval) {
    interval=timeInterval;
  }
  public void timerStart() {
    startTime=millis();
  }
  public boolean timerComplete() {
    int elapsedTime= millis()-startTime;
    if (elapsedTime>interval) return true;
    else return false;
  }
}
