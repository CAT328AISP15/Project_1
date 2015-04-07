//unidentified bouncing object.... somehwat related to a "top" in concept, more bouncy
class Ubo extends Mover 
{
    float red; 
    float green; 
    float blue;
  
    Ubo(float xCoordinate, float yCoordinate)
    {
      super(xCoordinate, yCoordinate);
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
      
        pushMatrix();
       stroke(0);
       fill(red, green, blue);
       ellipse(location.x, location.y-35, 20, 20);
       fill(201);
       triangle(location.x-20, location.y-35, location.x, location.y, location.x+20, location.y-35);
         popMatrix();
    }
    
    void checkedges()
    {
      super.checkedges();
    }
    
    void applyForce(PVector force)
    {
      super.applyForce(force);
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
    
    void collideWithUbo(ArrayList<Ubo> Ubos) //Uses Seperation method code as inspiration
   {
      float desiredSeperation = 20;
      
      int count = 0;
      for (Ubo other: ubos)
      {
          float distance = PVector.dist(location, other.location);
          if (distance > 0 && distance < desiredSeperation)  // if there is distance and that distance is lower than the "view" of this object
          {
            PVector diff = PVector.sub(location, other.location);
            //diff.normalize();
            // diff.div(distance);
            PVector steer = PVector.sub(diff,velocity);
            applyForce(steer);
          }
    
       }
   }
}


