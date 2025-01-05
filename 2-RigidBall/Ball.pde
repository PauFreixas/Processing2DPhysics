class Ball {
  //Ball parameters
  float BALL_RADIUS = 20;
  float MASS = 30;
  PImage basketballImage; 

  //Ball physics
  PVector position;
  PVector speed;
  PVector acceleration;
  float COEFFICIENT_OF_FRICTION = 1;
  PVector gravity = new PVector(0, -10);

  
  //Initial parameters
  PVector initialSpeed;
  PVector initialPosition;

  public Ball() {

    basketballImage = loadImage("basketBall.png");
    
    resetBall();
  }
  
  void resetBall () {
    //Initialize position, speed and acceleration
    position = new PVector().set(new PVector(200, -230));
    speed = new PVector().set(new PVector(10, 0));
    acceleration = new PVector();
  }

  //Draw the ball
  public void display() {
    fill(255, 0, 0);
    imageMode(CENTER);
    image(basketballImage, position.x, -position.y, BALL_RADIUS * 2, BALL_RADIUS * 2);
  }
  
  //Manage physics
  public void update() {
    speed.add(acceleration);
    position.add(speed);
    
    //Reset and recalculate acceleration
    acceleration.mult(0);
    PVector friction = new PVector().set(ball.speed);
    friction.mult(-1); 
    friction.normalize();
    friction.mult(COEFFICIENT_OF_FRICTION);
    
    applyForce(friction);
    applyForce(gravity);
   
    ball.checkEdges();
  }
  
  void setMass(float m) {
    MASS = m;
  }
  
  void setFriction (float f) {
    COEFFICIENT_OF_FRICTION = f;
  }

  public void applyForce(PVector force) {
    acceleration.add(PVector.div(force, MASS));
  }

  public void checkEdges() {
    if (position.x + BALL_RADIUS > SCREEN_WIDTH) {
      position.x = SCREEN_WIDTH - BALL_RADIUS;
      speed.x *= -1;
    } else if (position.x - BALL_RADIUS < 0) {
      position.x = BALL_RADIUS;
      speed.x *= -1;
    }

    if (position.y - BALL_RADIUS <= -SCREEN_HEIGHT) {

      speed.y *= -1;
      position.y = -SCREEN_HEIGHT + BALL_RADIUS;
    }
  }
}
