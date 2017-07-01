class Ship
{
  private PShape model;
  
  public PVector pos;
  private PVector direction;
  
  private MovementTracker movement;
  private Moonlander ml;
  
  private ArrayList<PVector> waypoints;
  
  
  Ship(PVector _pos, Moonlander _ml)
  {
    pos = _pos;
    direction = new PVector(0.0, 0.0, 0.0);
    movement = new MovementTracker(pos, direction);
    model = loadShape("ship.obj");
    ml = _ml;    
  }
  
  public void setWayPoints(ArrayList<PVector> _waypoints)
  {
    waypoints = _waypoints;
    movement.route = waypoints;
  }
  
  public void addWayPoint(PVector p)
  {
    waypoints.add(p);
  }
  
  void draw()
  {
        
    float time = (float)ml.getValue("ship");
    movement.update(time);
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    scale(3);
    PVector diff = direction.copy().sub(pos);
    float rotY = atan2(diff.x, diff.z);
    rotateY(rotY);
    
    shape(model);
    popMatrix();
  }
  
}