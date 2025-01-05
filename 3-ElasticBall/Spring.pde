class Spring {
  PVector position;
  
  PImage img;
    
  float wo;
  float amplitude = 20;
  float x;
  float w;
  float d = 50;
  float Pest = 0.3;
  float Ec = 10;
  float t = 20;
  float beta;
  float ka;
  boolean started = false;
  int startFrameCount;
  
  Spring(float k, float m) {
       ka = k;
       wo = sqrt(k/m);
       amplitude = sqrt(2*Pest*Ec/k);
       w = wo * sqrt(1 - 1/pow(2*wo*t , 2));
       beta = 1/(2*t);
       
       img = loadImage("basketBall.png");
  }
  
  
  void update(PVector pos) {
    position = pos;
    if (started) {
      amplitude = sqrt(2*Pest*Ec/ka);
      x = d - amplitude * sin(w * (frameCount-startFrameCount)) * exp(-beta * (frameCount - startFrameCount));
    }  else {
      x = d;
    }
  }
  
  void begin(float kinetic) {
     Ec = kinetic;
     started = true;
     startFrameCount = frameCount;
  }
  
  void display() {
    image(img, position.x - d/2, position.y -x, d, x);
    stroke(0);
    fill(175);
    rect(position.x - 10, position.y - 10, 20, 10);
    line(position.x,position.y,position.x,position.y-x);
    image(img, position.x -10, position.y-x,20,20);
  }
  
  
}
