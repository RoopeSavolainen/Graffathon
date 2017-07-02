import ddf.minim.*;
import moonlander.library.*;

Moonlander ml;
TerrainManager terrain;
ShipRowManager shipRows;
Sky sky;

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
  
 
  ml = new Moonlander(this, new TimeController(10));
  ml.start();
  
  ac = new AudioController(new Minim(this));
  
  cam = new CameraController(new PVector(0.0, -240.0, 0.0), new PVector(0.0, 0.0, 0.0), ml);
  s = new Ship(new PVector(0.0, -120.0, 0.0), ml);
  
  terrain = new TerrainManager();
  cam.setViewTarget(s.pos);
  
  le = new LineEffect();

  shipRows = new ShipRowManager();
  currentScene = new StartScene(cam, ac, s, c, terrain, shipRows);

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
  sky.draw(cam.pos, skyIntensity);

  terrain.draw(cam);
  shipRows.draw();
}
