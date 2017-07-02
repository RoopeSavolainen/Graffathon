import java.util.ArrayDeque;

class MovementTracker
{
  private PVector pos;
  private PVector lookAt;
  
  private final static int prevSize = 15;
  private ArrayDeque<PVector> prevPos;
  
  public int lastVisited = -1;
  
  private final static float steeringPower = 0.02;
  public float maxVel = 5;
  
  public ArrayList<PVector> route;
  public PVector fixedTarget;
  
  public MovementTracker()
  {
    pos = new PVector(0.0, 0.0, 0.0);
    prevPos = new ArrayDeque<PVector>(prevSize);
    prevPos.addLast(new PVector(0.0, 0.0, 0.0));
    lookAt = new PVector(0.0, 0.0, 0.0);
  }
  
  public MovementTracker(PVector _pos, PVector _lookAt)
  {
    pos = _pos;
    prevPos = new ArrayDeque<PVector>(prevSize);
    prevPos.add(pos.copy());
    lookAt = _lookAt;
  }
  
  public boolean isVisited(int index)
  {
    return index <= lastVisited;
  }
  
  public boolean allVisited()
  {
    return route.size() <= lastVisited;
  }
  
  public void update(float lerpValue)
  {
    if (route.size() <= lerpValue + 1)
    {
      return;
    }
    
    int next = ceil(lerpValue);
    int prev = floor(lerpValue);
    lastVisited = prev;
    
    PVector goal = route.get(next);
    PVector start = route.get(prev);
    PVector heading = PVector.lerp(start, goal, lerpValue - prev);
    
    PVector vel = pos.copy().sub(prevPos.peek()).div(prevPos.size());
    PVector direction = goal.copy().sub(pos);
    float deg = PVector.angleBetween(direction,goal);
    PVector steering = direction.copy().limit(steeringPower).mult(abs(deg/PI));
    PVector newVel = vel.copy().add(steering).limit(maxVel);
    
    PVector steered = pos.copy().add(newVel);
    
    PVector newPos = PVector.lerp(steered, heading, lerpValue - prev);
    
    if (prevPos.size() >= 15)
    {
      prevPos.removeFirst();
    }
    
    prevPos.add(pos.copy());
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