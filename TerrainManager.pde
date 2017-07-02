class TerrainManager {
  static final int GridSize = 8000;
  Terrain grid;
  Terrain mountains;
  Terrain outsideMountains;
  
  boolean areMountainsStatic = false;
  
  public TerrainManager() {
    grid = new Terrain(GridSize, GridSize, 0, 0, false);
    mountains = new Terrain(GridSize, GridSize, 0, 0, true);
    outsideMountains = new Terrain(GridSize, GridSize, 0, -Terrain.GridCellSize,  false);
  }
  
  void setMountainsStatic(boolean value) {
    areMountainsStatic = value;
  }
  
  void draw(CameraController camera) {
    boolean forceDrawWithCamera = !areMountainsStatic;
    grid.draw(camera.pos, forceDrawWithCamera);
    mountains.draw(camera.pos, forceDrawWithCamera);
    outsideMountains.draw(camera.pos, forceDrawWithCamera);
  }
}