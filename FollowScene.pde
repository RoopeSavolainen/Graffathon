class FollowScene extends Scene
{

  FollowScene(CameraController camera, AudioController audio, Ship ship, City city, TerrainManager terrain)
  {
    super(camera, audio, ship, city, terrain);
    
    terrain.setMountainsStatic(true);
    
    this.camera.setViewTarget(this.ship.pos);
    //this.ship.direction = new PVector(305.0, -400.0, 6150.0);
    
    ArrayList<PVector> route = new ArrayList();
    route.add(new PVector(320.0, -500.0, 640.0));
    
    route.add(new PVector(320.0, -700.0, 2000.0));
    route.add(new PVector(640.0,
                          -400.0,
                          6150));
    route.add(new PVector(320,
                          -400.0,
                          12000));
    route.add(new PVector(5000,
                          -800.0,
                          8000));
    this.camera.addWayPoints(route);
  
    ArrayList<PVector> shipRoute = new ArrayList();
    shipRoute.add(new PVector(320.0, -500.0, 320.0));
    
    shipRoute.add(new PVector(320.0, -400.0, 2000.0));
    shipRoute.add(new PVector(320.0,
                              -200.0,
                              6150));
    shipRoute.add(new PVector(320,
                              -200.0,
                              12000));
    shipRoute.add(new PVector(1000,
                              -800.0,
                              8150));
    this.ship.addWayPoints(shipRoute);
    
    city.setActive(true);
  }
  
  Scene update()
  {
    if (this.ship.movement.allVisited())
    {
      return this;//new FollowScene(camera, audio, ship, city, terrain);
    }
    else
    {
      return this;
    }
  }
}