class City
{
  private final static float w = 25;
  
  private final static float h_avg = 150;
  private final static float h_stdev = 100;
  
  private final static int drawAmount = 20;
  
  private float density;
  private int blockSize;
  
  private HashMap<Integer, HashMap<Integer, House>> houses;
  
  City(float _density, int _block)
  {
    density = _density;
    blockSize = _block;
    houses = new HashMap<Integer, HashMap<Integer, House>>();
  }
  
  void draw(PVector pos)
  {
    float _x = pos.x;
    float _z = pos.z;
    
    genHouses(_x, _z);
    
    int x_index = floor((float)_x / (w/density));
    int z_index = floor((float)_z / (w/density));
    x_index -= floor(x_index/blockSize);
    z_index -= floor(z_index/blockSize);
    
    for (int x = x_index - drawAmount; x < x_index + drawAmount; x++)
    {
      if (x % blockSize == 0)
      {
        continue;
      }
      pushMatrix();
      translate(x * (w/density), 0.0, 0.0);
      for (int z = z_index - drawAmount; z < z_index + drawAmount; z++)
      {
        if (z % blockSize == 0)
        {
          continue;
        }
        pushMatrix();
        translate(0.0, 0.0, z * (w/density));
        houses.get(x).get(z).draw();
        popMatrix();
      }
      popMatrix();
    }
  }
  
  public float getBlockDist(int n)
  {
    return w/density * ((float)blockSize * n - 0.5);
  }
  
  void genHouses(float _x, float _z)
  {
    int x_index = floor(_x / (w/density));
    int z_index = floor(_z / (w/density));
    x_index -= floor(x_index/blockSize);
    z_index -= floor(z_index/blockSize);
    
    for (int x = x_index - drawAmount; x < x_index + drawAmount; x++)
    {
      if (houses.get(x) == null)
      {
        houses.put(x, new HashMap<Integer, House>());
      }
      for (int z = z_index - drawAmount; z < z_index + drawAmount; z++)
      {
        if (houses.get(x).get(z) == null)
        {
          float h = randomGaussian() * h_stdev + h_avg;
          houses.get(x).put(z, new House(w, w, h));
        }
      }
    }
  }
}

class House
{
  private float w, d, h;
  House(float _w, float _d, float _h)
  {
    w = _w;
    d = _d;
    h = -_h;
  }
  void draw()
  {
    pushMatrix();
    translate(0.0, h/2.0, 0.0);
    stroke(128, 64, 64);
    shapeMode(CENTER);
    box(w,h,d);
    popMatrix();
  }
}