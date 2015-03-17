public class Fleer extends Agent
{
  static final int ROTATE_ADJUST = 0;
  boolean isFleeing;
  
  ////////////////////////////////////////////////////////////////////
  //constructor//
  Fleer()
  {
    super();
    myType = AgentType.FLEER;
  }
  
  ////////////////////////////////////////////////////////////////////
  public void update()
  {    
    //fleer uses lookAround to do most of update, as it evades all enemies within distance of it
    //use update to approach mouse with arrive if there's no accel
    if( !isFleeing )
    {
//      println("NOT fleeing");
      arrive(new PVector(mouseX, mouseY));
    }
    
    //at end of update, apply final accel to velocity
    //and velocity to position
    if(isFleeing)
    {
      updatePosition();
    }
    else
    {
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
    fill(0);
    ellipse(0, 0, 30, 30);
    
    //pop matrix
    popMatrix();
  }
  
  ////////////////////////////////////////////////////////////////////
  public void lookAround(ArrayList<Agent> agentList)
  {    
    //check all within range for seekers
    //evade all seekers in range
    boolean tempBool = false; //used to determine if you're running from someone or not
    PVector sum = new PVector();
    int count = 0;
    for(Agent a : agentList)
    {
      if (a.myType == AgentType.SEEKER)
      {
        //evade uses flee, and flee uses view distance, so send each seeker to evade
        if (!tempBool)
        {
          tempBool = evade(a);
        }
        else
        {
          evade(a);
        }
      }
    }//end for
    isFleeing = tempBool;
  }
}
