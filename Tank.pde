public class Tank{
  //Stats
  private int moveSpeed = 1;
  private int health = 1;
  private int maxHealth = 1;
  private int size = 1;
  private int shotSpeed = 1;
  private int reloadSpeed = 1;
  private int maxBounces = 1;
  private int maxShotDis = 1;
  private int shotSize = 1;
  private int shotCount = 1;
  private int shotBlastSize = 0;
  private int shotDamage = 1;
  private int maxTerrainBreak = 0;
  private int nailLifespan = 0;
  private int nailFrequency = 0;
  private int shieldSize = 0;
  private int mineTimer = 0;
  private int mineFrequency = 0;
  private int mineSize = 0;
  //Position
  private float x;
  private float y;
  private float moveTheta;
  private float aimTheta;
  //Counters
  private int shotCooldown=0;
  //Render
  private color col;
  
  //Constructors
  public Tank(int tsp,int chp,int mhp,int tsz,int bsp,int bfr,int bbn,int dis,int bsz,int cnt,int bbl,int bdm,int ter,int ntm,int nfr,int ssz,int mtm,int mfr,int msz, float xPos, float yPos, float mt, float at, color c){
    this.moveSpeed = tsp;
    this.health = chp;
    this.maxHealth = mhp;
    this.size = tsz;
    this.shotSpeed = bsp;
    this.reloadSpeed = bfr;
    this.maxBounces = bbn;
    this.maxShotDis = dis;
    this.shotSize = bsz;
    this.shotCount = cnt;
    this.shotBlastSize = bbl;
    this.shotDamage=bdm;
    this.maxTerrainBreak = ter;
    this.nailLifespan = ntm;
    this.nailFrequency = nfr;
    this.shieldSize = ssz;
    this.mineTimer = mtm;
    this.mineFrequency = mfr;
    this.mineSize = msz;
    this.x = xPos;
    this.y = yPos;
    this.moveTheta=mt;
    this.aimTheta=at;
    this.col=c;
  }
  public Tank(int[] stats,float x,float y,float moveTheta,float aimTheta,color col){
    this(stats[0],stats[1],stats[2],stats[3],stats[4],stats[5],stats[6],stats[7],stats[8],stats[9],stats[10],stats[11],stats[12],stats[13],stats[14],stats[15],stats[16],stats[17],stats[18],x,y,moveTheta,aimTheta,col);
  }
  public Tank(float x,float y,float moveTheta,float aimTheta,color col){
    this.x=x;
    this.y=y;
    this.moveTheta=moveTheta;
    this.aimTheta=aimTheta;
    this.col=col;
  }
  
  //Getters
  public int getStat(String inString){
    String stat = inString.toLowerCase();
    switch(stat){
      case "movespeed":
        return moveSpeed;
      case "health":
        return health;
      case "maxhealth":
        return maxHealth;
      case "size":
        return size;
      case "shotspeed":
        return shotSpeed;
      case "reloadspeed":
        return reloadSpeed;
      case "maxbounces":
        return maxBounces;
      case "maxshotdis":
        return maxShotDis;
      case "shotsize":
        return shotSize;
      case "shotcount":
        return shotCount;
      case "shotblastsize":
        return shotBlastSize;
      case "shotdamage":
        return shotDamage;
      case "maxterrainbreak":
        return maxTerrainBreak;
      case "naillifespan":
        return nailLifespan;
      case "nailfrequency":
        return nailFrequency;
      case "shieldsize":
        return shieldSize;
      case "minetimer":
        return mineTimer;
      case "minefrequency":
        return mineFrequency;
      case "minesize":
        return mineSize;
      default:
        println("Invalid Stat");
        return -1;
    }
    
  }
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public float getMoveTheta(){
    return moveTheta;
  }
  public float getAimTheta(){
    return aimTheta;
  }
  public color getColor(){
    return col;
  }
  
  //Setters
  public void setStat(String inString, int value){
    String stat = inString.toLowerCase();
    switch(stat){
      case "movespeed":
        this.moveSpeed=value;
        break;
      case "health":
        this.health=value;
        break;
      case "maxhealth":
        this.maxHealth=value;
        break;
      case "size":
        this.size=value;
        break;
      case "shotspeed":
        this.shotSpeed=value;
        break;
      case "reloadspeed":
        this.reloadSpeed=value;
        break;
      case "maxbounces":
        this.maxBounces=value;
        break;
      case "maxshotdis":
        this.maxShotDis=value;
        break;
      case "shotsize":
        this.shotSize=value;
        break;
      case "shotcount":
        this.shotCount=value;
        break;
      case "shotblastsize":
        this.shotBlastSize=value;
        break;
      case "shotdamage":
        this.shotDamage=value;
        break;
      case "maxterrainbreak":
        this.maxTerrainBreak=value;
        break;
      case "naillifespan":
        this.nailLifespan=value;
        break;
      case "nailfrequency":
        this.nailFrequency=value;
        break;
      case "shieldsize":
        this.shieldSize=value;
        break;
      case "minetimer":
        this.mineTimer=value;
        break;
      case "minefrequency":
        this.mineFrequency=value;
        break;
      case "minesize":
        this.mineSize=value;
        break;
      default:
        println("Invalid Stat");
    }
  }
  public void setX(float value){
    this.x=value;
  }
  public void setY(float value){
    this.y=value;
  }
  public void setMoveTheta(float value){
    this.moveTheta=value;
  }
  public void setAimTheta(float value){
    this.aimTheta=value;
  }
  public void setColor(color value){
    this.col=value;
  }
  //Render
  public void render(){
    strokeWeight(1);
    if(shotCooldown>0)shotCooldown--;
    delay(1);
    rectMode(CENTER);
    translate(x,y);
    rotate(moveTheta);
    translate(-x,-y);
    fill(0);
    rect(x,y+size*10,size*24,size*8);
    rect(x,y-size*10,size*24,size*8);
    fill(col);
    rect(x,y,size*20,size*14);
    translate(x,y);
    rotate(aimTheta-moveTheta);
    translate(-x,-y);
    rect(x+size*10,y,size*20,size*6);
    translate(x,y);
    rotate(-aimTheta);
    translate(-x,-y);
  }
  //Move
  public boolean checkCollision(float x,float y){
    for(Terrain[] array : layout){
      for(Terrain terrain : array){
        if((!terrain.traversable())&&abs(0.5+terrain.getX()-x/GRID_SIZE)<0.5+this.size*10.0/GRID_SIZE&&abs(0.5+terrain.getY()-y/GRID_SIZE)<0.5+this.size*10.0/GRID_SIZE)return true;
      }
    }
    return false;
  }
  
  public void forward(){
    for(int i = 0; i<this.moveSpeed;i++){
      if(!checkCollision(this.x+cos(this.moveTheta),this.y+sin(this.moveTheta))){
        this.y+=sin(this.moveTheta);
        this.x+=cos(this.moveTheta);
      }else if(!checkCollision(this.x+cos(this.moveTheta),this.y)){
        this.x+=cos(this.moveTheta);
      }else if(!checkCollision(this.x,this.y+sin(this.moveTheta))){
        this.y+=sin(this.moveTheta);
      }
    }
  }
  public void backward(){
    for(int i = 0; i<this.moveSpeed;i++){  
      if(!checkCollision(this.x-0.5*cos(this.moveTheta),this.y-0.5*sin(this.moveTheta))){
        this.y-=0.5*sin(this.moveTheta);
        this.x-=0.5*cos(this.moveTheta);
      }else if(!checkCollision(this.x-0.5*cos(this.moveTheta),this.y)){
        this.x-=0.5*cos(this.moveTheta);
      }else if(!checkCollision(this.x,this.y-0.5*sin(this.moveTheta))){
        this.y-=0.5*sin(this.moveTheta);
      }
    }
  }
  public void turn(float targetTheta){
    moveTheta%=2*PI;
    if(targetTheta-moveTheta<=PI&&abs(targetTheta-moveTheta)>0.1){
      moveTheta+=moveSpeed/50.0;
    }else if(targetTheta-moveTheta>PI&&abs(targetTheta-moveTheta)>0.1) {
      moveTheta-=moveSpeed/50.0;
    }else{
      moveTheta=targetTheta;
    }
  }
  public void aim(float targetTheta){
    aimTheta%=2*PI;
    if(targetTheta-aimTheta<=PI&&abs(targetTheta-aimTheta)>0.1){
      aimTheta+=moveSpeed/20.0;
    }else if(targetTheta-aimTheta>PI&&abs(targetTheta-aimTheta)>0.1) {
      aimTheta-=moveSpeed/20.0;
    }else{
      aimTheta=targetTheta;
    }
  }
  
  public boolean fire(){
    if(shotCooldown<=0){
      shots.add(new Shot(this));
      shotCooldown=reloadSpeed*100;
      return true;
    }
    return false;
  }
  
  //Debug Methods
  public void printStats(){
    println(this.moveSpeed);
    println(this.health);
    println(this.maxHealth);
    println(this.size);
    println(this.shotSpeed);
    println(this.reloadSpeed);
    println(this.maxBounces);
    println(this.maxShotDis);
    println(this.shotSize);
    println(this.shotCount);
    println(this.shotBlastSize);
    println(this.maxTerrainBreak);
    println(this.nailLifespan);
    println(this.nailFrequency);
    println(this.shieldSize);
    println(this.mineTimer);
    println(this.mineFrequency);
    println(this.mineSize);
  }
}
