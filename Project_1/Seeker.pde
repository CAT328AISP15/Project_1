public class Seeker extends Agent
{
  static final int ROTATE_ADJUST = 0;
  
  ////////////////////////////////////////////////////////////////////
  //constructor//
  Seeker()
  {
    super();
    myType = AgentType.SEEKER;
  }
  
  ////////////////////////////////////////////////////////////////////
  public void update()
  { 
    //if mouse is down, run from mouse regardless of target
    if(mousePressed == true)
    {
      flee(new PVector(mouseX, mouseY));//apply final accel to velocity, and velocity to position
      updatePosition(m_maxSpeed);
      return;
    }   
    
    //if has target, approach them, otherwise wander and look for a target
    if(m_target != null)
    {
//      println("seeking target");
      PVector target = m_target.getPosition();
      seek(target);
      //apply final accel to velocity, and velocity to position
      updatePosition(m_maxSpeed);
    }
    else
    {
//      println("walking randomly");
      noiseWander();
      //apply final accel to velocity, and velocity to position
      //wander SLOWER than chase/flee
      updatePosition(m_maxSpeed / 2);
    }
    
    wrapAround();
  }
  
  ////////////////////////////////////////////////////////////////////
  public void render()
  {
    //push matrix
    pushMatrix();
    
    //translate and rotate
    translate(m_position.x, m_position.y);
    
    //draw
    fill(255);
    rectMode(CENTER);
    rect(0, 0, 30, 30);
    
    //pop matrix
    popMatrix();
  }
  
  ////////////////////////////////////////////////////////////////////
  public void lookAround(ArrayList<Agent> agentList)
  {
    //first check current target, if you have one, to make sure it's still in range
    if(m_target != null)
    {
      float d = PVector.dist(m_position, m_target.getPosition());
      if (d < m_maxLookDistance)
      {
        return;
      }
      else
      {
        m_target = null;
      }
    }
    
    //if target is now null, look for a new target
    //no need to check if null, since if it got to this point, target is null
    for(int i = agentList.size() - 1; i >= 0; i--)
    {
      Agent a = agentList.get(i);
      if (a.myType == AgentType.FLEER)
      {
        float d = PVector.dist(m_position, a.getPosition());
//        println("Found a Fleer, distance: " + d);
        if (d < m_maxLookDistance)
        {
          //set new target and exit
          m_target = a;
          return;
        }
      }
      else
      {
//        println(a.myType);
      }
    }//end for
  }
  
  ////////////////////////////////////////////////////////////////////
  protected float calcRotAngle()
  {
    return (super.calcRotAngle() + ROTATE_ADJUST);
  }
  
}
