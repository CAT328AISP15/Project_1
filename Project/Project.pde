//Edd Brown Jr.
//Makes use of my Tracker and Ubo classes, Ubo, is affected by gravity while traveling, it bounces off walls and floor
// Tracker is mainly used to either flee or seek some PVector, green light shows its close to and traveling toward
//                                                             red light shows its too close to a predator and trying to move in the opposite direction

PVector gravity; // continuous force of world
PVector wind;
PVector mouse; // PVecor with mouse location
ArrayList<Ubo> ubos;
Ubo bouncer1;
Ubo bouncer2;
Ubo bouncer3;
Tracker cop, cop2;


void setup()
{
  size(800, 700);
  bouncer1 = new Ubo(500, 70);
  bouncer2 = new Ubo(200, 10);
  bouncer3 = new Ubo(width/2, 0);
  cop = new Tracker(10, 10);
  cop2 = new Tracker(10, 10);
  gravity = new PVector(0, 0.034);
  wind = new PVector(.0167, 0);
  ubos = new ArrayList<Ubo>();
  ubos.add(bouncer1);
  ubos.add(bouncer2);
  ubos.add(bouncer3);

}
 
void draw()
{
  
  background(0);
  if(keyPressed)
    if(key == CODED)
    
      if(keyCode == RIGHT)               //Right arrow key ignites a wind
      {
 
        cop.applyForce(wind);
        cop2.applyForce(wind);
        bouncer1.applyForce(wind);
        bouncer2.applyForce(wind);
        bouncer3.applyForce(wind);
      }
    
   cop.changeColorFill(252, 44, 134); //pinkish tracker tracking pink Ubo 
   cop.seek(bouncer2.getLocation());
   cop.flee(cop2.getLocation());
   cop.update();
   cop.construct();
   
   
   cop2.seek(bouncer1.getLocation()); //blue tracker tracking blue Ubo
   cop2.flee(cop.getLocation());
   cop2.update();
   cop2.construct();
  
  
  
  bouncer1.applyForce(gravity); //blue Ubo Object
  bouncer1.collideWithUbo(ubos);
  bouncer1.update();
  bouncer1.construct();
  
  bouncer2.changeColorFill(252, 44, 134); //Pinkish Ubo Object 
  bouncer2.applyForce(gravity);
  bouncer2.collideWithUbo(ubos);
  bouncer2.update();
  bouncer2.construct();
  
  bouncer3.applyForce(gravity); //white Ubo Object
  bouncer3.changeColorFill(255, 255, 255);
  bouncer3.collideWithUbo(ubos);
  bouncer3.update();
  bouncer3.construct();
  
  
}
  
