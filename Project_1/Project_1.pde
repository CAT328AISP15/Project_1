//SEEKER AI: FIRST, will use flee() from mouse IF mouse button is down
//           SECOND, chases a "Fleer" with seek() if one was found in range
//           THIRD, wanders otherwise with noiseWander() and half max speed
//FLEER AI:  FIRST, runs from any "Seeker" that gets to close with evade()
//           SECOND, approaches mouse with arrive() at half max speed
//Fleer can only see half as far as a Seeker
//Fleer can escape seeker in two ways:
//           FIRST, he can wrap around the screen, since seeker does not look to other side of screen for fleer
//           SECOND, you can save him by scaring the seeker away with holding the mouse button down

ArrayList<Agent> agentList;

public static final int BG_COLOR = 0xFF113311;

////////////////////////////////////////////////////////////////////
void setup()
{
  //setup screen
  size(640, 480);
  
  //create starting entities
  agentList = new ArrayList<Agent>();
  Seeker s = new Seeker();
  agentList.add(s);
  Fleer f = new Fleer();
  f.m_position.sub(f.m_position); //set position to 0, 0
  f.m_maxLookDistance = f.m_maxLookDistance/2;
  agentList.add(f);
}

////////////////////////////////////////////////////////////////////
void draw()
{
  //clear BG
  background(BG_COLOR);
  
  //update entities
  for(int i = agentList.size() - 1; i >= 0; i--)
  {
    agentList.get(i).lookAround(agentList);
    agentList.get(i).update();
  }
  
  //render entities
  for(int i = agentList.size() - 1; i >= 0; i--)
  {
    agentList.get(i).render();
  }
}
