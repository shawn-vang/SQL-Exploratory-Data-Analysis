-- Exploratory Data Analysis Project

Select *
FROM layoffs_staging2;

Select MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2
;
#What we are trying to find out here is total laid off from companies.
Select *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

Select *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

Select company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC; #What we have here is looking at the company and having the sum of total that was laid off. We grouped by company to make it look easier to look at then ordered by 2 which is the 2nd column SUM(total_laid_off)

Select MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

Select industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

Select *
FROM layoffs_staging2;

Select country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

Select YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR (`date`)
ORDER BY 1 DESC;

Select stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

Select company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_Total AS
(SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;
#rolling_total allowed for us to see how the numbers kept adding up each month. 



Select company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

Select company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 desc; #What we are doing here is looking at company and the date which would be the year and while doing this we are seeing total laid off each year by each company.


WITH Company_Year (company, years, total_laid_off) AS
(
Select company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`) # This allowed us to take information from layoffs_staging2 and make like a output naming it Company_Year
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK () OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking #We ranked the total layoff and partition means it groups all of the unique subjects so here would be years and ordered it by total laid off
FROM Company_Year
WHERE years IS NOT NULL #The IS NOT Null code allowed us to not look at the companies that have no information.
)
SELECT*
FROM Company_Year_Rank
WHERE Ranking <= 5
ORDER BY Ranking ASC #Easier to look at so that when you need to find out which company had the most lay offs
;
#What we did here was a deeper dive on finding out how many people were laid off in companies, months, and stage of company, plus more.
#This could used to find valuable insights on these data that could be presented.










