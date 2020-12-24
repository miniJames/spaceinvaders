class SpaceShip {

  PVector pos;
  PVector acc;
  boolean leftPressed =false, rightPressed =false, firing =false,fired=false;
  ArrayList<PVector> bullets;
  float firingStart=frameCount;
  SpaceShip() {
    pos=new PVector();
    bullets=new ArrayList<PVector>();
  }

  void show() {
    fill(255);
    stroke(255);
    rect(pos.x, pos.y, 50,20);
    rect(pos.x+22,pos.y-9,6,9);
   //println(bullets.size());
    for(PVector b : bullets){
      //fill(255);
      rect(b.x,b.y,2,10);
      //circle(b.x, b.y,10);  
    }
  }

  void update() {
    if(leftPressed){
      pos.x -=3;
    } else if(rightPressed){
      pos.x+=3;
    } 
    if(firing && !fired){
      bullets.add(new PVector(pos.x+24, pos.y-30));
      fired=true;
    } else {
      //fired=false;
    }
    updateBullets();
  }
  void left(){
    leftPressed=true;
    
  }
  void right(){
    rightPressed=true;
  }
  
  void fire(){
          //firingStart = frameCount;
    if(!fired && firingStart < frameCount-20){ 
      firing=true; 
      firingStart = frameCount;
    } else {
     firing=false; 
     fired=true;
 
    }
  }
  
  void updateBullets(){
    
    PVector b;
    for(int i=bullets.size() ;i>0;i--){
      b=bullets.get(i-1);
    //for(PVector b : bullets){
      b.y-=10;  
      if(b.y<10){
        bullets.remove(i-1);  
      }
    }
  }
  void keyUp(){
       if(keyCode==LEFT){
      leftPressed=false;
    } else if (keyCode==RIGHT){
      rightPressed=false;
    } 
    if(key == ' '){
      firing=false;
      fired=false;
    }
  }
  
  boolean  stillAlive(ArrayList<PVector> bombs){
    
    boolean rtrn = true;
    for(int i=bombs.size();i>0;i--){
      PVector bomb = bombs.get(i-1);
      if(bomb.x > pos.x && bomb.x+2 < pos.x + 50 && bomb.y > pos.y && bomb.y+10 < pos.y + 20){
        //println("I AM DEAD");
        return false;
        
      }
    }
    return rtrn;
  }
  
}
