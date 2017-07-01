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

City c = new City(0.45, 5);
Ship s;
ArrayList<PVector> shipRoute = new ArrayList();

private Scene currentScene;

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
  
  randomSeed(0);
  for (int i = 0; i < 4; i++) {
    int axis = (int)random(-10,5);
    int start = (int)random(-20,20);
    int goal = (int)random(-20,20);
    shipRows.add(new ShipRow(new PVector(c.getBlockDist(axis), -100 * i, c.getBlockDist((start))),
                             new PVector(c.getBlockDist(axis), -100 * i, c.getBlockDist((goal)))));
    shipRows.add(new ShipRow(new PVector(c.getBlockDist(start), -100 * i, c.getBlockDist(axis)),
                             new PVector(c.getBlockDist(goal), -100 * i, c.getBlockDist(axis))));
  }

  ml = new Moonlander(this, new TimeController(4));
  ml.start();
  
  ac = new AudioController(new Minim(this));
  
  cam = new CameraController(cameraPos, cameraLookAt, ml);
  s = new Ship(new PVector(320.0, -120.0, -2000.0), ml);
  
  currentScene = new FollowScene(cam, ac, s, c);
  
  cam.setViewTarget(s.pos);
}

void draw()
{
  ml.update();
  ac.update();
  
  time = ml.getValue("time");
  background(0);
  
  currentScene = currentScene.update();
  cam.update();

  println(cam.pos.x, " : ", cam.pos.y, " : ", cam.pos.z);
  println(cameraPos.x, " : ", cameraPos.y, " : ", cameraPos.z);

  directionalLight(153, 192, 255, 0.5, 1, 0.5);
  
<<<<<<< Updated upstream
  ambientLight(255 * ac.getBassIntensity(), 255 * ac.getMidIntensity(), 255 * ac.getTrebleIntensity());
=======
  float f = (ac.getBassIntensity() > 0.3 ? pow(ac.getBassIntensity(), 0.5) : 0.1); // * ac.getBassIntensity();
  float ambient = f * 255;
  ambientLight(ambient, ambient, ambient);
  //ambientLight(128 * ac.getBassIntensity(), 128 * ac.getMidIntensity(), 128 * ac.getTrebleIntensity());
>>>>>>> Stashed changes
  pointLight(255, 255, 255, width/2*sin((float)time/10), 50, 0);

  c.draw(cameraPos);
  s.draw();

<<<<<<< Updated upstream
  sky.draw(cameraPos);
=======
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

  float skyIntensity = ac.getBassIntensity() > 0.3 ? constrain((ac.getBassIntensity() - 0.3) / 0.7, 0, 1)  : 0;
  sky.draw(cameraPos, skyIntensity);
>>>>>>> Stashed changes
  grid.draw(cameraPos);
  mountains.draw(cameraPos);
  
  for(ShipRow shipRow : shipRows) {
    shipRow.draw();
  }
}