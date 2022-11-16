public class Shot{
  //Stats
  private int speed = 1;
  private int maxBounces = 0;
  private int size = 1;
  private int blastSize = 0;
  private int damage = 1;
  //Position
  private float x;
  private float y;
  private float theta;
  //Counters
  private int bounces;
  private int clock = 3;
  
  private color col;
  private boolean remove = false;
  
  public Shot(Tank originTank){
    this.col=originTank.getColor();
    this.speed=originTank.getStat("shotSpeed");
    this.maxBounces=originTank.getStat("maxBounces");
    this.size=originTank.getStat("shotSize");
    this.blastSize=originTank.getStat("shotBlastSize");
    this.damage=originTank.getStat("shotDamage");
    this.x=originTank.getX()+(originTank.getStat("size")*32*cos(originTank.getAimTheta()));
    this.y=originTank.getY()+(originTank.getStat("size")*32*sin(originTank.getAimTheta()));
    this.theta=originTank.getAimTheta();
    if(random(0,1)<originTank.getCritChance())this.damage*=2;
  }
  
  public float getX(){
    return this.x;
  }
  
  public float getY(){
    return this.y;
  }
  
  public int getDamage(){
    return this.damage;
  }
  
  public int getSize(){
    return this.size;
  }
  
  public float getTheta(){
    while(this.theta<0){
      this.theta+=2*PI;
    }
    return this.theta;
  }
  
  public boolean checkRemove(){
    return this.remove;
  }
  
  public void delete(){
    this.remove=true;
  }
  
  public void setTheta(float value){
    while(value<0){
      value+=2*PI;
    }
    this.theta=value;
  }
  
  public void render(){
    fill(this.col);
    circle(x,y,size*10);
    move();
  }
  
  
  public boolean checkCollision(float x,float y){//check if bullets hit a terrain
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
  
  public void bounce(Terrain terrain){//allows bullet to bounce
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
  
  public int explode(){//show explosion if bullet can explode due to perk
    fill(255,0,0);
   if(clock > 0) {
     clock--;
    }
    image(explosion,x,y,blastSize*100,blastSize*100);
    return this.blastSize;
  }
  
  public void move(){//bullet movement
    for(int i = 0; i<this.speed*2*FC;i++){
      if(!checkCollision(this.x+cos(this.theta)*FC,this.y+sin(this.theta)*FC)){
        this.y+=sin(this.theta)*FC;
        this.x+=cos(this.theta)*FC;
      } else if (getCollision(this.x+cos(this.theta)*FC,this.y+sin(this.theta)*FC).destructible()){
        getCollision(this.x+cos(this.theta)*FC,this.y+sin(this.theta)*FC).damage(damage);
        if(getCollision(this.x+cos(this.theta)*FC,this.y+sin(this.theta)*FC).getHealth()>0){
          this.bounce(getCollision(this.x+cos(this.theta)*FC,this.y+sin(this.theta)*FC));
        }
        this.y+=sin(this.theta)*FC;
        this.x+=cos(this.theta)*FC;
      } else {
        this.bounce(getCollision(this.x+cos(this.theta)*FC,this.y+sin(this.theta)*FC));
        this.y+=sin(this.theta)*FC;
        this.x+=cos(this.theta)*FC;
      }
    }
  }
}
