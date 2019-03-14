class Basketball {

  float BALL_RADIUS = 30;
  float STIFFNES = 10;   //In spanish, "Factor elástico"
  float MASS = 10;

  //The following constants must sum 1 (they should be normalized)
  float KINETIC_ENERGY_MIN = 0.8;
  float ELASTIC_ENERGY_MIN = 0.2;

  PVector position;
  PVector speed;
  PVector acceleration;

  PVector initialPosition;
  PVector initialSpeed;


  Bob bob;
  Bob anchor;
  Spring spring;

  public Basketball(PVector initialPosition, PVector initialSpeed) {
    spring = new Spring(BALL_RADIUS*2, STIFFNES);
    PVector bobPosition = new PVector().set(initialPosition);
    bobPosition.y+=BALL_RADIUS;
    bob = new Bob(bobPosition, initialSpeed);
    bob.c = color(0, 0, 255);

    PVector anchorPosition = new PVector().set(initialPosition);
    anchorPosition.y -= BALL_RADIUS;
    anchor = new Bob(anchorPosition, initialSpeed);

    position = new PVector().set(initialPosition);
    speed = new PVector().set(initialSpeed);
    acceleration = new PVector();


    this.initialSpeed = new PVector().set(initialSpeed);
    this.initialPosition = new PVector().set(initialPosition);
  }

  public void display() {
    fill(255, 0, 0);
    rectMode(CENTER);
    anchor.display();
    bob.display();
    ellipse(bob.position.x-(bob.position.x - anchor.position.x)/2, -( bob.position.y-(bob.position.y - anchor.position.y)/2), BALL_RADIUS*2, abs(anchor.position.y - bob.position.y));
  }

  public void update() {

    float llindar = spring.restPosition - 20;
    if (bob.position.y <= anchor.position.y + llindar) {
      PVector newPosition = new PVector().set(anchor.position);
      newPosition.y += llindar;
      bob.position.set(newPosition);
      bob.speed.set(anchor.speed);
    }

    PVector elasticForce = new PVector();
    elasticForce.y  = spring.getForceMag();

    if (anchor.position.y > bob.position.y) elasticForce.y *=-1;

    
    bob.applyForce(gravity);
    bob.applyForce(elasticForce);
    bob.update();
    bob.checkEdges();
    
    elasticForce.y *=-1;
    
    anchor.applyForce(gravity);
    anchor.applyForce(elasticForce);
    anchor.update();
    anchor.checkEdges();

    

    spring.update(bob.position, anchor.position);
    

  }

  public void applyForce(PVector force) {
    acceleration.add(PVector.div(force, MASS));
    bob.applyForce(force);
    anchor.applyForce(force);
  }

  public void checkEdges() {


    if (position.x + BALL_RADIUS > SCREEN_WIDTH) {
      position.x = SCREEN_WIDTH - BALL_RADIUS;
      speed.x *= -1;
    } else if (position.x - BALL_RADIUS < 0) {
      position.x = BALL_RADIUS;
      speed.x *= -1;
    }

    if (position.y - BALL_RADIUS <= -SCREEN_HEIGHT) {        
      speed.y *= -1;
      position.y = -SCREEN_HEIGHT+BALL_RADIUS;
    }
  }
}
