/**
 * Main entry point for the visualization.
 */

import java.util.*;


/**
 * Setup which runs and saves the unemployment visualization.
 */
void setup() {
  size(800, 630);
  loadSemiconstants();
  Dataset data = loadData();

  background(BACKGROUND_COLOR);

  drawTitle();
  drawBody(data);

  save("unemployment.png");
}


/**
 * Leave the existing visualization displayed.
 */
void draw() {
}
