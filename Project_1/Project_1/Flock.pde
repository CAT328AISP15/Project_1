//Foundation of this code came from www.natureofcode.come

class Flock
{
  ArrayList<Boid> boids;
 
  Flock() 
  {
    boids = new ArrayList<Boid>(); 
  } 
  
  void run(PVector target)
  {
    for(Boid b : boids)
    {
      b.run(boids, target);
    } 
  }
  
  void addBoid(Boid b)
  {
    boids.add(b); 
  }
}
