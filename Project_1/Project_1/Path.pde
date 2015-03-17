//Foundation of this code came from www.natureofcode.come

public class Path
{
  
  ArrayList<PVector> _points;
  
  public PVector _start;
  public PVector _end;
  
  public float _radius;
  
  Path()
  {
    _radius = 20;
    _start = new PVector(50, 50);
    _end = new PVector(50, height - 100);
    
    _points = new ArrayList<PVector>();
  }
  
  void addPoint(float x, float y)
  {
    PVector point = new PVector(x, y);
    _points.add(point); 
  }
  
  void display()
  {
    /*
    strokeWeight(_radius * 2);
    stroke(0, 100);
    line(_start.x, _start.y, _end.x, _end.y);
    strokeWeight(1);
    stroke(0);
    line(_start.x, _start.y, _end.x, _end.y);
    */
    
    stroke(0);
    noFill();
    beginShape();
    for(PVector v : _points)
    {
      vertex(v.x, v.y); 
    }
    endShape();
    
  }
}
