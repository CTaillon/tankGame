//main code
void setup() {
  size(840, 840, P2D);
  frameRate(250);
  loadImages();
  stencil = loadFont("stencil20.vlw");
  //hp boxes
  player1HP= new playerInventory(0, 0, GRID_SIZE*(hpxpBox), GRID_SIZE, hp1boxc);
  player2HP= new playerInventory(width-1, 0-1, -GRID_SIZE*(hpxpBox), GRID_SIZE, hp2boxc);//need the 1s because i cant find the stroke error to make ui look cleaner
  //xp boxes
  player1XP= new playerInventory(0, height-GRID_SIZE+1, 0, GRID_SIZE, xpboxc);
  player2XP= new playerInventory(width, (height-GRID_SIZE)+1, 0, GRID_SIZE, xpboxc);//need the 1s because i cant find the stroke error to make ui look cleaner

  //inventory code
  for (int i=0; i<invSlots; i++) {
    if (i<3) {//temp perk slots
      player1TempInv[i]= new playerInventory(doInnerStroke/2, (doInnerStroke/2)+(i*GRID_SIZE)+(4*GRID_SIZE), GRID_SIZE-(doInnerStroke), GRID_SIZE-(doInnerStroke), slotBlue);
      player2TempInv[i]= new playerInventory(width-(GRID_SIZE-doInnerStroke/2), (doInnerStroke/2)+(4*GRID_SIZE)+(GRID_SIZE*i), GRID_SIZE-(doInnerStroke), GRID_SIZE-(doInnerStroke), slotBlue);
    } //perm perk slots, 1 block away from temp perks
    player1Inv[i]= new playerInventory(doInnerStroke/2, (doInnerStroke/2)+(5*GRID_SIZE)+(GRID_SIZE*(i+3)), GRID_SIZE-(doInnerStroke), GRID_SIZE-(doInnerStroke), slotBlue);
    player2Inv[i]= new playerInventory(width-(GRID_SIZE-doInnerStroke/2), (5*GRID_SIZE)+(GRID_SIZE*(i+3))+(doInnerStroke/2), GRID_SIZE-(doInnerStroke), GRID_SIZE-(doInnerStroke), slotBlue);
  }
  //Timer timer30= new Timer(30000);
  //Timer timer5= new Timer(5000);
}

void draw() {
  strokeWeight(0);
  mapRender();
  updateTerrain();
  updateShots();
  for (Terrain[] array : layout) {
    for (Terrain terrain : array) {
      terrain.render();
    }
  }
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

  //testing
  //player1.healthTest();//xp is tied to this as well
  //player2.healthTest();

  //render inv slots but this time you can change values without null pointer error
  for (int i=0; i<invSlots; i++) {
    if (i<3) {//temp perk slots
      player1TempInv[i].render();
      player2TempInv[i].render();
    } //perm perk slots, 1 block away from temp perks
    player1Inv[i].render();
    player2Inv[i].render();
  }
  permPerksRender();//perm perk images loading on the sides
  //test drop
  //permLootRender(60, 200, 9, enemy1);
  //permLootRender(60, 300, 9, enemy2);
  //println(player2.dropChance);


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
  shots.forEach((n) -> n.render());
  //delay(1000);

  //test
  if (enemy1.getStat("health")>=0)  enemy1.render();
  if (enemy2.getStat("health")>=0) enemy2.render();
  enemy1.update();
  enemy2.update();
  enemy2.healthTest();
  enemy1.healthTest();
}

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

void updateTerrain() {
  for (int i=0; i<shots.size(); i++) {
    if (shots.get(i).checkRemove())shots.remove(i);
  }
}

void updateShots() {
  for (Terrain[] array : layout) {
    for (Terrain terrain : array) {
      if (terrain.destructible()&&terrain.getHealth()==0) {
        layout[terrain.getX()][terrain.getY()]=Floor(terrain.getX(), terrain.getY());
      }
    }
  }
}

Terrain[][] level1() {
  Terrain[][] temp = new Terrain[21][21];

  //setting which map is rendered
  if (randomMap==0) mapChosen = nyanMapColorValue;
  if (randomMap==1) mapChosen = abyssMapColorValue;
  if (randomMap==2) mapChosen = beachMapColorValue;
  if (randomMap==3) mapChosen = labyMapColorValue;
  if (randomMap==4) mapChosen = lossMapColorValue;

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
