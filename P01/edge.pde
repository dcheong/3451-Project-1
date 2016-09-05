void drawEdge(edge e) {
   line(e.A.x,e.A.y,e.B.x,e.B.y);
}
void drawShape(edge a, edge b) {
  beginShape();
  vertex(a.A.x,a.A.y);
  vertex(a.B.x,a.B.y);
  vertex(b.B.x,b.B.y);
  vertex(b.A.x,b.A.y);
  endShape(CLOSE);
}

class edge
  {
    pt A;
    pt B;
    edge(){}
    edge(pt A, pt B) {this.A = A; this.B = B;}
    edge(float x1, float y1, float x2, float y2) {
      this.A = new pt(x1,y1);
      this.B = new pt(x2,y2);
    }
    
      
  }