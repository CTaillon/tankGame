void mapRender() { //change background
  if (randomMap==0)background(nyan);
  if (randomMap==1)background(abyss);
  if (randomMap==2)background(beach);
  if (randomMap==3)background(laby);
  if (randomMap==4)background(loss);
}


void uiRender() {//ui images
  //killcount scoreboard render 
  image(killCount, width/2, GRID_SIZE, width/3, GRID_SIZE*2);
  textAlign(CENTER);
  fill(0);
  textFont(stencil);
  textSize(20);
  text("Score", width/2, GRID_SIZE*.5);
  text(" "+enemyKilled, width/2-4, GRID_SIZE);
  
  //border for xp and hp
  rectMode(CORNER);
  strokeWeight(doInnerStroke);
  fill(255);
  //player 1 full HP border outline
  rect(0, 0, hpxpBox*GRID_SIZE, GRID_SIZE);
  //1 xp borderoutline
  rect(0, height-GRID_SIZE, hpxpBox*GRID_SIZE+2, GRID_SIZE);
  //player2 full HP border outline
  rect(width-(GRID_SIZE*hpxpBox), 0, hpxpBox*GRID_SIZE, GRID_SIZE);
  //2 xp border outline
  rect(width-(GRID_SIZE*hpxpBox), height-GRID_SIZE, hpxpBox*GRID_SIZE, GRID_SIZE);
}


void hpDrain() { //make HP bar move down along with the percent of hp left and each box is worth .2 of the hp
  //player1 HP drain
  player1HP.playerInvw= (float(player1.getStat("health"))/float(player1.getStat("maxhealth")))*(GRID_SIZE*(hpxpBox));
  //player 2 HP drainage
  player2HP.playerInvw= (float(player2.getStat("health"))/float(player2.getStat("maxhealth")))*(-GRID_SIZE*(hpxpBox)+1);
}

void xpFill() {//bar gets filled as player gets xp
  //player 1 xp
  if (player1XP.playerInvw<=(GRID_SIZE)*(hpxpBox)) {
    player1XP.playerInvw= (float(player1.getStat("xp"))/float(player1.getStat("maxXP")))*(GRID_SIZE*(hpxpBox));
  }
  //player 2 XP
  if (player2XP.playerInvw<=GRID_SIZE*(hpxpBox)) {
    player2XP.playerInvw= (float(player2.getStat("xp"))/float(player2.getStat("maxXP")))*(-GRID_SIZE*(hpxpBox));
  }
}

void permPerksRender() { //place images according to the inventory box
  for (int i=0; i<invSlots; i++) {
    if (i<permPerks.size()) {
      image(permPerks.get(i), GRID_SIZE/2, player1Inv[i].playerInvy+GRID_SIZE/2-1, GRID_SIZE*.8, GRID_SIZE*.8);
      //inverses the image for player 2
      scale(-1, 1);
      image(permPerks.get(i), -player2Inv[i].playerInvx-GRID_SIZE/2+2, player2Inv[i].playerInvy+GRID_SIZE/2-1, -GRID_SIZE*.8, GRID_SIZE*.8);
      scale(-1, 1); //turns it off
    }
  }
}



void loadImages() {
  wall= loadImage("wallTexture.png");
  nyan= loadImage("nyanBackground.png");
  abyss= loadImage("abyssBackground.png");
  beach= loadImage("beachBackground.png");
  laby= loadImage("labyBackground.png");
  loss= loadImage("loss2Background.png");
  killCount= loadImage("enemyKillCount.png");

  //perm perks
  bulletdmg= loadImage("bulletdmg.png");
  permPerks.add(bulletdmg); //array 0
  bulletamt = loadImage("bulletamt.png");
  permPerks.add(bulletamt); //array 1
  bulletcast= loadImage("bulletcast.png");
  permPerks.add(bulletcast); //array 2
  bulletspeed= loadImage("bulletspeed.png");
  permPerks.add(bulletspeed); //array 3
  bulletbounce = loadImage("bulletbounce.png");
  permPerks.add(bulletbounce); //array 4
  CritBullets= loadImage("CritBullets.png");
  permPerks.add(CritBullets); //array 5
  Explosive_bullet= loadImage("Explosive_bullet.png");
  permPerks.add(Explosive_bullet); //array 6
  tankspeed= loadImage("tankspeed.png");
  permPerks.add(tankspeed); //array 7
  bulldoze= loadImage("bulldoze.png");
  permPerks.add(bulldoze); //array 8
  healthboost= loadImage("healthboost.png");
  permPerks.add(healthboost); //array 9

  //temp perks

  Drop_Chance= loadImage("Drop_Chance.png");
  tempPerks.add(Drop_Chance); //array 0
  XPboost= loadImage("XPboost.png");
  tempPerks.add(XPboost); //array 1
  Heal= loadImage("Heal.png");
  tempPerks.add(Heal); //array 2
  instant_death= loadImage("instant_death.png");
  tempPerks.add(instant_death); //array 3
  Rocket= loadImage("Rocket.png");
  tempPerks.add(Rocket); //array 4
  MachineGun= loadImage("MachineGun.png");
  tempPerks.add(MachineGun); //array 5
  Iframe= loadImage("Iframe.png");
  tempPerks.add(Iframe); //array 6
  Dmg2Heal= loadImage("Dmg2Heal.png");
  tempPerks.add(Dmg2Heal); //array 7

  //drops or other renders
  explosion= loadImage("explosion.png");
  otherAssets.add(explosion); //array 0
  missile=loadImage("missile.png");
  otherAssets.add(missile); //array 1
}
