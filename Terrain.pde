
class Terrain {
  public final int GridCellSize = 50;
  
  public final float[] heightMap;
  public final int _sizeX, _sizeY;
  public final int hmapSizeX, hmapSizeY;
  
  public Terrain(int sizeX, int sizeY) {
    this._sizeX = sizeX;
    this._sizeY = sizeY;
    
    this.hmapSizeX = sizeX / GridCellSize;
    this.hmapSizeY = sizeY / GridCellSize;
    
    heightMap = this.generateHeightMap(this.hmapSizeX, this.hmapSizeY);
  }
  
  void draw() {
    pushMatrix();
    translate(-this._sizeX / 2, 0, -this._sizeY / 2);
    
    stroke(255, 0, 0); // red stroke
    strokeWeight(2); // 2px 
    fill(24, 24, 64); // blue-ish fill color
    beginShape(QUADS);
    
    // TODO: one performance improvement would be to calculate all vertices to a
    // single array and then just loop the vertices in here and just call vertex(v)
    for(int hx = 0; hx < this.hmapSizeX; hx++) {
        for(int hy = 0; hy < this.hmapSizeY; hy++) {
           float x = hx * GridCellSize;
           float y = hy * GridCellSize;
           
           vertex(x, getZ(hx, hy), y);
           vertex(x + GridCellSize, getZ(hx + 1, hy), y);
           vertex(x + GridCellSize, getZ(hx + 1, hy + 1), y + GridCellSize);
           vertex(x, getZ(hx, hy + 1), y + GridCellSize); 
         }
      }
      
      endShape();
      popMatrix();
    }
    
    private float getZ(int x, int y) {
    x = constrain(x, 0, this.hmapSizeX - 1);
    y = constrain(y, 0, this.hmapSizeY - 1);
     
      return this.heightMap[x + y * this.hmapSizeX] + 0.1;
    }
    
    private final float HeightMapBias = 100;
    private float[] generateHeightMap(int sizeX, int sizeY) {
    //  sizeX++; sizeY++;
      
      float[] hmap = new float[sizeX * sizeY];
      PVector center = new PVector(sizeX, sizeY).div(2);
      for(int y = 0; y < sizeY; y++) {
        for(int x = 0; x < sizeX; x++) {
          PVector cur = new PVector(x, y);
          float distFromCenter = center.dist(cur) / (sizeX / 2);
          println("x = " + x + ", y = " +y  + ", distFromCenter = " + distFromCenter);
          
          float multiplier = 10;
          float baseAdd = 0;
          if(distFromCenter > 0.6) {
            float lerpVal = (distFromCenter - 0.6) * 5;
             multiplier = lerp(10, 400,  lerpVal);
             baseAdd += lerp(0, -500, constrain(lerpVal, 0, 1));
          }
          
          hmap[x + y * sizeX] = noise(x * GridCellSize / HeightMapBias, y * GridCellSize / HeightMapBias) * multiplier + baseAdd;
        }
      }
      
      return hmap;
    }
}