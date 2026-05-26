-- Má výška HDP vliv na změny ve mzdách a cenách potravin?
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to
-- na cenách potravin či mzdách ve stejném nebo následujícím roce
-- výraznějším růstem?

-- kroky:
-- 1. vypočítají průměrné hodnoty za jednotlivé roky,
-- 2. spojí data z primární a sekundární tabulky,
-- 3. vypočítá meziroční procentní růst,
-- 4. porovnají změny HDP, mezd a cen potravin.

WITH yearly_primary AS (
    -- Výpočet průměrných mezd a cen potravin za každý rok - primární tabulka
    SELECT
        year,
        ROUND(AVG(average_salary)::numeric, 2) AS avg_salary,
        ROUND(AVG(average_food_price)::numeric, 2) AS avg_food_price
    FROM t_michaela_podhrazska_project_sql_primary_final
    GROUP BY year
),

yearly_secondary AS (
    -- Výpočet průměrného HDP za každý rok - sekundární tabulka
    SELECT
        year,
        ROUND(AVG(gdp)::numeric, 2) AS avg_gdp
    FROM t_michaela_podhrazska_project_sql_secondary_final
    GROUP BY year
),

combined_data AS (
    -- Spojení dat z primární a sekundární tabulky pomocí roku
    SELECT
        yp.year,
        ys.avg_gdp,
        yp.avg_salary,
        yp.avg_food_price
    FROM yearly_primary yp
    JOIN yearly_secondary ys
        ON yp.year = ys.year
),

growth_calculation AS (
    -- Výpočet meziroční procentní změny pomocí funkce LAG()
    -- Vzorec:
    -- ((aktuální hodnota - minulá hodnota) / minulá hodnota) * 100
    SELECT
        year,

        ROUND(((avg_gdp - LAG(avg_gdp) OVER (ORDER BY year)) / LAG(avg_gdp) OVER (ORDER BY year)) * 100, 2) AS gdp_growth_percent,

        ROUND(((avg_salary - LAG(avg_salary) OVER (ORDER BY year)) / LAG(avg_salary) OVER (ORDER BY year)) * 100, 2) AS salary_growth_percent,

        ROUND(((avg_food_price - LAG(avg_food_price) OVER (ORDER BY year)) / LAG(avg_food_price) OVER (ORDER BY year)) * 100, 2) AS food_price_growth_percent

    FROM combined_data
)

-- Finální výstup analýzy - zobrazení meziročních změn HDP, mezd a cen potravin
SELECT
    year,
    gdp_growth_percent,
    salary_growth_percent,
    food_price_growth_percent
FROM growth_calculation
ORDER BY year;