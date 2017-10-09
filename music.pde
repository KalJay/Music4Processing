int trackNumber = 0;
StringList playlist;

void musicSetup() {
  importSounds();
  fftPlaySong(playlist.get(0));
}

void playNextSong() {
  jingle.pause();
  if (repeatAll && !repeat1) {
    trackNumber +=1;
    trackNumber = trackNumber%playlist.size();
  } else {
    if(!repeat1) {
      trackNumber += 1;
    }
  }
  
  println(trackNumber);
  //println(getSounds().length);
  if(trackNumber >= playlist.size()) {
    paused = true;
    fftPause();
    trackNumber = -1;
  } else {
    fftPlaySong(playlist.get(trackNumber));
    paused = false;
  }
}

void playPreviousSong() {
  if (isEarlySong()) {
    if (trackNumber <= 0) {
      trackNumber = playlist.size()-1;
    } else {
      trackNumber -= 1;
    }
    jingle.pause();
    fftPlaySong(playlist.get(trackNumber));
    paused = false;
  } else {
    setSongCue(1);
  }
}

String getSongName() {
  AudioMetaData meta = jingle.getMetaData();
  if (meta.title().equals("")) {
    if (meta.fileName().length() > 24){
      return meta.fileName().substring(0,26) + "...";
    } else {
      return meta.fileName();
    }
  } else {
    if (meta.title().length() > 24){
      return meta.title().substring(0,26) + "...";
    } else {
      return meta.title();
    }
  }
}

void shuffleCurrentPlaylist() {
  boolean found = false;
  playlist.shuffle();
  if(jingle.isPlaying()) {
    for(int i = 0; i < playlist.size(); i++) {
      if(sounds.get(trackNumber).equals(playlist.get(i)) && found == false) {
        trackNumber = i;
        found = true;
      }
    }
  }
  printArray(playlist.array());
  println(trackNumber);
}

void unshuffleCurrentPlaylist() {
  boolean found = false;
  if(jingle.isPlaying()) {
    for(int i = 0; i < playlist.size(); i++) {
       if(playlist.get(trackNumber).equals(sounds.get(i)) && found == false) {
         trackNumber = i;
         found = true;
       }
    }
  }
  importSounds();
  printArray(playlist.array());
  //println(trackNumber);
}

void importSounds() {
  if(playlist == null) {
    playlist = new StringList();
  }
  playlist.clear();
  for(int i=0; i < sounds.size(); i++) {
    playlist.append(sounds.get(i));
  }
}