import ddf.minim.*;
import moonlander.library.*;

Moonlander ml;
Terrain terrain;
Sky sky;

double time;
PShape detailShip;

PVector cameraPos = new PVector(0, 0, 0);
PVector cameraLookAt = new PVector(0, 0, 0);

MovementTracker cam = new MovementTracker(cameraPos, cameraLookAt);
ArrayList<PVector> route = new ArrayList();

void setup()
{
  size(1280, 720, P3D);
  frameRate(60);
  smooth();
  colorMode(RGB, 255);
  
  route.add(new PVector(320.0, -240.0, -1000.0));
  route.add(new PVector(320.0, -240.0, -100.0));
  route.add(new PVector(640.0, -240.0, -100.0));
  cam.route = route;
  
  detailShip = loadShape("ship.obj");
  terrain = new Terrain(3000, 3000);
  sky = new Sky();

  ml = Moonlander.initWithSoundtrack(this, "test.mp3", 60, 4);
  ml.start();
}

void draw()
{
  ml.update();
  time = ml.getValue("time");
// <<<<<<< Updated upstream
  
  double cameraLerp = ml.getValue("camera");
  
  background(0);
 
  cam.update((float)cameraLerp);
  camera(cameraPos.x, cameraPos.y, cameraPos.z, cameraLookAt.x, cameraLookAt.y, cameraLookAt.z, 0, 1, 0);
/* =======

  background(0); 
  PVector pos = new PVector(0, -400, -6000 + millis()/ 5);
  camera(
    pos.x, pos.y, pos.z, //width/2.0, -height/2.0, -2200, // (height/2.0) / tan(PI*30.0 / 180.0), 
    pos.x, 0, pos.z + 1400, 
    0, 1, 0);
>>>>>>> Stashed changes */

  directionalLight(153, 192, 255, 0.5, 1, 0.5);
  pushMatrix();

  ambientLight(64, 64, 64);
/*<<<<<<< Updated upstream
  pointLight(255, 255, 255, width/2*sin((float)time/10), -50, 0);
  
  pushMatrix();
  translate(0, 100, 0);
  box(1000.0, 1.0, 1000.0);
  popMatrix();
  
======= */
  pointLight(255, 255, 255, width/2*sin((float)time/10), 50, 0);

  pushMatrix();
  translate(0, 50, 0);
  rotateY((float)time/2*PI);
  rotateX(radians(-15));
  scale(4);
  shape(detailShip, 0, 0);
  popMatrix();

  popMatrix();
  
  terrain.draw();
  sky.draw(cameraPos);
}