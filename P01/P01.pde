// Template for 2D projects
// Author: Jarek ROSSIGNAC
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
  //P.resetOnCircle(8); // sets P to have 4 points and places them in a circle on the canvas
  P.loadPts("data/pts");  // loads points form file saved with this program
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    background(white); // clear screen and paints white background
    pt A=P.G[0], B=P.G[1], C=P.G[2], D=P.G[3];     // crates points with more convenient names 
    
    pen(black,3); fill(yellow); P.drawCurve(); P.IDs(); // shows polyloop with vertex labels
    stroke(red); pt G=P.Centroid(); show(G,10); // shows centroid
    vec PD=R(V(100,0),P.alignentAngle(G)); pt S = P(G,PD); pt E = P(G,-1.,PD); edge(S,E);  // shows principal direction
    pen(black,2); showId(A,"A"); showId(B,"B"); showId(C,"C"); showId(D,"D");
    t += 0.01;
    if (t >= 1) {
      t = 0.1;
    }
    
    vec AB=V(A,B), AC=V(A,C);                      // creates vectors with clear names
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
    pen(red,2); showSpiral(B,D,C);  
    pen(green,5); arrow(A,B);            // defines line style wiht (5) and color (green) and draws starting arrow from A to B
    pen(red,5); arrow(A,C);              // draws ending arrow in red


  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  