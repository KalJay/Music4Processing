boolean isOptionsOpen = false;

void optionsSetup() {
  
}

void optionsDraw() {
  if (!isOptionsOpen) {
    displayOptionsButton();
  } else {
    displayOptionsMenu();
  }
}

void displayOptionsButton() {
  setFillToColourScheme(colours[0]);
  rect(height/70, height/70, height/20, height/20, 14);
  setFillToColourScheme(colours[2]);
  rect(height/50, height/43, height/27, height/140, 2);
  rect(height/50, (height/43)*1.55, height/27, height/140, 2);
  rect(height/50, (height/43)*2.1, height/27, height/140, 2);
}

void displayOptionsMenu() {
  
}