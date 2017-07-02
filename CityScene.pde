class CityScene extends Scene {
  CityScene(CameraController camera, AudioController audio, Ship ship, City city) {
    super(camera, audio, ship, city);
    
    ArrayList<PVector> route = new ArrayList();
    route.add(new PVector(0.0, -875.0, 500.0));
    route.add(new PVector(500.0, -750.0, 0.0));
    route.add(new PVector(0.0, -625.0, -500.0));
    route.add(new PVector(-500.0, -500.0, 0.0));
    
    route.add(new PVector(0.0, -500.0, 500.0));
    route.add(new PVector(500.0, -400.0, 0.0));
    route.add(new PVector(0.0, -300.0, -500.0));
    route.add(new PVector(-500.0, -250.0, 0.0));
    
    
    
    this.camera.addWayPoints(route);
    camera.setViewTarget(new PVector(0, 0, 0));
  
    ArrayList<PVector> shipRoute = new ArrayList();
    shipRoute.add(new PVector(0, 0, 0));
    this.ship.addWayPoints(shipRoute);
  }
  
  Scene update() {
    if (this.ship.movement.allVisited())
    {
      return new FollowScene(camera, audio, ship, city);
    }
    else
    {
      return this;
    }
  }
}