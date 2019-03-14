class Mover {

  float MOVER_RADIUS = 20;
  float STIFFNES = 10; //In spanish, "Factor elástico"
  float MASS = 30;

  //The following constants must sum 1 (they should be normalized)
  float KINETIC_ENERGY_MIN = 0.8;
  float ELASTIC_ENERGY_MIN = 0.2;

  boolean ENERGY_SWITCHING_STAGE1 = false;
  boolean ENERGY_SWITCHING_STAGE2 = false;
  boolean ENERGY_SWITCHING_FINISHED = false;
  float elongation = 0;

  PVector position;
  PVector speed;
  PVector acceleration;

  PVector initialSpeed;
  PVector initialPosition;

  public Mover(PVector initialPosition, PVector initialSpeed) {
    position = new PVector().set(initialPosition);
    speed = new PVector().set(initialSpeed);
    acceleration = new PVector();


    this.initialSpeed = new PVector().set(initialSpeed);
    this.initialPosition = new PVector().set(initialPosition);
  }

  public void display() {
    fill(255, 0, 0);
    rectMode(CENTER);
    ellipse(position.x, -position.y+elongation/2, MOVER_RADIUS*2, MOVER_RADIUS*2-elongation);
  }

  public void update() {
    if (ENERGY_SWITCHING_STAGE1 || ENERGY_SWITCHING_STAGE2)  energySwitching();
    
      speed.add(acceleration);
      position.add(speed);
      acceleration.mult(0);
    
  }

  public void applyForce(PVector force) {
    acceleration.add(PVector.div(force, MASS));
  }

  public void checkEdges() {

    if (ENERGY_SWITCHING_STAGE1 || ENERGY_SWITCHING_STAGE2) {
    } else {

      if (position.x + MOVER_RADIUS > SCREEN_WIDTH) {
        position.x = SCREEN_WIDTH - MOVER_RADIUS;
        speed.x *= -1;
      } else if (position.x - MOVER_RADIUS < 0) {
        position.x = MOVER_RADIUS;
        speed.x *= -1;
      }

      if (position.y - MOVER_RADIUS <= -SCREEN_HEIGHT) {
        
          speed.y *= -1;
          ENERGY_SWITCHING_STAGE1 = true;
          position.y = -SCREEN_HEIGHT+MOVER_RADIUS;
        
      
      }
    }
  }

  float ENERGY_OFFSET = 0.002;
  float TOTAL_ENERGY = 0;
  boolean totalEnergyDefined = false;
  float lerpFactor = 0.9;

  private void energySwitching() {

    if (!totalEnergyDefined) {
      TOTAL_ENERGY  = (1.0/2.0)*MASS*sq(speed.mag());
      totalEnergyDefined = true;
    }

    float currentKineticEnergy = (1.0/2.0)*MASS*sq(speed.mag());
    float currentElasticEnergy = (1.0/2.0)*STIFFNES*sq(elongation);


    float updatedKineticEnergy = 0;
    float updatedElasticEnergy = 0;
    if (ENERGY_SWITCHING_STAGE1) { 
      updatedKineticEnergy = lerp(currentKineticEnergy, KINETIC_ENERGY_MIN*TOTAL_ENERGY, lerpFactor);
      updatedElasticEnergy = lerp(currentElasticEnergy, ELASTIC_ENERGY_MIN*TOTAL_ENERGY, lerpFactor);
    }
    if (ENERGY_SWITCHING_STAGE2) {
      updatedKineticEnergy = lerp(currentKineticEnergy, TOTAL_ENERGY, lerpFactor);
      updatedElasticEnergy = lerp(currentElasticEnergy, 0, lerpFactor);
    }
    speed.setMag(sqrt(2*updatedKineticEnergy/MASS));
    elongation = sqrt(2*updatedElasticEnergy/STIFFNES);

    if (ENERGY_SWITCHING_STAGE2 && updatedElasticEnergy <= 0+ENERGY_OFFSET) {
      ENERGY_SWITCHING_STAGE2 = false;
      ENERGY_SWITCHING_STAGE1 = false;
      totalEnergyDefined = false;
      ENERGY_SWITCHING_FINISHED = true;
      println("Switching energy ended.");
      println(speed);
    }

    if (ENERGY_SWITCHING_STAGE1 && updatedElasticEnergy >= TOTAL_ENERGY*ELASTIC_ENERGY_MIN-ENERGY_OFFSET) {
      ENERGY_SWITCHING_STAGE2 = true;
      ENERGY_SWITCHING_STAGE1 = false;
      println("Reversing energy switching.");
    }
  }
}
