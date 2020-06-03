/**
 * Constants for rendering the visualization.
 */

final int BACKGROUND_COLOR = #F9F9F9;
final int HEADER_PANEL_COLOR = #D0D0D0;

final int BLACK = #333333;
final int DARK_GREY = #555555;
final int MID_GREY = #888888;

final int PRIOR_COLOR = #33a02c;
final int CURRENT_COLOR = #1f78b4;
final int DELTA_COLOR = #C0C0C0;
final int BAR_COLOR = #a6cee3;
final int BAR_LABEL_COLOR = DARK_GREY;

final int HEADER_HEIGHT = 30;
final int OCCUPATION_HEIGHT = 25;
final int OCCUPATION_END_X = 280;
final int BAR_PADDED_WIDTH = 165;
final int START_UNEMPLOYEMENT_X = 300;
final int START_WAGE_X = START_UNEMPLOYEMENT_X + BAR_PADDED_WIDTH;
final int START_UNINSURED_X = START_WAGE_X + BAR_PADDED_WIDTH;
final int BAR_WIDTH = 150;

PFont LARGE_FONT;
PFont MEDIUM_FONT;
PFont SMALL_FONT;


public void loadSemiconstants() {
  LARGE_FONT = loadFont("Lato-Regular-20.vlw");
  MEDIUM_FONT = loadFont("Lato-Regular-12.vlw");
  SMALL_FONT = loadFont("Lato-Regular-10.vlw");
}
