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