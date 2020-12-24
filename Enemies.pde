class Enemies {

  ArrayList<Enemy> e;
  ArrayList<PVector> bombs;
  int counter=0;
  Enemies() {
    e=new ArrayList<Enemy>();
    for (int j=0; j<5; j++) {
      for (int i=0; i<11; i++) {
        //println((int)(30*i));
        e.add(new Enemy((int)(70*i)+100, 150 + (70*j)));
      }
    }
    bombs=new ArrayList<PVector>();
  }
  void show() {
    for (Enemy enemy : e) {
      enemy.show();
    }
  }

  void update() {
    counter++;
    for (Enemy enemy : e) {
      enemy.update();

      //if (!enemyBelow(enemy)) {
      //  println("FIRE WEAPON");
      //  bombs.add(enemy.fireWeapon());
      //}
    }

    for (Enemy en : e) {
      if (!enemyBelow(en)) {
        //println("FIRE WEAPON");
        PVector bomb = en.fireWeapon();
        if (bomb!=null) {
          bombs.add(bomb);
        }
      }
    }


    //find left most enemy.
    Enemy leftMost=e.get(0);
    for (int i=1; i<e.size(); i++) {
      Enemy current = e.get(i);
      if (current.pos.x < leftMost.pos.x) {
        leftMost=current;
      }
    }
    //find right most enemy
    Enemy rightMost=e.get(0);
    for (int i=1; i<e.size(); i++) {
      Enemy current = e.get(i);
      if (current.pos.x > rightMost.pos.x) {
        rightMost=current;
      }
    }

    if (leftMost.pos.x < 20 || rightMost.pos.x+ rightMost.wide > width - 20) {
      for (Enemy enemy : e) {
        enemy.changeDirection();
      }
    }
    //if (counter % 320==0) {
    //  for (Enemy enemy : e) {
    //    enemy.changeDirection();


    //  }
    //}
    updateBombs();
  }

  void updateBombs() {


    for (int i=bombs.size(); i>0; i--) {
      PVector bomb = bombs.get(i-1);

      //println(bombs.get(0));
      fill(255);
      rect(bomb.x, bomb.y, 2, 10);
      bomb.y+=3;
      if (bomb.y>height) {
        bombs.remove(bomb);
      }
    }
  }
  boolean enemyBelow(Enemy enmy) {
    for (Enemy enemy : e) {
      if (enmy!=enemy) {
        if (enemy.pos.x == enmy.pos.x) {
          if (enemy.pos.y > enmy.pos.y) {
            return true;
          }
        }
      }
      //return false;
    }

    return false;
  }
  void whoDied(ArrayList<PVector> bullets) {

    for (int i=e.size(); i>0; i--) {
      Enemy enemy = e.get(i-1);

      for (int j=bullets.size(); j>0; j--) {
        PVector bullet = bullets.get(j-1);

        if (bullet.x > enemy.pos.x && bullet.x+2 < enemy.pos.x + enemy.wide && 
          bullet.y > enemy.pos.y && bullet.y+10 < enemy.pos.y + enemy.wide) {
          e.remove(enemy);  
          bullets.remove(bullet);
        }
      }
    }
  }
}
