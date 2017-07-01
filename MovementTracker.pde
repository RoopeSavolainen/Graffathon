class MovementTracker
{
  private PVector pos;
  private PVector lookAt;
  
  private PVector prevPos;
  
  private final static float steeringPower = 0.02; 
  
  public ArrayList<PVector> route;
  public PVector fixedTarget;
  
  public MovementTracker()
  {
    pos = new PVector(0.0, 0.0, 0.0);
    prevPos = new PVector(0.0, 0.0, 0.0);
    lookAt = new PVector(0.0, 0.0, 0.0);
  }
  
  public MovementTracker(PVector _pos, PVector _lookAt)
  {
    pos = _pos;
    prevPos = pos.copy();
    lookAt = _lookAt;
  }
  
  public void update(float lerpValue)
  {
    if (route.size() <= lerpValue + 1)
    {
      return;
    }
    
    int next = ceil(lerpValue);
    int prev = floor(lerpValue);
    
    PVector goal = route.get(next);
    PVector start = route.get(prev);
    PVector heading = PVector.lerp(start, goal, lerpValue - prev);
    
    PVector diff = goal.copy().sub(pos);
    
    PVector vel = pos.copy().sub(prevPos);
    
    //print(vel.x, " : ", vel.y, " : ", vel.z, "\n");
    
    float s = diff.copy().normalize().dot(vel);
    PVector wrong = diff.copy().normalize().mult(s);
    PVector steering = diff.copy().sub(wrong).limit(steeringPower);
    PVector steered = pos.copy().add(vel).add(steering);
    
    print(steering.x, " : ", steering.y, " : ", steering.z, "\n");
    print(vel.x, " : ", vel.y, " : ", vel.z, "n");
    print("\n");
    
    PVector newPos = PVector.lerp(steered, heading, lerpValue - prev);
    
    
    
    prevPos.set(pos);
    pos.set(newPos);
    
    if (fixedTarget == null)
    {
      PVector lookDirection = pos.copy().add(vel);
      lookAt.set(lookDirection);
    }
    else
    {
      lookAt.set(fixedTarget);
    }
  }
}