import ddf.minim.*;
import ddf.minim.ugens.*;

class SynthPad implements Instrument
{
  Summer out;
  public Oscil osc;
  public Oscil fm;
  
  SynthPad(Summer out) {
    osc = new Oscil(0, 1, Waves.SINE);
    fm = new Oscil(0, 1, Waves.SINE);
    fm.patch(osc.phase);
    osc.patch(out);
    this.out = out;
  }
  
  void playNote(float freq, float amp) {
    fm.setFrequency(freq/2);
    osc.setFrequency(freq);
    osc.setAmplitude(amp);
  }
  
  void noteOn(float x) {
  }
  
  void noteOff() {
  }
  
}