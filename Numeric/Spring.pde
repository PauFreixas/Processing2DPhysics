class Spring {
  PVector position;
  
  float wo;
  float amplitude = 20;
  float x;
  float w;
  float d = 100;
  float Pest = 0.5;
  float Ec = 10;
  float t = 20;
  float beta;
  boolean started = false;
  int startFrameCount;
  
  Spring(float k, float m) {
       wo = sqrt(k/m);
       amplitude = sqrt(2*Pest*Ec/k);
       w = wo * sqrt(1 - 1/pow(2*wo*t , 2));
       beta = 1/(2*t);
  }
  
  
  void update(PVector pos) {
    position = pos;
    if (started) {
      x = d - amplitude * sin(w * (frameCount-startFrameCount)) * exp(-beta * (frameCount - startFrameCount));
    }  else {
      x = d;
    }
  }
  
  void begin() {
     started = true;
     startFrameCount = frameCount;
  }
  
  void display() {
    stroke(0);
    fill(175);
    line(position.x,position.y,position.x,position.y-x);
    ellipse(position.x, position.y-x,20,20);
  }
  
  
}
