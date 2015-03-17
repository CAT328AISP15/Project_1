abstract class Agent
{
  public AgentType myType;
  public PVector m_position;
  public PVector m_velocity = new PVector(0, 0);
  public PVector m_accel = new PVector(0, 0);
  public float m_maxSpeed = 10;
  public float m_maxForce = 5;
  private float m_mass = 1;
  
  private PVector noiseOff = new PVector(0, 0, 0);
  float randWanderTheta = 0.0f;
  float randWanderDist = 100;
  float randWanderRadius = 30;
  
  public int m_maxLookDistance = 100;
  
  protected Agent m_target;
  protected boolean m_dead = false;
  //protected int m_life;
  
  //protected boolean m_isFriendly;
  
  /////////////////
  //CONSTRUCTORS///
  /////////////////
  Agent()
  {
    m_position = new PVector(width/2, height/2);
    m_maxSpeed = 5;
  }
  Agent(int posX, int posY, float maxSpeed, float maxForce)
  {
    m_position = new PVector(posX, posY);
    m_maxSpeed = maxSpeed;
    m_maxForce = maxForce;
  }
  
  /////////////////
  //GETS AND SETS//
  /////////////////
  public Agent getTarget()
  {
    return m_target;
  }
  public void setTarget(Agent a)
  {
    m_target = a;
  }
  public boolean isDead()
  {
    return m_dead;
  }
  public PVector getPosition()
  {
    return m_position.get();
  }
  
  
  //////////////////
  ////FUNCTIONS/////
  //////////////////
  public abstract void update();
  public abstract void render();
  public abstract void lookAround(ArrayList<Agent> agentList);
  
  protected float calcRotAngle()
  {
    return atan2(m_velocity.y, m_velocity.x);
  }
  
  ////////////////////////////////////////////////////////////////////
  protected void applyForce(PVector force)
  {
    PVector f = force.get();
    f.div(m_mass);
    m_accel.add(f);
  }
  
  ////////////////////////////////////////////////////////////////////
  void updatePosition()
  {
    m_velocity.add(m_accel);
    m_position.add(m_velocity);
    m_accel.mult(0);
  }
  
  ////////////////////////////////////////////////////////////////////
  void updatePosition(float tempMaxSpd)
  {
    m_velocity.add(m_accel);
    m_velocity.normalize();
    m_velocity.mult(tempMaxSpd);
    m_position.add(m_velocity);
    m_accel.mult(0);
  }
  
  ////////////////////////////////////////////////////////////////////
  void wrapAround()
  {
    if(m_position.x < 0)
      m_position.x = width - 1;
    else if(m_position.x > width)
      m_position.x = 1;
    
    if(m_position.y < 0)
      m_position.y = height - 1;
    else if(m_position.y > height)
      m_position.y = 1;
  }
  
  ////////////////////////////////////////////////////////////////////
  protected void seek(PVector target)
  {
    PVector desired = PVector.sub(target, m_position);
    desired.setMag(m_maxSpeed);
    PVector steering = PVector.sub(desired, m_velocity);
    steering.limit(m_maxForce);
    applyForce(steering);
  }
  
  ////////////////////////////////////////////////////////////////////
  protected void arrive(PVector target)
  {
    PVector desired = PVector.sub(target, m_position);
    float d = desired.mag();
    if (d < 100)
    {
      float m = map(d, 0, 100, 0, m_maxSpeed);
      desired.setMag(m);
    }
    else
    {
      desired.setMag(m_maxSpeed);
    }
    PVector steering = PVector.sub(desired, m_velocity);
    steering.limit(m_maxForce);
    applyForce(steering);
  }
  
  ////////////////////////////////////////////////////////////////////
  protected boolean flee(PVector target)
  {
    boolean mustFlee = false;
    
    PVector steering;
    PVector desired = PVector.sub(m_position, target);
    float distance = desired.mag();
    if(distance > 0.01 && distance < m_maxLookDistance)
    {
      println(distance);
      mustFlee = true;
      desired.setMag(m_maxSpeed);
      steering = PVector.sub(desired, m_velocity);
    }
    else
    {
      steering = new PVector(0, 0);
    }
    
    //no need to limit since it's already checked the distance
    applyForce(steering);
    return mustFlee;
  }
  
  ////////////////////////////////////////////////////////////////////
  //may need to adjust this//
  void pursue(Agent a)
  {
    PVector aVel = a.m_velocity.get();
    
    //set mag if looking ahead a set amount instead of
    //an amount determined by their velocity
    aVel.setMag(10); //how far ahead are we looking
    PVector predictedLoc = PVector.add(a.m_position, aVel);
    arrive(predictedLoc);
  }
  
  ////////////////////////////////////////////////////////////////////
  boolean evade(Agent a)
  {
    PVector aVel = a.m_velocity.get();
    
    //set mag if looking ahead a set amount instead of
    //an amount determined by their velocity
    aVel.setMag(10); //how far ahead are we looking
    PVector predictedLoc = PVector.add(a.m_position, aVel);
    if(this != a)
      return flee(predictedLoc);
    else
      return false;
  }
  
  ////////////////////////////////////////////////////////////////////
  void follow(Path p)
  {
    PVector predict = m_velocity.get();
    predict.setMag(25);
    PVector predictLoc = PVector.add(m_position, predict);
    
    PVector a = p.m_begin;
    PVector b = p.m_end;
    PVector normalPoint = getNormalPoint(predictLoc, a, b);
    
    PVector dir = PVector.sub(b, a);
    dir.setMag(10);
    PVector target = PVector.add(normalPoint, dir);
    
    float dist = PVector.dist(normalPoint, predictLoc);
    if (dist > p.m_radius)
    {
      seek(target);
    }
  }
  
  ////////////////////////////////////////////////////////////////////
  PVector getNormalPoint(PVector point, PVector lineStart, PVector lineEnd)
  {
    PVector startToPoint = PVector.sub(point, lineStart);
    PVector line = PVector.sub(lineEnd, lineStart);
    line.normalize();
    line.mult(startToPoint.dot(line));
    return PVector.add(lineStart, line);
  }
  
  ////////////////////////////////////////////////////////////////////
  void noiseWander()
  {
    float theta = map( noise(noiseOff.x, noiseOff.y), 0, 1, 0, TWO_PI);
//    println(cos(theta));
    float dx = map(cos(theta), -1, 0, -1, 1);
//    println(dx);
    PVector dest = PVector.add(new PVector(dx, sin(theta)), m_position);
    seek(dest);
    noiseOff.add(0.01, 0.01, 0);
  }
  
  ////////////////////////////////////////////////////////////////////
  //currently behaving oddly
  void randomWander()
  {
    float change = 0.2;
    randWanderTheta += random(-change, change);
    PVector loc = m_velocity.get();
    loc.setMag(randWanderDist);
    float h = m_velocity.heading2D();
    PVector offset = new PVector(randWanderRadius * cos(randWanderTheta + h),
                                 randWanderRadius * sin(randWanderTheta + h));
    PVector target = PVector.add(loc, offset);
    seek(target);
  }
}
