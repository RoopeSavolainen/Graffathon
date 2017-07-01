class FollowScene extends Scene
{

  FollowScene(CameraController camera, AudioController audio, Ship ship, City city)
  {
    super(camera, audio, ship, city);
    
    ArrayList<PVector> route = new ArrayList();
    route.add(new PVector(320.0, -120.0, -3000.0));
    route.add(new PVector(320.0, -120.0, 200.0));
    route.add(new PVector(3000.0, -120.0, 200.0));
    route.add(new PVector(3000.0, -120.0, 3000.0));
    this.camera.addWayPoints(route);  
  
    ArrayList<PVector> shipRoute = new ArrayList();
    shipRoute.add(new PVector(320.0, -120.0, -1000.0));
    shipRoute.add(new PVector(320.0, -120.0, 1000.0));
    shipRoute.add(new PVector(-2000.0, -120.0, 1000.0));
    this.ship.addWayPoints(shipRoute);
  }
  
  Scene update()
  {
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