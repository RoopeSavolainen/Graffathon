class CameraController
{
  public PVector pos;
  private PVector lookAt;
  
  private MovementTracker movement;
  private Moonlander ml;
 
  private ArrayList<PVector> waypoints;
  private PVector viewTarget;
   
  public CameraController(Moonlander _ml)
  {
    pos = new PVector(0.0, 0.0, 0.0);
    lookAt = new PVector(0.0, 0.0, 0.0);
    movement = new MovementTracker(pos, lookAt);
    ml = _ml;
    waypoints = new ArrayList<PVector>();
    movement.route = waypoints;
  }
  
  public CameraController(PVector _pos, PVector _lookAt, Moonlander _ml)
  {
    pos = _pos;
    lookAt = _lookAt;
    movement = new MovementTracker(pos, lookAt);
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
  
  public void setViewTarget(PVector _target)
  {
    viewTarget = _target;
    movement.fixedTarget = viewTarget;
  }
  
  public void update()
  {    
    float time = (float)ml.getValue("camera");
    movement.update(time);
    
    camera(pos.x, pos.y, pos.z, lookAt.x, lookAt.y, lookAt.z, 0, 1, 0);
  }
}