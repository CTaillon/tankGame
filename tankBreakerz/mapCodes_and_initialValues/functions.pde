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
  textAlign(CENTER);
  textSize(20);
  fill(0);
  if (player1.getStat("health")>0) text("" + player1.getStat("health") + " / " +player1.getStat("maxHealth"), (hpxpBox*GRID_SIZE+2)/2, 25);//show hp ratio
  else text("PlAYER 1 DEAD", (hpxpBox*GRID_SIZE+2)/2, 25); //if hp is 0, show that player is dead
  text("" + player1.getStat("xp") + " / " +player1.getStat("maxxp"), (hpxpBox*GRID_SIZE+2)/2, height-15);//show xp ratio
  //player 2 HP drainage
  player2HP.playerInvw= (float(player2.getStat("health"))/float(player2.getStat("maxhealth")))*(-GRID_SIZE*(hpxpBox)+1);
  if (player2.getStat("health")>0) text("" + player2.getStat("health") + " / " +player2.getStat("maxHealth"), width-(GRID_SIZE*hpxpBox)/2, 25);//show hp ratio
  else text("PlAYER 2 DEAD", width-(GRID_SIZE*hpxpBox)/2, 25); //if hp is 0, show that player is dead
  text("" + player2.getStat("xp") + " / " +player2.getStat("maxxp"),  width-(GRID_SIZE*hpxpBox)/2, height-15);//show xp ratio
}

void xpFill() {//bar gets filled as player gets xp
  //player 1 xp
  if (player1XP.playerInvw<=(GRID_SIZE)*(hpxpBox)) {
    if (float(player1.getStat("xp"))/float(player1.getStat("maxXP"))>1) player1XP.playerInvw= GRID_SIZE*hpxpBox;
    else player1XP.playerInvw= (float(player1.getStat("xp"))/float(player1.getStat("maxXP")))*(GRID_SIZE*(hpxpBox));
  }
  //player 2 XP
  if (player2XP.playerInvw<=GRID_SIZE*(hpxpBox)) {
    if (float(player2.getStat("xp"))/float(player2.getStat("maxXP"))>1) player2XP.playerInvw= -GRID_SIZE*hpxpBox;
    else player2XP.playerInvw= (float(player2.getStat("xp"))/float(player2.getStat("maxXP")))*(-GRID_SIZE*(hpxpBox));
  }
}


void perksRender() { //place images according to the inventory box
  for (int i=0; i<invSlots; i++) {
    if (i<perks.size()) {
      image(perks.get(i), GRID_SIZE/2, player1Inv[i].playerInvy+GRID_SIZE/2-1, GRID_SIZE*.8, GRID_SIZE*.8);
      //inverses the image for player 2
      scale(-1, 1);
      image(perks.get(i), -player2Inv[i].playerInvx-GRID_SIZE/2+2, player2Inv[i].playerInvy+GRID_SIZE/2-1, -GRID_SIZE*.8, GRID_SIZE*.8);
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
  shotDamage= loadImage("bulletdmg.png");
  perks.add(shotDamage); //array 0
  shotCount = loadImage("bulletamt.png");
  perks.add(shotCount); //array 1
  reloadSpeed = loadImage("bulletcast.png");
  perks.add(reloadSpeed); //array 2
  shotSpeed= loadImage("bulletspeed.png");
  perks.add(shotSpeed); //array 3
  bounces = loadImage("bulletbounce.png");
  perks.add(bounces); //array 4
  critChance = loadImage("CritBullets.png");
  perks.add(critChance); //array 5
  explosiveBullet= loadImage("Explosive_bullet.png");
  perks.add(explosiveBullet); //array 6
  moveSpeed= loadImage("tankspeed.png");
  perks.add(moveSpeed); //array 7
  bulldoze= loadImage("bulldoze.png");
  perks.add(bulldoze); //array 8
  healthBoost= loadImage("healthboost.png");
  perks.add(healthBoost); //array 9


  //drops or other renders
  explosion= loadImage("explosion.png");
  otherAssets.add(explosion); //array 0
}
