//Foundation of this code came from www.natureofcode.come

class ControlledAgent extends Agent
{
  Boolean _movedRight;
  Boolean _movedUp;
  
  float _speed;
  
  ControlledAgent(PVector pos)
  {
    super(pos);
    _movedRight = false;
    _movedUp = false;
  
    _speed = 5.0f; 
  }
  
  void display()
  {
    super.display();
    ellipse(_pos.x, _pos.y, 32, 32); 
  }
  
  void update()
  {
    super.update();
    
    detectMovement();
   
    if(_movedRight)
       _vel.x += 1;
    if(!_movedRight)
       _vel.x -= 1;
    if(_movedUp)
        _vel.y -= 1;
    if(!_movedUp)
        _vel.y += 1;
  }
  
  void detectMovement()
  {
    if(key == CODED)
    {
      if(keyCode == LEFT)
        _movedRight = false;
      if(keyCode == RIGHT)
        _movedRight = true;
      if(keyCode == UP)
        _movedUp = true;
      if(keyCode == DOWN)
        _movedUp = false;
    } 
  }
}
