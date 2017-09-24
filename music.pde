int trackNumber = 0;

void musicSetup() {
  fftPlaySong(getSounds()[0]);
}

void playNextSong() {
  jingle.pause();
  trackNumber += 1;
  trackNumber = trackNumber%getSounds().length;
  println(getSounds().length);
  fftPlaySong(getSounds()[trackNumber]);
}

void playPreviousSong() {
  if (isEarlySong()) {
    if (trackNumber == 0) {
      trackNumber = getSounds().length-1;
    } else {
      trackNumber -= 1;
    }
    jingle.pause();
    fftPlaySong(getSounds()[trackNumber]);
  } else {
    setSongCue(1);
  }
}