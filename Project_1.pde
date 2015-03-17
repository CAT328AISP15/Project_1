Visual v, b, a, c;
PVector locV, locB, locA, locC;
PVector colV, colB, colA, colC;

public void setup()
{
  //do i have to define a color by number? can i use a name?
  colV = new PVector(255,0,0);
  colB = new PVector(0,255,0);
  colA = new PVector(0,0,255);
  colC = new PVector(0,0,0);
  
  //is there a better way to do this?
  locV = new PVector(10,10);
  locB = new PVector(100,150);
  locA = new PVector(360,360);
  locC = new PVector(500,500);
  
  size(640, 640);
  background(255);
  
  v = new Visual(locV,colV);
  b = new Visual(locB,colB);
  a = new Visual(locA,colA);
  c = new Visual(locC,colC);
}

public void draw()
{
  background(255);
  b.flee(a);
  a.pursuit(b);
  c.seek(v);
  v.wander();
}
