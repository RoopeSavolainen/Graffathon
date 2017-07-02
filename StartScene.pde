class StartScene extends Scene
{
  private static final float StartZ = -10000;
  StartScene(CameraController camera, AudioController audio, Ship ship, City city, TerrainManager terrain)
  {
    super(camera, audio, ship, city, terrain);
    
    /* ArrayList<PVector> shipRoute = new ArrayList();
     shipRoute.add(new PVector(0, -120.0, StartZ));
     shipRoute.add(new PVector(0, -120.0, StartZ));
     this.ship.addWayPoints(shipRoute);
     
     ArrayList<PVector> cameraRoute = new ArrayList();
     cameraRoute.add(new PVector(0, -120.0, StartZ));
     cameraRoute.add(new PVector(0, -120.0, StartZ));
     this.camera.addWayPoints(cameraRoute);*/
     
     terrain.setMountainsStatic(false);
     city.setActive(false);
  }
  
  Scene update()
  {
    float time = constrain((float)ml.getValue("ship"), 0, 1);
    
    println(camera.pos);
    camera.pos = PVector.lerp(new PVector(30, -300, StartZ), new PVector(30, -300, 0), time);
    ship.pos = PVector.lerp(new PVector(0, -120, StartZ), new PVector(0, -120, 0), time);
    camera.lookAt = new PVector(0, -120, +10000);
    
    if(time > 0.95) {
      city.setActive(true);
    }
    if(time > 0.999) {
     terrain.setMountainsStatic(true);
    }
    return this;
  }
}