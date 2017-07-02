abstract class Scene
{
  protected CameraController camera;
  protected AudioController audio;
  
  protected Ship ship;
  protected City city;
  protected TerrainManager terrain;
  
  Scene(CameraController camera, AudioController audio, Ship ship, City city, TerrainManager terrain)
  {
    this.camera = camera;
    this.audio = audio;
    this.ship = ship;
    this.city = city;
    this.terrain = terrain;
  }
  abstract Scene update();
}