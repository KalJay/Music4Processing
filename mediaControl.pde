int[] mediaColour = {0,0,0};
int[] mediaAccent = {0,0,0};
boolean paused = false;
int mediaCircleDiameter;
int pausePlayPos[] = {-30,-30};
int prevPos[] = {-100, -30};
int nextPos[] = {40, -30};
float radians = 0.0;
float volume = 0.0;

void displayMedia(int n) {
  mediaCircleDiameter = height/3;
  mediaColour = getColourStep((n+350)%900);
  mediaAccent = getColourStep((n+500)%900);
  translate(width/2, height/2);
  displayCueWheel();
  setFillToColourScheme(mediaColour);
  rect(pausePlayPos[0],pausePlayPos[1],60,60, 18);
  if(paused) {
    displayPaused();
  } else {
    displayPlaying();
  }
  displayNextAndPrev();
  if (!jingle.isPlaying() && !paused) {
    playNextSong();
  }
  displayVolume();
  translate(-width/2, -height/2);
}

void displayPaused() {
  setFillToColourScheme(mediaAccent);
  triangle(-15,-18, -15, 18, 18, 0);
}

void displayPlaying() {
  setFillToColourScheme(mediaAccent);
  rect(-18, -18, 12, 36);
  rect(6, -18, 12, 36);
}

void displayNextAndPrev() {
  setFillToColourScheme(mediaColour);
  rect(prevPos[0], prevPos[1], 60, 60, 18);
  rect(nextPos[0], nextPos[1], 60, 60, 18);
  setFillToColourScheme(mediaAccent);
  rect(-88, -18, 6, 36);
  triangle(-82, 0, -52, -18, -52, 18);
  rect(82, -18, 6, 36);
  triangle(52, -18, 52, 18, 82, 0);
}

void displayCueWheel() {
  setFillToColourScheme(mediaAccent);
  ellipse(0,0, height/3.4, height/3.4);
  setFillToColourScheme(circleColour);
  ellipse(0,0, height/3.5, height/3.5);
  rotate(-PI/2);
  arc(0,0, height/3.2, height/3.2, 0, TWO_PI*getSongCompletionRatio());
  setFillToColourScheme(mediaAccent);
  ellipse((height/6.9)*cos(TWO_PI*getSongCompletionRatio()), (height/6.9)*sin(TWO_PI*getSongCompletionRatio()), height/90, height/90);
  rotate(PI/2);
  
  
}

void displayVolume() {
  setFillToColourScheme(mediaAccent);
  rect(-95,35, 190,5);
  setFillToColourScheme(mediaColour);
  rect(-95,35, 190*(volume+40)/80, 5);
  ellipse(190*(volume+40)/80 - 95, 37.5, 10, 10);
}

void handleMouseClick() {
  //println(mouseX + ", " + mouseY);
  if(!isOptionsOpen) {
    if ((mouseX - width/2) > -30 && (mouseX - width/2) < 30 && (mouseY - height/2) > -30 && (mouseY - height/2) < 30) {
      paused = !paused;
      if(paused) {
        fftPause();
      } else {
        fftPlay();
      }
    }
    if((mouseX - width/2) > -100 && (mouseX - width/2) < -40 && (mouseY - height/2) > -30 && (mouseY - height/2) < 30) {
      playPreviousSong();
    }
    if((mouseX - width/2) > 40 && (mouseX - width/2) < 100 && (mouseY - height/2) > -30 && (mouseY - height/2) < 30) {
      playNextSong();
    }
    if(pow(mouseX - width/2, 2) + pow(mouseY - height/2, 2) < pow(height/6.3, 2) && pow(mouseX - width/2, 2) + pow(mouseY - height/2, 2) > pow(height/7.3, 2)) {
      //println("click!");
      
      
      float x = mouseX-width/2;
      float y = mouseY-height/2;
      float r = sqrt(pow(x,2) + pow(y,2));
      //println("X: " + x + ", Y:" + y + ", R: " + r);
      float asin = asin(y/r);
      //float acos = acos(x/r);
      //float atan = atan(y/x);
      
      //println("ASin: " + asin + ", ACos: " + acos + ", ATan: " + atan);
      if( x >= 0 && y >= 0) {
        //println("Q1");
        radians = asin;
      }
      if (x < 0 && y >= 0) {
        //println("Q2");
        radians = PI - asin;
      }
      if (x < 0 && y < 0) {
        //println("Q3");
        radians = PI + abs(asin);
      }
      if (x >= 0 && y < 0) {
        //println("Q4");
        radians = TWO_PI - abs(asin);
      }
      radians = (radians + PI/2)%TWO_PI;
      //println("Radians: " + radians);
      setSongCue((int)(jingle.length()* (radians/TWO_PI)));
    }
    if ((mouseX - width/2) >= -95 && (mouseY - height/2) >= 35 && (mouseX - width/2) <= 95 && (mouseY - height/2) <= 40 ) {
      volume = ((mouseX - width/2)*40)/95;
      jingle.setGain(volume);
    }
    if (mouseX>= optionsMargin && mouseY >= optionsMargin && mouseX <= optionsMargin*3.5 && mouseY <= optionsMargin*3.5 ) {
      isOptionsOpen = true;
    }
  } else { //options menu is open, previous events are bypassed
    if (mouseX>= width*0.04 && mouseY >= height*0.04 && mouseX <= width*0.04 + optionsMargin*2 && mouseY <= height*0.04 + optionsMargin*2) {
      isOptionsOpen = false;
    }
    if (mouseX >= width*0.1 + width*0.04 && mouseY >= height*0.08 + height*0.1 && mouseX <= height*0.16 + width*0.04 && mouseY <= height*0.08 + width*0.1 + height*0.1) {//width*0.1, height*0.08, height*0.08, height*0.08,
      toggleShuffle();
    } //width*0.25, height*0.08, height*0.08, height*0.08
    if (mouseX >= width*0.25 + width*0.04 && mouseY >= height*0.08 + height*0.1 && mouseX <= height*0.8 + width*0.29 && mouseY <= height*0.08 + width*0.1 + height*0.1) {//width*0.1, height*0.08, height*0.08, height*0.08,
      toggleRepeat();
    }
  }
}