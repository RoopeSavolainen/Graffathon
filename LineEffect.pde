class LineEffect {
  
  final int maxX = 3000;
  final int maxY = 3000;
  final int maxZ = 3000;
  ArrayList<PVector> lines;
  
  LineEffect() {
    lines = new ArrayList<>();
  }
  
  void update() {
  }
  
  void draw() {
    randomSeed(0);
    for(PVector line : lines) {
      int color = (int)random(0, 3);
      if (color == 0) {
        stroke(255, 0, 0);
      } else if (color == 1) {
        stroke(0, 255, 0);
      } else {
        stroke(0, 0, 255);
      }
      float xOffSet = random(-1, 1);
      float zOffSet = random(-1, 1);
      line(line.x + xOffSet * maxX / 2, 0, line.z + zOffSet * maxZ / 2,
           line.x - xOffSet * maxX / 2, line.y, line.z - zOffSet * maxZ / 2);
    }
  }
}