import ddf.minim.*;
import moonlander.library.*;

Moonlander ml;

double time;

void setup()
{
  size(640, 480, P2D);
  ml = Moonlander.initWithSoundtrack(this, "test.mp3", 60, 8);
  ml.start();
}

void draw()
{
  ml.update();
  time = ml.getValue("time");
  
  pushMatrix();
  scale(sin((float)time) + 1);
  translate(50, 50);
  
  background(255);
  noStroke();
  fill(0, 0, 255);
  rect(0, 0, 50, 50);
  
  popMatrix();
}