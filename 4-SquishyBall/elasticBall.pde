
int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

float COEFFICIENT_OF_FRICTION = 1;
PVector gravity = new PVector(0, -10);

Basketball ball;

void setup() {
  size(800, 600);
  surface.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
  surface.setLocation (400, 20);
  frameRate(50);
  ball = new Basketball(new PVector(400, -200), new PVector(0, 0));
}

void draw() {
  background(240);

  ball.update();
  ball.display();
}
