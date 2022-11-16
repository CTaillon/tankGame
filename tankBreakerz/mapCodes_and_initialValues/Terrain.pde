public static int GRID_SIZE=40;//size of each grid
public class Terrain {
  private boolean destructible;
  private boolean traversable;
  private boolean obstructive;
  private color c;
  private int x;
  private int y;
  private int health;
  private int maxHealth;
  
  //constructors
  public Terrain(boolean destructible, boolean traversable, boolean obstructive, color c, int x, int y, int health) {
    this.destructible=destructible;
    this.traversable=traversable;
    this.obstructive=obstructive;
    this.c=c;
    this.x=x;
    this.y=y;
    this.health=health;
    this.maxHealth=health;
  }
  public Terrain(boolean destructible, boolean traversable, boolean obstructive, int x, int y, int health) {
    this.destructible=destructible;
    this.traversable=traversable;
    this.obstructive=obstructive;
    this.x=x;
    this.y=y;
    this.health=health;
    this.maxHealth=health;
  }



  public boolean destructible() {
    return this.destructible;
  }
  public boolean traversable() {
    return this.traversable;
  }
  public boolean obstructive() {
    return this.obstructive;
  }
  public int getX() {
    return this.x;
  }
  public int getY() {
    return this.y;
  }
  public int getHealth() {
    return this.health;
  }
  public int getMaxHealth() {
    return this.maxHealth;
  }
  
  //change colors based on the map array values
  public void setColor(int value) {
    switch(value) {
    case 0:
      this.c=color(255, 255, 255, 0);
      break;
    case 1:
      this.c=color(0);
      break;
    case 2:
      this.c=color(255, 203, 164);
      break;
    case 3:
      this.c= #FFC0CB;
      break;
    case 4:
      this.c= #808080;
      break;
    case 5:
      this.c=color(255, 0, 0);
      break;
    case 6:
      this.c=color(0, 0, 255);
      break;
    case 7:
      this.c=color(0, 255, 0);
      break;
    case 10:
      this.c=color(255);
      break;
    }
  }
//remove terrain when hp is lower or at 0
  public void damage(int value) {
    this.health-=value;
    if (health<0)this.health=0;
  }
//render the terrain if it is a wall or breakable tiles
  public void render() {
    if (destructible==false && traversable==false && obstructive==true) {
      imageMode(CENTER);
      image(wall, this.x*GRID_SIZE+GRID_SIZE/2, this.y*GRID_SIZE+GRID_SIZE/2, GRID_SIZE, GRID_SIZE);
    }
    if (this.health>0 && traversable==false && destructible==true) {
      fill(this.c);
      rectMode(CENTER);
      square(this.x*GRID_SIZE+GRID_SIZE/2, this.y*GRID_SIZE+GRID_SIZE/2, GRID_SIZE);
    }
  }
}
