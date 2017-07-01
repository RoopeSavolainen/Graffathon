class MovementTracker
{
  private PVector pos;
  private PVector lookAt;
  
  public ArrayList<PVector> route;
  public PVector fixedTarget;
  
  public MovementTracker()
  {
    pos = new PVector(0.0, 0.0, 0.0);
    lookAt = new PVector(0.0, 0.0, 0.0);
  }
  
  public MovementTracker(PVector _pos, PVector _lookAt)
  {
    pos = _pos;
    lookAt = _lookAt;
  }
  
  public void update(float lerpValue)
  {
    if (route.size() == 0)
    {
      return;
    }
    
    print(lerpValue, "\n");
    
    int next = ceil(lerpValue);
    int prev = floor(lerpValue);
    
    PVector goal = route.get(next);
    PVector start = route.get(prev);
    PVector heading = PVector.lerp(start, goal, lerpValue - prev);
    
    pos.set(heading);
    
    if (fixedTarget == null)
    {
      lookAt.set(goal);
    }
    else
    {
      lookAt.set(fixedTarget);
    }
  }
}