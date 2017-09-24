float[][] floatSchemes;

int[] getColourStep(int n) {
  int steps = 180;
  float[] resultScheme = new float[2];
  float redStepAmount = 0;
  float greenStepAmount = 0;
  float blueStepAmount = 0;
  if(n < 180) {
    redStepAmount = (floatSchemes[1][0] - floatSchemes[0][0])/steps;
    greenStepAmount = (floatSchemes[1][1] - floatSchemes[0][1])/steps;
    blueStepAmount = (floatSchemes[1][2] - floatSchemes[0][2])/steps;
    //println("1-0: " + floatSchemes[1][2] + " - " + floatSchemes[0][2]);
    resultScheme = floatSchemes[0];
  }
  if (n >= 180 && n < 360) {
    redStepAmount = (floatSchemes[2][0] - floatSchemes[1][0])/steps;
    greenStepAmount = (floatSchemes[2][1] - floatSchemes[1][1])/steps;
    blueStepAmount = (floatSchemes[2][2] - floatSchemes[1][2])/steps;
    resultScheme = floatSchemes[1];
    n -= 180;
  }
  if (n >= 360 && n < 540) {
    redStepAmount = (floatSchemes[3][0] - floatSchemes[2][0])/steps;
    greenStepAmount = (floatSchemes[3][1] - floatSchemes[2][1])/steps;
    blueStepAmount = (floatSchemes[3][2] - floatSchemes[2][2])/steps;
    resultScheme = floatSchemes[2];
    n -=360;
  }
  if (n >= 540 && n < 720) {
    redStepAmount = (floatSchemes[4][0] - floatSchemes[3][0])/steps;
    greenStepAmount = (floatSchemes[4][1] - floatSchemes[3][1])/steps;
    blueStepAmount = (floatSchemes[4][2] - floatSchemes[3][2])/steps;
    resultScheme = floatSchemes[3];
    n -=540;
  }
  if (n >= 720 && n < 900) {
    redStepAmount = (floatSchemes[0][0] - floatSchemes[4][0])/steps;
    greenStepAmount = (floatSchemes[0][1] - floatSchemes[4][1])/steps;
    blueStepAmount = (floatSchemes[0][2] - floatSchemes[4][2])/steps;
    resultScheme = floatSchemes[4];
    n -=720;
  }
  for (int i = 0; i < n; i++) {
    //println("Green: " + resultScheme[1] + " + " + greenStepAmount);
    resultScheme[0] += redStepAmount;
    resultScheme[1] += greenStepAmount;
    resultScheme[2] += blueStepAmount;
    //println("Final: " + resultScheme[1]);
  }
  //println("BlueStep: " + blueStepAmount);
  //println(resultScheme[0] + ", " + resultScheme[1] + ", " + resultScheme[2] + ", " + n);
  return getIntScheme(resultScheme);
}

float[][] getSchemesByVal(int[][] schemes) {
  float[][] resultScheme = {{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0}};
  for (int i = 0; i < 5; i++) {
    for (int q = 0; q < 3; q++) {
      //println("i = " + i + ", q = " + q + ", value = " + schemes[i][q]);
      resultScheme[i][q] = schemes[i][q];
    }
  }
  return resultScheme;
}

int[] getIntScheme(float[] scheme) {
  int[] resultScheme = {0,0,0};
  for (int i =0; i < 3; i++) {
    resultScheme[i] = (int)scheme[i];
  }
  return resultScheme;
}

void setupRGB(int[][] schemes) {
  floatSchemes = getSchemesByVal(schemes);
}