class CityScene extends Scene {
  CityScene(CameraController camera, AudioController audio, Ship ship, City city, TerrainManager terrain) {
    super(camera, audio, ship, city, terrain);
    
    ArrayList<PVector> route = new ArrayList();
    float radius = 1200;
    
    route.add(new PVector(0.0, -1200.0, radius));
    route.add(new PVector(radius/4, -1150.0, 3*radius/4));
    route.add(new PVector(radius/2, -1100.0, radius/2));
    route.add(new PVector(3*radius/4, -1050.0, radius/4));
    
    route.add(new PVector(radius, -1000.0, 0));
    route.add(new PVector(3*radius/4, -950.0, -radius/4));
    route.add(new PVector(radius/2, -900.0, -radius/2));
    route.add(new PVector(radius/4, -850.0, -3*radius/4));
    
    route.add(new PVector(0.0, -800.0, -radius));
    route.add(new PVector(-radius/4, -750.0, -3*radius/4));
    route.add(new PVector(-radius/2, -700.0, -radius/2));
    route.add(new PVector(-3*radius/4, -650.0, -radius/4));
    
    route.add(new PVector(-radius, -600.0, 0));
    route.add(new PVector(-3*radius/4, -550.0, radius/4));
    route.add(new PVector(-radius/2, -500.0, radius/2));
    route.add(new PVector(-radius/4, -450.0, 3*radius/4));
    route.add(new PVector(0.0, -400.0, radius));
    
    route.add(new PVector(400.0, -350.0, -1200));
    
    
    
    this.camera.addWayPoints(route);
    camera.setViewTarget(new PVector(0, 0, 0));
  
    ArrayList<PVector> shipRoute = new ArrayList();
    shipRoute.add(new PVector(0, 0, 0));
    shipRoute.add(new PVector(0, 0, 0));
    this.ship.addWayPoints(shipRoute);
  }
  
  Scene update() {
    if (this.camera.movement.isVisited(15)) {
      camera.setViewTarget(new PVector(400, 350, -10000));
    }
    if (this.camera.movement.allVisited())
    { //<>//
      return new FollowScene(camera, audio, ship, city, terrain);
    }
    else
    {
      return this;
    }
  }
}