
class Particle extends VerletParticle3D {
 int cycleIndex = 0;
  Particle(float x, float y, float z) {
    super(x, y, z);
  }
  void loc(float x_, float y_, float z_){
    x = x_;
    y = y_;
    z = z_;
  }
  
  void display(float x_, float y_, float z_) {
    pushMatrix();

      //translate(x + x_,y + y_,z + z_);
    
    popMatrix();
  }
  

  
  void move(int x_, int y_){
    x = x_;
    y = y_;
  }  
  

}
