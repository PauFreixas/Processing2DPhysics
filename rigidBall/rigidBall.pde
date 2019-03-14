
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

float COEFFICIENT_OF_FRICTION = 1;

Mover ball;
PVector gravity = new PVector(0, -10);

void setup() {
  size(800, 600);
  surface.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
  surface.setLocation (400, 20);

  ball = new Mover(new PVector(200, -230), new PVector(10, 0));
}

void draw() {
  background(240);

  PVector friction = new PVector().set(ball.speed);
  friction.mult(-1); 
  friction.normalize();
  friction.mult(COEFFICIENT_OF_FRICTION);

  ball.applyForce(friction);
  ball.applyForce(gravity);
  ball.update();
  ball.display();
  ball.checkEdges();
}
