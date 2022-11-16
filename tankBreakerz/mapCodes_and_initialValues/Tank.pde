public class Tank {
  //Stats
  private int moveSpeed = 1;
  private float health = 1;
  private float maxHealth = 1;
  private int size = 1;
  private int shotSpeed = 1;
  private float reloadSpeed = 1;
  private int maxBounces = 0;
  private int maxShotDis = 1;
  private int shotSize = 1;
  private int shotCount = 1;
  private int shotBlastSize = 0;
  private int shotDamage = 1;
  private float critChance = 0.0;
  
  public boolean lootPickUP=false;
  public int dropIndex=0;

  public boolean computer=true;
  public boolean remove=false;
  public boolean dropCheck=false;

  private Path p1Path;

  //bulldoze
  private float trampleDmg=0;

  private int xp=0;
  private int maxXP=100;

  //Position
  private float x;
  private float y;
  private float moveTheta;
  private float aimTheta;
  //Counters
  private float shotCooldown=0;
  //Render
  private color col;

  private boolean drop=false;

  int hitsLeft=0;
  int shotsLeft=0;
  int killsLeft=0;

  //Constructors
  public Tank(int tsp, float chp, float mhp, int tsz, int bsp, float bfr, int bbn, int dis, int bsz, int cnt, int bbl, int bdm, float xPos, float yPos, float mt, float at, color c) {
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
    this.x = xPos;
    this.y = yPos;
    this.moveTheta=mt;
    this.aimTheta=at;
    this.col=c;
  }
  public Tank(int[] stats, float x, float y, float moveTheta, float aimTheta, color col) {
    this(stats[0], stats[1], stats[2], stats[3], stats[4], stats[5], stats[6], stats[7], stats[8], stats[9], stats[10], stats[11], x, y, moveTheta, aimTheta, col);
  }
  public Tank(float x, float y, float moveTheta, float aimTheta, color col, boolean computer) {
    this.x=x;
    this.y=y;
    this.moveTheta=moveTheta;
    this.aimTheta=aimTheta;
    this.col=col;
    this.computer=computer;
  }

  //Getters
  public int getStat(String inString) {
    String stat = inString.toLowerCase();
    switch(stat) {
    case "movespeed":
      return moveSpeed;
    case "health":
      return (int)health;
    case "maxhealth":
      return (int)maxHealth;
    case "size":
      return size;
    case "shotspeed":
      return shotSpeed;
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
    case "xp": //copy here
      return xp;
    case "maxxp":
      return maxXP;
    case "trampledmg":
      return (int)trampleDmg;
    default:
      println("Invalid Stat");
      return -1;
    }
  }
  public float getCritChance() {
    return critChance;
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public float getMoveTheta() {
    return moveTheta;
  }
  public float getAimTheta() {
    return aimTheta;
  }
  public color getColor() {
    return col;
  }
  public boolean checkRemove() {
    return this.remove;
  }

  //Setters
  public void setStat(String inString, int value) {
    String stat = inString.toLowerCase();
    switch(stat) {
    case "movespeed":
      this.moveSpeed=value;
      break;
    case "health":
      this.health=1.0*value;
      break;
    case "maxhealth":
      this.maxHealth=1.0*value;
      break;
    case "size":
      this.size=value;
      break;
    case "shotspeed":
      this.shotSpeed=value;
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
    default:
      println("Invalid Stat");
    }
  }
  public float getTrample() {
    return this.trampleDmg;
  }
  public void setTrample(float value) {
    this.trampleDmg=value;
  }
  public void xp(int value) {
    this.xp+=value;
  }

  public void setX(float value) {
    this.x=value;
  }
  public void setY(float value) {
    this.y=value;
  }
  public void setMoveTheta(float value) {
    this.moveTheta=value;
  }
  public void setAimTheta(float value) {
    this.aimTheta=value;
  }
  public void setColor(color value) {
    this.col=value;
  }

  //Render
  public void render() {
    lootType(drop, this.x, this.y, this);
    strokeWeight(1);
    if (shotCooldown>0)shotCooldown--;
    delay(1);
    rectMode(CENTER);
    translate(x, y);
    rotate(moveTheta);
    translate(-x, -y);
    fill(0);
    rect(x, y+size*10, size*24, size*8); //bottom half wheels
    rect(x, y-size*10, size*24, size*8);
    fill(col);
    rect(x, y, size*20, size*14); //tank main base
    fill(160);
    rect(x+size*7.5, y, size*5, size*14);//distinguish the front of tank
    translate(x, y);
    rotate(aimTheta-moveTheta);
    translate(-x, -y);
    fill(col);  
    rect(x+size*10, y, size*20, size*6);//barrel
    translate(x, y);
    rotate(-aimTheta);
    translate(-x, -y);
    //level up system xp goes back to 0 while you recover health
    if (this.xp>=this.maxXP) {
      if (this.health+this.maxHealth*.5 <= this.maxHealth) this.health+= floor(this.maxHealth*.5);
      else this.health= this.maxHealth;
      this.maxXP= floor(this.maxXP*1.2);
      this.xp=0;
    }
  }

  //Move
  public boolean checkCollision(float x, float y) {//checks if tank runs into walls
    for (Terrain[] array : layout) {
      for (Terrain terrain : array) {
        if ((!terrain.traversable())&&abs(0.5+terrain.getX()-x/GRID_SIZE)<0.5+this.size*10.0/GRID_SIZE&&abs(0.5+terrain.getY()-y/GRID_SIZE)<0.5+this.size*10.0/GRID_SIZE)return true;
      }
    }
    return false;
  }
  public boolean checkOverlap(float x, float y) {
    return x>this.x-this.size*12&&x<this.x+this.size*12&&y>this.y-this.size*12&&y<this.y+this.size*12;
  }

  public void trample(Tank target) {//function to dmg target when on top of them
    if (checkOverlap(target.getX(), target.getY()) && !target.remove)target.health-=this.trampleDmg;
    if (target.health<=0 && !target.remove) {
      if (target.computer) {
        enemyKilled++;
        enemiesLeft--;
        drop=lootSuccess();
        if (sqrt(pow((target.x-player1.getX()), 2)+pow((target.y-player1.getY()), 2))<= sqrt(pow((target.x-player2.getX()), 2)+pow((target.y-player2.getY()), 2))) {
          player1.xp(20);
        } else {
          player2.xp(20);
        }
      }
      target.remove=true;
    }
  }

  public void forward() {
    for (int i = 0; i<this.moveSpeed*FC; i++) {
      if (!checkCollision(this.x+cos(this.moveTheta)*FC, this.y+sin(this.moveTheta)*FC)) {
        this.y+=sin(this.moveTheta)*FC;
        this.x+=cos(this.moveTheta)*FC;
      } else if (!checkCollision(this.x+cos(this.moveTheta)*FC, this.y)) {
        this.x+=cos(this.moveTheta)*FC;
      } else if (!checkCollision(this.x, this.y+sin(this.moveTheta)*FC)) {
        this.y+=sin(this.moveTheta)*FC;
      }
    }
  }
  public void backward() {
    for (int i = 0; i<this.moveSpeed*FC; i++) {
      if (!checkCollision(this.x-0.5*cos(this.moveTheta)*FC, this.y-0.5*sin(this.moveTheta)*FC)) {
        this.y-=0.5*sin(this.moveTheta)*FC;
        this.x-=0.5*cos(this.moveTheta)*FC;
      } else if (!checkCollision(this.x-0.5*cos(this.moveTheta)*FC, this.y)) {
        this.x-=0.5*cos(this.moveTheta)*FC;
      } else if (!checkCollision(this.x, this.y-0.5*sin(this.moveTheta)*FC)) {
        this.y-=0.5*sin(this.moveTheta)*FC;
      }
    }
  }
  public void turn(float targetTheta) {
    while (moveTheta<0) {
      moveTheta+=2*PI;
    }
    float deltaTheta=targetTheta-moveTheta;
    while (deltaTheta<0) {
      deltaTheta+=2*PI;
    }
    if (deltaTheta<0.1||deltaTheta>2*PI-0.1) {
      moveTheta=targetTheta;
    } else if (deltaTheta<=PI) {
      moveTheta+=moveSpeed/50.0*FC;
    } else if (deltaTheta>PI) {
      moveTheta-=moveSpeed/50.0*FC;
    } else {
      moveTheta=targetTheta;
    }
  }
  public void aim(float targetTheta) {
    while (aimTheta<0) {
      aimTheta+=2*PI;
    }
    float deltaTheta=targetTheta-aimTheta;
    while (deltaTheta<0) {
      deltaTheta+=2*PI;
    }
    if (deltaTheta<0.1||deltaTheta>2*PI-0.1) {
      aimTheta=targetTheta;
    } else if (deltaTheta<=PI) {
      aimTheta+=moveSpeed/20.0*FC;
    } else if (deltaTheta>PI) {
      aimTheta-=moveSpeed/20.0*FC;
    } else {
      aimTheta=targetTheta;
    }
  }

  public boolean fire() {
    if (shotCooldown<=0&&!remove) {
      for (int i=0; i<shotCount; i++) {
        shots.add(new Shot(this));
        if (i>0) {
          shots.get(shots.size()-1).setTheta(shots.get(shots.size()-1).getTheta()+random(-1, 1));
        }
      }
      shotCooldown=reloadSpeed*100/FC;
      println(shotCooldown);
      return true;
    }
    return false;
  }

  //enemy ai
  public void standardAI(Tank p1, Tank p2, Terrain[][] layout, ArrayList<Shot> shots, ArrayList<Tank> enemies) {
    if (!remove) {
      Tank target;
      if (calcDistance(p1.x, p1.y)>calcDistance(p2.x, p2.y)) {
        target=p2;
      } else {
        target=p1;
      }
      if (checkIncoming(shots)!=null) {
        turn(checkIncoming(shots).getTheta());
        forward();
      } else {
        if (p1.getStat("size")>0) {
          if (moveTheta!=track(target.x, target.y, layout)) {
            turn(track(target.x, target.y, layout));
          }
          if (calcDistance(target.x, target.y)>200||checkObscured(calcTheta(target.x, target.y), calcDistance(target.x, target.y), layout)) {
            forward();
          }
          if (calcDistance(target.x, target.y)<100&&!checkObscured(calcTheta(target.x, target.y), calcDistance(target.x, target.y), layout)) {
            backward();
          }
        }
      }
      if (!checkObscured(calcTheta(target.x, target.y), calcDistance(target.x, target.y), layout)) {
        float targetTheta=calcTheta(target.x, target.y)%(2*PI);
        float aim=aimTheta%(2*PI);
        if ((targetTheta-aim+2*PI)%(2*PI)<PI&&abs(targetTheta-aim)>0.1||(targetTheta-aim+2*PI)%(2*PI)>=PI&&abs(targetTheta-aim)>0.1) {
          aim(calcTheta(target.x, target.y));
        } else {
          fire();
        }
      } else {
      }
    }
  }

  public float calcDistance(float x, float y) {
    return sqrt(sq(x-this.x)+sq(y-this.y));
  }

  public float calcTheta(float x, float y) {
    float theta;
    if (x>this.x) {
      theta=atan((y-this.y)/(x-this.x));
    } else {
      theta=PI+atan((y-this.y)/(x-this.x));
    }
    while (theta<0) {
      theta+=2*PI;
    }
    return theta;
  }

  public boolean checkObscured(float theta, float distance, Terrain[][] layout) {
    for (int i=0; i<distance; i++) {
      if (checkObscuredPoint(this.x+i*cos(theta), this.y+i*sin(theta), layout))return true;
    }
    return false;
  }

  public boolean checkObscuredPoint(float x, float y, Terrain[][] layout) {
    for (Terrain[] array : layout) {
      for (Terrain terrain : array) {
        if ((terrain.obstructive())&&abs(0.5+terrain.getX()-x/GRID_SIZE)<0.5+this.shotSize*10.0/GRID_SIZE&&abs(0.5+terrain.getY()-y/GRID_SIZE)<0.5+this.shotSize*10.0/GRID_SIZE)return true;
      }
    }
    return false;
  }
  //ai tracking
  public float track(float x, float y, Terrain[][] layout) {
    p1Path = new Path(this.x, this.y, x, y);
    p1Path.setPoint(this.x, this.y, 0);
    p1Path.setPoint(x, y, p1Path.size()-1);
    p1Path.adjustPath(this, layout);
    p1Path.render();
    return(p1Path.getTheta());
  }
  //check if tank get hit
  public void hit(int i) {
    if (!remove&&i!=-1&&shots.get(i).clock==3) {
      this.health-=shots.get(i).getDamage();
      if (this.health<=0) {
        if (computer) {
          enemyKilled++;
          enemiesLeft--;
          drop=lootSuccess();
          if (sqrt(pow((this.x-player1.getX()), 2)+pow((this.y-player1.getY()), 2))<= sqrt(pow((this.x-player2.getX()), 2)+pow((this.y-player2.getY()), 2))) {
            player1.xp(20);
          } else {
            player2.xp(20);
          }
        }
        this.remove=true;
      }
      shots.get(i).delete();
    }
  }
  //check if tank get hit
  public int checkHit(ArrayList<Shot> shots) {
    for (int i=0; i<shots.size(); i++) {
      if (shots.get(i).getX()>this.x-this.size*12-shots.get(i).getSize()*10&&shots.get(i).getX()<this.x+this.size*12+shots.get(i).getSize()*10&&shots.get(i).getY()>this.y-this.size*12-shots.get(i).getSize()*10&&shots.get(i).getY()<this.y+this.size*12+shots.get(i).getSize()*10) {
        return i;
      }
    }
    return -1;
  }
  //ai dodge bullets
  public Shot checkIncoming(ArrayList<Shot> shots) {
    for (int i=0; i<shots.size(); i++) {
      for (int j=0; j<calcDistance(shots.get(i).getX(), shots.get(i).getY()); j++) {
        if (shots.get(i).getX()+j*cos(shots.get(i).getTheta())>this.x-this.size*12-shots.get(i).getSize()*10&&shots.get(i).getX()+j*cos(shots.get(i).getTheta())<this.x+this.size*12+shots.get(i).getSize()*10&&shots.get(i).getY()+j*sin(shots.get(i).getTheta())>this.y-this.size*12-shots.get(i).getSize()*10&&shots.get(i).getY()+j*sin(shots.get(i).getTheta())<this.y+this.size*12+shots.get(i).getSize()*10) {
          return shots.get(i);
        }
      }
    }
    return null;
  }

  //Debug Methods
  public void printStats() {
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
  }
}

//drop chances, true means there is a drop
boolean lootSuccess() {
  float lootChance=floor((random(0, 4)));
  return lootChance==0;
}
//originally to render based on temp or perm perks, but this is just for perm perks (temp perks are no longer a thing)
void lootType(boolean success, float dropx, float dropy, Tank enemy) {//int tempRandom will use the boolean generated from lootSuccess()
  if (success) {
    if (enemy.dropCheck==false) {
      enemy.dropIndex= floor(random(0, perks.size()));
      enemy.dropCheck=true;
    }
    lootRender(dropx, dropy, enemy.dropIndex, enemy);
  }
}
//rendering the drop based on where the enemy was killed
void lootRender(float dropx, float dropy, int lootDropValue, Tank enemy) { // dropIndex from lootType() becomes lootDropValue, which is the the arraynumber of the enemy that dropped it
  if (lootDropValue<perks.size()) {
    for (int i=0; i<perks.size(); i++) {
      if (i==lootDropValue && enemy.lootPickUP==false) {
        image(perks.get(i), dropx, dropy, GRID_SIZE, GRID_SIZE);
        //player 1 pick up
        if (i==lootDropValue && abs((dropx)- player1.getX())<15 &&  abs((dropy)-player1.getY()) <15) {//gridsize /2 and subtract a couple number
          enemy.lootPickUP=true;
          upgradePermStat(i, player1, player1Inv);//pickup results in upgrade in stats
        }//player 2 pickup
        if (i==lootDropValue && abs((dropx)- player2.getX())<15 &&  abs((dropy)-player2.getY()) <15) {
          enemy.lootPickUP=true;
          upgradePermStat(i, player2, player2Inv);
        }
      }
    }
  }
}


//decide which perks were picked up and add upgrades to the correct player
void upgradePermStat(int perkNumber, Tank player, playerInventory [] invPlayer ) {
  switch(perkNumber) {
  case 0:
    if (player.getStat("shotDamage") <11) {
      player.setStat("shotDamage", player.getStat("shotDamage")+1);
      if (player.shotDamage>5) {//only until later dmg does the tier color pf the inv slot change
        invPlayer[perkNumber].upgradeValue++;
        print("a");
      }
    }
    break;
  case 1:
    if (player.getStat("shotCount") <5) { //number of bullets in one fire
      player.setStat("shotCount", player.getStat("shotCount")+1) ;
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 2:
    if (player.reloadSpeed >.8) { //decrease interval to fire bullets
      player.reloadSpeed-=.05;
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 3:
    if (player.getStat("shotSpeed") <3) {//bullet speed
      player.setStat("shotSpeed", player.getStat("shotSpeed")+1) ;//this stat might not work
      invPlayer[perkNumber].upgradeValue+=2;
    }
    break;
  case 4:
    if (player.getStat("maxBounces") <4) {//bounces
      player.setStat("maxBounces", player.getStat("maxBounces")+1);
      invPlayer[perkNumber].upgradeValue++;
    }
  case 5:
    if (player.critChance <0.8) {//allows rolls for critical dmg
      player.critChance+=0.2;
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 6:
    if (player.getStat("shotBlastSize") <1) {//allows for explosion
      player.setStat("shotBlastSize", 1);
      invPlayer[perkNumber].upgradeValue=4;
    }
    break;
  case 7:
    if (player.getStat("moveSpeed") <5) {//tank speed
      player.setStat("moveSpeed", player.getStat("moveSpeed")+1);
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 8:
    if (player.getStat("trampleDmg") <0.4) {
      player.setTrample(player.getTrample()+0.1);
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 9:
    player.setStat("maxHealth", player.getStat("maxHealth")+20); //increases max health but not current health
    invPlayer[perkNumber].upgradeValue++;
    break;
  }
}
