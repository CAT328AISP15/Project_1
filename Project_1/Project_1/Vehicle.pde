//Foundation of this code came from www.natureofcode.come

class Vehicle
{
   PVector _location;
   PVector _velocity;
   PVector _acceleration;
   
   float _r;
   float _maxSpeed;
   float _maxForce;
   
   color _myColor;
   
   Vehicle(PVector startingLocation)
   {
     _acceleration = new PVector(0,0);
     _velocity = new PVector(0,0);
     _location = new PVector(startingLocation.x, startingLocation.y);
    
     _r = 10;
     _maxSpeed = 5;
     _maxForce = 0.1; 
     
     _myColor = #FF0000;
   }
   
   void ChangeColor(color newColor)
   {
     _myColor = newColor; 
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
   
   void seek(PVector target)
   {
     PVector desired = PVector.sub(target, _location);
     desired.normalize();
     desired.mult(_maxSpeed);
    
     PVector steer = PVector.sub(desired, _velocity);
     
     steer.limit(_maxForce);
     
     applyForce(steer);
   }
   
   void arrive(PVector target)
   {
     PVector desired = PVector.sub(target, _location);
     
     float d = desired.mag();
     desired.normalize();
     
     if(d < 100)
     {
       float m = map(d, 0, 100, 0, _maxSpeed);
       desired.mult(m);
     } 
     else
     {
       desired.mult(_maxSpeed); 
     }
     
     PVector steer = PVector.sub(desired, _velocity);
     steer.limit(_maxForce);
     applyForce(steer);
   }
   
   float _radius = 20;
   float _theta = 0;
   PVector _targetLocation = new PVector(0,0);
     
   
   void wander()
   {
     
     float degree = degrees(_velocity.heading());
     
     float x = 10 * cos((atan(degree)));
     float y = 10 * sin((atan(degree)));

     PVector futureLocation = new PVector(_location.x + x, _location.y + y);
     
     if(_theta <= 0)
       _theta = PI * 2;
     else if(_theta >= PI * 2)
       _theta = 0;
       
     float r = random(50);
     
     println(r);
     
     if(r > 0 && r < 10)
       _theta += 1;
     if(r > 10 && r < 20)
       _theta -= 1;
       
     
     _targetLocation.x = _radius * cos(atan(degrees(_theta))) + futureLocation.x;
     _targetLocation.y = _radius * sin(atan(degrees(_theta))) + futureLocation.y;
     
     
     
     PVector desired = PVector.sub(_targetLocation, _location);
     desired.normalize();
     desired.mult(_maxSpeed);
     
     PVector steer = PVector.sub(desired, _velocity);
     
     steer.limit(_maxForce);
     
     applyForce(steer);
     
     /*
     
     PVector desired = PVector.sub(target, _location);
     desired.normalize();
     desired.mult(_maxSpeed);
    
     PVector steer = PVector.sub(desired, _velocity);
     
     steer.limit(_maxForce);
     
     applyForce(steer);
     
     */
   }
   
   PVector _normalPoint = null;
   
   void follow(Path p)
   {
     PVector predict = _velocity.get();
     predict.normalize();
     predict.mult(25);
     PVector predictLoc = PVector.add(_location, predict);
     
     /*
     PVector a = p._start;
     PVector b = p._end;
     PVector normalPoint = getNormalPoint(predictLoc, a, b);
    
     PVector dir = PVector.sub(b, a);
     dir.normalize();
     dir.mult(10);
     PVector target = PVector.add(normalPoint, dir);
     */
     
     //Added
     PVector target = null;
     //PVector normalPoint = null;
     float worldRecord = 1000000;
     
     for(int i = 0; i < p._points.size()-1; i++)
     {
       PVector a = p._points.get(i);
       PVector b = p._points.get(i+1);
       PVector normalPoint = getNormalPoint(predictLoc, a, b);
       if(normalPoint.x < a.x || normalPoint.x > b.x)
       {
         normalPoint = b.get();
       }
       
       _normalPoint = normalPoint;
       
      float dist = PVector.dist(predictLoc, normalPoint);

       if(dist < worldRecord)
       {
         worldRecord = dist;
         target = normalPoint.get();
       }
     }
     //
     
     seek(target);
     
     /*
     float distance = PVector.dist(_normalPoint, predictLoc);
     
     if(distance > p._radius) 
     {
       seek(target);
     }
     */
   }
   
   PVector getNormalPoint(PVector p, PVector a, PVector b)
   {
     PVector ap = PVector.sub(p, a);
     PVector ab = PVector.sub(b, a);
    
     ab.normalize();
     ab.mult(ap.dot(ab));
    
     PVector normalPoint = PVector.add(a, ab);
    
     return normalPoint; 
   }
   
   void separate(ArrayList<Vehicle> vehicles)
   {
     float desiredSeparation = _r*5;
     PVector sum = new PVector();
     int count = 0;
     
     for(Vehicle other : vehicles)
     {
       float d = PVector.dist(_location, other._location);
       
       if((d > 0) && (d < desiredSeparation))
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
       applyForce(steer);
     } 
   }
   
   void applyForce(PVector force)
   {
     _acceleration.add(force);
   }
}
