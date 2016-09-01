// Author: Lily Lau, Douglas Cheong
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!

//**************************** global variables ****************************
pts P = new pts(); // class containing array of points, used to standardize GUI
float t=0, f=0;
boolean animate=true, fill=false, timing=false;
boolean lerp=true, slerp=true, spiral=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points

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
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    background(black); // clear screen and paints white background
    pt A=P.G[0], B=P.G[1], C=P.G[2], D=P.G[3], E=P.G[4];     // crates points with more convenient names 
    
    //pen(black,3); fill(yellow); P.drawCurve(); P.IDs(); // shows polyloop with vertex labels
    //stroke(red);
    pt G=P.Centroid(); show(G,10); // shows centroid
    //vec PD=R(V(100,0),P.alignentAngle(G)); pt S = P(G,PD); pt E = P(G,-1.,PD); edge(S,E);  // shows principal direction
    
    
    
    pen(green, 1);
    
    edge AB = new edge(A,B);
    edge BC = new edge(B,C);
    edge CD = new edge(C,D);
    edge DA = new edge(D,A);
    edge x = W(AB,BC,t,5);
    //line(AB.A.x,AB.A.y,AB.B.x,AB.B.y);
    //line(BC.A.x,BC.A.y,BC.B.x,BC.B.y);
    //line(CD.A.x,CD.A.y,CD.B.x,CD.B.y);
    //line(DA.A.x,DA.A.y,DA.B.x,DA.B.y);
    for (float t = 0.1; t < 5; t+=0.05) {
      edge wiper = W(x,BC,t,5);
      edge wiper2 = W(x,DA,t,5);
      edge wiper3 = W(wiper,wiper2,t,5);
      line(wiper.A.x,wiper.A.y,wiper.B.x,wiper.B.y);
      line(wiper2.A.x,wiper2.A.y,wiper2.B.x,wiper2.B.y);
      line(wiper3.A.x,wiper3.A.y,wiper3.B.x,wiper3.B.y);
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

  pen(black,2); showId(A,"A"); showId(B,"B"); showId(C,"C"); showId(D,"D");
  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(white); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  