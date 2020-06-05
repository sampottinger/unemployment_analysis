/**
 * Logic to render the visualization body.
 */


/**
 * Draw the dataset body with the multiple bar charts.
 *
 * @param dataset The dataset to be drawn.
 */
void drawBody(Dataset dataset) {
  pushMatrix();
  pushStyle();

  translate(5, HEADER_HEIGHT + 15);

  drawBodyHeaders(dataset);

  translate(0, 37);

  for (Occupation occupation : dataset.getOccupations()) {
    drawOccupation(occupation, dataset);
    translate(0, OCCUPATION_HEIGHT);
  }

  popStyle();
  popMatrix();
}


/**
 * Draw the top column headers for the body of the visualization.
 *
 * <p>
 * Draw the column headers in the body of the visualization describing the variables and axes.
 * </p>
 *
 * @param dataset The dataset for which the dataset body headers should be drawn. The dataset will
 *    be used to determine the axis labels.
 */
void drawBodyHeaders(Dataset dataset) {
  pushMatrix();
  pushStyle();

  noStroke();
  textAlign(LEFT, BOTTOM);
  textFont(SMALL_FONT);
  fill(BLACK);
  text("Unemployment Rate", START_UNEMPLOYEMENT_X, 0);
  text("Median Wage (05/19)", START_WAGE_X, 0);
  text("2019 Uninsured Rate", START_UNINSURED_X, 0);

  noStroke();
  fill(MID_GREY);
  textAlign(LEFT, BOTTOM);
  text("0", START_UNEMPLOYEMENT_X + 2, 14);
  text("0", START_WAGE_X + 2, 14);
  text("0", START_UNINSURED_X + 2, 14);

  noFill();
  stroke(MID_GREY);
  line(START_UNEMPLOYEMENT_X, 4, START_UNEMPLOYEMENT_X, 12);
  line(START_WAGE_X, 4, START_WAGE_X, 12);
  line(START_UNINSURED_X, 4, START_UNINSURED_X, 12);

  noStroke();
  fill(MID_GREY);
  textAlign(RIGHT, BOTTOM);
  text(formatUnemploymentRate(dataset.getMaxUnemploymentRate()), START_UNEMPLOYEMENT_X + BAR_WIDTH - 2, 14);
  text(formatSalary(dataset.getMaxSalary()), START_WAGE_X + BAR_WIDTH - 2, 14);
  text(formatUninsuranceRate(dataset.getMaxUninsuredRate()), START_UNINSURED_X + BAR_WIDTH - 2, 14);

  noFill();
  stroke(MID_GREY);
  line(START_UNEMPLOYEMENT_X + BAR_WIDTH, 4, START_UNEMPLOYEMENT_X + BAR_WIDTH, 12);
  line(START_WAGE_X + BAR_WIDTH, 4, START_WAGE_X + BAR_WIDTH, 12);
  line(START_UNINSURED_X + BAR_WIDTH, 4, START_UNINSURED_X + BAR_WIDTH, 12);

  noStroke();

  fill(PRIOR_COLOR);
  textAlign(RIGHT, BOTTOM);
  text("05/19", START_UNEMPLOYEMENT_X + BAR_WIDTH / 2 - 3, 14);

  fill(CURRENT_COLOR);
  textAlign(LEFT, BOTTOM);
  text("05/20", START_UNEMPLOYEMENT_X + BAR_WIDTH / 2 + 3, 14);

  popStyle();
  popMatrix();
}


/**
 * Draw a row describing a single occupation.
 *
 * @param occupation The occupation and data for that occupation to be displayed.
 * @param dataset The dataset from which the occupation record is drawn.
 */
void drawOccupation(Occupation occupation, Dataset dataset) {
  pushMatrix();
  pushStyle();

  drawOccupationName(occupation, dataset);
  drawUnemployment(occupation, dataset);
  drawMedianSalary(occupation, dataset);
  drawUninsuranceRate(occupation, dataset);

  popStyle();
  popMatrix();
}


/**
 * Draw the name label for an occupation row.
 *
 * @param occupation The occupation and data for that occupation to be displayed.
 * @param dataset The dataset from which the occupation record is drawn.
 */
void drawOccupationName(Occupation occupation, Dataset dataset) {
  pushMatrix();
  pushStyle();

  fill(DARK_GREY);
  textAlign(RIGHT, BOTTOM);
  textFont(MEDIUM_FONT);
  text(occupation.getTitle().replace(" occupations", ""), OCCUPATION_END_X, 0);

  popStyle();
  popMatrix();
}


/**
 * Draw the unemployment small multiple for the occupation.
 *
 * @param occupation The occupation and data for that occupation to be displayed.
 * @param dataset The dataset from which the occupation record is drawn.
 */
void drawUnemployment(Occupation occupation, Dataset dataset) {
  pushMatrix();
  pushStyle();

  translate(START_UNEMPLOYEMENT_X, 0);

  float priorUnemployemnt = occupation.getUnemploymentRate2019();
  float currentUnemployment = occupation.getUnemploymentRate2020();

  String priorUnemploymentLabel = formatUnemploymentRate(priorUnemployemnt);
  String currentUnemploymentLabel = formatUnemploymentRate(currentUnemployment);

  float priorUnemploymentWidth = getUnemploymentWidth(priorUnemployemnt, dataset);
  float currentUnemploymentWidth = getUnemploymentWidth(currentUnemployment, dataset);

  noStroke();
  textFont(SMALL_FONT);

  fill(PRIOR_COLOR);
  textAlign(RIGHT, CENTER);
  text(priorUnemploymentLabel, priorUnemploymentWidth - 2, -8);

  fill(CURRENT_COLOR);
  textAlign(LEFT, CENTER);
  text(currentUnemploymentLabel, currentUnemploymentWidth + 2, -8);

  noFill();
  stroke(DELTA_COLOR);
  line(priorUnemploymentWidth, -8, currentUnemploymentWidth, -8);

  popStyle();
  popMatrix();
}


/**
 * Draw the median wage small multiple for the occupation.
 *
 * @param occupation The occupation and data for that occupation to be displayed.
 * @param dataset The dataset from which the occupation record is drawn.
 */
void drawMedianSalary(Occupation occupation, Dataset dataset) {
  pushMatrix();
  pushStyle();

  translate(START_WAGE_X, 0);

  float medianSalary = occupation.getAnnualSalaryMedianUsd();
  String salaryLabel = formatSalary(medianSalary);
  float salaryWidth = getSalaryWidth(medianSalary, dataset);

  noStroke();

  rectMode(CORNER);
  fill(BAR_COLOR);
  rect(0, -12, salaryWidth, 12);

  fill(BAR_LABEL_COLOR);
  textAlign(RIGHT, CENTER);
  textFont(SMALL_FONT);
  text(salaryLabel, salaryWidth - 1, -6);

  popStyle();
  popMatrix();
}


/**
 * Draw the uninsurance rate small multiple for the occupation.
 *
 * @param occupation The occupation and data for that occupation to be displayed.
 * @param dataset The dataset from which the occupation record is drawn.
 */
void drawUninsuranceRate(Occupation occupation, Dataset dataset) {
  pushMatrix();
  pushStyle();

  translate(START_UNINSURED_X, 0);

  float uninsuranceRate = occupation.getUninsuranceRate();
  String uninsuranceLabel = formatUninsuranceRate(uninsuranceRate);
  float uninsuranceWidth = getUninsuranceWidth(uninsuranceRate, dataset);

  noStroke();

  rectMode(CORNER);
  fill(BAR_COLOR);
  rect(0, -12, uninsuranceWidth, 12);

  fill(BAR_LABEL_COLOR);
  textFont(SMALL_FONT);

  if (uninsuranceRate >= 5) {
    textAlign(RIGHT, CENTER);
    text(uninsuranceLabel, uninsuranceWidth - 1, -6);
  } else {
    textAlign(LEFT, CENTER);
    text(uninsuranceLabel, uninsuranceWidth + 2, -6);
  }

  popStyle();
  popMatrix();
}


/**
 * Get the horizontal position for an unemployment rate.
 *
 * @param unemployment The unemployment rate for which the horizontal position should be returned.
 * @param dataset The dataset from which the unemployment rate was drawn.
 * @return The x coordinate within the unemployment axis corresponding to the provided unemployment
 *    rate.
 */
float getUnemploymentWidth(float unemployment, Dataset dataset) {
  return map(unemployment, 0, dataset.getMaxUnemploymentRate(), 0, BAR_WIDTH);
}


/**
 * Get the horizontal position for a median salary.
 *
 * @param salary The unemployment rate for which the horizontal position should be returned.
 * @param dataset The dataset from which the median salary was drawn.
 * @return The x coordinate within the salary axis corresponding to the provided median salary.
 */
float getSalaryWidth(float salary, Dataset dataset) {
  return map(salary, 0, dataset.getMaxSalary(), 0, BAR_WIDTH);
}


/**
 * Get the horizontal position for an uninsurance rate.
 *
 * @param uninsured The uninsured rate for which the horizontal position should be returned.
 * @param dataset The dataset from which the uninsurance rate was drawn.
 * @return The x coordinate within the uninsurance axis corresponding to the provided uninsurance
 *    rate.
 */
float getUninsuranceWidth(float uninsured, Dataset dataset) {
  return map(uninsured, 0, dataset.getMaxUninsuredRate(), 0, BAR_WIDTH);
}
