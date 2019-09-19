class MyCanvas  {
 
  Particle[][] particles;
  ArrayList<Spring> springs;
  ArrayList<SavedDots> savedDots;
  VerletPhysics3D physics;
  Vec3D gravity;
  GravityBehavior3D gb;
  int cols;
  int rows;
  float w;
   
  float osc = 0;
  float x = 0;
  float y = 0;
  float z = 0;
  PImage source;
  PGraphics img;
 
  int draw = 0;
  color drawcol = color(255,0,0);
  
  int rr = 20;
  int rg = 20;
  int rb = 20;
  
  int tr = 120;
  int tg = 120;
  int tb = 120;
  float lastDrX = 0;
  float lastDrY = 0; 
  
  MyCanvas(int cols_, int rows_, float w_, int px,int py, int pz){
    cols = cols_;
    rows = rows_;
    w = w_;
     //particles = new Particle[cols][rows];
    springs = new ArrayList<Spring>();
    particles = new Particle[cols][rows];
    savedDots = new ArrayList<SavedDots>();
    physics = new VerletPhysics3D();
    
    gravity = new Vec3D(0, 1, 0);
    gb = new GravityBehavior3D(gravity);
    physics.addBehavior(gb);
    
    //create the net of particles
    x = px;
    y = py;
    z = pz;
    float cx = x;
    float cy = y;
    float cz = z;

    for (int i = 0; i < cols; i++) {
      float z = 0;
      for (int j = 0; j < rows; j++) {
        if ((i == cols-1) && (j == rows-1)){
          Particle p = new Particle(cx, cy, cz);
          particles[i][j] = p;
          physics.addParticle(p);
        }else if ((i == 0) && (j == rows-1)){
          Particle p = new Particle(cx, cy, cz);
          particles[i][j] = p;
          physics.addParticle(p);
        }else{
          Particle p = new Particle(cx, cy + j * w, cz);
          particles[i][j] = p;
          physics.addParticle(p);
        }
      }
    cx = cx + w;
    }
    particles[0][0].lock();
    particles[cols-1][0].lock();
    
    
    //connect the particles
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        Particle a = particles[i][j];
        if (i != cols-1) {
          Particle b1 = particles[i+1][j];
          Spring s1 = new Spring(a, b1, w);
          springs.add(s1);
          physics.addSpring(s1);
        }
        if (j != rows-1) {
          Particle b2 = particles[i][j+1];
          Spring s2 = new Spring(a, b2, w);
          springs.add(s2);
          physics.addSpring(s2);
          }
        }
      }  
    
  }
     //  ----------------------- 
     //  ----------------------- 
     //  ----------------------- 
   void loadImg(String in){
     source = loadImage(in);
     source.loadPixels();
     source = Sharpen.apply(source, 10);
     img = createGraphics(source.width, source.height);
     
     int n = 0;
   for(int i = 0; i < source.width; i ++){
    for(int j = 0; j < source.height ; j ++){
      int loc = i+j*source.width;
      int outi = int(map(i, 0, source.width, 0, img.width));
      int outj = int(map(j, 0, source.height, 0, img.height));
      float r = red(source.pixels[loc]);
      float g = green(source.pixels[loc]);
      float b = blue(source.pixels[loc]);

      if (r > 60 && g < 10 && b < 10 ){  
        SavedDots p = new SavedDots(outi, outj,int(r),int(g),int(b));      
        savedDots.add(p);
        //println("r g b: " + r + " " +  g + " " + b + " ");
        n++;
        }
      if (g > 60 && r < 10 && b < 10 ){  
        SavedDots p = new SavedDots(outi, outj,int(r),int(g),int(b));      
        savedDots.add(p);
        //println("r g b: " + r + " " +  g + " " + b + " ");
        n++;
        }
       if (b > 60 && r < 10 && r < 10 ){  
        SavedDots p = new SavedDots(outi, outj,int(r),int(g),int(b));      
        savedDots.add(p);
        //println("r g b: " + r + " " +  g + " " + b + " ");
        n++;
        }
      }       
      }
     //println("n: " + n );
   }
   
   
   void updateImg() { 
     img.beginDraw();
     img.fill(10,0);
     //img.ellipse(img.width/2,img.height/2,img.width, img.height);
     for (SavedDots s : savedDots){
     // int loc = i+j*source.width;
      int outi = s.x;
      int outj = s.y;
      float r = s.r;
      float g = s.g;
      float b = s.b;

      if (r > 20 && g < 150 && b < 150){
        img.noStroke();
        img.fill(255,0,0,tr); 
        img.ellipse(outi, outj, rr, rr);
      } 
      if (g > 20 && r < 150 && b < 150){
        img.noStroke();
        img.fill(0,255,0,tg); 
        img.ellipse(outi, outj, rg, rg);
      } 
      if (b > 20 && r < 150 && b < 150){
        img.noStroke();
        img.fill(0,0,255,50); 
        img.ellipse(outi, outj, rb, rb);
      } 
    }
    img.endDraw();
    
    }

    void changeRr (int rr_){
      rr = rr_;
    }

    void changeRg (int rg_){
      rb = rg_;
    }
     void changeRb (int rb_){
      rg = rb_;
    }
    void diplayNet(){
        physics.update();
        for (Spring s : springs) {
         s.display();
      }
    }
    
    void displayIMG(){
      float t = 1;
      specular(t, t, t);
      noFill();
      noStroke();
      textureMode(NORMAL);
      for (int j = 0; j < rows-1; j++) {
        beginShape(TRIANGLE_STRIP);
        texture(img);
        //tint(255, 10);
        for (int i = 0; i < cols; i++) {
          float x1 = particles[i][j].x;
          float y1 = particles[i][j].y;
          float z1 = particles[i][j].z;
          float u = map(i, 0, cols-1, 0, 1);
          float v1 = map(j, 0, rows-1, 0, 1);
          vertex(x1, y1, z1, u, v1);
          float x2 = particles[i][j+1].x;
          float y2 = particles[i][j+1].y;
          float z2 = particles[i][j+1].z;
          float v2 = map(j+1, 0, rows-1, 0, 1);
          vertex(x2, y2, z2, u, v2);
          //color pix = source.get(x1, y2);
        }
      endShape();
      }
    }

    
    
    
    
    
    void mouseMove(int x, int y){
       particles[0][0].move(x,y);
    }    
    void setGravity(float x, float y, float z){
       Vec3D gravity_ = new Vec3D(x,y,z);
       gravity = gravity_;
    }  
    
    void oscillateX(float osc_){
      osc = osc + osc_;
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          Vec3D myMove = new Vec3D(30*osc_*sin(i + osc),0,0);
          particles[i][j].addForce(myMove);
        }
      }
    }

    void oscillateY(float osc_){
      osc = osc + osc_;
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          Vec3D myMove = new Vec3D(0,30*osc_*sin(i + osc),0);
          particles[i][j].addForce(myMove);
        }
      }
    }   
    
    void oscillateZ(float osc_){
      osc = osc + osc_;
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          Vec3D myMove = new Vec3D(0,0,30*osc_*sin(i + osc));
          particles[i][j].addForce(myMove);
        }
      }
    }
 
  void rndX(float in){
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          Vec3D myMove = new Vec3D((in/2)-random(in),0,0);
          particles[i][j].addForce(myMove);
        }
      }
    }
    
  void rndY(float in){
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          Vec3D myMove = new Vec3D(0,(in/2)-random(in),0);
          particles[i][j].addForce(myMove);
        }
      }
    }
   void rndZ(float in){
      for (int i = 0; i < cols; i++) {
        for (int j = 0; j < rows; j++) {
          Vec3D myMove = new Vec3D(0,0,(in/2)-random(in));
          particles[i][j].addForce(myMove);
        }
      }
   }  
      
   //---------------------------
   //---------------------------
   //---canvasDraw--------------
   //---------------------------
   
    void canvasDraw(float x, float y, int r, color c){
        stroke(c);
        strokeWeight(15);
        img.line (lastDrX,lastDrY,x,y);
       lastDrX = map(x,0,1,0,img.width);
        lastDrY = map(y,0,1,0,img.height);
  
      img.beginDraw();
      fill(c);
      img.ellipse(map(x,0,1,0,img.width),map(y,0,1,0,img.height),r/2,r/2);
      img.endDraw();
    }
    
    void canvasaddDotes(float x, float y, color c){
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      int outx = int(map(x, 0, 1, 0, img.width));
      int outy = int(map(y, 0, 1, 0, img.height));
      SavedDots p = new SavedDots(outx, outy, int(r),int(g),int(b));      
      savedDots.add(p);

    }
    
    void w(float w_){
    w = w_;
    
    
    float cx = x;
    float cy = y;
    float cz = z;

    for (int i = 0; i < cols; i++) {
      float z = 0;
      for (int j = 0; j < rows; j++) {
        if ((i == cols-1) && (j == rows-1)){
          Particle p = new Particle(cx, cy, cz);
          particles[i][j] = p;
          //physics.addParticle(p);
        }else if ((i == 0) && (j == rows-1)){
          Particle p = new Particle(cx, cy, cz);
          particles[i][j] = p;
          //physics.addParticle(p);
        }else{
          Particle p = new Particle(cx, cy + j * w, cz);
          particles[i][j] = p;
          //physics.addParticle(p);
        }
      }
    cx = cx + w;
    }
    particles[0][0].lock();
    particles[cols-1][0].lock();
    
    
    //connect the particles
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        Particle a = particles[i][j];
        if (i != cols-1) {
          Particle b1 = particles[i+1][j];
          Spring s1 = new Spring(a, b1, w);
          springs.add(s1);
          physics.addSpring(s1);
        }
        if (j != rows-1) {
          Particle b2 = particles[i][j+1];
          Spring s2 = new Spring(a, b2, w);
          springs.add(s2);
          physics.addSpring(s2);
          }
        }
      } 
  
    }
    
    void setColor(color c){
       drawcol = c;
    }
    
        
    void drawON(int in){
      draw = in;
    }
    
    void mouveVertex(float x_, float y_){   
      particles[0][0].x = x_;
      particles[0][0].y = y_;
    }
    
    void mouveVerte3D(float x_, float y_, float z_){
      x = x_;
      y = y_;
      z = z_;
      
      particles[0][0].x = x_;
      particles[0][0].y = y_;
      particles[0][0].z = z_;
      particles[rows-1][0].x = x_ + (rows * w);
      particles[rows-1][0].y = y_;
      particles[rows-1][0].z = z_;
  }
    
  void mouveVertex1(float x_, float y_, float z_){
      x = x_;
      y = y_;
      z = z_;
      
      particles[0][0].x = x_;
      particles[0][0].y = y_;
      particles[0][0].z = z_;
      }
      
 void mouveVertex2(float x_, float y_, float z_){
      x = x_;
      y = y_;
      z = z_;      
      particles[rows-1][0].x = x_;
      particles[rows-1][0].y = y_;
      particles[rows-1][0].z = z_;
      }   
      
   void oscillateLeft(float osc_){
      osc = osc + osc_;
      //Vec3D myMove = new Vec3D(30000*osc_*sin(osc),0,0);
      particles[0][raw-1].x += 300*osc_*sin(osc);
      particles[0][raw-1].y += 300*osc_*cos(osc);
      particles[0][raw-1].z += 300*osc_*sin(osc);

  }
     void oscillateReight(float osc_){
      osc = osc + osc_;
      //Vec3D myMove = new Vec3D(30000*osc_*sin(osc),0,0);
      particles[col-1][raw-1].x += 300*osc_*sin(osc);
      particles[col-1][raw-1].y += 300*osc_*cos(osc);
      particles[col-1][raw-1].z += 300*osc_*sin(osc);

  }
  
  
  void moveColR(int x_, int y_){
  
  
  }
}
