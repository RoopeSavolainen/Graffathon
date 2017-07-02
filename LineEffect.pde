class LineEffect {
  
  final int maxX = 1000;
  final int maxY = -3000;
  final int maxZ = 1000;
  ArrayList<PVector> lines;
  float millisCounter = 0;
  float lastTime = 0;
  
  LineEffect() {
    lines = new ArrayList<PVector>();
  }
  
  void update() {
    float elapsedTime = millis() - lastTime;
    lastTime = millis();
    if (millisCounter > 0) {
      millisCounter -= elapsedTime; 
      return;
    }
    millisCounter = (60 / 128) * 1000;
    lines.clear();
    //randomSeed(0);
    for (int i = 0; i < 50; i++) {
      lines.add(new PVector(random(-maxX, maxX), 0, random(-maxZ, maxZ)));
    }
  }
  
  void draw() {
    //randomSeed(0);
    for(PVector line : lines) {
      int colour = (int)random(0, 3);
      if (colour == 0) { stroke(255, 0, 0); }
      else if (colour == 1) { stroke(0, 255, 0); }
      else { stroke(0, 0, 255); }
      
      float xOffSet = random(-1, 1);
      float zOffSet = random(-1, 1);
      strokeWeight(4);
      line(line.x + xOffSet * maxX / 2, 0, line.z + zOffSet * maxZ / 2,
           line.x - xOffSet * maxX / 2, maxY, line.z - zOffSet * maxZ / 2);
      strokeWeight(1);
    }
  }
}
