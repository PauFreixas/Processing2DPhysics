class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float gravity = 0.5;
  float Pc = 0.7;
  
  Spring s;
 
  Mover() {
    mass = 1;
    location = new PVector(30,30);
    velocity = new PVector(2,0);
    acceleration = new PVector(0,0);
    s = new Spring(1, 10);
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
    
    s.update(location);
  }
 
  void display() {
    s.display();
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
      velocity.y *= -1 * Pc;
      location.y = height;
      s.begin(acceleration.y * mass);
      
      //If we are touching the floor we also slow down the x movement with friction
      int direction;
      if (velocity.x != 0) {
        if (velocity.x >0) {
          direction = -1;
        } else {
          direction = 1;
        }
        float mu = 0.5;
        float normal = mass * gravity;
        velocity.x += direction * normal* mu;
    
      }
      
    }
  }
}
