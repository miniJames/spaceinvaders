class ShieldCluster {
  PVector pos;
  ArrayList<Shield> shieldPieces;
  ShieldCluster(int x, int y) {
    pos = new PVector(x, y);
    shieldPieces=new ArrayList<Shield>();

    //10x20
    for (int i=x; i<x+100; i+=10) {
      
      for (int j=y; j<y+50; j+=20) {
         
        shieldPieces.add(new Shield(i, j));
      }
    }
  }

  void show() {

    for (Shield s : shieldPieces) {
      s.show();
    }
  }

  void update(ArrayList<PVector> bullets, boolean up) {

    for (int bc = bullets.size(); bc>0; bc--) {  
      PVector bullet = bullets.get(bc-1);  
      for (int sc=shieldPieces.size(); sc>0; sc--) {
        Shield shield= shieldPieces.get(sc-1);
        if (!up)
          if ( bullet.x + 2 > shield.pos.x  && bullet.x+2<shield.pos.x + 10 &&
            bullet.y + 10 > shield.pos.y ) {

            shield.shieldStrength--;
            bullets.remove(bullet);
          }
        if (up) {
          if (bullet.x > shield.pos.x && bullet.x+2 < shield.pos.x+10 && 
            bullet.y < shield.pos.y) {
            bullets.remove(bullet);
            shield.shieldStrength--;
          }
        }
        if (shield.shieldStrength==0) {
          shieldPieces.remove(shield);
        }
      }
    }
  }
}
