import controlP5.*;
ControlP5 cp5;
Button myButton;

int SCREEN_WIDTH = 800;
int SCREEN_HEIGHT = 600;

float COEFFICIENT_OF_FRICTION = 1;

Ball ball;

void setup() {
  size(800, 600);
  surface.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
  surface.setLocation (400, 20);

  ball = new Ball();
  
  cp5 = new ControlP5(this);  // Initialize ControlP5
  
  // Create a slider to control the mass (range 0.1 to 10, starting at 1)
  cp5.addSlider("mass")
     .setPosition(100, 10)   // Position of the slider
     .setSize(300, 10)       // Size of the slider
     .setRange(0, 10)      // Minimum and maximum values
     .setValue(5);           // Initial value
  cp5.addSlider("friction")
     .setPosition(100, 30)   // Position of the slider
     .setSize(300, 10)       // Size of the slider
     .setRange(0, 1)      // Minimum and maximum values
     .setValue(0.5);           // Initial value
  // Create a button
  myButton = cp5.addButton("buttonPressed")  // Function to be called on button press
                .setPosition(500, 0)       // Position of the button
                .setSize(100, 50)            // Size of the button
                .setLabel("Reset Ball");       // Label on the button
}

void buttonPressed() {
  ball.resetBall();
}

void draw() {
  background(0);
  
  ball.setMass(cp5.getController("mass").getValue());
  ball.setFriction(cp5.getController("friction").getValue());
  
  ball.update();
  ball.display();
}
