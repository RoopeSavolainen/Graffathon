class ShipRowManager {
  ArrayList<ShipRow> shipRows = new ArrayList<ShipRow>();
  float y = 0;
  boolean visible = true;
  
  ShipRowManager() {
      shipRows.add(new ShipRow(new PVector(-1550, -360, -40), new PVector(1000, -360, -40)));
      shipRows.add(new ShipRow(new PVector(-40, -400, -1500), new PVector(-40, -400, 1000)));
      shipRows.add(new ShipRow(new PVector(-1000, -380, -1000), new PVector(1000, -380, 1000)));
      
      for (int i = 1; i < 7; i++) {
        int axis = (int)random(-10,5);
        int start = (int)random(-20,20);
        int goal = (int)random(-20,20);
        shipRows.add(new ShipRow(new PVector(c.getBlockDist(axis), -70 * i, c.getBlockDist((start))),
                                 new PVector(c.getBlockDist(axis), -70 * i, c.getBlockDist((goal)))));
        shipRows.add(new ShipRow(new PVector(c.getBlockDist(start), -70 * i, c.getBlockDist(axis)),
                                 new PVector(c.getBlockDist(goal), -70 * i, c.getBlockDist(axis))));
      }
  }
  
  void setIsVisible(boolean val) {
    if(!val) y = 640;
    visible = val;
    
  }
  
  void draw() {
    if(visible && y > 0) y -= 1 / (float)frameRate * 600; //(float)millis();
    pushMatrix();
    translate(0, y, 0);
    for(ShipRow shipRow : shipRows) {
      shipRow.draw();
    }
    
    popMatrix();
  }
}