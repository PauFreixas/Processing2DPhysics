class Spring {

  float restPosition;        //Rest distance of the spring
  float stiffnes;            //Stiffness is the K of Hooks Law
  float elongation = 0;      //How much diference between restPosition and actual length
  float amplitude;           //Amplitude of the swing movement
  float springLength;        //Actual spring length
  
  
  public Spring(float restPosition, float stiffness ,float amplitude) { 
    this.restPosition = restPosition;
    this.stiffnes = stiffness;
    this.amplitude = amplitude;
  }
  
  //Method we use to get the Hooks Law Forces
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
