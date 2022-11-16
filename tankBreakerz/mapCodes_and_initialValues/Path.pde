public class Path{//ai pathfinding
  private ArrayList<float[]> points;
  private ArrayList<Terrain> checkedTerrain;
  
  public Path(float x1, float y1, float x2, float y2){
    this.points = new ArrayList<float[]>();
    this.checkedTerrain = new ArrayList<Terrain>();
    this.points.add(0,new float[] {x1,y1});
    this.points.add(1,new float[] {x2,y2});
  }
  
  public void render(){
    fill(0);
    for(int i=1;i<this.points.size();i++){
      //line(this.points.get(i-1)[0],this.points.get(i-1)[1],this.points.get(i)[0],this.points.get(i)[1]);
    }
    fill(255);
    for(int i=0;i<this.points.size();i++){
      //circle(this.points.get(i)[0],this.points.get(i)[1],10);
    }
  }
  
  public void addPoint(float x, float y, int n){
    this.points.add(n,new float[] {x,y});
  }
  public void setPoint(float x, float y, int n){
    this.points.set(n,new float[] {x,y});
  }
  public float[] getPoint(int n){
    return this.points.get(n);
  }
  
  public float getTheta(){
    return calcTheta(this.points.get(0)[0],this.points.get(0)[1],this.points.get(1)[0],this.points.get(1)[1]);
  }
  
  public int size(){
    return this.points.size();
  }
  
  public Terrain checkObscuredPoint(Tank tank, float x, float y,Terrain[][] layout){
    for(Terrain[] array : layout){
      for(Terrain terrain : array){
        if((!terrain.traversable())&&abs(0.5+terrain.getX()-x/GRID_SIZE-tank.getStat("size")*10.0/GRID_SIZE)<0.5&&abs(0.5+terrain.getY()-y/GRID_SIZE-tank.getStat("size")*10.0/GRID_SIZE)<0.5)return terrain;
      }
    }
    return null;
  }
  
  public float calcDistance(float x1, float y1, float x2, float y2){
    return sqrt(sq(x2-x1)+sq(y2-y1));
  }
  
  public float calcTheta(float x1, float y1, float x2, float y2){
    float theta;
    if(x2>x1){
      theta=atan((y2-y1)/(x2-x1));
    } else {
      theta=PI+atan((y2-y1)/(x2-x1));
    }
    while(theta<0){
      theta+=2*PI;
    }
    return theta;
  }
  
  public void adjustPath(Tank tank,Terrain[][] layout){
    boolean repeat;
    do{
      repeat=false;
      for(int i=1;i<this.points.size();i++){
        float theta=calcTheta(this.points.get(i-1)[0],this.points.get(i-1)[1],this.points.get(i)[0],this.points.get(i)[1]);
        for(float j=0;j<calcDistance(this.points.get(i-1)[0],this.points.get(i-1)[1],this.points.get(i)[0],this.points.get(i)[1]);j++){
          boolean checked=false;
          Terrain tempTerrain = this.checkObscuredPoint(tank,this.points.get(i-1)[0]+(cos(theta)*j),this.points.get(i-1)[1]+(sin(theta)*j),layout);
          for(int k=0;k<checkedTerrain.size();k++){
            if(tempTerrain!=null&&checkedTerrain.get(k)==tempTerrain)checked=true;
          }
            if(!checked&&tempTerrain!=null){
            this.addPoint(this.points.get(i-1)[0]+(cos(theta)*j),this.points.get(i-1)[1]+(sin(theta)*j),i);
            checkedTerrain.add(tempTerrain);
            repeat=true;
            }
        }
      }
    }while(repeat);
    for(int i=1;i<this.points.size();i++){
        Terrain tempTerrain = this.checkObscuredPoint(tank,this.points.get(i)[0],this.points.get(i)[1],layout);
        if(tempTerrain!=null){
          if(((this.points.get(i-1)[0]-this.points.get(i)[0])*(this.points.get(i-1)[1]-this.points.get(i)[1]))>0){
            if(calcDistance(points.get(i+1)[0],points.get(i+1)[1],tempTerrain.getX()*GRID_SIZE+GRID_SIZE+tank.getStat("size")*12,tempTerrain.getY()*GRID_SIZE-tank.getStat("size")*12)<calcDistance(points.get(i+1)[0],points.get(i+1)[1],tempTerrain.getX()*GRID_SIZE-tank.getStat("size")*12,tempTerrain.getY()*GRID_SIZE+GRID_SIZE+tank.getStat("size")*12)){
              this.points.set(i,new float[] {tempTerrain.getX()*GRID_SIZE+GRID_SIZE+tank.getStat("size")*12,tempTerrain.getY()*GRID_SIZE-tank.getStat("size")*12});
            }else{
              this.points.set(i,new float[] {tempTerrain.getX()*GRID_SIZE-tank.getStat("size")*12,tempTerrain.getY()*GRID_SIZE+GRID_SIZE+tank.getStat("size")*12});
            }
          }else{
            if(calcDistance(points.get(i+1)[0],points.get(i+1)[1],tempTerrain.getX()*GRID_SIZE+GRID_SIZE+tank.getStat("size")*12,tempTerrain.getY()*GRID_SIZE+GRID_SIZE+tank.getStat("size")*12)<calcDistance(points.get(i+1)[0],points.get(i+1)[1],tempTerrain.getX()*GRID_SIZE-tank.getStat("size")*12,tempTerrain.getY()*GRID_SIZE-tank.getStat("size")*12)){
              this.points.set(i,new float[] {tempTerrain.getX()*GRID_SIZE+GRID_SIZE+tank.getStat("size")*12,tempTerrain.getY()*GRID_SIZE+GRID_SIZE+tank.getStat("size")*12});
            }else{
              this.points.set(i,new float[] {tempTerrain.getX()*GRID_SIZE-tank.getStat("size")*12,tempTerrain.getY()*GRID_SIZE-tank.getStat("size")*12});
            }
          }
        }
      }
    }
  }
