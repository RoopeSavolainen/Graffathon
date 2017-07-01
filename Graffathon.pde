import ddf.minim.*;
import moonlander.library.*;

Moonlander ml;
Terrain terrain;
Sky sky;

double time;
PShape detailShip;

PVector cameraPos = new PVector(320, -240, -2000);
PVector cameraLookAt = new PVector(0, 0, 0);

CameraController cam;
ArrayList<PVector> route = new ArrayList();

void setup()
{
  size(1280, 720, P3D);
  frameRate(60);
  smooth();
  colorMode(RGB, 255);
  
  detailShip = loadShape("ship.obj");
  terrain = new Terrain(6000, 6000);
  sky = new Sky();

  ml = Moonlander.initWithSoundtrack(this, "Exit the Premises.mp3", 128, 4);
  ml.start();
  
  cam = new CameraController(cameraPos, cameraLookAt, ml);
  
  route.add(new PVector(320.0, -240.0, -2000.0));
  route.add(new PVector(320.0, -240.0, 200.0));
  route.add(new PVector(3000.0, -240.0, 200.0));
  route.add(new PVector(3000.0, -240.0, 3000.0));
  cam.setWayPoints(route);
}

void draw()
{
  ml.update();
  
  time = ml.getValue("time");
  background(0);
  cam.update();

  directionalLight(153, 192, 255, 0.5, 1, 0.5);
  pushMatrix();

  ambientLight(64, 64, 64);
  pointLight(255, 255, 255, width/2*sin((float)time/10), 50, 0);

  pushMatrix();
  translate(0, 50, 0);
  rotateY((float)time/2*PI);
  rotateX(radians(-15));
  scale(4);
  shape(detailShip, 0, 0);
  popMatrix();

  popMatrix();
  
  sky.draw(cameraPos);
  terrain.draw();
}
