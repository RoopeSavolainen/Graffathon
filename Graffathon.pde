import ddf.minim.*;
import moonlander.library.*;

Moonlander ml;
Terrain grid;
Terrain mountains;
Sky sky;
ArrayList<ShipRow> shipRows = new ArrayList<ShipRow>();

AudioController ac;

double time;

PVector cameraPos = new PVector(320, -120, -3000);
PVector cameraLookAt = new PVector(0, 0, 0);

CameraController cam;
ArrayList<PVector> route = new ArrayList();

City c = new City(0.45, 5);
Ship s;
ArrayList<PVector> shipRoute = new ArrayList();

void setup()
{
  size(1280, 720, P3D);
  frameRate(60);
  smooth();
  colorMode(RGB, 255);

  grid = new Terrain(8000, 8000, false);
  mountains = new Terrain(8000, 8000, true);

  sky = new Sky();
  shipRows.add(new ShipRow(new PVector(-1500, -400, 0), new PVector(0, -400, 0)));
  shipRows.add(new ShipRow(new PVector(0, -400, -1500), new PVector(0, -400, 0)));
  shipRows.add(new ShipRow(new PVector(-1000, -400, -1000), new PVector(0, -400, 0)));
  shipRows.add(new ShipRow(new PVector(c.getBlockDist(0), -100, c.getBlockDist(10)), new PVector(c.getBlockDist(0), -100, c.getBlockDist(10))));

  ml = new Moonlander(this, new TimeController(4));
  ml.start();
  
  ac = new AudioController(new Minim(this));
  
  cam = new CameraController(cameraPos, cameraLookAt, ml);
  s = new Ship(new PVector(320.0, -120.0, -2000.0), ml);
  
  route.add(new PVector(320.0, -120.0, -3000.0));
  route.add(new PVector(320.0, -120.0, 200.0));
  route.add(new PVector(3000.0, -120.0, 200.0));
  route.add(new PVector(3000.0, -120.0, 3000.0));
  cam.setWayPoints(route);  

  shipRoute.add(new PVector(320.0, -120.0, -1000.0));
  shipRoute.add(new PVector(320.0, -120.0, 1000.0));
  shipRoute.add(new PVector(-2000.0, -120.0, 1000.0));
  s.setWayPoints(shipRoute);
  
  cam.setViewTarget(s.pos);
}

void draw()
{
  ml.update();
  ac.update();
  
  time = ml.getValue("time");
  background(0);
  
  cam.update();

  directionalLight(153, 192, 255, 0.5, 1, 0.5);
  
  ambientLight(128 * ac.getBassIntensity(), 128 * ac.getMidIntensity(), 128 * ac.getTrebleIntensity());
  pointLight(255, 255, 255, width/2*sin((float)time/10), 50, 0);

  c.draw(cameraPos);
  s.draw();

/*=======
 // cam.update();
  PVector pos = new PVector(-100, -450, -150 + millis()/ 24124124);
  camera(
    pos.x, pos.y, pos.z, //width/2.0, -height/2.0, -2200, // (height/2.0) / tan(PI*30.0 / 180.0), 
    pos.x + 50, 0, pos.z + 800, 
    0, 1, 0);

  directionalLight(153, 192, 255, -0.5, 1, 0.5);
  pushMatrix();
>>>>>>> Stashed changes */

  sky.draw(cameraPos);
  grid.draw(cameraPos);
  mountains.draw(cameraPos);
  
  for(ShipRow shipRow : shipRows) {
    shipRow.draw();
  }
}