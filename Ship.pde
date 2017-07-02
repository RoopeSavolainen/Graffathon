class Ship
{
  private PShape model;
  
  public PVector pos;
  public PVector direction;
  
  public MovementTracker movement;
  private Moonlander ml;
  
  private ArrayList<PVector> waypoints;
  
  Ship(PVector _pos, Moonlander _ml)
  {
    pos = _pos;
    direction = new PVector(0.0, 0.0, 0.0);
    movement = new MovementTracker(pos, direction);
    model = loadShape("ship.obj");
    ml = _ml;
    waypoints = new ArrayList<PVector>();
    movement.route = waypoints;
  }
  
  public void addWayPoints(ArrayList<PVector> p)
  {
    if (movement.route == null)
    {
      movement.route = waypoints;
    }
    waypoints.addAll(p);
  }
  
  void draw()
  {
    float time = (float)ml.getValue("ship");
    movement.update(time);
    println(time);
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    scale(0.75);
    PVector diff = direction.copy().sub(pos);
    float rotY = atan2(diff.x, diff.z);
    rotateY(rotY);
    
    shape(model);
    popMatrix();
  }
  
}