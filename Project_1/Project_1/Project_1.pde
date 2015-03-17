//Foundation of this code came from www.natureofcode.come

Vehicle basicSeek;
Vehicle basicArrive;
Vehicle basicWander;
Vehicle basicPathFollowing;

ControlledAgent agent;

ArrayList<Vehicle> vehicles;

Flock flock;

Path simplePath;

void setup()
{
  size(800, 800);
  
  color red = #FF0000;
  color blue = #0000CC;
  color yellow = #fff000;
  
  agent = new ControlledAgent(new PVector(width/2, height/2));
  
  flock = new Flock();
  
  for(int i = 0; i < 50; i++)
  {
     Boid b = new Boid(new PVector(random(width), random(height)));
     flock.addBoid(b);
  }
  
  vehicles = new ArrayList<Vehicle>();
  
  for(int i = 0; i < 10; i++) 
  {
    Vehicle v = new Vehicle(new PVector(random(width), random(height)));
    v.ChangeColor(yellow);
    vehicles.add(v);
      
  } 
  
  simplePath = new Path();
  simplePath.addPoint(50, 300);
  simplePath.addPoint(200, 325);
  simplePath.addPoint(400, 300);
  simplePath.addPoint(600, 325);
  simplePath.addPoint(750, 300);
  
  basicSeek = new Vehicle(new PVector(width/2, height/2));
  basicSeek.ChangeColor(red);
  
  basicArrive = new Vehicle(new PVector(width/2, height/2 - 100));
  basicArrive.ChangeColor(blue);
  
  basicWander = new Vehicle(new PVector(width/2, height/2 + 100));
  
  basicPathFollowing = new Vehicle(new PVector(25,25));
}

void draw()
{
  background(#e0f2f6);
  
  basicSeek.update();
  basicArrive.update();
  basicWander.update();
  basicPathFollowing.update();
  
  agent.display();
  agent.update();
  
  basicSeek.seek(new PVector(mouseX, mouseY));
  basicArrive.arrive(new PVector(mouseX, mouseY));
  basicWander.wander();
  basicPathFollowing.follow(simplePath);
  
  simplePath.display();
  
  basicArrive.display();
  basicSeek.display();
  basicWander.display();
  basicPathFollowing.display();
  
  for(Vehicle v : vehicles)
  {
    v.separate(vehicles);
    v.arrive(basicPathFollowing._location);
    //v.arrive(new PVector(mouseX, mouseY));
    v.update();
    v.display(); 
  }
  
  flock.run(agent._pos);
  
}
