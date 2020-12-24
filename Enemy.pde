class Enemy {
  PVector pos;
  float dir,speed, wide=35;

  Enemy(int x, int y) {
    pos=new PVector(x, y);
    dir=1;
    speed=.5;
  }

  void show() {
    fill(255);
    square(pos.x, pos.y, wide);
  }

  void update() {
    pos.x+=(dir*speed);
  }
  void changeDirection() {
    dir*=-1; 
    pos.y+=10;
    speed*=1.1;
  }
  PVector fireWeapon() {
    if (random(0, 100) < .75) {
 
      return new PVector(pos.x+wide/2, pos.y+wide);
    }
    
    return null;
  }
}
