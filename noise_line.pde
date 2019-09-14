
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float x1 = 0; 
float y1 = 0; 
float z1 = 0; 

float x2 = 0; 
float y2 = 0; 
float z2 = 0; 

float xp1 = 0; 
float yp1 = 0; 
float zp1 = 0; 

float xp2 = 0; 
float yp2 = 0; 
float zp2 = 0; 

int dON = 0;
int cON = 0;

int cue = 0;

void setup(){
    oscP5 = new OscP5(this,12345);

  size(1400, 800); 
  background(0);

}


void draw(){
 xp1 = x1;
 yp1 = y1;
 zp1 = z1;

// x1 = mouseX;
// y1 = mouseY;

 xp2 = x2;
 yp2 = y2;
 // x2 = mouseX;
 // y2 = mouseY;
 
 if (dON == 1){
   float xr1 = 0;
   float yr1 = 0;
   float zr1 = 0;
   
   stroke(255);
   strokeWeight(2);

    //line(x1,y1,z1,xp1,yp1,zp1);  
    //line(x1 + 3,y1 + 3,z1 + 3,xp1 + 3,yp1 + 3,zp1 + 3);  
    //line(x1 + 1,y1 + 2, z1 + 1, xp1 + 1,yp1 + 2,zp1 + 1);  
     noStroke();
     fill(255, 20);
    ellipse(x1,y1,20,20);

   float Drnd = 80;
   for (int i = 0; i <= 6; i ++){
     xr1 = x1 + (Drnd/2) - random(Drnd);
     yr1 = y1 + (Drnd/2) - random(Drnd);
     zr1 = z1 + (Drnd/2) - random(Drnd);
     

     stroke(0);
     strokeWeight(20);
     //line(x1,y1,z1,xp1,yp1,zp1);

     stroke(255);
     strokeWeight(1);
     if(x1 != xp1 || y1!= yp1){
     line(x1 + (Drnd/2) - random(Drnd),y1 + (Drnd/2) - random(Drnd),
     x1 + (Drnd/2) - random(Drnd),y1 + (Drnd/2) - random(Drnd));
     }
   }
 
 }
 
 if (cON == 1){
   stroke(0);
   strokeWeight(4);
    fill(0,0,0);
   ellipse(x2,y2,80,80);

  // line(x2,y2,z2,xp2,yp2,zp2);
 }
 

 
  
}


void keyPressed(){
  if (key == '1'){
    if(dON == 0){
      dON = 1;
    }else{
      dON = 0;
    }
  }
  
  if (key == '2'){
    if(cON == 0){
      cON = 1;
    }else{
      cON = 0;
    }
  }     
  if(key == 'e'){
  background(0);
  }
  if(key == ' '){
   cue = cue + 1;
   println("CUE : " + cue);
   }
   if(key == 'b'){
   cue = cue - 1;
   println("CUE : " + cue);
   }
}

void oscEvent(OscMessage theOscMessage) {
   if (theOscMessage.checkAddrPattern("/p1")==true) {
      x1 = map(theOscMessage.get(0).floatValue(),-4,4,0,width);  
      y1 = map(theOscMessage.get(1).floatValue(),0,2,height,0);  
     // z1 = map(theOscMessage.get(2).floatValue(),-4,4,0,0);  
     z1 = -20;
   }
  if (theOscMessage.checkAddrPattern("/v1")==true) {
      x2 = map(theOscMessage.get(0).floatValue(),-4,4,0,width);  
      y2 = map(theOscMessage.get(1).floatValue(),0,2,height,0);  
     // z1 = map(theOscMessage.get(2).floatValue(),-2,2,0,width);  
     // println(x2);
     // println(y2);
   }
  
 
 
}
