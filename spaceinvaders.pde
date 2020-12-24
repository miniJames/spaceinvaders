
GameEnvironment ge;

//todo:
//Gamestate
//scoring
//lives

void setup() {
  size(1000, 1000);
  background(0);
  ge=new GameEnvironment();
  //noLoop();
}

void draw() {
  background(0);
  ge.show();
  ge.update();
}

void keyPressed() {
  ge.keyDown();
}
void keyReleased() {
  ge.keyUp();
}
