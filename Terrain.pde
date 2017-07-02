
class Terrain {
  public static final int GridCellSize = 50;
  
  public final float[] heightMap;
  public final boolean[] isMountain;
  public final int _sizeX, _sizeY;
  public final int hmapSizeX, hmapSizeY;
  public final int hmapOffsetX, hmapOffsetY;
  public final boolean isMountains;
  
  public final ArrayList<PVector> vertices = new ArrayList<PVector>();
  public final PShape shape;
  
  public Terrain(int sizeX, int sizeY, int hmapOffsetX, int hmapOffsetY, boolean isMountains) {
    this._sizeX = sizeX;
    this._sizeY = sizeY;
    
    this.hmapSizeX = sizeX / GridCellSize;
    this.hmapSizeY = sizeY / GridCellSize;
    this.hmapOffsetX = hmapOffsetX;
    this.hmapOffsetY = hmapOffsetY;
    
    this.isMountains = isMountains;
    isMountain = new boolean[(this.hmapSizeX + 1) * (this.hmapSizeY + 1)];
    heightMap = this.generateHeightMap(this.hmapSizeX, this.hmapSizeY);
    
    shape = createShape();
    genVertices();
  }
  void draw(PVector cameraPos) { this.draw(cameraPos, false); }
  void draw(PVector cameraPos, boolean forceDrawWithCamera) {
    pushMatrix();
    PVector t = new PVector(cameraPos.x - (cameraPos.x) % (GridCellSize), cameraPos.z - (cameraPos.z ) % (GridCellSize));
    //println(t);
    
    PVector baseOffset = new PVector(-this._sizeX / 2 + (hmapOffsetX / (float)GridCellSize) * _sizeX, -this._sizeY / 2+ (hmapOffsetY / (float)GridCellSize) * _sizeY);
    if(forceDrawWithCamera) { translate(baseOffset.x, 0, baseOffset.y); }
    else if(!this.isMountains) translate(baseOffset.x + t.x, 0, baseOffset.y + t.y);
    else translate(baseOffset.x + cameraPos.x, 0, baseOffset.y + cameraPos.z);

    shape.setFill(color(24, 24, 64));
    shape.setStroke(color(255, 0, 0));
    shape.setStrokeWeight(2);
   /*beginShape(QUADS);
    
    for(int i = 0; i < vertices.size(); i++) {
      PVector v = vertices.get(i);
      vertex(v.x, v.y, v.z);
    }
     endShape(); */
    
    shape(shape);
    /*
    // TODO: one performance improvement would be to calculate all vertices to a
    // single array and then just loop the vertices in here and just call vertex(v)
    for(int hx = 0; hx < this.hmapSizeX; hx++) {
        for(int hy = 0; hy < this.hmapSizeY; hy++) {
          if(this.isMountains != this.isMountain[hx + hy * this.hmapSizeX]) continue;
           float x = hx * GridCellSize;
           float y = hy * GridCellSize;
           
           vertex(x, getZ(hx, hy), y);
           vertex(x + GridCellSize, getZ(hx + 1, hy), y);
           vertex(x + GridCellSize, getZ(hx + 1, hy + 1), y + GridCellSize);
           vertex(x, getZ(hx, hy + 1), y + GridCellSize); 
         }
      }
      */
      popMatrix();
    }
    
    private void genVertices() {
      // TODO: one performance improvement would be to calculate all vertices to a
    // single array and then just loop the vertices in here and just call vertex(v)
     // stroke(255, 0, 0); // red stroke
   // strokeWeight(2); // 2px 
    shape.setFill(color(24, 24, 64));
  //  shape.setStroke(color(255, 0, 0));
    shape.beginShape(QUADS);
    
    for(int hx = 0; hx < this.hmapSizeX; hx++) {
        for(int hy = 0; hy < this.hmapSizeY; hy++) {
          if(this.isMountains != this.isMountain[hx + hy * this.hmapSizeX]) continue;
           float x = hx * GridCellSize;
           float y = hy * GridCellSize;
           
    stroke(255, 0, 0); // red stroke
    strokeWeight(2); // 2px 
           shape.vertex(x, getZ(hx, hy), y);
           shape.vertex(x + GridCellSize, getZ(hx + 1, hy), y);
           shape.vertex(x + GridCellSize, getZ(hx + 1, hy + 1), y + GridCellSize);
           shape.vertex(x, getZ(hx, hy + 1), y + GridCellSize);
           
           vertices.add(new PVector(x, getZ(hx, hy), y));
           vertices.add(new PVector(x + GridCellSize, getZ(hx + 1, hy), y));
           vertices.add(new PVector(x + GridCellSize, getZ(hx + 1, hy + 1), y + GridCellSize));
           vertices.add(new PVector(x, getZ(hx, hy + 1), y + GridCellSize));
         }
      }
      
      shape.endShape();
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
          if(hmapOffsetX != 0 || hmapOffsetY != 0) {
            distFromCenter = 1;
          }
          
          float multiplier = 10;
          float baseAdd = 0;
          isMountain[x + y * sizeX] = false;
          if(distFromCenter > 0.6) {
            float lerpVal = (distFromCenter - 0.6) * 5;
             multiplier = lerp(10, 400,  lerpVal);
             baseAdd += lerp(0, -500, constrain(lerpVal, 0, 1));
             isMountain[x + y * sizeX] = true;
          }
          
          if(hmapOffsetX != 0 || hmapOffsetY != 0) {
            multiplier *= 0.2;
          }
          
          int testX = x + hmapOffsetX;
          int testY = y + hmapOffsetY;
          hmap[x + y * sizeX] = noise(testX * GridCellSize / HeightMapBias, testY * GridCellSize / HeightMapBias) * multiplier + baseAdd;
        }
      }
      
      return hmap;
    }
    
}