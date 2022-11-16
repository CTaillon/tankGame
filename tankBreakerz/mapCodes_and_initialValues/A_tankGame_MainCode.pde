//main code

//fix for slow game, stats will be based off of current fps
float FC;

//allows players to have sometime before ai starts attacking at the start of program
boolean gracePeriod=true;
int timer= 30;

void setup() {
  frameRate(30);
  //players will have more health than enemy
  player1.setStat("health", 20);
  player1.setStat("maxHealth", 20);
  player2.setStat("health", 20);
  player2.setStat("maxHealth", 20);
  size(840, 840, P2D);
  loadImages();
  stencil = loadFont("stencil20.vlw");
  //initialize hp boxes
  player1HP= new playerInventory(0, 0, GRID_SIZE*(hpxpBox), GRID_SIZE, hp1boxc);
  player2HP= new playerInventory(width-1, 0-1, -GRID_SIZE*(hpxpBox), GRID_SIZE, hp2boxc);//need the 1s because i cant find the stroke error to make ui look cleaner
  //initialize xp boxes
  player1XP= new playerInventory(0, height-GRID_SIZE+1, 0, GRID_SIZE, xpboxc);
  player2XP= new playerInventory(width, (height-GRID_SIZE)+1, 0, GRID_SIZE, xpboxc);//need the 1s because i cant find the stroke error to make ui look cleaner

  //inventory code
  for (int i=0; i<invSlots; i++) {
    player1Inv[i]= new playerInventory(doInnerStroke/2, (doInnerStroke/2)+(5*GRID_SIZE)+(GRID_SIZE*(i+3)), GRID_SIZE-(doInnerStroke), GRID_SIZE-(doInnerStroke), slotBlue);
    player2Inv[i]= new playerInventory(width-(GRID_SIZE-doInnerStroke/2), (5*GRID_SIZE)+(GRID_SIZE*(i+3))+(doInnerStroke/2), GRID_SIZE-(doInnerStroke), GRID_SIZE-(doInnerStroke), slotBlue);
  }
}

void draw() {
  //lag fix
  //println(frameRate);
  if (frameRate<10) FC= 10/frameRate;
  if (frameRate<20 && frameRate>=10) FC= 20/frameRate;
  if(frameRate>=20)FC= 30/frameRate;
  
  strokeWeight(0);
  mapRender();
  updateTerrain();
  updateTanks();
  for (Terrain[] array : layout) {
    for (Terrain terrain : array) {
      terrain.render();
    }
  }
  updateShots();
  //ui for enemy killed
  uiRender();
  //render the hp or xp boxes
  player1HP.HPXPrender();
  player2HP.HPXPrender();
  player1XP.HPXPrender();
  player2XP.HPXPrender();
  //make HP bar move down along with the percent of hp left. XP will go up according to percentage of current xp to max xp
  hpDrain();
  xpFill();

  //render inv slots but this time you can change values without null pointer error
  for (int i=0; i<invSlots; i++) {
    //perk slots
    player1Inv[i].render();
    player2Inv[i].render();
  }
  //show the perks on the inventory
  perksRender();

  if (enemiesLeft==0) {//spawn in enemies when all 4 are killed
    enemiesLeft=4;
    enemies.add(new Tank(780, 60, 0, 0, 255, true));
    enemies.add(new Tank(60, 780, 0, 0, 255, true));
    enemies.add(new Tank(780, 100, 0, 0, 255, true));
    enemies.add(new Tank(60, 740, 0, 0, 255, true));
  }

  //player tank renders (must be below the hp and xp renders to prevent visual glitches)
  if (player2.getStat("health")>=0) {
    player2.render();
    if (keyLeft)player2.turn(player2.getMoveTheta()+5);
    if (keyRight)player2.turn(player2.getMoveTheta()-5);
    if (keyComma)player2.aim(player2.getAimTheta()+5);
    if (keyPeriod)player2.aim(player2.getAimTheta()-5);
    if (keyUp)player2.forward();
    if (keyDown)player2.backward();
  }
  if (player1.getStat("health")>=0) {
    player1.render();
    if (keyA)player1.turn(player1.getMoveTheta()+5);
    if (keyD)player1.turn(player1.getMoveTheta()-5);
    if (keyQ)player1.aim(player1.getAimTheta()+5);
    if (keyE)player1.aim(player1.getAimTheta()-5);
    if (keyW)player1.forward();
    if (keyS)player1.backward();
  }
  //render bullets for each array list of shots
  shots.forEach((n) -> n.render());
  //give each enemy ai, they will not attack for a short time (mostly for beginning lag when they spawn in)
  if (gracePeriod) timer--; 
  if (timer<=0) {
    enemies.forEach((n) -> n.standardAI(player1, player2, layout, shots, enemies));
    gracePeriod=false;
  }

  //enemy stops rendering when hp is below or at 0
  for (int i=0; i<enemies.size(); i++) {
    if (enemies.get(i).getStat("health")>=0)  enemies.get(i).render();
  }
  //check when tanks get hit by shots
  player1.hit(player1.checkHit(shots));
  player2.hit(player2.checkHit(shots));
  enemies.forEach((n) -> n.hit(n.checkHit(shots)));
  //allows trample dmg to work for any tanks (trample dmg is dmg dealt when tanks are on top of each other)
  player1.trample(player2);
  player2.trample(player1);
  enemies.forEach((n) -> n.trample(player1));
  enemies.forEach((n) -> n.trample(player2));
  enemies.forEach((n) -> player1.trample(n));
  enemies.forEach((n) -> player2.trample(n));
  //delete enemies when their loot is picked up or when they die and drop no loot
  for (int i=0; i<enemies.size();i++){
    if(enemies.get(i).lootPickUP==true || (enemies.get(i).remove==true && enemies.get(i).drop == false)) enemies.remove(i);
  }
}

//movement function
void keyPressed() {
  switch(key) {
  case 'w':
    keyW=true;
    keyS=false;
    break;
  case 'a':
    keyA=true;
    keyD=false;
    break;
  case 's':
    keyS=true;
    keyW=false;
    break;
  case 'd':
    keyD=true;
    keyA=false;
    break;
  case 'q':
    keyQ=true;
    keyE=false;
    break;
  case 'e':
    keyE=true;
    keyQ=false;
    break;
  case 'f':
    if (!p1Fire&&player1.fire())p1Fire=true;
    break;
  case ',':
    keyComma=true;
    keyPeriod=false;
    break;
  case '.':
    keyPeriod=true;
    keyComma=false;
    break;
  case '/':
    if (!p2Fire&&player2.fire())p2Fire=true;
    break;
  case CODED:
    switch(keyCode) {
    case UP:
      keyUp=true;
      keyDown=false;
      break;
    case LEFT:
      keyLeft=true;
      keyRight=false;
      break;
    case DOWN:
      keyDown=true;
      keyUp=false;
      break;
    case RIGHT:
      keyRight=true;
      keyLeft=false;
      break;
    }
    break;
  }
}
void keyReleased() {
  switch(key) {
  case 'w':
    keyW=false;
    break;
  case 'a':
    keyA=false;
    break;
  case 's':
    keyS=false;
    break;
  case 'd':
    keyD=false;
    break;
  case 'q':
    keyQ=false;
    break;
  case 'e':
    keyE=false;
    break;
  case 'f':
    p1Fire=false;
    break;
  case ',':
    keyComma=false;
    break;
  case '.':
    keyPeriod=false;
    break;
  case '/':
    p2Fire=false;
    break;
  case CODED:
    switch(keyCode) {
    case UP:
      keyUp=false;
      break;
    case LEFT:
      keyLeft=false;
      break;
    case DOWN:
      keyDown=false;
      break;
    case RIGHT:
      keyRight=false;
      break;
    }
    break;
  }
}

//remove shots when they hit something
void updateShots() {
  for (int i=0; i<shots.size(); i++) {
    if (shots.get(i).checkRemove()) {
      for (int j=0; j<enemies.size(); j++) {
        if (calcDistance(shots.get(i).getX(), shots.get(i).getY(), enemies.get(j).getX(), enemies.get(j).getY())<shots.get(i).explode()) {
          enemies.get(i).setStat("health", enemies.get(i).getStat("health")-100);//2*shots.get(i).getDamage()
          print(calcDistance(shots.get(i).getX(), shots.get(i).getY(), enemies.get(j).getX(), enemies.get(j).getY()));
        }
      }
      if (shots.get(i).clock<=0) {
        shots.remove(i);
      }
    }
  }
}
//if walls are broken, change render
void updateTerrain() {
  for (Terrain[] array : layout) {
    for (Terrain terrain : array) {
      if (terrain.destructible()&&terrain.getHealth()==0) {
        layout[terrain.getX()][terrain.getY()]=Floor(terrain.getX(), terrain.getY());
      }
    }
  }
}

//when players die, they are removed from the screen
void updateTanks() {
  for (int i=0; i<enemies.size(); i++) {
    if (enemies.get(i).checkRemove())enemies.get(i).setStat("size", 0);
  }
  if (player1.checkRemove()) {
    player1.setStat("size", 0);
    player1.setX(-1000);
  }
  if (player2.checkRemove()) {
    player2.setStat("size", 0);
    player2.setX(-1000);
  }
}
//how maps would be implemented
Terrain[][] level1() {
  Terrain[][] temp = new Terrain[21][21];

  //setting which map is rendered
  if (randomMap==0) mapChosen = nyanMapColorValue;
  if (randomMap==1) mapChosen = abyssMapColorValue;
  if (randomMap==2) mapChosen = beachMapColorValue;
  if (randomMap==3) mapChosen = labyMapColorValue;
  if (randomMap==4) mapChosen = lossMapColorValue;
  //mapChosen=debugMapColorValue;

  for (int i=0; i<21; i++) {
    for (int j=0; j<21; j++) {

      if (i==0||i==20||j==0||j==20) {
        temp[i][j]=Wall(i, j);
      } else if (mapChosen[j][i]>0) {
        temp[i][j]=BreakableWall(i, j);
        temp[i][j].setColor(mapChosen[j][i]);
      } else {
        temp[i][j]=Floor(i, j);
      }
    }
  }
  return temp;
}
public Terrain Hole(int x, int y) {
  return new Terrain(false, false, false, #7E5819, x, y, 1);
}
public Terrain Wall(int x, int y) {
  return new Terrain(false, false, true, #d98130, x, y, 1);
}
public Terrain BreakableWall(int x, int y) {
  return new Terrain(true, false, true, #B47816, x, y, 4);
}
public Terrain Floor(int x, int y) {
  return new Terrain(false, true, false, #F2C375, x, y, 1);
}
public Terrain BreakableFloor(int x, int y) {
  return new Terrain(true, true, false, #FFD99B, x, y, 1);
}

//math for distance
public float calcDistance(float x1, float y1, float x2, float y2) {
  return sqrt(sq(x1-x2)+sq(y1-y1));
}
