class CameraTracker
{
  private PVector pos;
  
  public ArrayList<PVector> route;
  public PVector target;
  
  private float velocity = 100;
  
  public CameraTracker()
  {
    pos = new PVector(0.0, 0.0, 0.0);
  }
  
  public CameraTracker(PVector _pos)
  {
    pos = _pos;
  }
  
  public void update()
  {
    PVector heading = route.get(0).copy();
    
    PVector lookAt;
    if (target == null)
    {
      lookAt = heading.copy();
    }
    else
    {
      lookAt = target;
    }
    
    heading.sub(pos).normalize().mult(velocity/frameRate);
    
    pos.add(heading);
    
    print(pos.x, " : ", pos.y, " : ", pos.z, "\n");
    camera(pos.x, pos.y, pos.z, lookAt.x, lookAt.y, lookAt.z, 0, 1, 0);
  }
  
  public void setTarget()
  {
    
  }
  
}