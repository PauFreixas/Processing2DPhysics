Mover m;
Spring s;

void setup() {
  size(640,360);
  m = new Mover();
  s = new Spring(10, 10);
  s.begin();
}
 
void draw() {
  background(255);
  s.update(new PVector(0,0));
  s.display();
 
   //m.update();
   //m.display();
   
}
