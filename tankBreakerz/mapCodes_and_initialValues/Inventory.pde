int doInnerStroke=5;

//player Inventory
class playerInventory {
  int playerInvx=0;
  int playerInvy=0;
  int upgradeValue=0; //upgrade values of tank perks
  float playerInvw=GRID_SIZE;
  int playerInvh= GRID_SIZE;
  color playerInvc;


  //constructor
  playerInventory(int gridInvx, int gridInvy, float gridInvw, int gridInvh, color slotC) {
    playerInvx=gridInvx;
    playerInvy=gridInvy;
    playerInvw=gridInvw;
    playerInvh=gridInvh;
    playerInvc=slotC;
  }
  void render() { //inventory
    strokeJoin(ROUND);
    if (upgradeValue==0) fill(playerInvc);
    else if (upgradeValue==1) fill(181, 24, 147); //tier 1 is pink
    else if (upgradeValue==2) fill(128, 5, 64); //tier 2 is darker pink
    else if (upgradeValue==3) fill(150, 27, 191); //tier 3 is purple
    else if (upgradeValue>3) fill(255, 215, 0); //master tier is golden
    rectMode(CORNER);
    strokeWeight(doInnerStroke);
    square(playerInvx, playerInvy, playerInvw);
    strokeWeight(1);
    strokeJoin(MITER);
  }


  void HPXPrender() { //hpxp boxes
    rectMode(CORNER);
    fill(playerInvc);
    noStroke();
    rect(playerInvx, playerInvy, playerInvw, playerInvh);
    strokeWeight(1);
    stroke(0);
  }
}
