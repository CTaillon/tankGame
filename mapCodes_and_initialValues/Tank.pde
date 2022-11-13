public class Tank {
  //Stats
  private int moveSpeed = 1;//up to 4
  private int health = 10;//current health
  private int maxHealth = 10;
  private int size = 1;
  private int shotSpeed = 1; //up to 4
  public float reloadSpeed = 1; //this needs to be in float
  private int maxBounces = 0; //up to 4
  private int maxShotDis = 1;
  private int shotSize = 1;
  private int shotCount = 1;// bullet amt? up to 5
  private int shotBlastSize = 0;
  private int shotDamage = 1; //up to 10
  private int maxTerrainBreak = 0;
  private int nailLifespan = 0;
  private int nailFrequency = 0;
  private int shieldSize = 0;
  private int mineTimer = 0;
  private int mineFrequency = 0;
  private int mineSize = 0;

  public int lootSuccessValue=100;//makes sure the value doesnt generate loot at first
  public float critDmg= 1.0;
  private int explodyShot=0;
  public boolean lootPickUP=false; //check whether or not their loot has been picked up
  public float dropChance=1; //this can have max of 1.5
  public float xpBoost=1;
  public int dropIndex=0;
  public boolean enemyAI=true;
  public boolean runOnce=false;
  public boolean runOnce2=false;

  //bulldoze
  public float dmgReduction= 1;
  private int trampleDmg=0;

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
  
  int hitsLeft=0;
  int shotsLeft=0;
  int killsLeft=0;

  //Constructors
  public Tank(int tsp, int chp, int mhp, int tsz, int bsp, float bfr, int bbn, int dis, int bsz, int cnt, int bbl, int bdm, int ter, int ntm, int nfr, int ssz, int mtm, int mfr, int msz, float xPos, float yPos, float mt, float at, color c) {
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
  public Tank(int[] stats, float x, float y, float moveTheta, float aimTheta, color col) {
    this(stats[0], stats[1], stats[2], stats[3], stats[4], stats[5], stats[6], stats[7], stats[8], stats[9], stats[10], stats[11], stats[12], stats[13], stats[14], stats[15], stats[16], stats[17], stats[18], x, y, moveTheta, aimTheta, col);
  }
  public Tank(float x, float y, float moveTheta, float aimTheta, color col, boolean enemyAI) {
    this.x=x;
    this.y=y;
    this.moveTheta=moveTheta;
    this.aimTheta=aimTheta;
    this.col=col;
    this.enemyAI=enemyAI;
  }

  //Getters
  public int getStat(String inString) {
    String stat = inString.toLowerCase();
    switch(stat) {
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
    case "explodyshot":
      return explodyShot;
    case "xp": //copy here
      return xp;
    case "maxxp":
      return maxXP;
    case "trampledmg":
      return trampleDmg;

    default:
      println("Invalid Stat");
      return -1;
    }
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

  //Setters
  public void setStat(String inString, int value) {
    String stat = inString.toLowerCase();
    switch(stat) {
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
    case"explodyshot":
      this.explodyShot=value;
      break;
    case"trampledmg":
      this.trampleDmg=value;
      break;
    case"xp":
      this.xp=value;
      break;
    default:
      println("Invalid Stat");
    }
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
    strokeWeight(1);
    if (shotCooldown>0)shotCooldown--;
    delay(1);
    rectMode(CENTER);
    translate(x, y);
    rotate(moveTheta);
    translate(-x, -y);
    fill(0);
    rect(x, y+size*10, size*24, size*8);
    rect(x, y-size*10, size*24, size*8);
    fill(col);
    rect(x, y, size*20, size*14);
    translate(x, y);
    rotate(aimTheta-moveTheta);
    translate(-x, -y);
    rect(x+size*10, y, size*20, size*6);
    translate(x, y);
    rotate(-aimTheta);
    translate(-x, -y);
    if (this.xp>=this.maxXP) {//level up system xp goes back to 0 while you recover health
      if (this.health+this.maxHealth*.5 <= this.maxHealth) this.health+= floor(this.maxHealth*.5);
      else this.health= this.maxHealth;
      this.maxXP= floor(this.maxXP*1.2);
      this.xp=0;
    }
  }
  //Move
  public boolean checkCollision(float x, float y) {
    for (Terrain[] array : layout) {
      for (Terrain terrain : array) {
        if ((!terrain.traversable())&&abs(0.5+terrain.getX()-x/GRID_SIZE)<0.5+this.size*10.0/GRID_SIZE&&abs(0.5+terrain.getY()-y/GRID_SIZE)<0.5+this.size*10.0/GRID_SIZE)return true;
      }
    }
    return false;
  }

  public void forward() {
    for (int i = 0; i<this.moveSpeed; i++) {
      if (!checkCollision(this.x+cos(this.moveTheta), this.y+sin(this.moveTheta))) {
        this.y+=sin(this.moveTheta);
        this.x+=cos(this.moveTheta);
      } else if (!checkCollision(this.x+cos(this.moveTheta), this.y)) {
        this.x+=cos(this.moveTheta);
      } else if (!checkCollision(this.x, this.y+sin(this.moveTheta))) {
        this.y+=sin(this.moveTheta);
      }
    }
  }
  public void backward() {
    for (int i = 0; i<this.moveSpeed; i++) {
      if (!checkCollision(this.x-0.5*cos(this.moveTheta), this.y-0.5*sin(this.moveTheta))) {
        this.y-=0.5*sin(this.moveTheta);
        this.x-=0.5*cos(this.moveTheta);
      } else if (!checkCollision(this.x-0.5*cos(this.moveTheta), this.y)) {
        this.x-=0.5*cos(this.moveTheta);
      } else if (!checkCollision(this.x, this.y-0.5*sin(this.moveTheta))) {
        this.y-=0.5*sin(this.moveTheta);
      }
    }
  }
  public void turn(float targetTheta) {
    moveTheta%=2*PI;
    if (targetTheta-moveTheta<=PI&&abs(targetTheta-moveTheta)>0.1) {
      moveTheta+=moveSpeed/50.0;
    } else if (targetTheta-moveTheta>PI&&abs(targetTheta-moveTheta)>0.1) {
      moveTheta-=moveSpeed/50.0;
    } else {
      moveTheta=targetTheta;
    }
  }
  public void aim(float targetTheta) {
    aimTheta%=2*PI;
    if (targetTheta-aimTheta<=PI&&abs(targetTheta-aimTheta)>0.1) {
      aimTheta+=moveSpeed/20.0;
    } else if (targetTheta-aimTheta>PI&&abs(targetTheta-aimTheta)>0.1) {
      aimTheta-=moveSpeed/20.0;
    } else {
      aimTheta=targetTheta;
    }
  }

  public boolean fire() {
    if (shotCooldown<=0) {
      shots.add(new Shot(this));
      shotCooldown=reloadSpeed*100;
      return true;
    }
    return false;
  }


  public void update() {//enemy drop function need help with this so it will only initialize only once when they die
    if (this.health<=0 && enemyAI==true) {//we might not need enemyAI honestly
      if (runOnce==false) {
        enemyKilled++;
        if (sqrt(pow((this.x-player1.getX()), 2)+pow((this.y-player1.getY()), 2))<= sqrt(pow((this.x-player2.getX()), 2)+pow((this.y-player2.getY()), 2))) {
          this.lootSuccessValue= lootSuccess(player1);
          if(player1.killsLeft>0){
            player1.dropChance=1.5;
            player1.killsLeft--;
          } else {
            player1.dropChance=1;
          }
          player1.setStat("xp", floor(player1.getStat("xp")+(20*player1.xpBoost)));
          this.runOnce=true;
        } else {
          this.lootSuccessValue= lootSuccess(player2);
          if(player2.killsLeft>0){
            player2.dropChance=1.5;
            player2.killsLeft--;
          } else {
            player2.dropChance=1;
          }
          player2.setStat("xp", floor(player2.getStat("xp")+(20*player2.xpBoost)));
          println(player2.getStat("xp"));
          this.runOnce=true;
        }
      }
      lootType(this.lootSuccessValue, this.x, this.y, this);
    }
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
    println(this.maxTerrainBreak);
    println(this.nailLifespan);
    println(this.nailFrequency);
    println(this.shieldSize);
    println(this.mineTimer);
    println(this.mineFrequency);
    println(this.mineSize);
  }
  void healthTest() {
    health-=1;
  }
  void xpTest() {
    this.xp++;
  }
}

/////////////// FUNCTIONS BELOW /////////////

//drop chance
int lootSuccess(Tank player) {//decides whether or not a loot can be dropped and who did the finishing blow to calculate their dropchance increase
  float lootChance= floor((random(0, 4))) * player.dropChance; //chance of dropping perks
  int tempRandom= floor(random(0, 2)); //50/50 with loot being a temp or perm perk
  if (lootChance>=2.5) return tempRandom;
  else return 100;
}

void lootType(int tempRandom, float dropx, float dropy, Tank enemy) {//decides which type of perk it is, perm or temp int tempRandom will use the number generated from lootSuccess()
  if (tempRandom<2) {
    if (tempRandom==0) {
      if (enemy.runOnce2==false) {
        enemy.dropIndex=floor(random(0, tempPerks.size()));
        enemy.runOnce2=true;
      }
      tempLootRender(dropx, dropy, enemy.dropIndex, enemy);//dropx and dropy are the enemy's death position and enemy is one of the instance of a class
    }
    if (tempRandom==1) {
      if (enemy.runOnce2==false) {
        enemy.dropIndex= floor(random(0, permPerks.size()));
        enemy.runOnce2=true;
      }
      permLootRender(dropx, dropy, enemy.dropIndex, enemy);
    }
  }
}

//also REMEMBER to have a timer on these, so that the screen is not littered with perks or just let them litter
void permLootRender(float dropx, float dropy, int lootDropValue, Tank enemy) { // dropIndex from lootType() becomes lootDropValue, which is the the arraynumber of the enemy that dropped it
  if (lootDropValue<permPerks.size()) {
    for (int i=0; i<permPerks.size(); i++) {
      if (i==lootDropValue && enemy.lootPickUP==false) {
        image(permPerks.get(i), dropx, dropy, GRID_SIZE, GRID_SIZE);
        //player 1 pick up
        if (i==lootDropValue && abs((dropx)- player1.getX())<15 &&  abs((dropy)-player1.getY()) <15) {//gridsize /2 and subtract a couple number
          enemy.lootPickUP=true;
          upgradePermStat(i, player1, player1Inv);//pickup results in upgrade in stats
        }//player 2 pickup
        if (i==lootDropValue && abs((dropx)- player2.getX())<15 &&  abs((dropy)-player2.getY()) <15) {
          enemy.lootPickUP=true;
          upgradePermStat(i, player2, player2Inv);
          //add another function so that whatever tempPerk is will give certain effects to the player
        }
      }
    }
  }
}

void tempLootRender(float dropx, float dropy, int lootDropValue, Tank enemy) {
  if (lootDropValue<tempPerks.size()) {
    for (int i=0; i<tempPerks.size(); i++) {
      if (i==lootDropValue && enemy.lootPickUP==false) {
        image(tempPerks.get(i), dropx, dropy, GRID_SIZE, GRID_SIZE);
      }
      //player 1 pick up
      if (i==lootDropValue && abs((dropx)- player1.getX())<15 &&  abs((dropy)-player1.getY()) <15) {//gridsize /2 and subtract a couple number
        enemy.lootPickUP=true;
        upgradeTempStat(i, player1);//pickup results in upgrade in stats
        for (int j=0; j<3; j++) {
          if (j==0 && i<=2 && player1TempInv[j].tempPerk1Occ==false) {
            player1TempInv[j].indexValue=i;
            player1TempInv[j].tempPerk1Occ=true;
          } else if (j==1 && i>2 && i<=5 && player1TempInv[j].tempPerk1Occ==false) {
            player1TempInv[j].indexValue=i;
            player1TempInv[j].tempPerk1Occ=true;
          }
          if (j==2 && i>5 && i<=7 && player2TempInv[j].tempPerk2Occ==false) {
            player2TempInv[j].indexValue=i;
            player2TempInv[j].tempPerk2Occ=true;
          }
        }
      }
      //player 2 pickup
      else if (i==lootDropValue && abs((dropx)- player2.getX())<15 &&  abs((dropy)-player2.getY()) <15) {
        enemy.lootPickUP=true;
        upgradeTempStat(i, player2);
        for (int j=0; j<3; j++) {
          if (j==0 && i<=2 && player2TempInv[j].tempPerk2Occ==false) {
            player2TempInv[j].indexValue=i;
            player2TempInv[j].tempPerk2Occ=true;
          } else if (j==1 && i>2 && i<=5 && player2TempInv[j].tempPerk2Occ==false) {
            player2TempInv[j].indexValue=i;
            player2TempInv[j].tempPerk2Occ=true;
          }
          if (j==2 && i>5 && i<=7 && player2TempInv[j].tempPerk2Occ==false) {
            player2TempInv[j].indexValue=i;
            player2TempInv[j].tempPerk2Occ=true;
          }
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
      if (player.shotDamage>5) {
        invPlayer[perkNumber].upgradeValue++;
        print("a");
      }
    }
    break;
  case 1:
    if (player.getStat("shotCount") <5) { //this might not be the correct var or not being used anywhere
      player.setStat("shotCount", player.getStat("shotCount")+1) ;
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 2:
    if (player.reloadSpeed >.8) { //int changed to float
      player.reloadSpeed-=.05; //change this to --
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 3:
    if (player.getStat("shotSpeed") <3) {
      player.setStat("shotSpeed", player.getStat("shotSpeed")+1) ;//this stat might not work
      invPlayer[perkNumber].upgradeValue+=2;
    }
    break;
  case 4:
    if (player.getStat("maxBounces") <4) {
      player.setStat("maxBounces", player.getStat("maxBounces")+1);
      invPlayer[perkNumber].upgradeValue++;
    }
  case 5:
    if (player.critDmg <2) {//crit dmg has not been used
      player.critDmg+=.25;
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 6:
    if (player.getStat("explodyShot") <1) {
      player.setStat("explodyShot", 1);
      invPlayer[perkNumber].upgradeValue=4;
    }
    break;
  case 7:
    if (player.getStat("moveSpeed") <5) {
      player.setStat("moveSpeed", player.getStat("moveSpeed")+1);
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 8:
    if (player.dmgReduction >.5 && player.getStat("trampleDmg") <4) { //trample dmg has not been used in dmg calc
      player.dmgReduction -=.125;
      player.setStat("trampleDmg", player.getStat("trampleDmg")+1);
      invPlayer[perkNumber].upgradeValue++;
    }
    break;
  case 9:
    player.setStat("maxHealth", player.getStat("maxHealth")+20);
    invPlayer[perkNumber].upgradeValue++;
    //println(player.getStat("maxHealth"));
    //println(player.getStat("health"));
    break;
  }
}

void upgradeTempStat(int perkNumber, Tank player) {
  switch(perkNumber) {
  case 0:
    player.killsLeft=10;
    //change damage to heal
    break;
  case 1:
    player.xpBoost=1.5;
    //set timer
    break;
  case 2:
    if (player.getStat("health")+(floor(.2*player.getStat("maxHealth"))) <= player.getStat("maxHealth")) {
      player.setStat("health", player.getStat("health")+(floor(.2*player.getStat("maxHealth"))));
    } else player.setStat("health", player.getStat("maxhealth"));
    //heal
    break;
  case 3:
    //instant death, only one bullet
    break;
  case 4:
    //rockets
  case 5:
    //machine gun, remove limit where you cant hold down and fire
    break;
  case 6:
    //iframe
    break;
  case 7:
    //dmg2heal
    break;
  }
}
