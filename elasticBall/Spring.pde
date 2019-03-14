class Spring {

  float restPosition;
  float stiffnes;
  float elongation = 0;
  float springLength;
  public Spring(float restPosition, float stiffness ) { 
    this.restPosition = restPosition;
    this.stiffnes = stiffness;
  }
  
  public float getForceMag(){
     return elongation*stiffnes;
  }
  
  public void update(PVector bobPosition, PVector anchorPosition){
    PVector diference = PVector.sub(bobPosition,anchorPosition);
    elongation = restPosition - diference.mag();
    springLength = restPosition-elongation;
    elongation = constrain(elongation,-2,2 );
  }
  
}
