
class DumbShip {
  public final PVector size;
  public final float speedMultiplier;
  public final PVector offset;
  
  public DumbShip(PVector size, float speedMultiplier, PVector offset) {
     this.size = size;
     this.speedMultiplier = speedMultiplier;
     this.offset = offset;
  }
  
  void draw(PVector pos, float rotationX) {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(rotationX);
    box(size.x, size.y, size.z);
    popMatrix();
  }
}

class ShipRow {
  public static final float BaseSpeed = 40;
  
  public final PVector from, to;
  public final float dist;
  public final int count;
  
  private ArrayList<DumbShip> ships = new ArrayList<DumbShip>();
  
  public ShipRow(PVector from, PVector to) {
    this.from = from;
    this.to = to;
    
    dist = from.dist(to);
    count = (int)(dist / 10);
    
    this.generateShips();
  }
  
  void draw() {
    float seconds = ((float)millis() / 1000.0);
    float speed = BaseSpeed / dist;
    float spacing = 1.0 / count;
   // fill(255);
    fill(24, 24,40);
    stroke(96, 96, 160);
    strokeWeight(1);
    
    PVector diff = to.copy().sub(from);
    float rotationX = atan2(diff.x, diff.z);
    // println(rotationX + " " + to.copy().sub(from));
    for(int i = 0; i < ships.size(); i++) {
     // ship.progress += BaseSpeed * ship.speedMultiplier;
      ships.get(i).draw(
        PVector.lerp(
          from, 
          to, 
          (spacing * i + seconds * speed * ships.get(i).speedMultiplier) % 1).add(ships.get(i).offset), rotationX);
    }
  }  
  
  void generateShips() {
     for(int i = 0; i < count; i++) {
        float width = random(2.5, 4);
        float height = random(1.2, 2);
        float depth = random(5, 10);
        
        PVector offset = new PVector(random(-4, 4), random(-4, 4), 0);
        ships.add(new DumbShip(new PVector(width, height, depth), random(0.5, 1.5), offset));
     }
  }
}