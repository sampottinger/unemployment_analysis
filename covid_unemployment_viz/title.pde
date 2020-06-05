/**
 * Draw the title that appears at the top of the visualization.
 */
void drawTitle() {
  pushMatrix();
  pushStyle();

  noStroke();
  fill(HEADER_PANEL_COLOR);
  rectMode(CORNER);
  rect(0, 0, width, HEADER_HEIGHT);

  fill(BLACK);
  textAlign(LEFT, BOTTOM);
  textFont(LARGE_FONT);
  text("Umeployment, Uninsurance, and Wage by Occupation", 5, HEADER_HEIGHT - 5);

  textFont(SMALL_FONT);
  textAlign(RIGHT, BOTTOM);
  text("BLS 5/19 and 5/20\n2018 5 year ACS Microdata", width - 5, HEADER_HEIGHT - 5);

  popStyle();
  popMatrix();
}
