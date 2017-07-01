abstract class Scene
{
  protected CameraController camera;
  protected AudioController audio;
  
  protected Ship ship;
  protected City city;
  
  Scene(CameraController camera, AudioController audio, Ship ship, City city)
  {
    this.camera = camera;
    this.audio = audio;
    this.ship = ship;
    this.city = city;
  }
  abstract Scene update();
}