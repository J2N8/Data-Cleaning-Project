# Data Cleaning Project

## Overview

This project focuses on cleaning and processing the Tech Layoffs Dataset from COVID-19 to Present obtained from Kaggle. The dataset contains information about layoffs in the tech industry, including company names, industries, locations, and the number of affected employees. Using MySQL, I performed data cleaning operations to ensure consistency, remove errors, and prepare the dataset for analysis.

### Dataset

* Source: [Kaggle - Tech Layoffs Dataset](https://www.kaggle.com/datasets/swaptr/layoffs-2022/data)
* Contents: The dataset contains records of layoffs with attributes such as:
  * Company
  * Industry
  * Total Laid Off
  * Percentage Laid Off
  * Date
  * Country
  * Stage
  * Funds Raised

### Technologies Used
* Database: MySQL
* Querying Language: SQL
* Data Source: Kaggle

### Data Cleaning Process

The following data cleaning steps were performed in MySQL:

1. Remove Duplicates
  * Identified and deleted duplicate records.

2. Standardize the Data
  * Ensured consistent date formats.

3. Null Values or Blank Values
  * Identified and replaced null values where necessary.
  * Removed records with excessive missing data.

4. Remove Any Columns or Rows That Are Not Necessary
  * Eliminated irrelevant or redundant columns and rows.

### Installation & Setup

* Download the Dataset
* Import the Dataset into MySQL
* Run the Cleaning Scripts

### How to Use
* Use the cleaned dataset for further analysis, visualization, or reporting.
* Queries can be run to explore trends, such as:
```
SELECT Industry, SUM(Total_Laid_Off) AS TotalLayoffs
FROM layoffs_staging
GROUP BY Industry
ORDER BY TotalLayoffs DESC;
```
### Future Improvements
* Automate data cleaning using Python scripts.
* Integrate visualization tools like Tableau or Power BI.
* Expand the dataset to include additional years.
***
Author: Jasmine Poole

