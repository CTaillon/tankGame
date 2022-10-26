public class Shot{
  //Stats
  private int speed = 1;
  private int maxBounces = 0;
  private int maxDis = 1;
  private int size = 1;
  private int blastSize = 0;
  private int maxTerrainBreak = 0;
  private int damage = 1;
  //Position
  private float x;
  private float y;
  private float theta;
  //Counters
  private int bounces;
  private int dis;
  private int terrainBreak;
  
  private boolean remove = false;
  
  public Shot(Tank originTank){
    this.speed=originTank.getStat("shotSpeed");
    this.maxBounces=originTank.getStat("maxBounces");
    this.maxDis=originTank.getStat("maxShotDis");
    this.size=originTank.getStat("shotSize");
    this.blastSize=originTank.getStat("shotBlastSize");
    this.damage=originTank.getStat("shotDamage");
    this.maxTerrainBreak=originTank.getStat("maxTerrainBreak");
    this.x=originTank.getX()+(originTank.getStat("size")*20*cos(originTank.getAimTheta()));
    this.y=originTank.getY()+(originTank.getStat("size")*20*sin(originTank.getAimTheta()));
    this.theta=originTank.getAimTheta();
  }
  
  public void render(){
    fill(255);
    circle(x,y,size*10);
    move();
  }
  
  public boolean checkRemove(){
    return this.remove;
  }
  
  public boolean checkCollision(float x,float y){
    for(Terrain[] array : layout){
      for(Terrain terrain : array){
        if((!terrain.traversable())&&abs(0.5+terrain.getX()-x/GRID_SIZE)<0.5+this.size*10/GRID_SIZE&&abs(0.5+terrain.getY()-y/GRID_SIZE)<0.5+this.size*10/GRID_SIZE)return true;
      }
    }
    return false;
  }
  
  public Terrain getCollision(float x,float y){
    for(Terrain[] array : layout){
      for(Terrain terrain : array){
        if(abs(0.5+terrain.getX()-x/GRID_SIZE)<0.5+this.size*10/GRID_SIZE&&abs(0.5+terrain.getY()-y/GRID_SIZE)<0.5+this.size*10/GRID_SIZE)return terrain;
      }
    }
    return null;
  }
  
  public void bounce(Terrain terrain){
    if(bounces<maxBounces){
      if(this.x>terrain.getX()*GRID_SIZE&&this.x<terrain.getX()*GRID_SIZE+GRID_SIZE){
        this.theta+=2*(0-this.theta);
      } else if(this.y>terrain.getY()*GRID_SIZE&&this.y<terrain.getY()*GRID_SIZE+GRID_SIZE){
        this.theta+=2*(HALF_PI-this.theta);
      }
      
      bounces++;
    } else {
      this.remove=true;
    }
  }
  
  public void move(){
    for(int i = 0; i<this.speed*2;i++){
      if(!checkCollision(this.x+cos(this.theta),this.y+sin(this.theta))){
        this.y+=sin(this.theta);
        this.x+=cos(this.theta);
      } else if (getCollision(this.x+cos(this.theta),this.y+sin(this.theta)).destructible()){
        getCollision(this.x+cos(this.theta),this.y+sin(this.theta)).damage(damage);
        if(getCollision(this.x+cos(this.theta),this.y+sin(this.theta)).getHealth()>0){
          this.bounce(getCollision(this.x+cos(this.theta),this.y+sin(this.theta)));
        }
        this.y+=sin(this.theta);
        this.x+=cos(this.theta);
      } else {
        this.bounce(getCollision(this.x+cos(this.theta),this.y+sin(this.theta)));
        this.y+=sin(this.theta);
        this.x+=cos(this.theta);
      }
    }
  }
}
