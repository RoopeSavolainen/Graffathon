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
    
    route.add(new PVector(320.0, -500.0, 3000.0));
    route.add(new PVector(640.0,
                          -500.0,
                          5900));
    route.add(new PVector(320,
                          -500.0,
                          15100));
    route.add(new PVector(5100,
                          -500.0,
                          15100));
    route.add(new PVector(3000,
                          -1000.0,
                          13000));
    this.camera.addWayPoints(route);
  
    ArrayList<PVector> shipRoute = new ArrayList();
    shipRoute.add(new PVector(320.0, -400.0, 320.0));
    
    shipRoute.add(new PVector(320.0, -400.0, 3000.0));
    shipRoute.add(new PVector(320,
                              -200.0,
                              15100));
    shipRoute.add(new PVector(5200,
                              -200.0,
                              15100));
    shipRoute.add(new PVector(8000,
                              -1000.0,
                              18050));
    this.ship.addWayPoints(shipRoute);
    
    city.setActive(true);
  }
  
  Scene update()
  {
    if (this.ship.movement.allVisited())
    {
      float endTime = (float)ml.getValue("time");
      println(endTime);
      camera();
      fill(230, 230, 230);
        
      if (endTime >= 0.5)
      {
        beginShape(QUAD);
        vertex(-100, -100, 0);
        vertex(-100, height+100, 0);
        vertex(width/3.0, height+100, 0);
        vertex(width/4.0, -100, 0);
        endShape();
      }
      if (endTime >= 1.0)
      {
        beginShape(QUAD);
        vertex(width+100, -100, 0);
        vertex(width+100, height+100, 0);
        vertex(width-width/3.0, height+100, 0);
        vertex(width-width/4.0, -100, 0);
        endShape();
      }
      
      if (endTime >= 1.5)
      {
        beginShape(QUAD);
        vertex(width+100, -100, 0);
        vertex(width+100, height+100, 0);
        vertex(-100, height+100, 0);
        vertex(-100, -100, 0);
        endShape();
      }
      if (endTime >= 2.5)
      {
        fill(0, 0, 0);
        textSize(72);
        text("Demon nimi", 96, 96);
        text("GNU/Konala", 240, 280);
      }
      if (endTime >= 3.5)
      {
        textSize(48);
        text("impliedfeline", width-360, height-64);
      }
      if (endTime >= 3.7)
      {
        text("ruuben", width-360, height-192);
      }
      if (endTime >= 3.9)
      {
        text("flai", width-360, height-320);
      }
      if (endTime >= 5.0)
      {
        text("Music: Kevin MacLeod - Exit the Premises", 32, height-96);
      }
      if (endTime >= 10.0)
      {
        exit();
      }
      return this;
    }
    else
    {
      return this;
    }
  }
}