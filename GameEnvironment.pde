class GameEnvironment {
  SpaceShip s;
  Enemies e;

  int maxLives = 3;
  int currentLives =3;
  int gameState;
  int deathStart;
  int gameOverStart;
  int menu=0, game=1, playerDead=2, gameOver=3;

  int currentScore=0;
  int highScore=0;
  

  ArrayList<ShieldCluster> shields ;

  GameEnvironment() {
    s=new SpaceShip();
    gameState = menu;
    s.pos.x=width/2;
    s.pos.y=height -100;
    e= new Enemies();

    shields = new ArrayList<ShieldCluster>();
    shields.add(new ShieldCluster(150, 800));
    shields.add( new ShieldCluster(350, 800));
    shields.add( new ShieldCluster(550, 800));
    shields.add(new ShieldCluster(750, 800));
  }
  void keyDown() {
    if (gameState==menu) {
      if (key=='s' || key=='S') {
        gameState=game;
      }
    } else if (gameState==game) {
      if (keyCode==LEFT) {
        s.left();
      } else if (keyCode==RIGHT) {
        s.right();
      }
      if (key==' ') {

        s.fire();
      }
    }
  }

  void keyUp() {
    s.keyUp();
  }

  String getGameState() {
    String rtrn="";
    if (gameState==0) {
      rtrn="menu";
    } else if (gameState==1) {
      rtrn="game";
    } else if (gameState==2) {
      rtrn="player dead";
    } else if (gameState==3) {
      rtrn="game over";
    } 
    return rtrn;
  }

  void show() {  
    println(getGameState());
    if (gameState==menu) {
      text("Press <s> to start", 300, 300);
    } else if (gameState==game) {

      s.show();
      e.show();

      for (ShieldCluster sc : shields) {
        sc.show();
      }
    } else if (gameState==playerDead) {

      s.show();
      e.show();
      for (ShieldCluster sc : shields) {
        sc.show();
      }
      stroke(255);
      strokeWeight(3);
      textSize(30);
      text("You Died", 300, 300);
    } else if (gameState==gameOver) {
      textSize(30);
      strokeWeight(5);
      stroke(255);
      text("Game Over", 300, 300);
    }
  }
  void update() {
    if (gameState==game) {
      boolean alive;
      alive=s.stillAlive(e.bombs);
      if (alive) {
        e.update();
        s.update(); 
        e.whoDied(s.bullets);
      }


      if (!alive && deathStart ==0) {
        //change gamestate into death scene.
        currentLives--;
        gameState=playerDead;
        deathStart=frameCount;
        if (currentLives==0) {
          gameState=gameOver;
          gameOverStart=frameCount;
        }
      }


      for (ShieldCluster sc : shields) {
        sc.update(e.bombs, false);
        sc.update(s.bullets, true);
      }
    } else if (gameState==playerDead) {
      if ( frameCount - deathStart == 200) {
        gameState=game;
        deathStart=0;
        e.bombs=new ArrayList<PVector>();
      }
    } else if (gameState==gameOver) {
      if (frameCount - gameOverStart ==200) {
        gameState=menu;
        currentLives=3;
        s=new SpaceShip();

        s.pos.x=width/2;
        s.pos.y=height -100;
        e= new Enemies();

        shields = new ArrayList<ShieldCluster>();
        shields.add(new ShieldCluster(150, 800));
        shields.add( new ShieldCluster(350, 800));
        shields.add( new ShieldCluster(550, 800));
        shields.add(new ShieldCluster(750, 800));
      }
    }
  }
}
