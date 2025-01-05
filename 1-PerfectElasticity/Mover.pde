class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass = 1;
  float gravity = 0.5;
 
  Mover() {
    location = new PVector(30,30);
    velocity = new PVector(2,0);
    acceleration = new PVector(0,0);
  }
  
  void resetPos(float x, float y) {
    location.set(x, y);
  }
  
  void applyForce(PVector force) {
    PVector a = PVector.div(force, mass);
    acceleration.add(a);
  }
  
  void setMass(float m) {
    mass = m;
  }
  
  void setGravity(float g) {
    gravity = g;
  }
 
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
    applyForce(new PVector(0, gravity));
    
    checkCollisions();
  }
 
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,mass*16,mass*16);
  }
 
  void checkCollisions() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
 
    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    } else {
      if (location.y < 0) {
        velocity.y *= -1;
        location.y = 0;
      }
    }
  }
}
