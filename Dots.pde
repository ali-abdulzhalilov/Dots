ArrayList<PVector> dots;
float[][] dists;
ArrayList<Edge> edges;

void setup() {
  size(640, 480);
  
  dots = generateDots(20);
  dists = generateDists(dots);
  edges = generateEdges();
}

ArrayList<PVector> generateDots(int num) {
  int offset = 50;
  ArrayList<PVector> res = new ArrayList<PVector>();
  
  for (int i=0; i<num; i++) {
    float x = random(width-2*offset)+offset;
    float y = random(height-2*offset)+offset;
    res.add(new PVector(x, y));
    println(res.get(i).x +" "+ res.get(i).y);
  }
  
  return res;
}

float[][] generateDists(ArrayList<PVector> dots) {
  float[][] res = new float[dots.size()][dots.size()];
  
  for (int i=0; i<dots.size(); i++) {
    PVector dot_from = dots.get(i);
    for(int j=0; j<dots.size(); j++) {
      PVector dot_to = dots.get(j);
      res[i][j] = (i==j) ? width+height : dist(dot_from.x, dot_from.y, dot_to.x, dot_to.y);
      print(res[i][j]+" ");
    }
    println();
  }
  
  return res;
}

ArrayList<Edge> generateEdges() {
  ArrayList<Edge> res = new ArrayList<Edge>();
  
  for (int i=0; i<dots.size(); i++) {
    PVector dot_from = dots.get(i);
    for(int j=0; j<dots.size(); j++) {
      PVector dot_to = dots.get(j);
      
      float r = random(0.9);
      float d = dists[i][j];
      float dd = pow(d/(width), 2);
      println(r+" "+d+" "+dd);
      if (r<dd)
        res.add(new Edge(i, j));
    }
  }
  
  return res;
}

void draw() {
  background(0);
  
  noStroke();
  fill(255);
  for (int i=0; i<dots.size(); i++)
    ellipse(dots.get(i).x, dots.get(i).y, 5, 5);
    
  for (int i=0; i<edges.size(); i++)
    edges.get(i).display();
}

class Edge {
  int from; 
  int to;
  
  Edge(int from, int to) {
    this.from = from;
    this.to = to;
  }
  
  void display() {
    PVector dot_from = dots.get(from);
    PVector dot_to = dots.get(to);
    
    stroke(255);
    line(dot_from.x, dot_from.y, dot_to.x, dot_to.y);
  }
}
