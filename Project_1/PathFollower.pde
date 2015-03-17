public class PathFollower extends Agent
{
  Path myPath;
  PVector m_desiredDirection;
  
  ////////////////////////////////////////////////////////////////////
  //constructor//
  PathFollower(Path p)
  {
    myPath = p;
    m_position = new PVector(0, height/2);
    m_velocity = new PVector(0, m_maxSpeed);
    m_desiredDirection = m_velocity.get();
  }
  
  ////////////////////////////////////////////////////////////////////
  void update()
  {
    //seek(p.m_end);
//    m_velocity = m_desiredDirection.get();
    follow(myPath);
//    m_desiredDirection = m_velocity.get();
    updatePosition(m_maxSpeed/2);
    wrapAround();
  }
  
  ////////////////////////////////////////////////////////////////////
  void render()
  {
    //push matrix
    pushMatrix();
    
    //translate and rotate
    translate(m_position.x, m_position.y);
    
    //draw
    fill(255);
    triangle(-5, -5, -5, 5, 10, 0);
    
    //pop matrix
    popMatrix();
  }
  
  ////////////////////////////////////////////////////////////////////
  void lookAround(ArrayList<Agent> agentList) 
  {
    for(Agent a : agentList)
    {
      boolean evading = evade(a);
      if(evading)
      {
        println("EVADING " + a);
      }
    }
  }
}
