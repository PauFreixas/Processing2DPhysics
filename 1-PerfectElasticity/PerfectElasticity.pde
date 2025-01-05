import controlP5.*;
Mover m;
ControlP5 cp5;
Button myButton;

void setup() {
  size(640, 360);
  fill(255, 126);
  m = new Mover();
  
  cp5 = new ControlP5(this);  // Initialize ControlP5
  
  // Create a slider to control the mass (range 0.1 to 10, starting at 1)
  cp5.addSlider("mass")
     .setPosition(100, 10)   // Position of the slider
     .setSize(300, 10)       // Size of the slider
     .setRange(0, 10)      // Minimum and maximum values
     .setValue(1);           // Initial value
  cp5.addSlider("gravity")
     .setPosition(100, 30)   // Position of the slider
     .setSize(300, 10)       // Size of the slider
     .setRange(0, 10)      // Minimum and maximum values
     .setValue(1);           // Initial value
  // Create a button
  myButton = cp5.addButton("buttonPressed")  // Function to be called on button press
                .setPosition(500, 0)       // Position of the button
                .setSize(100, 50)            // Size of the button
                .setLabel("Reset Position");       // Label on the button
}

void buttonPressed() {
  m.resetPos(30, 30);
}

void draw() {
  background(51);
  
  m.setMass(cp5.getController("mass").getValue());
  m.setGravity(cp5.getController("gravity").getValue());
  
  m.update();
  m.display();
};
