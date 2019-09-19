import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.geom.*;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

import milchreis.imageprocessing.*;
int numberOfCanvas = 1;
MyCanvas[] canvasTest = new MyCanvas[numberOfCanvas];
float[] positions = new float[15];
float speed = 100;

float danceX = - 500;
float danceY = 0;
float danceZ = 0;


float[] ahead = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
float[] moves = {0,0,0,0,0};
float[] firstplan = {0,0,0,0,0};

int draw = 0;

int col = 25;
int raw = 25;
int d = 15;
int posinit = -1500;



void setup() {
  size(1400, 800, P3D); 
  
  oscP5 = new OscP5(this,12346);
  myRemoteLocation = new NetAddress("127.0.0.1",12346);
  for(int i = 0; i < numberOfCanvas; i++){
  canvasTest[i] = new MyCanvas(col,raw,d,col*d*i,0, posinit);
  }
  for (int i = 0; i < numberOfCanvas; i++){
    positions[i] = canvasTest[i].x;
    positions[i + 1] = canvasTest[i].y;
    positions[i + 2] = canvasTest[i].z;    
    //println("x, y, z = " + positions[i] + ", " + positions[i + 1] + ", "  + positions[i + 2]);
  }
  
  background(1);
  canvasTest[0].loadImg("A1.jpg");
  //canvasTest[1].loadImg("A2.jpg");
  //canvasTest[2].loadImg("A3.jpg");
  //canvasTest[3].loadImg("A4.jpg");
  //canvasTest[4].loadImg("A5.jpg");    
  for(int i = 0; i < numberOfCanvas; i++){
    canvasTest[i].updateImg();
    }
}


//----------------------------------------------------
//draw-------------------------------------------------
//----------------------------------------------------
 
void draw(){
  background(0,0,0);
  //translate(0);
  strokeWeight(2);
stroke(255);
//fill(127,100);
  noFill();
beginShape();
vertex(0, 0, 0);
vertex(width, 0, 0);
vertex(width, height, 0);
vertex(0, height, 0);
endShape(CLOSE);

 /// line(0,0,-300,0,500,-300);
  for(MyCanvas c : canvasTest){
   c.diplayNet();
  }
  canvasTest[0].oscillateX(mouseX*0.50/width);
  //canvasTest[1].oscillateY(mouseX*0.50/width);
  //canvasTest[2].oscillateZ(mouseX*0.50/width);
  //canvasTest[3].rndX(mouseX*50/width);
  //canvasTest[4].rndY(mouseX*50/width);
  
  //canvasTest.mouseMove(mouseX, mouseY);


  //canvasTest[2].updateImg();
  //canvasTest[2].rndY(mouseX*100.0/width);
  //canvasTest[2].oscillateLeft(mouseX*0.50/width);
  //canvasTest[2].oscillateReight(mouseX*0.50/width);

 // canvasTest[2].oscillateX(mouseX*0.50/width);

  for(int i = 0; i < numberOfCanvas; i ++){
    
    if(moves[i] > 0){
      //print("sono1ui");
      println("i,  " + i + " " + ahead[i * 3] + " " + ahead[i * 3 + 1] + " " + ahead[i * 3 + 2]  );
      float prevX = canvasTest[i].x + ahead[i * 3];
      float prevY = canvasTest[i].y + ahead[i * 3 + 1];
      float prevZ = canvasTest[i].z + ahead[i * 3 + 2];
     // println("sono1ui " + moves[i]);
  
      moves[i] = moves[i] - 1;
      println("moves[i]  " + moves[i]);
      canvasTest[i].mouveVerte3D(prevX,prevY,prevZ);
    }    
  } 
  
// canvasTest[0].mouveVerte3D(danceX,danceY,danceZ);

  
  for(int i = 0; i < numberOfCanvas; i ++){
    canvasTest[i].displayIMG();
   }
  strokeWeight(2);
  stroke(200);
  
  fill(255,0,0);
  line(0,0,posinit,col*(d)*(canvasTest.length),0,posinit); 
  line(0,0,posinit,0,0,0); 
  line(width,0,0,col*(d)*(canvasTest.length),0,posinit); 
  line(0,height,posinit,col*(d)*(canvasTest.length),height,posinit); 

  line(0,0,posinit,0,height,posinit); 
  line(col*(d)*(canvasTest.length),0,posinit,col*(d)*(canvasTest.length),height,posinit); 

  
  pointLight(255, 0, 0, 0, 0, 0);
  pointLight(0, 0, 255, width, height, 0);

}


void calculateMove(int n, float x, float y, float z, float speed){
println("n " + n);
 
  positions[n * 3] = x;
  positions[n * 3+ 1] = y;
  positions[n * 3+ 2] = z;
  //ahead[n * 3 + 2] = -10;  
  
  ahead[n * 3] = (1.0 * positions[n * 3] - canvasTest[n].x)/ speed;
  ahead[n * 3 + 1] = (1.0 * positions[n * 3 + 1] - canvasTest[n].y)/ speed;
  ahead[n * 3 + 2] = (1.0 * positions[n * 3 + 2] - canvasTest[n].z)/ speed;
  moves[n] = speed;
  println("moves[i]  " + moves[n]);
  println(ahead);
}






void keyPressed(){
   //canvasTest[2].mouveVertex(mouseX,mouseY);
   
  if (key == '1'){
    if(firstplan[0] == 0){
      calculateMove(0, width/2-(col*d)/2, 0, 0, 100);
      firstplan[0] = 1;
    }else{
      calculateMove(0, 0, 0, posinit, 100);
      firstplan[0] = 0;
    }
  }
  if (key == '2'){
   if(firstplan[1] == 0){
      calculateMove(1, width/2-(col*d)/2, 0, 0, 100);
      firstplan[1] = 1;
    }else{
      calculateMove(1, col*d, 0, posinit, 100);
      firstplan[1] = 0;
    }  
  } 
  if (key == '3'){
   if(firstplan[2] == 0){
      calculateMove(2, width/2-(col*d)/2, 0, 0, 100);
      firstplan[2] = 1;
    }else{
      calculateMove(2, col*d, 0, posinit, 100);
      firstplan[2] = 0;
    }  
  } 
  if (key == '4'){
   if(firstplan[3] == 0){
      calculateMove(3, width/2-(col*d)/2, 0, 0, 100);
      firstplan[3] = 1;
    }else{
      calculateMove(3, col*d*2, 0, posinit, 100);
      firstplan[3] = 0;
    }  
  }
  
   if (key == '5'){
   if(firstplan[4] == 0){
      calculateMove(4, width/2-(col*d)/2, 0, 0, 100);
      firstplan[4] = 1;
    }else{
      calculateMove(4, col*d*2, 0, posinit, 100);
      firstplan[4] = 0;
    }  
  }
  

  
}

void mouseDragged(){
  if (canvasTest[0].draw == 1){
    color c = color(255,0,0,10);
  }
  //canvasTest[0].changeRr(int((mouseX)));
  color c = color(255,0,0,10);

  canvasTest[0].canvasDraw((mouseX * 1.0)/width,(mouseY * 1.0)/height, 100, c);
  //canvasTest[0].mouveVerte3D(mouseX,mouseY,posinit);

  //canvasTest[0].updateImg();
    //  canvasTest[2].mouveVertex(mouseX,mouseY);
    //  float prevZ = canvasTest[2].x;
}




//---------------------------------------------
//---------------------------------------------
//---------------------------------------------
//---------------------------------------------



int captdrawOn = 0;
int captdanceOn = 0;

int appdrawOn = 0;
int appdanceOn = 0;

color c = color(255,0,0,100); 

int On = 0;
//---------------------------------------------
//---------------------------------------------
//---------------------------------------------
//---------------------------------------------
//---------------------------------------------
void oscEvent(OscMessage theOscMessage) {
  //println(theOscMessage);
  float piedistallo = 300;
  if (theOscMessage.checkAddrPattern("/captdrawOn")==true){
    captdrawOn = theOscMessage.get(0).intValue(); 
        println("captdrawOn      ONNNNNN!N!N!N!N!NIDUNIEBGCUOEWFSoivuhwe io");

  }

  
  if (theOscMessage.checkAddrPattern("/captdanceOn")==true){
    captdanceOn = theOscMessage.get(0).intValue();  
    println("captdanceOn     ONNNNNN!N!N!N!N!NIDUNIEBGCUOEWFSoivuhwe io");
  }
  
  if (captdanceOn ==1){
 if (theOscMessage.checkAddrPattern("/x1")==true) {
    danceX = map(theOscMessage.get(0).floatValue(),-2,2,0,width);  
    canvasTest[0].particles[0][0].x = danceX;
 }

 
 if (theOscMessage.checkAddrPattern("/y1")==true) {
    danceY = map(theOscMessage.get(0).floatValue(),0,2.5,height,0);  
    canvasTest[0].particles[0][0].y = danceY - piedistallo;
 }
 
  if (theOscMessage.checkAddrPattern("/z1")==true) {
    danceZ = map(theOscMessage.get(0).floatValue(),-2.5,2.5,-500,0);  
    canvasTest[0].particles[0][0].z = danceZ;
 }

 if (theOscMessage.checkAddrPattern("/x4")==true) {
    danceX = map(theOscMessage.get(0).floatValue(),-2,2,0,width);  
    canvasTest[0].particles[raw-1][0].x = danceX;
 }
 
 if (theOscMessage.checkAddrPattern("/y4")==true) {
    danceY = map(theOscMessage.get(0).floatValue(),0,2.5,height,0);  
    canvasTest[0].particles[raw-1][0].y = danceY - piedistallo;
 }
 
  if (theOscMessage.checkAddrPattern("/z4")==true) {
    danceZ = map(theOscMessage.get(0).floatValue(),-2.5,2.5,-500,0);  
    canvasTest[0].particles[raw-1][0].z = danceZ;
 }
 
  if (theOscMessage.checkAddrPattern("/x10")==true) {
    danceX = map(theOscMessage.get(0).floatValue(),-2,2,0,width);  
    canvasTest[0].particles[0][col-1].x = danceX;
 }
 
 if (theOscMessage.checkAddrPattern("/y10")==true) {
    danceY = map(theOscMessage.get(0).floatValue(),0,2.5,height,0);  
    canvasTest[0].particles[0][col-1].y = danceY - piedistallo;
 } 
 
  if (theOscMessage.checkAddrPattern("/z10")==true) {
    danceZ = map(theOscMessage.get(0).floatValue(),-2.5,2.5,-500,0);  
    canvasTest[0].particles[0][col-1].z = danceZ;
 }
 
  if (theOscMessage.checkAddrPattern("/x12")==true) {
    danceX = map(theOscMessage.get(0).floatValue(),-2,2,0,width);  
    canvasTest[0].particles[raw-1][col-1].x = danceX;
 }
 
 if (theOscMessage.checkAddrPattern("/y12")==true) {
    danceY = map(theOscMessage.get(0).floatValue(),0,2.5,height,0);  
    canvasTest[0].particles[raw-1][col-1].y = danceY - piedistallo;
 }
 
  if (theOscMessage.checkAddrPattern("/z12")==true) {
    danceZ = map(theOscMessage.get(0).floatValue(),-2.5,2.5,-500,0);  
    canvasTest[0].particles[raw-1][col-1].z = danceZ;
 }
 }
 
 
 //draw from captury
  if (captdrawOn ==1){
    
    if (theOscMessage.checkAddrPattern("/x1")==true) {
    danceX = map(theOscMessage.get(0).floatValue(),-2,2,0,width);  
    canvasTest[0].particles[0][0].x = danceX;
   }
   if (theOscMessage.checkAddrPattern("/y1")==true) {
    danceY = map(theOscMessage.get(0).floatValue(),0,2.5,height,0);  
    canvasTest[0].particles[0][0].y = danceY - piedistallo;
     }
    canvasTest[0].canvasDraw(danceX/width,danceY/height, 100, 31);
  }
  
  
  //appp
  
    if (theOscMessage.checkAddrPattern("/appdrawOn")==true){
    appdrawOn = theOscMessage.get(0).intValue();  
      println("/appdrawOn " + appdrawOn);

  }

  
  if (theOscMessage.checkAddrPattern("/appdanceOn")==true){
    appdanceOn = theOscMessage.get(0).intValue(); 
    println("/appdanceOn " + appdanceOn);

  }
  
  //draw from app
 if(appdanceOn == 1){
    if (theOscMessage.checkAddrPattern("/Papp")==true) {
      float x = ((theOscMessage.get(0).intValue()/1000.0));
      float y = ((theOscMessage.get(1).intValue()/1000.0));
      x = map(x,0,1,0,width);
      y = map(y,0,1,0,height);
      println("x,y: " + x + " " + y);

    canvasTest[0].mouveVerte3D(x,y,posinit);
     }
 }
 
  if(appdrawOn == 1){
    if (theOscMessage.checkAddrPattern("/Papp")==true) {
      float x = ((theOscMessage.get(0).intValue()/1000.0));

      float y = ((theOscMessage.get(1).intValue()/1000.0));
      color c = color(255,0,0);
      canvasTest[0].canvasDraw(x, y, 100, c);
      canvasTest[0].updateImg();

     }
 }
 String in = theOscMessage.addrPattern();
 int checkBitalino = int(in.substring(1,2));
 //println(checkBitalino == 0);
 if (checkBitalino == 0){
   //println(in);
   String inI = in.substring(in.indexOf(" ")+1, in.length()-1);
   //println(inI);
   float inInt = map(1.0*int(inI)/1200,0.4,0.7,0,2);
   //println(inInt);
   //println((1.0*inInt/1000));
   //canvasTest[0].oscillateX(inInt);
  }

}
