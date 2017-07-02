class CityScene extends Scene {
  CityScene(CameraController camera, AudioController audio, Ship ship, City city, TerrainManager terrain) {
    super(camera, audio, ship, city, terrain);
    
      city.setActive(true);
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
    
    route.add(new PVector(0.0, -400.0, radius)); // 16
    route.add(new PVector(100, -400, 600));
    route.add(new PVector(400.0, -400, -1200));
    
    route.add(new PVector(1200, -500, 15)); // 19
    route.add(new PVector(0, -500, 15));
    route.add(new PVector(320, -400, 320)); // 21
    route.add(new PVector(-320, -100, -320));
    route.add(new PVector(0, -1200, 0));
    
    this.camera.addWayPoints(route);
    camera.setViewTarget(new PVector(0, 50, 0));
  
    ArrayList<PVector> shipRoute = new ArrayList();
    shipRoute.add(new PVector(320, -400, 320));
    this.ship.addWayPoints(shipRoute);
  }
  
  Scene update() { //<>//
    if (this.camera.movement.isVisited(16)) {
      camera.setViewTarget(new PVector(100, -200, 0));
    }
    
    /*
    if (this.camera.movement.isVisited(18)) {
      camera.setViewTarget(new PVector(400, -350, -10000));
    }*/
    
    if (this.camera.movement.isVisited(18)) {
      camera.setViewTarget(new PVector(1200, -350, 0));
    }
    
    if (this.camera.movement.isVisited(19)) {
      camera.setViewTarget(new PVector(-1000, -400, 15));
      //camera.setViewTarget(new PVector(0,0,0));
    }
      
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