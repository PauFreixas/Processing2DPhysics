class Mover {

  float MOVER_RADIUS = 20;
  float MASS = 30;
  PImage basketballImage; 

  PVector position;
  PVector speed;
  PVector acceleration;

  PVector initialSpeed;
  PVector initialPosition;

  public Mover(PVector initialPosition, PVector initialSpeed) {

    basketballImage = loadImage("basketBall.png");

    position = new PVector().set(initialPosition);
    speed = new PVector().set(initialSpeed);
    acceleration = new PVector();


    this.initialSpeed = new PVector().set(initialSpeed);
    this.initialPosition = new PVector().set(initialPosition);
  }

  public void display() {
    fill(255, 0, 0);
    imageMode(CENTER);
    image(basketballImage, position.x, -position.y, MOVER_RADIUS*2, MOVER_RADIUS*2);
  }

  public void update() {

    speed.add(acceleration);
    position.add(speed);
    acceleration.mult(0);
  }

  public void applyForce(PVector force) {
    acceleration.add(PVector.div(force, MASS));
  }

  public void checkEdges() {


    if (position.x + MOVER_RADIUS > SCREEN_WIDTH) {
      position.x = SCREEN_WIDTH - MOVER_RADIUS;
      speed.x *= -1;
    } else if (position.x - MOVER_RADIUS < 0) {
      position.x = MOVER_RADIUS;
      speed.x *= -1;
    }

    if (position.y - MOVER_RADIUS <= -SCREEN_HEIGHT) {

      speed.y *= -1;
      position.y = -SCREEN_HEIGHT+MOVER_RADIUS;
    }
  }
}
