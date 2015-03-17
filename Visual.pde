public class Visual
{
  private PVector loc;
  private PVector vel;
  private PVector col;
  /*
   impliment
   @Seek, @Arrive, @Flee; @Pursuit, 
   Wander, Evade; Basic Path Following, 
   Flocking, Obstacle Avoidance
   */
  public Visual(PVector loc, PVector col)
  {
    this.col = col;
    this.loc = loc;
    fill(col.x, col.y, col.z);
    vel = new PVector(0, 0);
    ellipse(this.loc.x, this.loc.y, 16, 16);
  }

  public void wallSwitch()
  {
    if (loc.x <= 0)
      loc.x = width - 5;
    else if (loc.x >= width)
      loc.x = 5;

    if (loc.y <= 0)
      loc.y = height - 5;
    else if (loc.y >= height)
      loc.y = 5;
  }

  public void velCheck()
  {
    int max = 5;

    if (vel.x > max)
      vel.x = max;
    else if (vel.x < -max)
      vel.x = -max;

    if (vel.y > max)
      vel.y = max;
    else if (vel.y < -max)
      vel.y = -max;
  }

  public void move()
  {
    fill(col.x, col.y, col.z);
    velCheck();
    loc.add(vel);
    ellipse(loc.x, loc.y, 16, 16);
    wallSwitch();
  }

  public void seek(Visual v)
  {
    float targX = v.loc.x + v.vel.x;
    float targY = v.loc.y + v.vel.y;

    if (targX - loc.x > 50)
      targX = (targX-loc.x)/5;
    else
      targX = (targX-loc.x)/10;

    if (targY - loc.y > 50)
      targY = (targY-loc.y)/5;
    else
      targY = (targY-loc.y)/10;

    vel = new PVector(targX, targY);
    move();
  }

  public void flee(Visual v)
  {
    float targX = v.loc.x + v.vel.x;
    float targY = v.loc.y + v.vel.y;

    if (abs(loc.x - v.loc.x) < 20 && abs(loc.y - v.loc.y) < 20 )
    {
      if (abs(loc.x - v.loc.x) < 10 && abs(loc.y - v.loc.y) < 10)
        wander();
      else
      {
        targX = 0 - (targX-loc.x);

        targY = 0 - (targY-loc.y);
      } 
      vel = new PVector(targX, targY);
      move();
    } else
      wander();
  }

  //seek with steering
  public void pursuit(Visual v)
  {
    PVector desVel = new PVector(loc.x - v.loc.x, loc.y - v.loc.y);
    desVel.mult(5);
    PVector steer = new PVector(desVel.x - vel.x, desVel.y - vel.y);
    vel.sub(steer);
    move();
  }
  
  //working on evade
  //public void evade(Visual v)

  public void wander()
  {

    int dir = int(random(3));
    switch (dir)
    {
    case 1: 
      vel.x -= 1;
      break;
    case 2: 
      vel.x += 1;
      break;
    default:
      break;
    }

    int dir1 = int(random(3));
    switch (dir1)
    {
    case 1: 
      vel.y -= 1;
      break;
    case 2: 
      vel.y += 1;
      break;
    default:
      break;
    }
    move();
  }
}

