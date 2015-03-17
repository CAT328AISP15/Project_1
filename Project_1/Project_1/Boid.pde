//Foundation of this code came from www.natureofcode.come

class Boid
{
  
  PVector _location;
  PVector _velocity;
  PVector _acceleration;
  
  float _maxSpeed;
  float _maxForce;
  
  float _r;
  
  color _myColor;
  
   Boid(PVector startingLocation)
   {
     _acceleration = new PVector(0,0);
     _velocity = new PVector(0,0);
     _location = new PVector(startingLocation.x, startingLocation.y);
    
     _r = 10;
     _maxSpeed = 5;
     _maxForce = 0.1; 
     
     _myColor = #690708;
   }
  
  void flock(ArrayList<Boid> boids)
  {
    PVector sep = separate(boids);
    PVector ali = align(boids);
    PVector coh = cohesion(boids);
    
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }
  
  void run(ArrayList<Boid> boids, PVector target)
  {
     //applyForce(seek(new PVector(mouseX, mouseY)));
     flock(boids);
     applyForce(seek(target));
     update();
     display();
  }
  
  void update()
  {
     _velocity.add(_acceleration);
     _velocity.limit(_maxSpeed);
     _location.add(_velocity);
     _acceleration.mult(0); 
  }
  
  void display()
  {
     float theta = _velocity.heading() + PI/2;
     
     fill(_myColor);
     stroke(0);
     pushMatrix();
     translate(_location.x, _location.y);
     rotate(theta);
     beginShape();
     vertex(0, -_r*2);
     vertex(-_r, _r*2);
     vertex(_r, _r*2);
     endShape(CLOSE);
     popMatrix();     
  }
  
  void applyForce(PVector force)
  {
    _acceleration.add(force); 
  }
  
  PVector separate(ArrayList<Boid> boids)
  {
    float desiredSeparation = _r * 2;
   
    PVector sum = new PVector();
    int count = 0;
   
    for(Boid other : boids)
    {
      float d = PVector.dist(_location, other._location);
      
      if( (d > 0) && (d < desiredSeparation))
      {
        PVector diff = PVector.sub(_location, other._location);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++; 
      }
    }
    
    if(count > 0)
    {
      sum.div(count);
      sum.normalize();
      sum.mult(_maxSpeed);
      PVector steer = PVector.sub(sum, _velocity);
      steer.limit(_maxForce);
      return steer; 
    }
    else
    {
      return new PVector(0, 0); 
    }
  }
  
  PVector seek(PVector target)
  {
    PVector desired = PVector.sub(target, _location);
    desired.normalize();
    desired.mult(_maxSpeed);
    PVector steer = PVector.sub(desired, _velocity);
    steer.limit(_maxForce);
   
    return steer; 
  }
  
  PVector align(ArrayList<Boid> boids)
  {
    float neighborList = 50;
    PVector sum = new PVector(0,0);
    int count = 0;
    
    for(Boid other : boids)
    {
      float d = PVector.dist(_location, other._location);
      
      if( (d > 0) && (d < neighborList))
      {
        sum.add(other._velocity);
        count++; 
      }
    } 
    
    if(count > 0)
    {
      sum.div(count);
      sum.normalize();
      sum.mult(_maxSpeed);
      PVector steer = PVector.sub(sum, _velocity);
      steer.limit(_maxForce);
     
      return steer; 
    }
    else
    {
      return new PVector(0,0); 
    }
  }
  
  PVector cohesion(ArrayList<Boid> boids)
  {
    float neighborList = 50;
    PVector sum = new PVector(0,0);
    int count = 0;
    
    for(Boid other : boids)
    {
      float d = PVector.dist(_location, other._location);
     
      if( (d > 0) && (d < neighborList))
      {
        sum.add(other._location);
        count++;
      } 
    }
    
    if(count > 0)
    {
      sum.div(count);
      return seek(sum); 
    }
    else
    {
      return new PVector(0,0); 
    }
  }
  
}
