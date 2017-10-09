boolean isOptionsOpen = false;
float optionsMargin;
boolean optionsHovered = false;

boolean shuffled = false;
boolean repeat1 = false;
boolean repeatAll = true;

void optionsSetup() {
  optionsMargin = height*0.025;
}

void optionsDraw() {
  if (mouseX>= optionsMargin && mouseY >= optionsMargin && mouseX <= optionsMargin*3.5 && mouseY <= optionsMargin*3.5 ) {
      optionsHovered = true;
    } else {
      optionsHovered = false;
    }
  if (!isOptionsOpen) {
    displayOptionsButton(optionsHovered);
  } else {
    displayOptionsMenu();
  }
}

void displayOptionsButton(boolean isHovered) {
  if (isHovered) {
    setFillToColourScheme(colours[0]);
  } else {
    setFillToColourScheme(colours[0], 100);
  }
  rect(optionsMargin, optionsMargin, optionsMargin*2.5, optionsMargin*2.5, 14);
  if (isHovered) {
    setFillToColourScheme(colours[2]);
  } else {
    setFillToColourScheme(colours[2], 100);
  }
  //3 slashes in the button
  rect(optionsMargin*1.5, optionsMargin*1.5, optionsMargin*1.5, optionsMargin*0.3, 2);
  rect(optionsMargin*1.5, optionsMargin*2, optionsMargin*1.5, optionsMargin*0.3, 2);
  rect(optionsMargin*1.5, optionsMargin*2.5, optionsMargin*1.5, optionsMargin*0.3, 2);
}

void displayOptionsMenu() {
  //main window
  setFillToColourScheme(colours[0], 200);
  rect(width*0.025, height*0.025, width*0.95, height*0.95, 18);
  
  //exit button
  setFillToColourScheme(colours[3], 200);
  rect(width*0.04, height*0.04, optionsMargin*2, optionsMargin*2, 5);
  setFillToColourScheme(colours[4]);
  triangle(width*0.05, height*0.08, width*0.065, height*0.045, width*0.08, height*0.08);
  
  //PLAYBACK OPTIONS
  translate(width*0.04, height*0.1);
  displayPlayback();
  displayShuffle();
  displayRepeat();
  translate(-width*0.04, -height*0.1);
  
}

void displayPlayback() {
  setFillToColourScheme(colours[2], 200);
  rect(0,0, width*0.5, height*0.2, 12);
  textSize(26);
  setFillToColourScheme(colours[4]);
  text(getSongName(), width*0.02, height*0.04);
}

void displayShuffle() {
  
  
  if(shuffled) {
    setFillToColourScheme(mediaColour);
    rect(width*0.09, height*0.07, height*0.10, height*0.10, 12);
  }
  setFillToColourScheme(colours[0]);
  rect(width*0.1, height*0.08, height*0.08, height*0.08, 8);
  rotate(-PI/4);
  if(shuffled) {
    setFillToColourScheme(mediaColour);
  } else {
    setFillToColourScheme(colours[2]);
  }
  rect(width*0.01, height*0.15, height*0.01, height*0.05);
  triangle(width*0, height*0.20, width*0.03, height*0.2, width*0.015, height*0.215);
  rect(width*-0.015, height*0.175, height*0.05, height*0.01);
  triangle(width*0.035, height*0.165, width*0.035, height*0.195, width*0.05, height*0.18);
  rotate(PI/4);
  
}

void displayRepeat() {
  if(repeatAll) {
    setFillToColourScheme(mediaColour);
    rect(width*0.24, height*0.07, height*0.10, height*0.10, 12);
  }
  setFillToColourScheme(colours[0]);
  rect(width*0.25, height*0.08, height*0.08, height*0.08, 8);
  if(repeat1 || repeatAll) {
    setFillToColourScheme(mediaColour);
  } else {
    setFillToColourScheme(colours[2]);
  }
  translate(width*0.25+height*0.04, height*0.12);
  rotate(-PI/2);
  arc(0, 0, height*0.05, height*0.05, 0,6*PI/4);
  rotate(PI/2);
  setFillToColourScheme(colours[0]);
  ellipse(0,0,height*0.03, height*0.03);
  
  if(repeat1 || repeatAll) {
    setFillToColourScheme(mediaColour);
  } else {
    setFillToColourScheme(colours[2]);
  }
  triangle(-height*0.0325, 0, -height*0.005, 0, -height*0.0185, -height*0.01);
  if(repeat1) {
    textSize(15);
    text("1",-height*0.0075,height*0.005);
  }
  translate(-width*0.25+height*0.04, -height*0.12);
}

void toggleShuffle() {
  if(shuffled) {
    shuffled = false;
    unshuffleCurrentPlaylist();
  } else {
    shuffled = true;
    shuffleCurrentPlaylist();
  }
}

void toggleRepeat() {
  if (repeatAll) {
    if (repeat1) {
      repeatAll = false;
      repeat1 = false;
    } else {
      repeat1 = true;
    }
  } else {
    repeatAll = true;
  }
}