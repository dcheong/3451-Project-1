// Author: Lily Lau, Douglas Cheong
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!

//**************************** global variables ****************************
pts P = new pts(); // class containing array of points, used to standardize GUI
float t=0, f=0;
boolean animate=true, fill=false, timing=false;
boolean lerp=true, slerp=true, spiral=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points
boolean up = true;
color c = color(255,0,255);
pt A, B, C, D;
pt tL, tR, bL, bR;
edge top, left, right, bottom;
edge colorInitial = new edge(new pt(0,0), new pt(255, 0));
edge colorFinal = new edge(new pt(255,255), new pt(0, 255));

//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(800, 800);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
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
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    background(black); // clear screen and paints white background
    //pt A=P.G[0], B=P.G[1], C=P.G[2], D=P.G[3];     // crates points with more convenient names 
    
    
    
    //pen(black,3); fill(yellow); P.drawCurve(); P.IDs(); // shows polyloop with vertex labels
    //stroke(red);
    //pt G=P.Centroid(); show(G,10); // shows centroid
    //vec PD=R(V(100,0),P.alignentAngle(G)); pt S = P(G,PD); pt E = P(G,-1.,PD); edge(S,E);  // shows principal direction
   
    pen(green, 1);
    
    edge AB = new edge(A,B);
    edge BC = new edge(B,C);
    edge CD = new edge(C,D);
    edge AD = new edge(D,A);
    //line(AB.A.x,AB.A.y,AB.B.x,AB.B.y);
    //line(BC.A.x,BC.A.y,BC.B.x,BC.B.y);
    //line(CD.A.x,CD.A.y,CD.B.x,CD.B.y);
    //line(DA.A.x,DA.A.y,DA.B.x,DA.B.y);
    edge[] edges1 = new edge[30];
    edge[] edges2 = new edge[30];
    edge[] edges3 = new edge[30];
    edge[] edges4 = new edge[30];
    for (float t = 0; t < 3; t+=0.1) {
      System.out.println((int)(t*10));
      int index = (int)(t * 10);
      edges1[index] = W(AB,right,t,3);
      edges2[index] = W(BC,bottom,t,3);
      edges3[index] = W(CD,left,t,3);
      edges4[index] = W(AD,top,t,3);
      pen(color(255.*t/5.,255-(255.*t/10.),255),1);
      drawEdge(edges1[index]);
      drawEdge(edges2[index]);
      drawEdge(edges3[index]);
      drawEdge(edges4[index]);
    }
    for (int i = 1; i < edges1.length; i++) {
      edge colorCurrent = W(colorInitial, colorFinal, i/10., 10);
      fill(color(colorCurrent.A.x,colorCurrent.B.x,255));
      System.out.println(i);
      drawShape(edges1[i],edges1[i-1]);
      drawShape(edges2[i],edges2[i-1]);
      drawShape(edges3[i],edges3[i-1]);
      drawShape(edges4[i],edges4[i-1]);
    }
    t += 0.1;
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

  pen(white,2); showId(A,"A"); showId(B,"B"); showId(C,"C"); showId(D,"D");
  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(white); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  