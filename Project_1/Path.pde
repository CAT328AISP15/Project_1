public class Path
{
  PVector m_begin;
  PVector m_end;
  float m_radius;
  
  Path()
  {
    m_radius = 25;
    
    m_begin = new PVector(0, height/4);
    m_end = new PVector(width+5, 3*height/4);
  }
  
  void display() //used to show path for debugging
  {
    strokeWeight(80);
    stroke(0, 100);
    line(m_begin.x, m_begin.y, m_end.x, m_end.y);
    strokeWeight(1);
    stroke(0);
    line(m_begin.x, m_begin.y, m_end.x, m_end.y);
  }
}
