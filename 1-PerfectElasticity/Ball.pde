class Ball {
 //Ball has location, position, velocity and mass and gravity
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass = 1;
  float gravity = 0.5;
 
  //Initialize Ball
  Ball() {
    location = new PVector(30,30);
    velocity = new PVector(2,0);
    acceleration = new PVector(0,0);
  }
  
  //Used to reset the position of the ball
  void resetBall() {
    location = new PVector(30,30);
    velocity = new PVector(2,0);
    acceleration = new PVector(0,0);;
  }
  
  //Used to apply force to the Ball 
  void applyForce(PVector force) {
    PVector a = PVector.div(force, mass);
    acceleration.add(a);
  }
  
  //Used to modify the mass of the ball
  void setMass(float m) {
    mass = m;
  }
  
  //Used to modify the gravity affecting the ball
  void setGravity(float g) {
    gravity = g;
  }
 
 //Ran each update
  void update() {
    
    //Zero mass breaks physics, so we only apply physics if mass is not 0
    if (mass > 0) {
      velocity.add(acceleration);
      location.add(velocity);
      
      //Reset acceleration and reapply gravity
      acceleration.set(0, 0);
      applyForce(new PVector(0, mass * gravity));
      
      
      checkCollisions();
    }
  }
 
 //Draw the ball
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,mass*16,mass*16);
  }
 
 //Check collisions with the edges of the window
  void checkCollisions() {
    
    //Collision Right
    if (location.x > width) {
      velocity.x *= -1;
      location.x = width;
    } else 
    //Collision Left
    if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    
    //Collision bottom
    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    } else 
    //Collision top
    if (location.y < 0) {
        velocity.y *= -1;
        location.y = 0;
    }
  }
}
