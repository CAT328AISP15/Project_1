//Tracker is mainly used to either flee or seek some PVector, green light shows its close to and traveling toward
//                                                             red light shows its too close to a predator and trying to move in the opposite direction
class Tracker extends Mover
{
  float radius, sight, red, green, blue;
    
  Tracker(float xCoordinate, float yCoordinate)
  {
      super(xCoordinate, yCoordinate);
      velocity = new PVector(0, 0);
      mass = 1;
      maxForce = .9;
      maxSpeed = 4;
      radius = 20;
      sight = 300;
      red = 23;
      green = 100;
      blue = 255;
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
  
  void getLlocation()
  {
    super.getLocation();
  }
  
  void seek(PVector target)
  {
    super.seek(target);
    if(PVector.dist(location, target) < sight)
    {
      stroke(59, 230, 30);
      line(location.x, location.y, target.x, target.y);
    }
  }
  
  void flee(PVector predator)  
  {
    if(PVector.dist(location, predator) < sight)
    {
      super.flee(predator);
        pushMatrix();
      stroke(165, 30, 30);
      line(location.x, location.y, predator.x, predator.y);
        popMatrix();
    }
    //if(PVector.dist(location, predator) > sight)
      
  }
  
  void changeColorFill(float r, float g, float b)
  {
    if((r>255 || r < 0) && (g>255 || g<0) && (b>255 || b<0))
    {
    }
      else
      {
        red = r; 
        green = g; 
        blue = b;
      }
  }
  
}
