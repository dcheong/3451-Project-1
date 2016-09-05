

// Author: Lily Lau, Douglas Cheong
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//**************************** global variables ****************************
pts P = new pts(); // class containing array of points, used to standardize GUI
float t=0, f=0;
boolean animate=true, fill=false, timing=false;
boolean drift = true;
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points
boolean up = true;
color c = color(255,0,255);
pt A, B, C, D;
pt tL, tR, bL, bR;
edge top, left, right, bottom;
edge colorInitial = new edge(new pt(0,0), new pt(255, 0));
edge colorFinal = new edge(new pt(255,255), new pt(0, 255));

Minim minim;
AudioPlayer song;
float volume = 0.;
boolean incAngle = true;



//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(800, 800);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  
  noCursor();
  
  myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  P.declare(); // declares all points in P. MUST BE DONE BEFORE ADDING POINTS 
  //P.resetOnCorners();
  P.resetOnCircle(4); // sets P to have 4 points and places them in a circle on the canvas
  //P.loadPts("data/pts");  // loads points form file saved with this program
  A = P.G[0];
  B = P.G[1];
  C = P.G[2];
  D = P.G[3];
  //initialize corner points
  tL = new pt(0,0);
  tR = new pt(width, 0);
  bL = new pt(0, height);
  bR = new pt(width, height);
  //initialize screen edges
  top = new edge(tL, tR);
  left = new edge(bL, tL);
  right = new edge(tR, bR);
  bottom = new edge(bR, bL);
  
  P.scaleAllAroundCentroid(0.75);
  
  minim = new Minim(this);
  song = minim.loadFile("data/song.mp3");
  song.loop();
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
    P.moveAll(new vec(mouseX - P.Centroid().x, mouseY - P.Centroid().y)); //make the points follow the mouse
    volume = (song.left.level() + song.right.level()) / 2;
    background(white); // clear screen and paints white background
    

    edge AB = new edge(A,B);
    edge BC = new edge(B,C);
    edge CD = new edge(C,D);
    edge AD = new edge(D,A);
    edge e1 = W(AB,BC,t,5);
    edge e2 = W(BC,CD,t,5);
    edge e3 = W(CD,AD,t,5);
    edge e4 = W(AD,AB,t,5);
    //line(AB.A.x,AB.A.y,AB.B.x,AB.B.y);
    //line(BC.A.x,BC.A.y,BC.B.x,BC.B.y);
    //line(CD.A.x,CD.A.y,CD.B.x,CD.B.y);
    //line(DA.A.x,DA.A.y,DA.B.x,DA.B.y);
    edge[] edges1 = new edge[50];
    edge[] edges2 = new edge[50];
    edge[] edges3 = new edge[50];
    edge[] edges4 = new edge[50];
    for (int index = 0; index < edges1.length; index++) {
      float t = (float)index/(float)edges1.length;
      edges1[index] = W(e1,right,t,1);
      edges2[index] = W(e2,bottom,t,1);
      edges3[index] = W(e3,left,t,1);
      edges4[index] = W(e4,top,t,1);
    }
    for (int i = 1; i < edges1.length; i++) {
      edge colorCurrent = W(colorInitial, colorFinal, i/10., 10);
      noStroke();
      fill(color(colorCurrent.A.x * volume,colorCurrent.B.x * volume,255 * volume));
      drawShape(edges1[i],edges1[i-1]);
      drawShape(edges2[i],edges2[i-1]);
      drawShape(edges3[i],edges3[i-1]);
      drawShape(edges4[i],edges4[i-1]); 
    }
    for (int i = 0; i < edges1.length; i++) {
      pen(color(255,255,255,10), 1);
      if (i < volume * edges1.length) {
        pen(white, 1);
      }
        drawEdge(edges1[i]);
        drawEdge(edges2[i]);
        drawEdge(edges3[i]);
        drawEdge(edges4[i]);
    }
    t += volume/5;
    //pt At = spiralA(A,B,D,C,t);
    //pt Bt = spiralB(A,B,D,C,t);
    //pt Ct = spiralA(B,C,A,D,t);
    //pt Dt = spiralB(B,C,A,D,t);
    //line(At.x,At.y,Bt.x, Bt.y);
    //line(Ct.x, Ct.y, Dt.x, Dt.y);
    
    /*
    if(lerp) 
      {
      pen(cyan,3); 
      fill(cyan); scribeHeader("1-LERP",3); 
      vec V=L(V(A,B),V(A,C),t); 
      arrow(A,P(A,V));
      }
    if(slerp) 
      {
      pen(magenta,3); 
      fill(magenta); 
      scribeHeader("2-SLERP",4); 
      vec V=slerp(V(A,B),t,V(A,C)); 
      arrow(A,P(A,V));
      }
    if(spiral) 
      {
      pen(blue,3); 
      fill(blue); 
      scribeHeader("3-SPIRAL",5); 
      vec V=S(V(A,B),V(A,C),t); 
      arrow(A,P(A,V));
      }
     */
    //pen(red,2); showSpiral(B,D,C);  
    //pen(green,5); arrow(A,B);            // defines line style wiht (5) and color (green) and draws starting arrow from A to B
    //pen(red,5); arrow(A,C);              // draws ending arrow in red

  //pen(white,2); showId(A,"A"); showId(B,"B"); showId(C,"C"); showId(D,"D");
  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(white); displayHeader(); // displays header
  //if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  