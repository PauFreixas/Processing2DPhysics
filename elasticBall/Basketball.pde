class Basketball {

  float BALL_RADIUS = 30;
  float STIFFNES = 10;   //In spanish, "Factor elástico".  The K for Hooks Law
  float AMPLITUDE = 20;
  float MASS = 10;

  PImage basketballImage;

  Mover bob;
  Mover anchor;
  Spring spring;

  public Basketball(PVector initialPosition, PVector initialSpeed) {

    basketballImage = loadImage("basketBall.png");

    spring = new Spring(BALL_RADIUS*2, STIFFNES, AMPLITUDE);
    PVector bobPosition = new PVector().set(initialPosition);
    bobPosition.y+=BALL_RADIUS;
    bob = new Mover(bobPosition, initialSpeed);
    bob.c = color(0, 0, 255);

    PVector anchorPosition = new PVector().set(initialPosition);
    anchorPosition.y -= BALL_RADIUS;
    anchor = new Mover(anchorPosition, initialSpeed);

  }

  public void display() {
    fill(255, 0, 0);
    rectMode(CENTER);
    anchor.display();
    bob.display();
    imageMode(CENTER);
    image(basketballImage, 
          bob.position.x-(bob.position.x - anchor.position.x)/2, 
          -( bob.position.y-(bob.position.y - anchor.position.y)/2), 
          BALL_RADIUS*2+(BALL_RADIUS*2-abs(anchor.position.y - bob.position.y)), 
          abs(anchor.position.y - bob.position.y));
  }

  public void update() {

    PVector friction = new PVector().set(bob.speed);
    friction.mult(-1); 
    friction.normalize();
    friction.mult(COEFFICIENT_OF_FRICTION);

    PVector elasticForce = new PVector();
    elasticForce.y  = spring.getForceMag();
    if (anchor.position.y > bob.position.y) elasticForce.y *=-1;



    bob.applyForce(gravity);
    bob.applyForce(elasticForce);
    bob.applyForce(friction);
    bob.update();
    bob.checkEdges();

    elasticForce.y *=-1;

    friction.set(anchor.speed);
    friction.mult(-1); 
    friction.normalize();
    friction.mult(COEFFICIENT_OF_FRICTION);

    anchor.applyForce(gravity);
    anchor.applyForce(elasticForce);
    anchor.applyForce(friction);
    anchor.update();
    anchor.checkEdges();

    spring.update(bob.position, anchor.position);
    
    
    float treshold = spring.restPosition - spring.amplitude;
    if (bob.position.y <= anchor.position.y + treshold) {
      PVector newPosition = new PVector().set(anchor.position);
      newPosition.y += treshold;
      bob.position.set(newPosition);
      bob.speed.set(anchor.speed);
    }
  }

  public void applyForce(PVector force) {
    bob.applyForce(force);
    anchor.applyForce(force);
  }
}
