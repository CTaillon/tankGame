public static int GRID_SIZE=40;
public class Terrain{
  private boolean destructible;
  private boolean traversable;
  private boolean obstructive;
  private color c;
  private int x;
  private int y;
  private int health;
  private int maxHealth;
  
  public Terrain(boolean destructible, boolean traversable, boolean obstructive, color c, int x, int y, int health){
    this.destructible=destructible;
    this.traversable=traversable;
    this.obstructive=obstructive;
    this.c=c;
    this.x=x;
    this.y=y;
    this.health=health;
    this.maxHealth=health;
  }
  public Terrain(boolean destructible, boolean traversable, boolean obstructive, int x, int y, int health){
    this.destructible=destructible;
    this.traversable=traversable;
    this.obstructive=obstructive;
    this.x=x;
    this.y=y;
    this.health=health;
    this.maxHealth=health;
  } 
  
  
  
  public boolean destructible(){
    return this.destructible;
  }
  public boolean traversable(){
    return this.traversable;
  }
  public boolean obstructive(){
    return this.obstructive;
  }
  public int getX(){
    return this.x;
  }
  public int getY(){
    return this.y;
  }
  public int getHealth(){
    return this.health;
  }
  public int getMaxHealth(){
    return this.maxHealth;
  }
  
  public void setColor(int value){
    switch(value){
      case 0:
      this.c=color(255,255,255,0);
      break;
      case 1:
      this.c=color(0);
      break;
      case 2:
      this.c=color(255,203,164);
      break;
      case 3:
      this.c=color(#FFC0CB);
      break;
      case 4:
      this.c=color(#808080);
      break;
      case 5:
      this.c=color(255,0,0);
      break;
      case 6:
      this.c=color(0,0,255);
      break;
      case 7:
      this.c=color(0,255,0);
      break;
      case 10:
      this.c=color(255);
      break;
    }
  }
  
  public void damage(int value){
    this.health-=value;
    if(health<0)this.health=0;
  }
  
  public void render(){
    fill(this.c);
    rectMode(CENTER);
    square(this.x*GRID_SIZE+GRID_SIZE/2,this.y*GRID_SIZE+GRID_SIZE/2,GRID_SIZE);
  }
}
