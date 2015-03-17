Visual v, b, a, c, d, e;
PVector locV, locB, locA, locC, locD, locE;
PVector colV, colB, colA, colC, colD, colE;

public void setup()
{
  //do i have to define a color by number? can i use a name?
  //red
  colV = new PVector(255,0,0);
  //green
  colB = new PVector(0,255,0);
  //blue
  colA = new PVector(0,0,255);
  //black
  colC = new PVector(0,0,0);
  //sky blue
  colD = new PVector(0,255,255);
  //yellow
  colE = new PVector(255,255,0);

  
  //is there a better way to do this? random spots.
  locV = new PVector(10,10);
  locB = new PVector(300,150);
  locA = new PVector(360,600);
  locC = new PVector(500,360);
  locD = new PVector(500,250);
  locE = new PVector(600,250);

  
  size(640, 640);
  background(255);
  
  v = new Visual(locV,colV);
  b = new Visual(locB,colB);
  a = new Visual(locA,colA);
  c = new Visual(locC,colC);
  d = new Visual(locD,colD);
  e = new Visual(locE,colE);
}

public void draw()
{
  background(255);
  //aggresivly chases a
  b.pursuit(a);
  //gentally runs from b
  a.flee(b);
  //gentally chases d
  c.seek(d);
  //free roam
  v.wander();
  //running form c
  d.evade(c);
  //Runs from mouse
  e.evadeMouse();
}
