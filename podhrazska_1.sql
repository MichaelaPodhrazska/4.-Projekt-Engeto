-- Smazání tabulky pokud existuje
DROP TABLE IF EXISTS t_michaela_podhrazska_project_sql_primary_final;

-- Vytvoření nové výsledné tabulky
CREATE TABLE t_michaela_podhrazska_project_sql_primary_final AS

-- CTE pro průměrné ceny potravin
WITH food_prices AS (
    SELECT
        cpc.name AS food_name,
        ROUND(AVG(cpr.value)::numeric, 2) AS average_food_price,
        EXTRACT(YEAR FROM cpr.date_from)::INT AS year
    FROM czechia_price cpr
    JOIN czechia_price_category cpc
        ON cpr.category_code = cpc.code
    GROUP BY 
        cpc.name,
        EXTRACT(YEAR FROM cpr.date_from)
),

-- CTE pro průměrné mzdy
salary_data AS (
    SELECT
        cpib.name AS industry_name,
        ROUND(AVG(cpay.value)::numeric, 2) AS average_salary,
        cpay.payroll_year AS year
    FROM czechia_payroll cpay
    JOIN czechia_payroll_industry_branch cpib
        ON cpay.industry_branch_code = cpib.code
    WHERE cpay.value_type_code = 5958 --- filtr průměrná hrubá mzda
        AND cpay.calculation_code = 100 --- filtr plných pracovních úvazků
        AND cpay.unit_code = 200 ---měna je v Kč
        AND cpay.industry_branch_code IS NOT NULL
    GROUP BY 
        cpib.name,
        cpay.payroll_year
)

-- Finální spojení dat
SELECT
    fp.year,
    fp.food_name,
    fp.average_food_price,
    sd.industry_name,
    sd.average_salary
FROM food_prices fp
JOIN salary_data sd
    ON fp.year = sd.year
ORDER BY
    fp.year DESC,
    fp.average_food_price ASC,
    sd.average_salary ASC;

-- Kontrola výsledku
SELECT *
FROM t_michaela_podhrazska_project_sql_primary_final;