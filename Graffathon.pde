import ddf.minim.*;
import moonlander.library.*;

Moonlander ml;
Terrain terrain;

double time;
PShape detailShip;

void setup()
{
  size(640, 480, P3D);
  frameRate(60);
  smooth();
  colorMode(RGB, 255);

  detailShip = loadShape("ship.obj");
  terrain = new Terrain(10000, 10000);

  ml = Moonlander.initWithSoundtrack(this, "test.mp3", 60, 4);
  ml.start();
}

void draw()
{
  ml.update();
  time = ml.getValue("time");
  
  background(0);
  
  pushMatrix();
  
  translate(width/2.0, height/2.0);
  
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
  terrain.draw();
}