class AudioController {
  Minim minim;
  Moonlander ml;
  AudioOutput out;
  Summer summer;
  SynthPad sp;
  SynthPad sp2;
  
  AudioController(Minim minim, Moonlander ml) {
    this.minim = minim;
    this.ml = ml;
    this.out = minim.getLineOut();
    this.summer = new Summer();
    this.sp = new SynthPad(summer);
    //this.sp2 = new SynthPad(summer);
    summer.patch(out);
  }
  
  void update() {
    sp.playNote(noteToFrequency((float)ml.getValue("SynthPadN")), (float)ml.getValue("SynthPadV"));
    //sp.osc.setWaveform(Waves.SQUARE);
    //sp.fm.setWaveform(Waves.PHASOR);
    //sp2.playNote(noteToFrequency((float)ml.getValue("SynthPadN2")), (float)ml.getValue("SynthPadV2"));
    //print(ml.getValue("SynthPadV") + " " + ml.getValue("SynthPadN") + "\n");
  }
  
  float noteToFrequency(float note) {
    return 440 * pow(2, (note - 48)/12);
  }
  
}