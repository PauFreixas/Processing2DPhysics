Mover m;

void setup() {
  size(640,360);
  m = new Mover();
  frameRate(20);
}
 
void draw() {
  background(255);
 
   m.update();
   m.display();
   
}
