-- DATA CLEANING

-- ADDING A TABLE from -- https://www.kaggle.com/datasets/swaptr/layoffs-2022--


-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove any columns or rows that are not necessary

-- CREATE A STAGGING TABLE SO THAT THE RAW TABLE WILL NOT BE ALTERED
CREATE TABLE layoffs_staging
LIKE layoffs_raw;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs_raw;

SELECT *
FROM layoffs_raw;

-- NEED TO CREATE A ROW ID TO BE ABLE TO SEE THE DUPLICATION EASIER
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised) AS row_num
FROM layoffs_staging
)

SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- 2. Standardize the data

-- FIXED ERRORS IN THE COMPANY COLUMNS, HAD SPACES BEFORE THE NAME

SELECT company, TRIM(company)
FROM layoffs_staging;

UPDATE layoffs_staging
SET company = TRIM(company);

-- CHECK INDUSTRY COLUMNS
SELECT DISTINCT industry
FROM layoffs_staging
ORDER BY 1;

-- CHECK LOCATION COLUMNS
SELECT DISTINCT location
FROM layoffs_staging
ORDER BY 1;

-- CHECK COUNTRY COLUMNS
SELECT DISTINCT country
FROM layoffs_staging
ORDER BY 1;

-- CHECK STAGE COLUMNS
SELECT DISTINCT stage
FROM layoffs_staging
ORDER BY 1;

-- CHECK DATE COLUMNS
SELECT `date`
FROM layoffs_staging;

-- CHANGE DATE TO A STANDARD DATE FORMAT , UPDATE, AND CHECK CHANGES

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging;

UPDATE layoffs_staging
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging;

-- ALTER THE COLUMNS INPUT NEEDED

ALTER TABLE layoffs_staging
MODIFY COLUMN `date` DATE;

ALTER TABLE layoffs_staging
MODIFY COLUMN total_laid_off INT;

ALTER TABLE layoffs_staging
MODIFY COLUMN funds_raised INT;

-- 3. Null values or blank values

-- CHANGING ALL BLANK VALUES TO NULL

	-- LOCATION
SELECT *
FROM layoffs_staging
WHERE location = NULL OR location = '';

UPDATE layoffs_staging
SET location = NULL
WHERE location = '';

SELECT *
FROM layoffs_staging
WHERE location IS NULL;

	-- INDUSTRY

SELECT *
FROM layoffs_staging
WHERE industry = NULL OR industry = '';

UPDATE layoffs_staging
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging
WHERE industry IS NULL;

	-- TOTAL LAID OFF

SELECT *
FROM layoffs_staging
WHERE total_laid_off = NULL OR total_laid_off = '';

UPDATE layoffs_staging
SET total_laid_off = NULL
WHERE total_laid_off = '';

SELECT *
FROM layoffs_staging
WHERE total_laid_off IS NULL;

	-- PERCENTAGE LAID OFF

SELECT *
FROM layoffs_staging
WHERE percentage_laid_off = NULL OR percentage_laid_off = '';

UPDATE layoffs_staging
SET percentage_laid_off = NULL
WHERE percentage_laid_off = '';

SELECT *
FROM layoffs_staging
WHERE percentage_laid_off IS NULL;

	-- FUNDS RAISED

SELECT *
FROM layoffs_staging
WHERE funds_raised = NULL OR funds_raised = '';

UPDATE layoffs_staging
SET funds_raised = NULL
WHERE funds_raised = '';

SELECT *
FROM layoffs_staging
WHERE funds_raised IS NULL;

-- 4. Remove any columns or rows that are not necessary

-- DELETING NULLS THAT ARE POPULATED IN BOTH TOTAL LAID OFF AND PERCENTAGE LAID OFF

SELECT *
FROM layoffs_staging;

SELECT *
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;









