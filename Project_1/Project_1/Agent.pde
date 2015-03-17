//Foundation of this code came from www.natureofcode.come

class Agent
{
  PVector _pos;
  PVector _accel;
  PVector _vel;
 
  int _topSpeed;
 
  Agent(PVector pos)
  {
    _pos = pos;
    _accel = new PVector();
    _vel = new PVector(0,0);
    _topSpeed = 5;
  }
  
  void display()
  {
    stroke(255);
    fill(0); 
  }
  
  void update()
  {
    checkEdges();
   
    _vel.add(_accel);
    _vel.limit(_topSpeed);
    _pos.add(_vel);
    _accel.mult(0); 
  }
  
  void addForce(PVector force)
  {
    _accel.add(force); 
  }
  
   //http://natureofcode.com/book/chapter-2-forces/ Checking Boundaries
   
   public void checkEdges()
   {
      if(_pos.x > width)
      {
        _pos.x = width;
        _vel.x *= -1; 
      }
      else if(_pos.x < 0)
      {
        _vel.x *= -1;
        _pos.x = 0; 
      }
      
      if(_pos.y > height) {
        _vel.y *= -1;
        _pos.y = height; 
      }
      else if(_pos.y < 0) {
        _vel.y *= -1;
        _pos.y = 0; 
      }
       
   }
}
