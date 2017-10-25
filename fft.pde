import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer jingle;
FFT fftLin;


void fftSetup() {
    minim = new Minim(this);
}

float[] fftAnalysis() {
 FloatList list = new FloatList();
  fftLin.forward(jingle.mix);
  for(int i = 0; i < fftLin.avgSize(); i++)
    {
      list.append(atan(fftLin.getAvg(i)*0.1));
      //println(list.get(i));
    }
    return list.array();
}

void fftPause() {
  jingle.pause();
}

void fftPlay() {
  jingle.play();
}

void fftPlaySong(String song) {
  println(song);
  jingle = minim.loadFile(song, 1024);
  jingle.loop();
  fftLin = new FFT( jingle.bufferSize(), jingle.sampleRate() );
  fftLin.logAverages(22, 3);
  jingle.pause();
  jingle.play();
  jingle.setGain(volume);
}

boolean isEarlySong() {
  return ((float)jingle.position()/ (float)jingle.length()) < 0.05;
}

void setSongCue(int cue) {
  jingle.cue(cue);
}

float getSongCompletionRatio() {
  return (float)jingle.position()/ (float)jingle.length();
}