Ball b;

void setup() {
  size(640,360);
  b = new Ball();
  frameRate(20);
}
 
void draw() {
  background(255);
 
   b.update();
   b.display();
   
}
