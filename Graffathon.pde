import ddf.minim.*;
import moonlander.library.*;

Moonlander ml;
TerrainManager terrain;
Sky sky;
ArrayList<ShipRow> shipRows = new ArrayList<ShipRow>();

AudioController ac;

CameraController cam;

City c = new City(0.45, 5);
Ship s;
ArrayList<PVector> shipRoute = new ArrayList();

private Scene currentScene;

LineEffect le;

void setup()
{
  size(1280, 720, P3D);
  frameRate(60);
  smooth();
  colorMode(RGB, 255);


  sky = new Sky();
  
  shipRows.add(new ShipRow(new PVector(-1500, -400, 0), new PVector(0, -400, 0)));
  shipRows.add(new ShipRow(new PVector(0, -400, -1500), new PVector(0, -400, 0)));
  shipRows.add(new ShipRow(new PVector(-1000, -400, -1000), new PVector(0, -400, 0)));
  
  randomSeed(0);
  for (int i = 1; i < 4; i++) {
    int axis = (int)random(-10,5);
    int start = (int)random(-20,20);
    int goal = (int)random(-20,20);
    shipRows.add(new ShipRow(new PVector(c.getBlockDist(axis), -200 * i, c.getBlockDist((start))),
                             new PVector(c.getBlockDist(axis), -200 * i, c.getBlockDist((goal)))));
    shipRows.add(new ShipRow(new PVector(c.getBlockDist(start), -200 * i, c.getBlockDist(axis)),
                             new PVector(c.getBlockDist(goal), -200 * i, c.getBlockDist(axis))));
  }

  ml = new Moonlander(this, new TimeController(10));
  ml.start();
  
  ac = new AudioController(new Minim(this));
  
  cam = new CameraController(new PVector(0, -120.0, 2000.0), new PVector(0.0, 0.0, 0.0), ml);
  s = new Ship(new PVector(0, -120.0, 3000.0), ml);
  
  terrain = new TerrainManager();
  currentScene = new StartScene(cam, ac, s, c, terrain);
  
  cam.setViewTarget(s.pos);
  
  le = new LineEffect();
}

void draw()
{
  ml.update();
  ac.update();
  
  le.update();
  le.draw();
  
  background(0);
  
  currentScene = currentScene.update();
  cam.update();

  directionalLight(153, 192, 255, 0.5, 1, 0.5);
  
  float f = (ac.getBassIntensity() > 0.3 ? pow(ac.getBassIntensity(), 0.5) : 0.1); // * ac.getBassIntensity();
  float ambient = f * 255;
  ambientLight(ambient, ambient, ambient);
  c.draw(cam.pos);
  s.draw();

  float skyIntensity = ac.getBassIntensity() > 0.3 ? constrain((ac.getBassIntensity() - 0.3) / 0.7, 0, 1)  : 0;
  //sky.draw(cam.pos, skyIntensity);

  //terrain.draw(cam);
  
  for(ShipRow shipRow : shipRows) {
    shipRow.draw();
  }
}