class Shield {

  PVector pos;
  int shieldStrength = 2;

  Shield(int x, int y) {

    pos = new PVector(x, y);
  }

  void show() {
    noStroke();
    if (shieldStrength==2) {
      fill(0, 255, 0);
    } else {
      fill(0, 128, 0);
    }
    rect(pos.x, pos.y, 10, 20);
  }

  boolean isHit(PVector bullet) {
    return bullet==null;
  }
}
