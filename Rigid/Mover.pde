class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float gravity = 0.5;
 
  Mover() {
    mass = 1;
    location = new PVector(30,30);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
 
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
 
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    applyForce(new PVector(0,mass * gravity));
    checkEdges();
  }
 
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,mass*16,mass*16);
  }
 
  void checkEdges() {
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
    }
  }
}
