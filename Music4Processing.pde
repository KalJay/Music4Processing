int[] backgroundColour = {255,255,255};
  
int[] colour1 = {13,77,255};
int[] colour2 = {12,128,232};
int[] colour3 = {0,202,255};
int[] colour4 = {12,232,219};
int[] colour5 = {13,255,172};
  
int[][] colours = {colour1, colour2, colour3, colour4, colour5};

float[] testLevels = {0.5,0.3,0.7, 0.66, 0.4, 0.23, 0.45, 0, 0.98, 0.5, 0.87, 0.35, 0.154, 0.46, 0.456, 0.8256, 0.572, 0.9634, 0.872, 0.6445, 0.1754};

int n =0;
  
void setup() {
  size(800,800);
  filesSetup();
  fftSetup();
  musicSetup();
  optionsSetup();
}

void draw() {
  setupRGB(colours);
  float[] theLevels = fftAnalysis();
  channels(30, theLevels, n%900);
  displayMedia(n);
  //channels(21, testLevels);
  n++;
  optionsDraw();
  
}

void mousePressed() {
  handleMouseClick();
}

float transform(float t) {
  return (float)(425 + 47*t)/660;
}

void setFillToColourScheme(int[] scheme) {
  fill(scheme[0], scheme[1], scheme[2]);
}

void setFillToColourScheme(int[] scheme, int alpha) {
  fill(scheme[0], scheme[1], scheme[2], alpha);
}