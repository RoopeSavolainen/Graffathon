class StartScene extends Scene
{
  private static final float StartZ = -10000;
  private ShipRowManager shipRows;
  StartScene(CameraController camera, AudioController audio, Ship ship, City city, TerrainManager terrain, ShipRowManager shipRow)
  {
    super(camera, audio, ship, city, terrain);
    shipRows = shipRow;
    
    /* ArrayList<PVector> shipRoute = new ArrayList();
     shipRoute.add(new PVector(0, -120.0, StartZ));
     shipRoute.add(new PVector(0, -120.0, StartZ));
     this.ship.addWayPoints(shipRoute);
     
     ArrayList<PVector> cameraRoute = new ArrayList();
     cameraRoute.add(new PVector(0, -120.0, StartZ));
     cameraRoute.add(new PVector(0, -120.0, StartZ));
     this.camera.addWayPoints(cameraRoute);*/
     
     terrain.setMountainsStatic(false);
     terrain.setRenderingOutside(true);
     shipRows.setIsVisible(false);
     city.setActive(false);
  }
  
  Scene update()
  {
    float time = constrain((float)ml.getValue("time"), 0, 1);
    
    float y = time < 0.55 ? -520 : lerp(-520, -50, slerp(0, 1, constrain((time - 0.55) * 5, 0, 1)));
    PVector cameraPos = PVector.lerp(new PVector(30, y, StartZ), new PVector(30, y, 0), slerp(0, 1, time));
    camera.pos = cameraPos;
    ship.pos = PVector.lerp(new PVector(0, -120, StartZ), new PVector(0, -120, 0), slerp(0, 1, time));
    camera.lookAt = new PVector(0, -120, +10000);
    
    if(time > 0.75) {
       terrain.setRenderingOutside(false); 
    }
    if(time > 0.92) {
      shipRows.setIsVisible(true);
    }
    
    if(time > 0.95) {
      city.setActive(true);
    }
    if(time > 0.999) {
     terrain.setMountainsStatic(true);
    return new FollowScene(camera, audio, ship, city, terrain);
    }
    
   // rect(cameraPos.x
  // if(time 
  
    return this;
  }
  
  PVector slerp(PVector from, PVector to, float t) {
     return new PVector(
       slerp(from.x, to.x, t), 
       slerp(from.y, to.y, t),
       slerp(from.z, to.z, t));
  }
  
  float slerp(float edge0, float edge1, float x)
  {
    // Scale, bias and saturate x to 0..1 range
    x = clamp((x - edge0)/(edge1 - edge0), 0.0, 1.0); 
    // Evaluate polynomial
    return x*x*(3 - 2*x);
  }

float clamp(float x, float lowerlimit, float upperlimit)
{
    if (x < lowerlimit) x = lowerlimit;
    if (x > upperlimit) x = upperlimit;
    return x;
}
}