class Ship
{
  private PShape model;
  
  public PVector pos;
  public PVector direction;
  
  public MovementTracker movement;
  private Moonlander ml;
  
  private ArrayList<PVector> waypoints;
  private ExhaustSystem exhaust;
  
  Ship(PVector _pos, Moonlander _ml)
  {
    pos = _pos;
    direction = new PVector(0.0, 0.0, 0.0);
    movement = new MovementTracker(pos, direction);
    model = loadShape("ship.obj");
    ml = _ml;
    waypoints = new ArrayList<PVector>();
    movement.route = waypoints;
    exhaust = new ExhaustSystem(10, new PVector(0, -20, -100));
  }
  
  public void addWayPoints(ArrayList<PVector> p)
  {
    if (movement.route == null)
    {
      movement.route = waypoints;
    }
    waypoints.addAll(p);
  }
  
  void draw()
  {
    float time = (float)ml.getValue("ship");
    movement.update(time);
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    scale(0.75);
    PVector diff = direction.copy().sub(pos);
    float rotY = atan2(diff.x, diff.z);
    rotateY(rotY);
    
    shape(model);
    exhaust.applyForce(direction.copy().mult(-1).limit(5.0f));
    scale(100);
    exhaust.update();
    popMatrix();
  }  
}

/*
 * Heavily inspired by the Smoke Particle tutorial at
 * https://processing.org/examples/smokeparticlesystem.html
 */
class ExhaustSystem
{
  float prevMillis = 0;
  ArrayList<ExhaustParticle> particles;
  PVector pos;
  
  PShape particleModel;
  
  int n;
  
  ExhaustSystem(int n, PVector pos)
  {
    this.particles = new ArrayList<ExhaustParticle>();
    this.pos = pos.copy();
    
    this.n = n;
    particleModel = createModel();
  }
  
  void update()
  {
    float diff = millis() - prevMillis;
    prevMillis = millis();
    for (int i = particles.size()-1; i >= 0; i--)
    {
      ExhaustParticle p = particles.get(i);
      p.update(diff);
      if (p.isDead())
      {
        particles.remove(i);
      }
    }
    addParticles();
  }
  
  void applyForce(PVector f)
  {
    for (ExhaustParticle p : particles)
      p.a.add(f);
  }
  
  void addParticles()
  {
    for (int i = 0; i < this.n; i++)
      particles.add(new ExhaustParticle(this.pos, particleModel));
  }
  
  PShape createModel()
  {
    PShape model = createShape();
    model.beginShape(TRIANGLES);
    
    model.vertex(-0.5,0.0,-0.433013);
    model.vertex(0.5,0.0,-0.433013);
    model.vertex(0.0,0.0,0.433013);
    
    model.vertex(0, 1, 0);
    model.vertex(-0.5,0.0,-0.433013);
    model.vertex(0.5,0.0,-0.433013);
    
    
    model.vertex(0, 1, 0);
    model.vertex(0.5,0.0,-0.433013);
    model.vertex(0.0,0.0,0.433013);
    
    
    model.vertex(0, 1, 0);
    model.vertex(-0.5,0.0,-0.433013);
    model.vertex(0.0,0.0,0.433013);
    
    model.endShape();
    return model;
  }
}

class ExhaustParticle
{
  private PVector pos;
  private PVector vel;
  public PVector a;
  
  float lifeTime;
  
  private PShape model;
  
  ExhaustParticle(PVector pos, PShape model)
  {
    float v_x = randomGaussian()*0.3;
    float v_y = randomGaussian()*0.3;
    float v_z = randomGaussian()*0.3 - 2.0;
    this.vel = new PVector(v_x, v_y, v_z);
    this.pos = pos.copy();
    this.a = new PVector(0, 0, 0);
    this.lifeTime = 500.0;
    this.model = model;
  }
  
  void update(float time)
  {
    vel.add(a);
    pos.add(vel);
    lifeTime -= time;
    a.mult(0);
    
    println(a);
    println(vel);
    println(pos);
    println();
    
    imageMode(CENTER);
    pushMatrix();
    //translate(pos.x, pos.y, pos.z);
    shape(model);
    
    model.setFill(color(255, 168, 0));
    popMatrix();
  }
  
  boolean isDead()
  {
    if (lifeTime <= 0.1)
    {
      return true;
    }
    return false;
  }
}