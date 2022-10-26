Tank player1 = new Tank(140,60,0,0,color(255,0,0));
Tank player2 = new Tank(60,140,0,0,color(0,0,255));

public ArrayList<Shot> shots = new ArrayList<Shot>();
boolean keyW,keyA,keyS,keyD,keyQ,keyE,keyUp,keyLeft,keyDown,keyRight,keyComma,keyPeriod;
boolean p1Fire,p2Fire=false;
float mouseTheta;
public Terrain[][] layout = level1();
void setup(){
  size(840,840);
}
void draw(){
  strokeWeight(0);
  background(100);
  updateTerrain();
  updateShots();
  for(Terrain[] array : layout){
    for(Terrain terrain : array){
      terrain.render();
    }
  }
  player2.render();
  player1.render();
  if(keyA)player1.turn(player1.getMoveTheta()+5);
  if(keyD)player1.turn(player1.getMoveTheta()-5);
  if(keyQ)player1.aim(player1.getAimTheta()+5);
  if(keyE)player1.aim(player1.getAimTheta()-5);
  if(keyW)player1.forward();
  if(keyS)player1.backward();
  if(keyLeft)player2.turn(player2.getMoveTheta()+5);
  if(keyRight)player2.turn(player2.getMoveTheta()-5);
  if(keyComma)player2.aim(player2.getAimTheta()+5);
  if(keyPeriod)player2.aim(player2.getAimTheta()-5);
  if(keyUp)player2.forward();
  if(keyDown)player2.backward();
  shots.forEach((n) -> n.render());
  //delay(1000);
}

void keyPressed(){
  switch(key){
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
    if(!p1Fire&&player1.fire())p1Fire=true;
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
    if(!p2Fire&&player2.fire())p2Fire=true;
    break;
    case CODED:
    switch(keyCode){
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
void keyReleased(){
  switch(key){
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
    switch(keyCode){
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

void updateTerrain(){
  for(int i=0;i<shots.size();i++){
    if(shots.get(i).checkRemove())shots.remove(i);
  }
}

void updateShots(){
  for(Terrain[] array : layout){
    for(Terrain terrain : array){
      if(terrain.destructible()&&terrain.getHealth()==0){
        layout[terrain.getX()][terrain.getY()]=Floor(terrain.getX(),terrain.getY());
      }
    }
  }
}

Terrain[][] level1(){
  Terrain[][] temp = new Terrain[21][21];
  for(int i=0;i<21;i++){
    for(int j=0;j<21;j++){
      if(i==0||i==20||j==0||j==20){temp[i][j]=Wall(i,j);}
      else if(i%4==0&&j%4==0){temp[i][j]=BreakableWall(i,j);}
      else {temp[i][j]=Floor(i,j);}
    }
  }
  return temp;
}
public Terrain Hole(int x, int y){
  return new Terrain(false,false,false,#7E5819,x,y,1);
}
public Terrain Wall(int x, int y){
  return new Terrain(false,false,true,#7E5819,x,y,1);
}
public Terrain BreakableWall(int x, int y){
  return new Terrain(true,false,true,#B47816,x,y,2);
}
public Terrain Floor(int x, int y){
  return new Terrain(false,true,false,#F2C375,x,y,1);
}
public Terrain BreakableFloor(int x, int y){
  return new Terrain(true,true,false,#FFD99B,x,y,1);
}
