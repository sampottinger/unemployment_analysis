/**
 * Structures and logic to hold the dataset being visualized.
 */


/**
 * Record describing data on a single major BLS occupational category.
 */
class Occupation {
  private final int occCode;
  private final String title;
  private final float unemploymentRate2020;
  private final float unemploymentRate2019;
  private final float annualSalaryMedianUsd;
  private final float uninsuranceRate;

  /**
   * Create a new occupation record.
   *
   * @param newOccCode The BLS occupation code.
   * @param newTitle The human-readable name of the occupation.
   * @param newUnemploymentRate2020 The unemployment rate in 2020 (0 - 100).
   * @param newUnemploymentRate2019 The unemployment rate in 2019 (0 - 100).
   * @param newAnnualSalaryMedianUsd The median salary for this occupation (USD).
   * @param newUninsuranceRate The rate of uninusured persons within the given occupation (0 - 100).
   */
  public Occupation(int newOccCode, String newTitle, float newUnemploymentRate2020,
      float newUnemploymentRate2019, float newAnnualSalaryMedianUsd, float newUninsuranceRate) {

    occCode = newOccCode;
    title = newTitle;
    unemploymentRate2020 = newUnemploymentRate2020;
    unemploymentRate2019 = newUnemploymentRate2019;
    annualSalaryMedianUsd = newAnnualSalaryMedianUsd;
    uninsuranceRate = newUninsuranceRate;
  }

  /**
   * Get the BLS ocupation code.
   *
   * @return The BLS occupation code for this occuaption.
   */
  public int getOccCode() {
    return occCode;
  }

  /**
   * Get the human readable name for this occupation.
   *
   * @return Human-friendly string name of this occupation.
   */
  public String getTitle() {
    return title;
  }

  /**
   * Get the unemployment rate in 2020.
   *
   * @return The unemployment rate in 2020 (0 - 100).
   */
  public float getUnemploymentRate2020() {
    return unemploymentRate2020;
  }

  /**
   * Get the unemployment rate in 2019.
   *
   * @return The unemployment rate in 2019 (0 - 100).
   */
  public float getUnemploymentRate2019() {
    return unemploymentRate2019;
  }

  /**
   * Get the change in unemployment rate between 2020 and 2019.
   *
   * @return The unemployment rate in 2020 minus the unemployment rate in 2019 (0 - 100).
   */
  public float getChangeInUnemploymentRate() {
    return unemploymentRate2020 - unemploymentRate2019;
  }

  /**
   * Get the annual median salary for this occupation.
   *
   * @return Median salary (USD).
   */
  public float getAnnualSalaryMedianUsd() {
    return annualSalaryMedianUsd;
  }

  /**
   * Get the rate of uninsurance within this occupation.
   *
   * @return The uninsurance rate (0 - 100).
   */
  public float getUninsuranceRate() {
    return uninsuranceRate;
  }
}


/**
 * Dataset which can be visualized and which holds multiple occupations.
 */
class Dataset {

  private final List<Occupation> occupations;
  private final float maxUnemploymentRate;
  private final float maxSalary;
  private final float maxUninsuredRate;

  /**
   * Create a new dataset
   *
   * @param newOccupations The occupation records that make up this dataset.
   */
  public Dataset(List<Occupation> newOccupations) {
    occupations = newOccupations;

    // Unemployment max
    float localMax = 0;
    for (Occupation occupation : occupations) {
      localMax = max(localMax, occupation.getUnemploymentRate2020());
      localMax = max(localMax, occupation.getUnemploymentRate2019());
    }
    maxUnemploymentRate = localMax;

    // Salary max
    localMax = 0;
    for (Occupation occupation : occupations) {
      localMax = max(localMax, occupation.getAnnualSalaryMedianUsd());
    }
    maxSalary = localMax;

    // Uninsured rate
    localMax = 0;
    for (Occupation occupation : occupations) {
      localMax = max(localMax, occupation.getUninsuranceRate());
    }
    maxUninsuredRate = localMax;
  }

  /**
   * Get the list of occupations in this dataset.
   *
   * @return The occupation records within this dataset.
   */
  public List<Occupation> getOccupations() {
    return occupations;
  }

  /**
   * Get the maximum unemployment rate seen in this dataset, rounded to nearest whole percent.
   *
   * @return The rounded maximum unemployment rate in this dataset.
   */
  public float getMaxUnemploymentRate() {
    return getMaxUnemploymentRate(true);
  }

  /**
   * Get the maximum unemployment rate seen in this dataset.
   *
   * @param rounded If true, rounded to nearest whole percent. If false, simply the maximum
   *    unemployment rate in the dataset without rounding.
   * @return The maximum unemployment rate in this dataset.
   */
  public float getMaxUnemploymentRate(boolean rounded) {
    return rounded ? ceil(maxUnemploymentRate / 10) * 10 : maxUnemploymentRate;
  }

  /**
   * Get the maximum median salary seen in this dataset, rounded to the nearest 10k USD.
   *
   * @return The maximum median salary rounded to the nearest 10k USD.
   */
  public float getMaxSalary() {
    return getMaxSalary(true);
  }

  /**
   * Get the maximum median salary seen in this dataset
   *
   * @param rounded If true, will be rounded to the nearest 10k USD. If false, no rounding.
   * @return The maximum median salary in the dataset.
   */
  public float getMaxSalary(boolean rounded) {
    return rounded ? ceil(maxSalary / 10000) * 10000 : maxSalary;
  }

  /**
   * Get the maximum uninsured rate seen in the dataset rounded to the nearest 10%.
   *
   * @return The highest uninsured rate seen in this dataset rounded to the nearest 10%.
   */
  public float getMaxUninsuredRate() {
    return getMaxUninsuredRate(true);
  }

  /**
   * Get the maximum uninsured rate seen in the dataset.
   *
   * @param rounded The uninsured rate rounded to the nearest 10%.
   * @return The highest uninsured rate seen in this dataset rounded to the nearest 10%.
   */
  public float getMaxUninsuredRate(boolean rounded) {
    return rounded ? ceil(maxUninsuredRate / 10) * 10 : maxUninsuredRate;
  }

}


/**
 * Load the dataset using the default file.
 *
 * @return The newly loaded dataset.
 */
Dataset loadData() {
  List<Occupation> innerData = loadData("unemployment_salary_and_uninsurance.csv");
  Collections.sort(innerData, (a, b) -> {
    Float changeA = a.getChangeInUnemploymentRate();
    Float changeB = b.getChangeInUnemploymentRate();
    return changeB.compareTo(changeA);
  });
  return new Dataset(innerData);
}


/**
 * Load a dataset.
 *
 * @param filename The filename from which the dataset should be loaded.
 * @return The newly loaded dataset.
 */
List<Occupation> loadData(String filename) {
  List<Occupation> retList = new ArrayList<>();
  Table sourceData = loadTable(filename, "header");

  for (TableRow row : sourceData.rows()) {

    int occCode = row.getInt("majorOccCode");
    String title = row.getString("title");
    float unemploymentRate2020 = row.getFloat("unemploymentRate2020");
    float unemploymentRate2019 = row.getFloat("unemploymentRate2019");
    float annualSalaryMedianUsd = row.getFloat("annualSalaryMedianUsd");
    float uninsuranceRate = row.getFloat("uninsuranceRate");

    retList.add(new Occupation(
      occCode,
      title,
      unemploymentRate2020,
      unemploymentRate2019,
      annualSalaryMedianUsd,
      uninsuranceRate
    ));

  }

  return retList;
}
