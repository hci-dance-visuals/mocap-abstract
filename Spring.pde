
class Spring extends VerletSpring3D {

  Spring(Particle a, Particle b, float w) {
    super(a, b, w, 1);
  }
  
  void display() {
    stroke(255,255,255,40);
    strokeWeight(1);
    line(a.x, a.y, a.z, b.x, b.y, b.z);
  } 
}
