import ddf.minim.*;
import moonlander.library.*;

Moonlander ml;
Terrain terrain;
Sky sky;

double time;

PVector cameraPos = new PVector(320, -120, -2000);
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
  
  terrain = new Terrain(6000, 6000);
  sky = new Sky();

  ml = Moonlander.initWithSoundtrack(this, "Exit the Premises.mp3", 128, 4);
  ml.start();
  
  cam = new CameraController(cameraPos, cameraLookAt, ml);
  s = new Ship(new PVector(320.0, -120.0, 0.0), ml);
  
  route.add(new PVector(320.0, -120.0, -2000.0));
  route.add(new PVector(320.0, -120.0, 200.0));
  route.add(new PVector(3000.0, -120.0, 200.0));
  route.add(new PVector(3000.0, -120.0, 3000.0));
  cam.setWayPoints(route);
  
  
  shipRoute.add(new PVector(320.0, -120.0, 0.0));
  shipRoute.add(new PVector(320.0, -120.0, 1000.0));
  shipRoute.add(new PVector(-2000.0, -120.0, 1000.0));
  s.setWayPoints(shipRoute);
}

void draw()
{
  ml.update();
  
  time = ml.getValue("time");
  background(0);
  
  cam.update();

  directionalLight(153, 192, 255, 0.5, 1, 0.5);
  ambientLight(16, 16, 16);
  
  c.draw(cameraPos);
  s.draw();

  /*
  pushMatrix();
  translate(0, 50, 0);
  rotateY((float)time/2*PI);
  rotateX(radians(-15));
  scale(4);
  shape(detailShip, 0, 0);
  popMatrix();*/

  terrain.draw();
  sky.draw(cameraPos);
  terrain.draw();
}
