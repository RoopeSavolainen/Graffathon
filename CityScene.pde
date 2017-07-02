class CityScene extends Scene {
  CityScene(CameraController camera, AudioController audio, Ship ship, City city, TerrainManager terrain) {
    super(camera, audio, ship, city, terrain);
    
    ArrayList<PVector> route = new ArrayList();
    route.add(new PVector(0.0, -1000.0, 500.0));
    route.add(new PVector(250.0, -900.0, 250.0));
    route.add(new PVector(500.0, -800.0, 0.0));
    route.add(new PVector(250.0, -700.0, -250.0));
    
    route.add(new PVector(0.0, -600.0, -500.0));
    route.add(new PVector(-250.0, -500.0, -250.0));
    route.add(new PVector(-500.0, -450.0, 0.0));
    route.add(new PVector(-250.0, -400.0, 250.0));
    
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
    camera.setViewTarget(new PVector(0, 0, 0));
    if (this.camera.movement.allVisited())
    {
      return new FollowScene(camera, audio, ship, city, terrain);
    }
    else
    {
      return this;
    }
  }
}