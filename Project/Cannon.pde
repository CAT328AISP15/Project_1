class Cannon extends Mover
{
   
  float radius, sight, red, green, blue;
    
  Cannon(float xCoordinate, float yCoordinate)
  {
      super(xCoordinate, yCoordinate);
      velocity = new PVector(0, 2);
      mass = 1;
      maxForce = .9;
      maxSpeed = 4;
      radius = 20;
      sight = 300;
      red = 233;
      green = 100;
      blue = 55;
  }
  
  void update()
  {
    super.update();
  }
  
  void construct()
  {
    fill(red, green, blue);
    ellipse(location.x, location.y, radius, radius);
  }
  
  PVector getLocation()
  {
    return super.getLocation();
  }
  
}
