class TerrainManager {
  static final int GridSize = 8000;
  Terrain grid;
  Terrain mountains;
  Terrain outsideMountains;
  
  boolean areMountainsStatic = false;
  boolean renderingOutside = false;
  
  public TerrainManager() {
    noiseSeed(0);
    grid = new Terrain(GridSize, GridSize, 0, 0, false);
    mountains = new Terrain(GridSize, GridSize, 0, 0, true);
    outsideMountains = new Terrain(GridSize, GridSize, 0, -Terrain.GridCellSize,  true);
  }
  
  void setMountainsStatic(boolean value) {
    areMountainsStatic = value;
  }
  
  void setRenderingOutside(boolean val) {
    renderingOutside = val;
  }
  
  void draw(CameraController camera) {
    boolean forceDrawWithCamera = !areMountainsStatic;
    grid.draw(camera.pos, forceDrawWithCamera);
    mountains.draw(camera.pos, forceDrawWithCamera);
    
    if(renderingOutside)
      outsideMountains.draw(camera.pos, forceDrawWithCamera);
  }
}