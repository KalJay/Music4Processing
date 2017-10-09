File dir; 
File [] files;
StringList sounds;
String[] songs;

void filesSetup() {
  dir= new File(dataPath(sketchPath()));
  files= dir.listFiles();
  findSounds();
}

void findSounds() {
  sounds = new StringList();
  for (int i = 0; i <= files.length - 1; i++) {
    String path = files[i].getAbsolutePath();
    if (isSound(path)) {
      sounds.append(path.substring(sketchPath().length()+1));
    }
  }
  printArray(sounds.array());
}

boolean isSound(String path) {
  if (path.toLowerCase().endsWith(".mp3")) {
    return true;
  }
  if (path.toLowerCase().endsWith(".wav")) {
    return true;
  }
  if (path.toLowerCase().endsWith(".aiff")) {
    return true;
  }
  if (path.toLowerCase().endsWith(".au")) {
    return true;
  }
  return false;
}