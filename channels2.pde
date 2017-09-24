int[] circleColour = {0,0,0};

void channels(int channels, float[] levels, int n) {
  
  boolean rgbfade = true; // Use true to enable RGB Fade, false to use standard colouring of the middle circle
  
  float segmentWidth = radians(360/channels);
  float channelWidth = segmentWidth*0.8;
  float spacingWidth = segmentWidth*0.2;
  
  
  
  //Debug Print Lines
  
  //println("Channels: " + channels);
  //println("Degrees: " + 360/channels);
  //println("Radians: " + radians(1/channels*360));
  //println("Segment Width: " + segmentWidth);
  //println("Channel Width: " + channelWidth);
  //println("Spacing: " + spacingWidth);
  background(backgroundColour[0], backgroundColour[1], backgroundColour[2]);
  noStroke();
  pushMatrix();
  translate(width/2, height/2);
  for (int i =0; i < channels; i++) {
    int w = i % 5;
    fill(colours[w][0], colours[w][1],colours[w][2]);
    arc(0,0, level(levels[i])*height/1.1, level(levels[i])*height/1.1, i*channelWidth + i*spacingWidth, (i+1)*channelWidth + i*spacingWidth);
    fill (backgroundColour[0], backgroundColour[1], backgroundColour[2]);
    arc(0,0,height/3, height/3, i*channelWidth + i*spacingWidth, (i+1)*channelWidth + i*spacingWidth);
    noFill();
    //line((height/6)*cos(i*segmentWidth), (height/6)*sin(i*segmentWidth), level(levels[i])*(height/2.2)*cos(i*segmentWidth), level(levels[i])*(height/2.2)*sin(i*segmentWidth));
    //line((height/6)*cos((i+1)*channelWidth + i*spacingWidth), (height/6)*sin((i+1)*channelWidth + i*spacingWidth), level(levels[i])*(height/2.2)*cos((i+1)*channelWidth + i*spacingWidth), level(levels[i])*(height/2.2)*sin((i+1)*channelWidth + i*spacingWidth));
  }
  if(rgbfade) {
    circleColour = getColourStep(n);
    setFillToColourScheme(circleColour);
  } else {
    circleColour = colours[1];
    setFillToColourScheme(colours[1]);
  }
  //fill(0,0,0);
  noStroke();
  ellipse(0,0,height/3, height/3);
  popMatrix();
}

float level(float level) {
  level = (114 + 282*level)/396;
  return sqrt(level)-(0.18);
  //return 0.2 + 0.4*level;
  //return (114 + 282*level)/396;
}