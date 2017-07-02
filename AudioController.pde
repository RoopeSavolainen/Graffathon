import ddf.minim.analysis.*;

class AudioController {
  
  Minim minim;
  public AudioPlayer ap;
  FFT fft;
  
  private float bass, mid, treble;
  
  AudioController(Minim minim) {
    this.minim = minim;
    this.ap = minim.loadFile("Exit the Premises.mp3");
    this.ap.play();
    this.fft = new FFT(ap.bufferSize(), ap.sampleRate());
  }
  
  void update() {
    
    
    bass = mid = treble = 0;
    int thirdOfBand = (fft.specSize() - 120) / 3;
    
    fft.forward(ap.mix);
    for (int i = 20; i < fft.specSize() - 100; i++) {
      if (i < thirdOfBand) {
        bass += fft.getBand(i);
      } else if (i - thirdOfBand < thirdOfBand) {
        mid += fft.getBand(i);
      } else {
        treble += fft.getBand(i);
      }
    }
    bass =  (bass / thirdOfBand) / 8;
    mid = (mid / thirdOfBand) / 3.75;
    treble = (treble / thirdOfBand) / 2.85;
  }
  
  float getBassIntensity() {
    return bass;
  }
  
  float getMidIntensity() {
    return mid;
  }
  
  float getTrebleIntensity() {
    return treble;
  }
}