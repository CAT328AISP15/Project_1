//Basics for Mover classes 
class Mover implements SuperMover
{
    PVector location;
    PVector velocity;
    PVector acceleration;
    PVector steer;
    PVector desired;
    float mass;
    float maxForce, maxSpeed;
   

    Mover(float xCoordinate, float yCoordinate)
    {
      location = new PVector(xCoordinate, yCoordinate);
      acceleration = new PVector(0, 0);
      velocity = new PVector(0.50, 0);
      mass =  1;
      maxForce = .4;
      maxSpeed = 4;
    }
   
    void update()
    {
      velocity.add(acceleration);
      velocity.limit(8);
      location.add(velocity);
      acceleration.mult(0);
      this.checkedges();
    }
  
    void construct()
    {
     fill(201);
      pushMatrix();
     ellipse(location.x, location.y-35, 20, 20);
     triangle(location.x-20, location.y-35, location.x, location.y, location.x+20, location.y-35);
       popMatrix();
    }
   
   void checkedges() //bumps against edges
   {
     if (location.x > width)
      {
       velocity.x *= -1;
       velocity.x -= 0.003;
       location.x = width;
      }
     else if (location.x < 0) 
      {
        velocity.x *= -1;
        velocity.x += 0.003;
        location.x = 0;
      }
        
     if (location.y > 700)
      { 
        velocity.y *= -1;
        velocity.y += 0.09;
        location.y = 700;
      }
      if (location.y < 0)
      {
       velocity.y *= -1;
       velocity.y -= 0.003;
       location.y = 0;
      }
   }
   
   void applyForce(PVector force)
   {
     PVector f = force.get();
     f.div(mass);
     acceleration.add(f);
   }
   
   PVector getLocation()
   {
    return location.get();
   }
   
   void seek(PVector target) // normal seek method, chases
   {
     PVector desired = PVector.sub(target, location);
     desired.normalize();
     desired.mult(2);
     PVector steer = PVector.sub(desired, velocity);
     steer.limit(maxForce);
     applyForce(steer);
   }
   
   void flee(PVector predator) // may need work
   {
     PVector target = predator.get();
     PVector desired = PVector.sub(location, target);
     desired.normalize();
     desired.mult(2);
     PVector steer = PVector.sub(desired, velocity);
     steer.limit(maxForce);
     applyForce(steer);
   }
   
   void arrive(PVector target) 
   {
    PVector desired = PVector.sub(target,location);
    float d = desired.mag();
    desired.normalize();

    if (d < 100) 
    {
      float m = map(d,0,100,0,maxSpeed);
      desired.mult(m);
    } 
    else 
      desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
    void seperate (ArrayList<Mover> movers)
  {
    float desiredSeperation = 10;
    PVector sum = new PVector();
    int count = 0;
    for (Mover other: movers)
    {
      float distance = PVector.dist(location, other.location);
      if (distance > 0 && distance < desiredSeperation)  // if there is distance and that distance is lower than the "view" of this object
      {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(distance);
        sum.add(diff);
        count++;
      }
      if (count > 0) 
      {
      sum.div(count);
      sum.setMag(maxSpeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxForce);
      applyForce(steer);
      }
   }
}  

  void cohesion (ArrayList<Mover> movers)
  {
    float desiredSeperation = 100;
    PVector sum = new PVector();
    int count = 0;
    for (Mover other: movers)
    {
      float distance = PVector.dist(location, other.location);
       if (distance > 0 && distance < desiredSeperation)
      {
        PVector diff = PVector.sub(other.location, location); // inverse of locatoion to other (seperate)
        diff.normalize();
        diff.div(distance);
        sum.add(diff);
        count++;
                                                              //something may be wrong with the logic of the code
        sum.div(count);
        sum.setMag(maxSpeed);
        PVector steer = PVector.sub(sum,velocity);
        steer.limit(maxForce);
        applyForce(steer);
      }
    
     }
     
    }
    
   void checkCollision(ArrayList<Mover> movers)
   {
     float desiredSeperation = 10;
    PVector sum = new PVector();
    int count = 0;
    for (Mover other: movers)
    {
      float distance = PVector.dist(location, other.location);
      if (distance > 0 && distance < desiredSeperation)  // if there is distance and that distance is lower than the "view" of this object
      {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(distance);
        sum.add(diff);
        count++;
      }
      if (count > 0) 
      {
      sum.setMag(maxSpeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxForce);
      applyForce(steer);
      }
    
   }
     
   }
}   



