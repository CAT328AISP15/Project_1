//interface to help me organize which methods are important for most of my mover classes
public interface SuperMover
{

 
  void update();


  void construct();

 
 void checkedges(); //passes an edge, goes to the other (like mario)

 
 void applyForce(PVector force);

 
 PVector getLocation();



 
 
 
}

