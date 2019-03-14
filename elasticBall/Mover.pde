class Mover {
  
  float mass;
  float radius = 10;
  
  PVector position;
  PVector speed;
  PVector acceleration;

  PVector initialSpeed;
  PVector initialPosition;

  Bob bob;
  Anchor anchor;
  Spring spring;
  
  color c = color(255,0,0);

  public Mover(PVector initialPosition, PVector initialSpeed) {
    mass = 30;
    position = new PVector().set(initialPosition);
    speed = new PVector().set(initialSpeed);
    acceleration = new PVector();


    this.initialSpeed = new PVector().set(initialSpeed);
    this.initialPosition = new PVector().set(initialPosition);
  }

  public void display() {
    fill(c);
    rectMode(CENTER);
    ellipse(position.x, -position.y, radius*2, radius*2);
  }

  public void update() {
    speed.add(acceleration);
    position.add(speed);
    acceleration.mult(0);
  }

  public void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }

  public void checkEdges() {


    if (position.x + radius > SCREEN_WIDTH) {
      position.x = SCREEN_WIDTH - radius;
      speed.x *= -1;
    } else if (position.x - radius < 0) {
      position.x = radius;
      speed.x *= -1;
    }

    if (position.y - radius <= -SCREEN_HEIGHT) {        
      speed.y *= -1;
      position.y = -SCREEN_HEIGHT+radius;
    }
  }
}
