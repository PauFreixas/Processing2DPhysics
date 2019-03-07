Mover m = new Mover();

void setup() {
  size(640, 360);
  fill(255, 126);
  m = new Mover();
}

void draw() {
  background(51);
  m.update();
  m.display();
};
