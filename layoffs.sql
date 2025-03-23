use world_layoffs;
SELECT * FROM layoffs;

-- 1. remove duplicate values
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. remove any column

-- duplicating the layoffs table
CREATE Table layoffs_staging LIKE layoffs;
SELECT * FROM layoffs_staging;

-- populating the layoff_staging table with the data from layoffs 
INSERT INTO layoffs_staging 
SELECT * FROM layoffs

-- 1. remove duplicate values

SELECT * ,ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging

WITH duplicate_cte AS(
SELECT * ,ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SELECT * FROM layoffs
WHERE company = "Cazoo";


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs_staging2 
SELECT * ,ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT * FROM
 layoffs_staging2 
 WHERE row_num > 1
 ;

 DELETE  FROM
 layoffs_staging2 
 WHERE row_num > 1
 ;


SELECT * FROM
 layoffs_staging2 ;

-- standardizing data

SELECT  DISTINCT(TRIM(company))
FROM
 layoffs_staging2 ;


SELECT DISTINCT company , TRIM(company)
FROM
 layoffs_staging2 ;


 UPDATE layoffs_staging2
 SET company = TRIM(company);


SELECT industry 
FROM
 layoffs_staging2 ;
SELECT DISTINCT industry 
FROM
 layoffs_staging2 
 ORDER BY 1;
SELECT * 
FROM
 layoffs_staging2 
 WHERE industry
 LIKE 'crypto%';

 UPDATE layoffs_staging2 
 SET industry='crypto'
 WHERE industry LIKE 'crypto%'


 SELECT DISTINCT location
  from layoffs_staging2 ;

  SELECT DISTINCT country , TRIM(TRAILING '.' FROM country)
FROM
 layoffs_staging2 
 
 ORDER BY 1;

  UPDATE layoffs_staging2 
 SET country=TRIM(TRAILING '.' FROM country)
 WHERE country  LIKE 'United States%'


-- change date from text
use world_layoffs;
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') AS date
FROM layoffs_staging2;
SELECT `date`
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off is NULL;

SELECT * FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
-- AND t1.location = t2.location
WHERE (t1.industry is NULL || t1.industry='')
AND t2.industry is NOT NULL;

SELECT  t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
-- AND t1.location = t2.location
WHERE (t1.industry is NULL || t1.industry='')
AND t2.industry is NOT NULL

UPDATE 
layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry =t2.industry
WHERE t1.industry is NULL 
AND t2.industry is NOT NULL


UPDATE layoffs_staging2
SET industry = NULL
WHERE industry=''

SELECT * from 
layoffs_staging2 
WHERE company="Airbnb"

-- DELETE null VALUES
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off is NULL;
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off is NULL;


SELECT *
FROM layoffs_staging2;

ALTER Table layoffs_staging2
DROP COLUMN row_num;

ALTER Table layoffs_staging2
DROP COLUMN row_num;
ALTER Table layoffs_staging2
DROP COLUMN row_num;

-- 356hrs