/**
 * Logic to format numbers wihtin the visualization.
 */


/**
 * Format an unemployment rate to a human friendly string.
 *
 * @param unemploymentRate The unemployment rate to format.
 * @return Human friendly string describing the provided unemployment rate.
 */
String formatUnemploymentRate(float unemploymentRate) {
  return round(unemploymentRate) + "%";
}


/**
 * Format a salary to a human friendly string.
 *
 * @param salary The median salary to format.
 * @return Human friendly string describing the provided median salary.
 */
String formatSalary(float salary) {
  return "$" + round(salary / 1000) + "k";
}


/**
 * Format an uninsurance rate to a human friendly string.
 *
 * @param salary The uninsurance rate to format.
 * @return Human friendly string describing the provided uninsurance rate.
 */
String formatUninsuranceRate(float uninsuredRate) {
  return round(uninsuredRate) + "%";
}
